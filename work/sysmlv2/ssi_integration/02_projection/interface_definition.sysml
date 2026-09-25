package interface_definition {
    private import general_definition::*;
    private import port_definition::*;
    interface def IF_IF_MEA_004 {
    end source : PT_PT_MEA_004;
    end target : ~PT_PT_MEA_004;
    flow of I_ITM_MEA_004 from source.payload to target.payload;
    }
    interface def IF_IF_MEA_005 {
    end source : PT_PT_MEA_005;
    end target : ~PT_PT_MEA_005;
    flow of I_ITM_MEA_005 from source.payload to target.payload;
    }
    interface def IF_IF_MEA_006 {
    end source : PT_PT_MEA_006;
    end target : ~PT_PT_MEA_006;
    flow of I_ITM_MEA_006 from source.payload to target.payload;
    }
    interface def IF_IF_MEA_011 {
    end source : PT_PT_MEA_011;
    end target : ~PT_PT_MEA_011;
    flow of I_ITM_MEA_011 from source.payload to target.payload;
    }
    interface def IF_IF_MEA_012 {
    end source : PT_PT_MEA_012;
    end target : ~PT_PT_MEA_012;
    flow of I_ITM_MEA_012 from source.payload to target.payload;
    }
    interface def IF_IF_PHY_001 {
    end source : PT_PT_PHY_001;
    end target : PT_PT_PHY_001;
    flow of I_ITM_PHY_001 from source.payload to target.payload;
    }
    interface def IF_IF_PHY_004 {
    end source : PT_PT_PHY_004;
    end target : PT_PT_PHY_004;
    flow of I_ITM_PHY_004 from source.payload to target.payload;
    }
    interface def IF_IF_PHY_005 {
    end source : PT_PT_PHY_005;
    end target : PT_PT_PHY_005;
    flow of I_ITM_PHY_005 from source.payload to target.payload;
    }
    interface def IF_IF_PHY_007 {
    end source : PT_PT_PHY_007;
    end target : PT_PT_PHY_007;
    flow of I_ITM_PHY_007 from source.payload to target.payload;
    }
    interface def IF_IF_PHY_014 {
    end source : PT_PT_PHY_014;
    end target : PT_PT_PHY_014;
    flow of I_ITM_PHY_014 from source.payload to target.payload;
    }
    interface def IF_IF_STA_013 {
    end source : PT_PT_STA_013;
    end target : ~PT_PT_STA_013;
    flow of I_ITM_STA_013 from source.payload to target.payload;
    }
    interface def IF_IF_STA_016 {
    end source : PT_PT_STA_016;
    end target : ~PT_PT_STA_016;
    flow of I_ITM_STA_016 from source.payload to target.payload;
    }
}
