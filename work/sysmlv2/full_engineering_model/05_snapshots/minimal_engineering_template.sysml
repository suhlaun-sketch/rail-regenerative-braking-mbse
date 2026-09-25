package MinimalGeneralDefinitions {
    private import ScalarValues::*;
}

package MinimalItemDefinitions {
    private import ScalarValues::*;
    item def EngineeringItem {
        attribute itemCode : String = "ITM-TEST-001";
    }
}

package MinimalPortDefinitions {
    private import MinimalItemDefinitions::*;
    port def SignalPort {
        out item payload : EngineeringItem;
    }
    port def PhysicalPort {
        inout item payload : EngineeringItem;
    }
}

package MinimalInterfaceDefinitions {
    private import MinimalItemDefinitions::*;
    private import MinimalPortDefinitions::*;
    interface def SignalInterface {
        end source : SignalPort;
        end target : ~SignalPort;
        flow of EngineeringItem from source.payload to target.payload;
    }
}

package MinimalProductDefinitions {
    private import ScalarValues::*;
    private import MinimalPortDefinitions::*;
    part def LeafSource {
        attribute productCode : String = "SRC";
        port output : SignalPort;
        port physical : PhysicalPort;
    }
    part def LeafTarget {
        attribute productCode : String = "DST";
        port input : ~SignalPort;
        port physical : PhysicalPort;
    }
    part def ParentProduct {
        part source : LeafSource;
        part target : LeafTarget;
    }
}

package MinimalFunctionDefinitions {
    private import MinimalItemDefinitions::*;
    action def TransferFunction {
        out item transferred : EngineeringItem;
    }
}

package MinimalSystemDefinition {
    private import ScalarValues::*;
    private import MinimalInterfaceDefinitions::*;
    private import MinimalProductDefinitions::*;
    part system {
        part parent : ParentProduct;
        interface finalConnection : SignalInterface connect parent.source.output to parent.target.input {
            attribute connectionId : String = "CONN-TEST-001";
        }
    }
}

package MinimalFunctionAllocations {
    private import MinimalFunctionDefinitions::*;
    private import MinimalProductDefinitions::*;
    action functionUsage : TransferFunction;
    part productUsage : LeafSource;
    allocation functionAllocation allocate functionUsage to productUsage;
}

package MinimalPhysicalNetworks {
    private import MinimalProductDefinitions::*;
    part physicalContext {
        part source : LeafSource;
        part target : LeafTarget;
        connection physicalNetwork connect (source.physical, target.physical);
    }
}
