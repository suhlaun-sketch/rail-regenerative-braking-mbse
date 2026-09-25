# MATLAB Environment Report

- MATLAB: 25.1.0.2943329 (R2025a)
- Architecture: win64
- Simulink: AVAILABLE
- Simulink Coder: AVAILABLE
- MATLAB Coder license: AVAILABLE
- `exportToFMU`: AVAILABLE
- FMU Builder for Simulink: AVAILABLE, 25.1.2 (project runtime support-package root)
- C/C++ compiler used: MinGW-w64 8.1.0, project-local toolchain
- FMI export implemented: FMI 2.0 Co-Simulation

The initial compiler audit found no configured compiler. A project-local MinGW toolchain was configured before compilation and the successful 16/16 code-generation and FMU-export records are the execution evidence.

Existing PMSM and regenerative-braking models were audited as candidate sources. They had no root-level interface matching the frozen executable contract, so they were not overwritten; the delivered models use new system-level averaged behavior.
