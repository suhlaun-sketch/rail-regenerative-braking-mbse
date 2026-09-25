import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";

const [endpoint, editingContextId, specificationPath, outputPath] = process.argv.slice(2);
if (!endpoint || !editingContextId || !specificationPath || !outputPath) {
  process.stderr.write("Usage: node syson_create_representations.mjs <endpoint> <editing-context-id> <spec.json> <result.json>\n");
  process.exit(2);
}

const specifications = JSON.parse(fs.readFileSync(path.resolve(specificationPath), "utf8"));
const query = `
mutation createRepresentation($input: CreateRepresentationInput!) {
  createRepresentation(input: $input) {
    __typename
    ... on CreateRepresentationSuccessPayload {
      representation { __typename id label }
    }
    ... on ErrorPayload { messages { level body } }
  }
}`;

const generalViewDescriptionId =
  "siriusComponents://representationDescription?kind=diagramDescription&sourceKind=view&sourceId=8dcd14b0-6259-3193-ad2c-743f394c68e4&sourceElementId=db495705-e917-319b-af55-a32ad63f4089";
const results = [];

for (const specification of specifications) {
  const started = Date.now();
  let httpStatus = null;
  let body = null;
  let exception = null;
  try {
    const response = await fetch(endpoint, {
      method: "POST",
      headers: { "content-type": "application/json" },
      body: JSON.stringify({
        query,
        variables: {
          input: {
            id: crypto.randomUUID(),
            editingContextId,
            objectId: specification.object_id,
            representationName: specification.label,
            representationDescriptionId: specification.representation_description_id ?? generalViewDescriptionId,
          },
        },
      }),
    });
    httpStatus = response.status;
    body = await response.json();
  } catch (error) {
    exception = error instanceof Error ? `${error.name}: ${error.message}` : String(error);
  }
  const payload = body?.data?.createRepresentation ?? null;
  results.push({
    ...specification,
    http_status: httpStatus,
    payload_type: payload?.__typename ?? null,
    representation: payload?.representation ?? null,
    messages: payload?.messages ?? [],
    graphql_errors: body?.errors ?? [],
    exception,
    elapsed_ms: Date.now() - started,
  });
  process.stdout.write(`${specification.label}: ${payload?.__typename ?? "NO_PAYLOAD"}\n`);
}

const output = {
  endpoint,
  editing_context_id: editingContextId,
  representation_description_id: generalViewDescriptionId,
  attempted: results.length,
  succeeded: results.filter((result) => result.payload_type === "CreateRepresentationSuccessPayload").length,
  failed: results.filter((result) => result.payload_type !== "CreateRepresentationSuccessPayload").length,
  results,
};
fs.mkdirSync(path.dirname(path.resolve(outputPath)), { recursive: true });
fs.writeFileSync(path.resolve(outputPath), `${JSON.stringify(output, null, 2)}\n`, "utf8");

if (output.failed > 0) process.exit(1);
