# SysON Full Rail Visualization Report

- SysON: v2026.7.0
- Deployment: official application JAR with PostgreSQL 15.19
- URL: http://localhost:8080
- Project: Rail MBSE Full v1 (4db1e0e8-09cd-45e3-b97f-562eb6ae3cdf)
- Full SysML import: PASS
- Semantic projection: NOT NEEDED
- Visualization-only projection: GENERATED from frozen Full SysML
- Authoritative Full SysML modified: NO

## Persisted SysON Views

- Planned: 76
- Created: 76
- Persisted: 76
- Failed: 0
- L2 detailed views: 16/16

## Visualization Coverage

| Element | Visualized | Required | Coverage |
|---|---:|---:|---:|
| Products | 147 | 147 | 100% |
| Raw Ports | 517 | 517 | 100% |
| Functions | 191 | 191 | 100% |
| Allocations | 191 | 191 | 100% |
| Final Connections | 184 | 184 | 100% |
| Physical Nets | 9 | 9 | 100% |

## Actual Diagram Edge Evidence

- Allocation edges: 191
- Final connection edges: 184
- Physical-net edges: 9
- All16 L2 boundary edges: 74
- Regenerative-braking core edges: 15

## Key Views

- Rail Full Architecture Overview: PASS
- Full L2 Interface Overview: PASS
- Regenerative Braking Core: PASS

## Mapping Integrity

The direct authoritative import contains all original semantic elements. The additional files under `syson_integration/projection/generated` are generated visualization definitions only. Deep hierarchical connector endpoints are flattened one-to-one for rendering; every projected connection and physical net carries its original stable ID and SysML path in the projection manifest. No engineering element or relationship is invented, removed, or promoted into the authoritative model.

## Status

SYSON_FULL_RAIL_VISUALIZATION = PASS
