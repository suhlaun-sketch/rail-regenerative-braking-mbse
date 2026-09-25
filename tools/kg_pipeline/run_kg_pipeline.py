"""Run extraction and Neo4j upsert twice for idempotency."""
import subprocess,sys
from pathlib import Path
root=Path(__file__).resolve().parent; py=root/'.venv'/'Scripts'/'python.exe'
for name in ['00_probe_sources.py','01_extract_graph_data.py','02_init_schema.py','03_load_products.py','04_load_items.py','05_load_ports.py','06_validate_graph.py','03_load_products.py','04_load_items.py','05_load_ports.py','06_validate_graph.py']:
 print(f'== {name} =='); subprocess.run([str(py),str(root/name)],check=True)
