# SSI_v1.0.0 Local Source Tree

Repository: `C:\Users\AUSA\Desktop\牵引制动能量回收\third_party\ssi_transformer\Standard-System-Interface`

```text
Standard-System-Interface/
├── README.md
├── LICENSE
├── environment.yml
├── source/
│   ├── SSI_transformer.py          # Transformer entry, GUI, parser, SSD generator
│   ├── SSI_transformer_modelica.py # Modelica variant
│   └── SSI_simulator.py            # PyFMI simulator (not run)
├── sec_3/
│   ├── general_definition.sysml
│   ├── port_definition.sysml
│   ├── interface_definition.sysml
│   ├── usage.sysml
│   └── Paper_sec3.ipynb
├── sec_4/
│   ├── general_definition.sysml
│   ├── port_definition.sysml
│   ├── interface_definition.sysml
│   ├── system_definition_p1.sysml
│   ├── system_definition_p4.sysml
│   └── Paper_sec4.ipynb
├── P1_SSP/
│   ├── generatedSSD.ssd
│   └── resources/*.fmu
├── P4_SSP/
│   ├── generatedSSD.ssd
│   └── resources/*.fmu
└── EXTRA/modelica/
    ├── SysML models/
    └── simulation/
```

The GUI actually requests exactly two files, in this order:

1. `interface_definition.sysml`
2. `system_definition*.sysml`

`general_definition.sysml` and `port_definition.sysml` are conceptual SSI workflow inputs referenced by imports, but SSI_v1.0.0 does not open or resolve them at runtime.
