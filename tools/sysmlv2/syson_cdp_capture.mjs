import fs from "node:fs";
import path from "node:path";

const [debugBase, projectUrl, representationLabel, screenshotPath, inspectionPath] = process.argv.slice(2);
if (!inspectionPath) {
  process.stderr.write("Usage: node syson_cdp_capture.mjs <debug-base> <project-url> <representation-label> <screenshot.png> <inspection.json>\n");
  process.exit(2);
}

const targetResponse = await fetch(`${debugBase}/json/new?${encodeURIComponent("about:blank")}`, { method: "PUT" });
const target = await targetResponse.json();
const socket = new WebSocket(target.webSocketDebuggerUrl);
await new Promise((resolve, reject) => {
  socket.addEventListener("open", resolve, { once: true });
  socket.addEventListener("error", reject, { once: true });
});

let sequence = 0;
const pending = new Map();
socket.addEventListener("message", (event) => {
  const message = JSON.parse(event.data);
  if (!message.id) return;
  const handler = pending.get(message.id);
  if (!handler) return;
  pending.delete(message.id);
  if (message.error) handler.reject(new Error(JSON.stringify(message.error)));
  else handler.resolve(message.result);
});

function command(method, params = {}) {
  const id = ++sequence;
  socket.send(JSON.stringify({ id, method, params }));
  return new Promise((resolve, reject) => pending.set(id, { resolve, reject }));
}
const wait = (milliseconds) => new Promise((resolve) => setTimeout(resolve, milliseconds));
const evaluate = async (expression) => {
  const result = await command("Runtime.evaluate", { expression, awaitPromise: true, returnByValue: true });
  if (result.exceptionDetails) throw new Error(result.exceptionDetails.text ?? "Runtime evaluation failed");
  return result.result?.value;
};

await command("Page.enable");
await command("Runtime.enable");
await command("Emulation.setDeviceMetricsOverride", { width: 1800, height: 1100, deviceScaleFactor: 1, mobile: false });
await command("Page.navigate", { url: projectUrl });
await wait(12000);

const clickResult = await evaluate(`(() => {
  const wanted = ${JSON.stringify(representationLabel)};
  const elements = [...document.querySelectorAll('a,button,[role="button"],li,div,span')];
  const exact = elements.filter((element) => (element.textContent || '').trim() === wanted);
  const element = exact.find((candidate) => candidate.tagName === 'A' || candidate.tagName === 'BUTTON' || candidate.getAttribute('role') === 'button') || exact.at(-1);
  if (!element) return { clicked: false, candidates: exact.length };
  element.click();
  return { clicked: true, tag: element.tagName, outerHTML: element.outerHTML.slice(0, 1000), candidates: exact.length };
})()`);
await wait(12000);

const inspection = await evaluate(`(() => ({
  title: document.title,
  url: location.href,
  bodyTextSample: document.body.innerText.slice(0, 6000),
  buttons: [...document.querySelectorAll('button')].map((element) => ({
    text: (element.innerText || '').trim(),
    title: element.getAttribute('title'),
    ariaLabel: element.getAttribute('aria-label'),
    testId: element.getAttribute('data-testid'),
  })).filter((item) => item.text || item.title || item.ariaLabel || item.testId),
  svgs: [...document.querySelectorAll('svg')].map((element) => ({
    width: element.getAttribute('width'),
    height: element.getAttribute('height'),
    ariaLabel: element.getAttribute('aria-label'),
    className: element.getAttribute('class'),
  })).slice(0, 100),
}))()`);

const screenshot = await command("Page.captureScreenshot", { format: "png", captureBeyondViewport: true });
fs.mkdirSync(path.dirname(path.resolve(screenshotPath)), { recursive: true });
fs.writeFileSync(path.resolve(screenshotPath), Buffer.from(screenshot.data, "base64"));
fs.mkdirSync(path.dirname(path.resolve(inspectionPath)), { recursive: true });
fs.writeFileSync(path.resolve(inspectionPath), `${JSON.stringify({ click_result: clickResult, inspection }, null, 2)}\n`, "utf8");
process.stdout.write(`${JSON.stringify({ click_result: clickResult, title: inspection.title, url: inspection.url, buttons: inspection.buttons.filter((item) => /export|svg|png|download/i.test(JSON.stringify(item))) }, null, 2)}\n`);

socket.close();
await fetch(`${debugBase}/json/close/${target.id}`);
