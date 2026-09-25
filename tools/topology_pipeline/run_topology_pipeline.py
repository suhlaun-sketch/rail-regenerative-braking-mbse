"""Run the frozen-KG topology candidate pipeline."""
import subprocess,sys
from pathlib import Path
HERE=Path(__file__).resolve().parent
for name in ['01_build_role_map.py','02_build_topology_rules.py','03_generate_candidates.py','04_build_physical_nets.py','05_build_port_coverage.py','06_validate_candidate_topology.py']:
 print(f'== {name} ==',flush=True);subprocess.run([sys.executable,str(HERE/name)],check=True)
