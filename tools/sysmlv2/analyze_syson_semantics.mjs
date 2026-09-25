import fs from "node:fs";
import path from "node:path";

const [inputPath, outputPath] = process.argv.slice(2);
if (!inputPath || !outputPath) {
  process.stderr.write("Usage: node analyze_syson_semantics.mjs <semantic_document.json> <inventory.json>\n");
  process.exit(2);
}

const documentJson = JSON.parse(fs.readFileSync(path.resolve(inputPath), "utf8").trim());
const records = [];

function visit(value, namedAncestors = [], classAncestors = []) {
  if (Array.isArray(value)) {
    for (const child of value) visit(child, namedAncestors, classAncestors);
    return;
  }
  if (!value || typeof value !== "object") return;

  let nextNamed = namedAncestors;
  let nextClasses = classAncestors;
  if (typeof value.eClass === "string" && typeof value.id === "string") {
    const data = value.data && typeof value.data === "object" ? value.data : {};
    const declaredName = typeof data.declaredName === "string" ? data.declaredName : null;
    const basicName = typeof data.name === "string" ? data.name : null;
    const name = declaredName ?? basicName;
    nextNamed = name ? [...namedAncestors, name] : namedAncestors;
    nextClasses = [...classAncestors, value.eClass];
    records.push({
      id: value.id,
      element_id: typeof data.elementId === "string" ? data.elementId : null,
      eclass: value.eClass,
      declared_name: declaredName,
      name: basicName,
      qualified_path: nextNamed.join("::"),
      named_ancestors: namedAncestors,
      class_ancestors: classAncestors,
      top_package: namedAncestors.length > 0 ? namedAncestors[0] : name,
    });
  }

  for (const child of Object.values(value)) {
    visit(child, nextNamed, nextClasses);
  }
}

visit(documentJson);

const byEclass = {};
const byTopPackage = {};
for (const record of records) {
  byEclass[record.eclass] = (byEclass[record.eclass] ?? 0) + 1;
  const pkg = record.top_package ?? "<unnamed>";
  byTopPackage[pkg] ??= {};
  byTopPackage[pkg][record.eclass] = (byTopPackage[pkg][record.eclass] ?? 0) + 1;
}

const inventory = {
  source: path.resolve(inputPath),
  total_emf_objects: records.length,
  by_eclass: Object.fromEntries(Object.entries(byEclass).sort(([a], [b]) => a.localeCompare(b))),
  by_top_package: Object.fromEntries(
    Object.entries(byTopPackage)
      .sort(([a], [b]) => a.localeCompare(b))
      .map(([pkg, counts]) => [pkg, Object.fromEntries(Object.entries(counts).sort(([a], [b]) => a.localeCompare(b)))]),
  ),
  records,
};

const absoluteOutput = path.resolve(outputPath);
fs.mkdirSync(path.dirname(absoluteOutput), { recursive: true });
fs.writeFileSync(absoluteOutput, `${JSON.stringify(inventory, null, 2)}\n`, "utf8");
process.stdout.write(
  `${JSON.stringify({ total_emf_objects: records.length, by_eclass: inventory.by_eclass }, null, 2)}\n`,
);
