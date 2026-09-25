"""Build a non-destructive publication copy from the authoritative local project."""
from __future__ import annotations
import argparse
import collections
import json
import os
import shutil
from pathlib import Path

ROOT_NAMES = {
    "01_baseline_audit", "02_SC_v1_results", "分系统demo", "config",
    "data_structure", "icd", "models", "OUTPUT", "reports", "Req",
    "scripts", "SysML", "tools", "ui", "work",
}
SKIP_PARTS = {
    ".git", ".venv", "venv", "node_modules", "__pycache__", "slprj",
    ".pytest_cache", ".mypy_cache", ".cache", "dist", "build", "codegen",
    "logs", "postgres-data", "pgdata", ".artifact_runtime",
}
SKIP_SUFFIXES = {".pyc", ".slxc", ".autosave", ".bak", ".tmp", ".jar", ".exe"}
SKIP_NAMES = {".env", ".env.local", "ui_processes.json", "syson_frontend_bundle.js"}

def reason(rel: Path) -> str | None:
    parts = rel.parts
    lower = tuple(x.lower() for x in parts)
    if parts[0] not in ROOT_NAMES and parts[0] != "third_party":
        if len(parts) == 1 and rel.suffix.lower() in {".xlsx", ".json", ".slx", ".m", ".md", ".csv"}:
            return None
        return "unselected_root"
    if parts[0] == "third_party":
        if lower[:3] != ("third_party", "ssi_transformer", "standard-system-interface"):
            return "external_toolchain"
        if len(parts) > 3 and lower[3] in {"p1_ssp", "p4_ssp"}:
            return "third_party_examples"
    if any(p.lower() in SKIP_PARTS for p in parts[:-1]):
        return "runtime_or_dependency"
    if parts[0] == "work" and lower[:3] == ("work", "sysmlv2", "syson_integration"):
        if len(parts) > 3 and lower[3] in {"exports", "workspace", "runtime"}:
            return "superseded_syson_intermediate"
    if lower[:3] == ("work", "simulation", "simulink_fmu_v1"):
        if len(parts) > 3 and lower[3] == "09_tools":
            return "downloaded_toolchain"
    if lower[:2] == ("tools", "syson-local") and len(parts) > 2 and lower[2] == "data":
        return "database_volume"
    if lower[:2] == ("ui", "cache") and len(parts) > 2:
        return "browser_cache"
    if lower[:3] == ("ui", "backend", "cache"):
        return "runtime_cache"
    name = parts[-1]
    if name in SKIP_NAMES or name.startswith(".env."):
        return "secret_or_runtime_config"
    if rel.suffix.lower() in SKIP_SUFFIXES:
        return "compiled_or_third_party_binary"
    if rel.suffix.lower() == ".pdf" and parts[0] in {"SysML", "data_structure", "third_party"}:
        return "third_party_document"
    if rel.suffix.lower() == ".zip" and parts[:2] == ("work", "ssi_transformer_deployment"):
        return "downloaded_third_party_package"
    if name.endswith(".db") or name.endswith(".sqlite"):
        return "runtime_database"
    return None

def main():
    ap=argparse.ArgumentParser()
    ap.add_argument("--source",required=True,type=Path)
    ap.add_argument("--dest",required=True,type=Path)
    ap.add_argument("--dry-run",action="store_true")
    args=ap.parse_args()
    src=args.source.resolve(); dest=args.dest.resolve()
    if src == dest or src in dest.parents:
        raise SystemExit("destination must be an isolated sibling of source")
    included=[]; excluded=collections.defaultdict(lambda:[0,0]); errors=[]
    for base,dirs,files in os.walk(src):
        dirs[:]=[d for d in dirs if not (Path(base)/d).is_symlink()]
        for name in files:
            p=Path(base)/name
            if p.is_symlink():
                continue
            rel=p.relative_to(src)
            try: size=p.stat().st_size
            except OSError as exc:
                errors.append((str(rel),str(exc))); continue
            why=reason(rel)
            if why:
                excluded[why][0]+=1; excluded[why][1]+=size; continue
            included.append((p,rel,size))
    print(f"INCLUDED_FILES={len(included)} INCLUDED_MIB={sum(x[2] for x in included)/1048576:.1f}",flush=True)
    for why,(count,size) in sorted(excluded.items(),key=lambda x:-x[1][1]):
        print(f"EXCLUDED {why} FILES={count} MIB={size/1048576:.1f}",flush=True)
    print(f"SCAN_ERRORS={len(errors)}",flush=True)
    if errors: print(f"FIRST_SCAN_ERROR={errors[0]}",flush=True)
    if args.dry_run:
        return
    copied=0
    for p,rel,size in included:
        target=dest/rel
        if target.exists():
            if target.stat().st_size != size:
                raise RuntimeError(f"destination collision: {rel}")
            continue
        target.parent.mkdir(parents=True,exist_ok=True)
        shutil.copy2(p,target)
        copied+=1
    report={"source":str(src),"destination":str(dest),
            "included":[{"path":str(rel).replace(os.sep,"/"),"size":size} for _,rel,size in included],
            "excluded":{k:{"files":v[0],"bytes":v[1]} for k,v in excluded.items()},
            "scan_errors":errors}
    out=dest/"docs"/"publishing"/"COPY_SELECTION.json"
    out.parent.mkdir(parents=True,exist_ok=True)
    out.write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding="utf-8")
    print(f"COPIED_FILES={copied}",flush=True)

if __name__=="__main__":
    main()
