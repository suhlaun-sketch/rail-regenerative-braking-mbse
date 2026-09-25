import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";

function fail(message) {
  process.stderr.write(`${message}\n`);
  process.exit(2);
}

const [endpoint, editingContextId, objectId, inputPath, outputPath] = process.argv.slice(2);
if (!endpoint || !editingContextId || !objectId || !inputPath || !outputPath) {
  fail(
    "Usage: node syson_direct_import.mjs <endpoint> <editing-context-id> <object-id> <input.sysml> <result.json>",
  );
}

const absoluteInput = path.resolve(inputPath);
const absoluteOutput = path.resolve(outputPath);
const textualContent = fs.readFileSync(absoluteInput, "utf8");
const inputSha256 = crypto.createHash("sha256").update(textualContent).digest("hex");

const query = `
mutation insertTextualSysMLv2($input: InsertTextualSysMLv2Input!) {
  insertTextualSysMLv2(input: $input) {
    __typename
    ... on SuccessPayload {
      id
      messages { level body }
    }
    ... on ErrorPayload {
      id
      messages { level body }
    }
  }
}`;

const startedAt = new Date();
let httpStatus = null;
let responseBody = null;
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
          objectId,
          textualContent,
        },
      },
    }),
  });
  httpStatus = response.status;
  responseBody = await response.json();
} catch (error) {
  exception = error instanceof Error ? `${error.name}: ${error.message}` : String(error);
}

const finishedAt = new Date();
const payload = responseBody?.data?.insertTextualSysMLv2 ?? null;
const result = {
  endpoint,
  editing_context_id: editingContextId,
  object_id: objectId,
  input_file: absoluteInput,
  input_bytes: Buffer.byteLength(textualContent, "utf8"),
  input_sha256: inputSha256,
  started_at: startedAt.toISOString(),
  finished_at: finishedAt.toISOString(),
  elapsed_ms: finishedAt.getTime() - startedAt.getTime(),
  http_status: httpStatus,
  payload_type: payload?.__typename ?? null,
  messages: payload?.messages ?? [],
  graphql_errors: responseBody?.errors ?? [],
  exception,
  response: responseBody,
};

fs.mkdirSync(path.dirname(absoluteOutput), { recursive: true });
fs.writeFileSync(absoluteOutput, `${JSON.stringify(result, null, 2)}\n`, "utf8");
process.stdout.write(`${JSON.stringify(result, null, 2)}\n`);

if (exception || httpStatus !== 200 || payload?.__typename !== "SuccessPayload") {
  process.exit(1);
}
