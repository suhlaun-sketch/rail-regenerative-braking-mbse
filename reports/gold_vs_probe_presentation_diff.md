# Gold vs v6 Presentation Diff

## MODEL_LAYER_DIFFERENCE

- Frozen Product Blocks, Ports, InterfaceBlocks, Signal names, and technical metadata are unchanged.
- gold adds a dedicated standard Block IBD presentation harness with two direct Part Properties typed by 4235 and 5111.
- gold hand-created a direct Connector owned by that harness and an InformationFlow/ItemFlow realized by it; the imported v6 nested Connector remains model-only and has no diagram symbol.
- Native v7 will retain only one semantic Connector for the displayed path by moving the stable frozen Connector identity into the harness.

## PRESENTATION_LAYER_DIFFERENCE

- v6 ownedDiagram / mdElement counts: 0 / 0.
- Current on-disk v6 container was subsequently saved by MagicDraw: true (not overwritten by this pipeline).
- gold ownedDiagram / mdElement counts: 1 / 215.
- gold has Part and nested Port symbols, one solid Connector path, ConnectorEnd symbols, a conveyed Signal compartment, and a Connector-owned TextBox label.
- gold has no independent InformationFlow or ItemFlow path symbol.
- Direct cause: v6 is standard model XMI without MagicDraw native ownedDiagram/filePart/mdOwnedViews resources; therefore it cannot reproduce the hand-authored IBD presentation.
