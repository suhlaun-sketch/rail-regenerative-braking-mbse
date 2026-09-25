import fs from "node:fs";
import path from "node:path";

const [creationPath, exportRoot, missingSpecPath, resultPath] = process.argv.slice(2);
const creation = JSON.parse(fs.readFileSync(path.resolve(creationPath), "utf8"));
const absoluteExportRoot = path.resolve(exportRoot);
const normalize = (value) => value.normalize("NFKC").replace(/\.svg$/i, "").replace(/[\s_()]+/g, "").toLowerCase();
const results = [];

for (const specification of creation.results) {
  const categoryDirectory = path.join(absoluteExportRoot, specification.category);
  fs.mkdirSync(categoryDirectory, { recursive: true });
  const deterministicPath = path.join(categoryDirectory, `${specification.view_name}.svg`);
  let sourcePath = null;
  if (fs.existsSync(deterministicPath)) sourcePath = deterministicPath;
  else {
    const files = fs.readdirSync(categoryDirectory).filter((filename) => filename.toLowerCase().endsWith(".svg") && filename.toLowerCase() !== "diagram.svg");
    const matches = files.filter((filename) => normalize(filename) === normalize(specification.label));
    if (matches.length === 1) {
      sourcePath = path.join(categoryDirectory, matches[0]);
      fs.copyFileSync(sourcePath, deterministicPath);
    }
  }
  results.push({
    view_name: specification.view_name,
    label: specification.label,
    category: specification.category,
    source_path: sourcePath,
    deterministic_path: deterministicPath,
    indexed: fs.existsSync(deterministicPath),
  });
}

const missingNames = new Set(results.filter((result) => !result.indexed).map((result) => result.view_name));
const missingSpecifications = creation.results.filter((specification) => missingNames.has(specification.view_name));
fs.writeFileSync(path.resolve(missingSpecPath), `${JSON.stringify({ results: missingSpecifications }, null, 2)}\n`, "utf8");
const output = {
  expected: results.length,
  indexed: results.filter((result) => result.indexed).length,
  missing: missingSpecifications.length,
  missing_view_names: [...missingNames],
  results,
};
fs.writeFileSync(path.resolve(resultPath), `${JSON.stringify(output, null, 2)}\n`, "utf8");
process.stdout.write(`${JSON.stringify({ expected: output.expected, indexed: output.indexed, missing: output.missing, missing_view_names: output.missing_view_names }, null, 2)}\n`);
