"""Resolve once, then UPSERT/validate twice to prove Neo4j idempotency."""
import subprocess,sys
from pathlib import Path
HERE=Path(__file__).resolve().parent
def run(name,*args):
 print(f'== {name} {" ".join(args)} ==',flush=True);subprocess.run([sys.executable,str(HERE/name),*args],check=True)
run('07_resolve_candidates.py')
run('08_build_connectgraph.py');run('09_validate_connectgraph.py','--snapshot','first')
run('08_build_connectgraph.py');run('09_validate_connectgraph.py','--snapshot','second')
