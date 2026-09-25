# Rail MBSE Topology Rule Layer

This pipeline reads the frozen `tools/kg_pipeline/work/graph_data.json` and writes only offline topology artifacts. It never writes Neo4j, creates Port nodes, creates `CONNECTS_TO`, or creates a final executable Connection.

Run:

```powershell
tools\kg_pipeline\.venv\Scripts\python.exe tools\topology_pipeline\run_topology_pipeline.py
```

Stages:

1. derive Product roles and Port-local side semantics;
2. resolve and audit hard topology rules and variant groups;
3. enumerate interface-compatible pairs, then retain only hard-rule candidates;
4. build explicit physical nets without pairwise cliques;
5. assign exactly one coverage disposition to each Active EXPOSES;
6. re-read artifacts and run closure, voltage-continuity, freeze, and hard-rule QA.

`UNRESOLVED` and `UNRESOLVED_ROUTE` are intentional stop states. They prevent unsupported deployment, cardinality, or variant choices from becoming final connections.
