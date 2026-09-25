import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";

const [creationPath, exportRoot, outputPath] = process.argv.slice(2);
const creation = JSON.parse(fs.readFileSync(path.resolve(creationPath), "utf8"));
const results = [];

async function hashFile(filename) {
  const hash = crypto.createHash("sha256");
  for await (const chunk of fs.createReadStream(filename)) hash.update(chunk);
  return hash.digest("hex");
}

for (const specification of creation.results) {
  const filename = path.resolve(exportRoot, specification.category, `${specification.view_name}.svg`);
  let exists = fs.existsSync(filename);
  let bytes = 0;
  let validSvgEnvelope = false;
  let digest = null;
  if (exists) {
    const stat = fs.statSync(filename);
    bytes = stat.size;
    const descriptor = fs.openSync(filename, "r");
    const head = Buffer.alloc(Math.min(4096, bytes));
    const tail = Buffer.alloc(Math.min(4096, bytes));
    fs.readSync(descriptor, head, 0, head.length, 0);
    fs.readSync(descriptor, tail, 0, tail.length, Math.max(0, bytes - tail.length));
    fs.closeSync(descriptor);
    validSvgEnvelope = /<svg[\s>]/i.test(head.toString("utf8")) && /<\/svg>\s*$/i.test(tail.toString("utf8"));
    digest = await hashFile(filename);
  }
  results.push({
    view_name: specification.view_name,
    category: specification.category,
    representation_id: specification.representation.id,
    file: filename,
    exists,
    bytes,
    sha256: digest,
    valid_svg_envelope: validSvgEnvelope,
    status: exists && bytes > 0 && validSvgEnvelope ? "PASS" : "FAIL",
  });
  process.stdout.write(`${results.length}/${creation.results.length} ${specification.view_name}: ${results.at(-1).status}\n`);
}

const output = {
  generated_at: new Date().toISOString(),
  expected: results.length,
  valid: results.filter((result) => result.status === "PASS").length,
  failed: results.filter((result) => result.status !== "PASS").length,
  total_bytes: results.reduce((total, result) => total + result.bytes, 0),
  results,
};
fs.writeFileSync(path.resolve(outputPath), `${JSON.stringify(output, null, 2)}\n`, "utf8");
process.stdout.write(`${JSON.stringify({ expected: output.expected, valid: output.valid, failed: output.failed, total_bytes: output.total_bytes }, null, 2)}\n`);
if (output.failed > 0) process.exit(1);
