package Probe {
    private import ScalarValues::*;

    item def Payload {
        attribute sourceCode : String = "ITM-TEST";
    }

    port def OutputPort {
        out item payload : Payload;
    }

    port def PhysicalPort {
        inout item payload : Payload;
    }

    interface def SignalInterface {
        end source : OutputPort;
        end target : ~OutputPort;
    }

    part def Source {
        port output : OutputPort {
            attribute sourcePortId : String = "PORT-1";
        }
    }

    part def Target {
        port input : ~OutputPort;
    }

    part system {
        part source : Source;
        part target : Target;
        interface signal : SignalInterface connect source.output to target.input {
            attribute sourceConnectionId : String = "CONN-1";
        }
        connection physicalNet connect (source.output, target.input);
    }
}
