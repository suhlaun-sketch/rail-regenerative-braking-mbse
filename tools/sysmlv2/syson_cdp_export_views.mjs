import fs from "node:fs";
import path from "node:path";

const [debugBase, projectBaseUrl, creationPath, exportRoot, resultPath] = process.argv.slice(2);
if (!resultPath) {
  process.stderr.write("Usage: node syson_cdp_export_views.mjs <debug-base> <project-base-url> <creation.json> <export-root> <result.json>\n");
  process.exit(2);
}

const creation = JSON.parse(fs.readFileSync(path.resolve(creationPath), "utf8"));
const absoluteExportRoot = path.resolve(exportRoot);
fs.mkdirSync(absoluteExportRoot, { recursive: true });
const target = await (await fetch(`${debugBase}/json/new?${encodeURIComponent("about:blank")}`, { method: "PUT" })).json();
const socket = new WebSocket(target.webSocketDebuggerUrl);
await new Promise((resolve, reject) => {
  socket.addEventListener("open", resolve, { once: true });
  socket.addEventListener("error", reject, { once: true });
});

let nextId = 0;
const pending = new Map();
let activeDownload = null;
socket.addEventListener("message", (event) => {
  const message = JSON.parse(event.data);
  if (message.id) {
    const item = pending.get(message.id);
    if (!item) return;
    pending.delete(message.id);
    message.error ? item.reject(new Error(JSON.stringify(message.error))) : item.resolve(message.result);
    return;
  }
  if (message.method === "Browser.downloadWillBegin" && activeDownload) {
    activeDownload.guid = message.params.guid;
    activeDownload.suggested_filename = message.params.suggestedFilename;
    activeDownload.url = message.params.url;
  }
  if (message.method === "Browser.downloadProgress" && activeDownload && message.params.guid === activeDownload.guid) {
    activeDownload.received_bytes = message.params.receivedBytes;
    activeDownload.total_bytes = message.params.totalBytes;
    if (message.params.state === "completed") activeDownload.resolve("completed");
    if (message.params.state === "canceled") activeDownload.resolve("canceled");
  }
});

function command(method, params = {}) {
  const id = ++nextId;
  socket.send(JSON.stringify({ id, method, params }));
  return new Promise((resolve, reject) => pending.set(id, { resolve, reject }));
}
const wait = (milliseconds) => new Promise((resolve) => setTimeout(resolve, milliseconds));
const evaluate = async (expression) => {
  const result = await command("Runtime.evaluate", { expression, returnByValue: true, awaitPromise: true });
  if (result.exceptionDetails) throw new Error(result.exceptionDetails.text ?? "Runtime evaluation failed");
  return result.result.value;
};
async function waitFor(expression, timeout = 25000) {
  const started = Date.now();
  while (Date.now() - started < timeout) {
    if (await evaluate(expression)) return true;
    await wait(400);
  }
  return false;
}

await command("Page.enable");
await command("Runtime.enable");
await command("Emulation.setDeviceMetricsOverride", { width: 1800, height: 1100, deviceScaleFactor: 1, mobile: false });

const screenshotViews = new Set([
  "RV_00_RAIL_FULL_ARCHITECTURE_OVERVIEW",
  "RV_00_ALL16_L2_BOUNDARY_OVERVIEW",
  "RV_09_REGENERATIVE_BRAKING_CORE",
]);
const results = [];

