from common import q

def build(model):
    return """package GeneralDefinitions {
    private import ScalarValues::*;
    part def ExternalBoundaryBase {
        attribute sourceType : String = \"external_boundary\";
    }
}\n"""

