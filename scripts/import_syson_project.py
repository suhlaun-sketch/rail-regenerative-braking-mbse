"""Import the exported formal SysON project into a fresh SysON instance."""
from __future__ import annotations

import argparse
import io
import json
import uuid
import zipfile
from pathlib import Path
from urllib.request import Request, urlopen

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_ZIP = ROOT / "artifacts/syson/Rail_Regenerative_Braking_MBSE_FULL.zip"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--url", default="http://127.0.0.1:8080")
    parser.add_argument("--zip", type=Path, default=DEFAULT_ZIP)
    args = parser.parse_args()
    if not args.zip.is_file():
        parser.error(f"Project ZIP missing: {args.zip}")
    boundary = "----railmbse" + uuid.uuid4().hex
    mutation = (
        "mutation Upload($input: UploadProjectInput!) { uploadProject(input:$input) "
        "{ __typename ... on UploadProjectSuccessPayload { id project { id name } } "
        "... on ErrorPayload { message } } }"
    )
    operations = json.dumps(
        {"query": mutation, "variables": {"input": {"id": str(uuid.uuid4()), "file": None}}}
    ).encode()
    upload_map = json.dumps({"0": "variables.file"}).encode()
    file_bytes = args.zip.read_bytes()
    segments = []
    for name, data, content_type, filename in (
        ("operations", operations, "application/json", None),
        ("map", upload_map, "application/json", None),
        ("0", file_bytes, "application/zip", args.zip.name),
    ):
        header = f"--{boundary}\r\nContent-Disposition: form-data; name=\"{name}\""
        if filename:
            header += f'; filename="{filename}"'
        header += f"\r\nContent-Type: {content_type}\r\n\r\n"
        segments.extend([header.encode(), data, b"\r\n"])
    segments.append(f"--{boundary}--\r\n".encode())
    request = Request(
        args.url.rstrip("/") + "/api/graphql/upload",
        data=b"".join(segments),
        headers={"Content-Type": f"multipart/form-data; boundary={boundary}"},
        method="POST",
    )
    with urlopen(request, timeout=1800) as response:
        body = response.read()
        try:
            result = json.loads(body)
        except json.JSONDecodeError:
            raise RuntimeError(f"SysON upload returned {response.status} {response.headers.get('Content-Type')}: {body[:300]!r}")
    payload = result.get("data", {}).get("uploadProject", {})
    if result.get("errors") or payload.get("__typename") != "UploadProjectSuccessPayload":
        print(json.dumps(result, ensure_ascii=False, indent=2))
        raise SystemExit(1)
    project_id = payload["project"]["id"]
    with urlopen(args.url.rstrip("/") + "/api/projects/" + project_id, timeout=180) as response:
        exported = response.read()
    with zipfile.ZipFile(io.BytesIO(exported)) as archive:
        labels = [json.loads(archive.read(name)).get("label", "")
                  for name in archive.namelist()
                  if "/representations/" in name and name.endswith(".json")]
    count = sum(label.startswith("AUTO_IBD_") for label in labels)
    print(json.dumps({"project_id": project_id, "name": payload["project"]["name"],
                      "representation_count": len(labels), "formal_ibd_count": count,
                      "status": "PASS" if count == 57 else "FAIL"}, ensure_ascii=False))
    if count != 57:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