for (const specification of creation.results) {
  const representationId = specification.representation?.id;
  const categoryDirectory = path.join(absoluteExportRoot, specification.category);
  fs.mkdirSync(categoryDirectory, { recursive: true });
  const representationUrl = `${projectBaseUrl}/${representationId}?selection=${representationId}`;
  const started = Date.now();
  let status = "FAIL";
  let error = null;
  let download = null;
  try {
    await command("Browser.setDownloadBehavior", { behavior: "allow", downloadPath: categoryDirectory, eventsEnabled: true });
    await command("Page.navigate", { url: representationUrl });
    const loaded = await waitFor(`Boolean(document.querySelector('[data-testid="export-diagram-to-image"]') && document.querySelector('.react-flow'))`);
    if (!loaded) throw new Error("SysON diagram toolbar or canvas did not become ready");
    await wait(1200);
    await evaluate(`(() => { const b=document.querySelector('[data-testid="fit-to-screen"]'); if(b)b.click(); return true; })()`);
    await wait(500);
    await evaluate(`(() => { const b=document.querySelector('[data-testid="export-diagram-to-image"]'); if(!b)return false; b.click(); return true; })()`);
    const menuReady = await waitFor(`Boolean(document.querySelector('[data-testid="export-diagram-to-svg"]'))`, 5000);
    if (!menuReady) throw new Error("SVG export command did not appear");
    const downloadPromise = new Promise((resolve) => {
      activeDownload = { resolve, guid: null, suggested_filename: null, received_bytes: 0, total_bytes: 0 };
      setTimeout(() => resolve("timeout"), 30000);
    });
    await evaluate(`(() => { const b=document.querySelector('[data-testid="export-diagram-to-svg"]'); if(!b)return false; b.click(); return true; })()`);
    const downloadState = await downloadPromise;
    download = {
      guid: activeDownload.guid,
      suggested_filename: activeDownload.suggested_filename,
      received_bytes: activeDownload.received_bytes,
      total_bytes: activeDownload.total_bytes,
      state: downloadState,
    };
    activeDownload = null;
    if (downloadState !== "completed") throw new Error(`SVG download ${downloadState}`);
    const exportedPath = path.join(categoryDirectory, download.suggested_filename);
    for (let index = 0; index < 20 && !fs.existsSync(exportedPath); index += 1) await wait(250);
    if (!fs.existsSync(exportedPath)) throw new Error(`Downloaded SVG not found: ${exportedPath}`);
    const deterministicPath = path.join(categoryDirectory, `${specification.view_name}.svg`);
    if (path.resolve(exportedPath) !== path.resolve(deterministicPath)) fs.copyFileSync(exportedPath, deterministicPath);
    download.path = deterministicPath;
    download.bytes = fs.statSync(deterministicPath).size;
    if (screenshotViews.has(specification.view_name)) {
      const screenshot = await command("Page.captureScreenshot", { format: "png", captureBeyondViewport: true });
      const screenshotName = `${specification.view_name}.png`;
      fs.writeFileSync(path.join(categoryDirectory, screenshotName), Buffer.from(screenshot.data, "base64"));
    }
    status = "PASS";
  } catch (exception) {
    error = exception instanceof Error ? `${exception.name}: ${exception.message}` : String(exception);
    activeDownload = null;
  }
  results.push({
    view_name: specification.view_name,
    label: specification.label,
    category: specification.category,
    representation_id: representationId,
    representation_url: representationUrl,
    status,
    download,
    error,
    elapsed_ms: Date.now() - started,
  });
  process.stdout.write(`${results.length}/${creation.results.length} ${specification.view_name}: ${status}${error ? ` - ${error}` : ""}\n`);
}

const output = {
  generated_at: new Date().toISOString(),
  project_base_url: projectBaseUrl,
  expected: creation.results.length,
  exported: results.filter((result) => result.status === "PASS").length,
  failed: results.filter((result) => result.status !== "PASS").length,
  results,
};
fs.mkdirSync(path.dirname(path.resolve(resultPath)), { recursive: true });
fs.writeFileSync(path.resolve(resultPath), `${JSON.stringify(output, null, 2)}\n`, "utf8");
socket.close();
await fetch(`${debugBase}/json/close/${target.id}`);
process.stdout.write(`${JSON.stringify({ expected: output.expected, exported: output.exported, failed: output.failed }, null, 2)}\n`);
if (output.failed > 0) process.exit(1);
