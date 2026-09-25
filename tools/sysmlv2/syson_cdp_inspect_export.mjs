const [debugBase, representationUrl] = process.argv.slice(2);
const target = await (await fetch(`${debugBase}/json/new?${encodeURIComponent("about:blank")}`, { method: "PUT" })).json();
const socket = new WebSocket(target.webSocketDebuggerUrl);
await new Promise((resolve, reject) => {
  socket.addEventListener("open", resolve, { once: true });
  socket.addEventListener("error", reject, { once: true });
});
let nextId = 0;
const pending = new Map();
socket.addEventListener("message", (event) => {
  const message = JSON.parse(event.data);
  const item = pending.get(message.id);
  if (!item) return;
  pending.delete(message.id);
  message.error ? item.reject(new Error(JSON.stringify(message.error))) : item.resolve(message.result);
});
const command = (method, params = {}) => {
  const id = ++nextId;
  socket.send(JSON.stringify({ id, method, params }));
  return new Promise((resolve, reject) => pending.set(id, { resolve, reject }));
};
const wait = (milliseconds) => new Promise((resolve) => setTimeout(resolve, milliseconds));
const evaluate = async (expression) => (await command("Runtime.evaluate", { expression, returnByValue: true, awaitPromise: true })).result.value;
await command("Page.enable");
await command("Runtime.enable");
await command("Page.navigate", { url: representationUrl });
await wait(12000);
const clicked = await evaluate(`(() => { const b=document.querySelector('[data-testid="export-diagram-to-image"]'); if(!b)return false; b.click(); return true; })()`);
await wait(1000);
const inspection = await evaluate(`(() => ({body:document.body.innerText.slice(-4000), elements:[...document.querySelectorAll('button,[role="menuitem"],li')].map(e=>({text:(e.innerText||'').trim(),testId:e.getAttribute('data-testid'),aria:e.getAttribute('aria-label'),title:e.getAttribute('title')})).filter(x=>x.text||x.testId||x.aria||x.title).slice(-100)}))()`);
process.stdout.write(`${JSON.stringify({ clicked, inspection }, null, 2)}\n`);
socket.close();
await fetch(`${debugBase}/json/close/${target.id}`);
