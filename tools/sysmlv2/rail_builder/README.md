# Rail MBSE SysML v2 Builder

This builder treats `Rail_MBSE_Function_Interface_v1_final.xlsx` as the primary engineering source. It reads every worksheet, validates source keys and relationships, generates the complete L1-L4 product definition/usage hierarchy, leaf raw ports, canonical items, semantic port/interface types, functions, allocations, 184 final connections and nine n-ary physical networks, and validates the combined model with the local official SysML v2 Pilot kernel 0.59.0.

Data flow:

Excel Product Row → Product Definition → System Part Usage → Child Product Composition → Leaf Product → Raw Port → Item / Interface → Final Connection → Function → Allocation → Full SysML v2

Future simulation flow (not performed here):

Full SysML v2 + L2 Simulation Contract → L2 SSI Projection → SSI Transformer → SSD → FMU

Run `build_full_rail_sysml.ps1` from any working directory. The script does not modify source workbooks, final connections, raw ports, MagicDraw models, SSI, SSD or FMUs.

