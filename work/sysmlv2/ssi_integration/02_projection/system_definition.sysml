package system_definition {
    private import general_definition::*;
    private import port_definition::*;
    private import interface_definition::*;
    part L2_4200 : P_N_4200 {
        attribute sourceProductCode = "4200";
        port p_4235_rp_6fea4b377f978aac : PT_PT_MEA_005;
        port p_4236_rp_78e99abb7d77c156 : PT_PT_PHY_001;
        port p_4236_rp_9107465175683792 : PT_PT_MEA_006;
        port p_4238_rp_0674d2b80a6a72da : PT_PT_STA_013;
        port p_4238_rp_11b7e7965ec2e386 : ~PT_PT_STA_016;
        port p_4238_rp_9458944450b0dd4c : PT_PT_STA_016;
    }
    part L2_4500 : P_N_4500 {
        attribute sourceProductCode = "4500";
        port p_4511_rp_c782fb362436088e : PT_PT_PHY_001;
        port p_4513_rp_f597e9dc63931270 : PT_PT_PHY_014;
        port p_4517_rp_b93b1716e8b4e844 : PT_PT_STA_016;
        port p_4518_rp_67eef246e016ac82 : ~PT_PT_STA_013;
        port p_4518_rp_a87c9390595138d6 : ~PT_PT_STA_016;
    }
    part L2_5100 : P_N_5100 {
        attribute sourceProductCode = "5100";
        port p_5111_rp_5f90d6dd8fba4321 : ~PT_PT_MEA_005;
        port p_5111_rp_651700e69b7dccba : ~PT_PT_MEA_006;
        port p_5112_rp_21e86fb073b61523 : ~PT_PT_MEA_011;
        port p_5112_rp_4557e9b0656c46f5 : ~PT_PT_MEA_012;
        port p_5112_rp_780596fabcc73a0f : ~PT_PT_MEA_004;
        port p_5121_rp_9dedfe88c8a34261 : PT_PT_PHY_014;
        port p_5122_rp_0b57347688ba1240 : PT_PT_PHY_014;
        port p_5132_rp_770f7e1c507cc073 : PT_PT_PHY_004;
    }
    part L2_5300 : P_N_5300 {
        attribute sourceProductCode = "5300";
        port p_5311_rp_10bb4c4f0063bc18 : PT_PT_MEA_012;
        port p_5311_rp_537e9856bafa2a02 : PT_PT_MEA_011;
        port p_5311_rp_57f3c317ac0c860d : PT_PT_PHY_004;
        port p_5311_rp_79c695a1342df24f : PT_PT_MEA_004;
        port p_5311_rp_97eb613c06ae1b2e : PT_PT_PHY_005;
    }
    part L2_7200 : P_N_7200 {
        attribute sourceProductCode = "7200";
        port p_7254_rp_d9511ef0fa1c17df : PT_PT_PHY_007;
    }
    part L2_X100 : P_X100 {
        attribute sourceProductCode = "X100";
    }
    part L2_3500 : P_N_3500 {
        attribute sourceProductCode = "3500";
        port p_3511_rp_aa7691c6f81e4771 : PT_PT_PHY_005;
        port p_3512_rp_c455741f6ca5a597 : PT_PT_PHY_005;
    }
    part L2_3100 : P_N_3100 {
        attribute sourceProductCode = "3100";
        port p_3121_rp_fdcd27ee9b0a936f : PT_PT_PHY_005;
        port p_3131_rp_06d152ddc255f2eb : PT_PT_PHY_007;
    }
    interface c_CG_002543DBE0F9A7FBC2A3FDD3 : IF_IF_MEA_005 connect L2_4200.p_4235_rp_6fea4b377f978aac to L2_5100.p_5111_rp_5f90d6dd8fba4321;
    interface c_CG_117A3F0E6C8FF8FF0013A46B : IF_IF_PHY_014 connect L2_4500.p_4513_rp_f597e9dc63931270 to L2_5100.p_5122_rp_0b57347688ba1240;
    interface c_CG_118F2C2B84D1D301C7BE63F8 : IF_IF_PHY_014 connect L2_4500.p_4513_rp_f597e9dc63931270 to L2_5100.p_5121_rp_9dedfe88c8a34261;
    interface c_CG_20C0A22ECCF07864FDBA3F5A : IF_IF_MEA_006 connect L2_4200.p_4236_rp_9107465175683792 to L2_5100.p_5111_rp_651700e69b7dccba;
    interface c_CG_2274BA128E639FDE4D4F56EC : IF_IF_STA_016 connect L2_4500.p_4517_rp_b93b1716e8b4e844 to L2_4200.p_4238_rp_11b7e7965ec2e386;
    interface c_CG_338D68ABEF709ACD5E0DDCC6 : IF_IF_PHY_005 connect L2_5300.p_5311_rp_97eb613c06ae1b2e to L2_3500.p_3511_rp_aa7691c6f81e4771;
    interface c_CG_37792F42F4274C7C51C63270 : IF_IF_STA_013 connect L2_4200.p_4238_rp_0674d2b80a6a72da to L2_4500.p_4518_rp_67eef246e016ac82;
    interface c_CG_37ECA5B04E215AC3E6A4B472 : IF_IF_MEA_011 connect L2_5300.p_5311_rp_537e9856bafa2a02 to L2_5100.p_5112_rp_21e86fb073b61523;
    interface c_CG_3BD24EBE88F37EEFFE563597 : IF_IF_PHY_004 connect L2_5100.p_5132_rp_770f7e1c507cc073 to L2_5300.p_5311_rp_57f3c317ac0c860d;
    interface c_CG_3CA6C3BF7D7B4F80CF0990D0 : IF_IF_PHY_005 connect L2_3500.p_3512_rp_c455741f6ca5a597 to L2_3100.p_3121_rp_fdcd27ee9b0a936f;
    interface c_CG_46A1EE350324445D016EAF45 : IF_IF_MEA_004 connect L2_5300.p_5311_rp_79c695a1342df24f to L2_5100.p_5112_rp_780596fabcc73a0f;
    interface c_CG_B483D5C4E4EC5F805E3B0F19 : IF_IF_PHY_001 connect L2_4200.p_4236_rp_78e99abb7d77c156 to L2_4500.p_4511_rp_c782fb362436088e;
    interface c_CG_CE2820923CC0CB141833E11D : IF_IF_STA_016 connect L2_4200.p_4238_rp_9458944450b0dd4c to L2_4500.p_4518_rp_a87c9390595138d6;
    interface c_CG_D4DF5719633CB5B375F35094 : IF_IF_MEA_012 connect L2_5300.p_5311_rp_10bb4c4f0063bc18 to L2_5100.p_5112_rp_4557e9b0656c46f5;
    interface c_CG_DA869E241F8A36DBAAC07E48 : IF_IF_PHY_007 connect L2_7200.p_7254_rp_d9511ef0fa1c17df to L2_3100.p_3131_rp_06d152ddc255f2eb;
}
