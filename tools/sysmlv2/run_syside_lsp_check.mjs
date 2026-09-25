import fs from "node:fs/promises";
import path from "node:path";
import { pathToFileURL } from "node:url";
import { spawn } from "node:child_process";

const root = path.resolve(import.meta.dirname, "..", "..");
const integration = path.join(root, "work", "sysmlv2", "syside_integration");
const exe = path.join(integration, "config", "syside-0.10.3", "syside.exe");
const config = path.join(integration, "config", "syside.toml");
const logFile = path.join(integration, "logs", "syside_lsp_full_rail.log");
const output = path.join(integration, "logs", "syside_lsp_diagnostics.json");
const model = path.join(root, "work", "sysmlv2", "full_engineering_model", "01_generated", "Rail_MBSE_Full_v1.sysml");
const sessionRoot = path.join(integration, "session_full_rail");

await fs.mkdir(path.dirname(output), { recursive: true });
await fs.mkdir(sessionRoot, { recursive: true });
const child = spawn(exe, [
  "server", "--config", config, "--log", logFile, "--log-level", "debug",
  "--trace", "off", "--crash-reports", "ignore", "--edit", "all", "--stdio"
], { cwd: root, stdio: ["pipe", "pipe", "pipe"] });

let buffer = Buffer.alloc(0);
let nextId = 1;
const pending = new Map();
const published = new Map();
let stderr = "";
child.stderr.on("data", chunk => { stderr += chunk.toString("utf8"); });

function send(message) {
  const body = Buffer.from(JSON.stringify(message), "utf8");
  child.stdin.write(`Content-Length: ${body.length}\r\n\r\n`);
  child.stdin.write(body);
}

function request(method, params, timeoutMs = 120000) {
  const id = nextId++;
  send({ jsonrpc: "2.0", id, method, params });
  return new Promise((resolve, reject) => {
    const timer = setTimeout(() => {
      pending.delete(id);
      reject(new Error(`Timeout waiting for ${method}`));
    }, timeoutMs);
    pending.set(id, { resolve, reject, timer, method });
  });
}

function notify(method, params) {
  send({ jsonrpc: "2.0", method, params });
}

function handle(message) {
  if (message.id !== undefined && pending.has(message.id)) {
    const slot = pending.get(message.id);
    clearTimeout(slot.timer);
    pending.delete(message.id);
    if (message.error) slot.reject(new Error(`${slot.method}: ${JSON.stringify(message.error)}`));
    else slot.resolve(message.result);
    return;
  }
  if (message.method === "textDocument/publishDiagnostics") {
    published.set(message.params.uri, message.params.diagnostics || []);
  }
}

child.stdout.on("data", chunk => {
  buffer = Buffer.concat([buffer, chunk]);
  while (true) {
    const marker = buffer.indexOf("\r\n\r\n");
    if (marker < 0) return;
    const header = buffer.subarray(0, marker).toString("ascii");
    const match = /Content-Length:\s*(\d+)/i.exec(header);
    if (!match) throw new Error(`Invalid LSP header: ${header}`);
    const length = Number(match[1]);
    const start = marker + 4;
    if (buffer.length < start + length) return;
    const body = buffer.subarray(start, start + length).toString("utf8");
    buffer = buffer.subarray(start + length);
    handle(JSON.parse(body));
  }
});

const modelUri = pathToFileURL(model).href;
const rootUri = pathToFileURL(sessionRoot).href;
let initializeResult;
let pullResult = null;
let status = "FAIL";
let exception = null;

try {
  initializeResult = await request("initialize", {
    processId: process.pid,
    clientInfo: { name: "Rail MBSE SysIDE evidence client", version: "1.0" },
    rootUri,
    workspaceFolders: [{ uri: rootUri, name: "Rail Full SysML isolated validation" }],
    capabilities: {
      workspace: { diagnostics: { refreshSupport: true } },
      textDocument: { diagnostic: { dynamicRegistration: true, relatedDocumentSupport: true } }
    }
  });
  notify("initialized", {});
  const text = await fs.readFile(model, "utf8");
  notify("textDocument/didOpen", {
    textDocument: { uri: modelUri, languageId: "sysml", version: 1, text }
  });
  await new Promise(resolve => setTimeout(resolve, 2500));
  if (initializeResult?.capabilities?.diagnosticProvider) {
    pullResult = await request("textDocument/diagnostic", {
      textDocument: { uri: modelUri },
      identifier: null,
      previousResultId: null
    });
  } else {
    await new Promise(resolve => setTimeout(resolve, 2500));
  }
  status = "PASS";
} catch (error) {
  exception = error.stack || String(error);
} finally {
  try { await request("shutdown", null, 10000); } catch {}
  try { notify("exit", null); } catch {}
  child.stdin.end();
  await new Promise(resolve => {
    const timer = setTimeout(() => { child.kill(); resolve(); }, 5000);
    child.once("exit", () => { clearTimeout(timer); resolve(); });
  });
}

const diagnostics = pullResult?.items || published.get(modelUri) || [];
const severityCounts = { error: 0, warning: 0, information: 0, hint: 0, unknown: 0 };
for (const diagnostic of diagnostics) {
  const key = ({ 1: "error", 2: "warning", 3: "information", 4: "hint" })[diagnostic.severity] || "unknown";
  severityCounts[key]++;
}
const result = {
  status,
  tool: "Syside Editor language server",
  version: "0.10.3",
  executable: exe,
  standard_library: path.join(integration, "config", "syside-0.10.3", "share", "sysml.library"),
  files_parsed: [model],
  initialize_capabilities: initializeResult?.capabilities || null,
  diagnostic_transport: pullResult ? "textDocument/diagnostic" : "textDocument/publishDiagnostics",
  severity_counts: severityCounts,
  diagnostics,
  stderr,
  exception
};
await fs.writeFile(output, JSON.stringify(result, null, 2), "utf8");
console.log(JSON.stringify({
  status, version: result.version, files_parsed: 1,
  diagnostic_transport: result.diagnostic_transport,
  severity_counts: severityCounts, diagnostic_count: diagnostics.length,
  exception, stderr
}, null, 2));
if (status !== "PASS") process.exitCode = 1;
