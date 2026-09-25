package RailSysONConnectionViews {
    private import ScalarValues::*;
    private import ProductDefinitions::*;
    private import InterfaceDefinitions::*;
    package BySourceL1_3000 {
        part leaf_N_3111 : P_N_3111;
        part leaf_N_3112 : P_N_3112;
        part leaf_N_3121 : P_N_3121;
        part leaf_N_3131 : P_N_3131;
        part leaf_N_3132 : P_N_3132;
        part leaf_N_3133 : P_N_3133;
        part leaf_N_3511 : P_N_3511;
        part leaf_N_3512 : P_N_3512;
        part leaf_N_3514 : P_N_3514;
        part leaf_N_3641 : P_N_3641;
        part leaf_N_3643 : P_N_3643;
        part leaf_N_3644 : P_N_3644;
        part leaf_N_3811 : P_N_3811;
        part leaf_N_3813 : P_N_3813;
        part leaf_N_3814 : P_N_3814;
        part leaf_N_5311 : P_N_5311;
        part leaf_N_8125 : P_N_8125;
        part leaf_BOUNDARY_RAIL : B_BOUNDARY_RAIL;
        part leaf_BOUNDARY_THERMAL_ENVIRONMENT : B_BOUNDARY_THERMAL_ENVIRONMENT;
        interface c_CG_07AF42BFA3927EF22F7BDDE7 : IF_IF_PHY_005 connect leaf_N_3644.rp_af1c1b2c65382775 to leaf_N_5311.rp_97eb613c06ae1b2e {
            attribute originalConnectionId : String = "CG-07AF42BFA3927EF22F7BDDE7";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_07AF42BFA3927EF22F7BDDE7";
        }
        interface c_CG_3CA6C3BF7D7B4F80CF0990D0 : IF_IF_PHY_005 connect leaf_N_3512.rp_c455741f6ca5a597 to leaf_N_3121.rp_fdcd27ee9b0a936f {
            attribute originalConnectionId : String = "CG-3CA6C3BF7D7B4F80CF0990D0";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_3CA6C3BF7D7B4F80CF0990D0";
        }
        interface c_CG_4B59832BB120B07245DB82FA : IF_IF_PHY_005 connect leaf_N_3511.rp_813a305545723d57 to leaf_N_3514.rp_b12dc4cc17618821 {
            attribute originalConnectionId : String = "CG-4B59832BB120B07245DB82FA";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_4B59832BB120B07245DB82FA";
        }
        interface c_CG_4CB0735167799FD438F90DD2 : IF_IF_PHY_005 connect leaf_N_3643.rp_48ddc723a7d58137 to leaf_N_3121.rp_6464b6253314b208 {
            attribute originalConnectionId : String = "CG-4CB0735167799FD438F90DD2";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_4CB0735167799FD438F90DD2";
        }
        interface c_CG_5CC6DABFA52A640C8BC115E5 : IF_IF_PHY_005 connect leaf_N_3514.rp_4569aa8f56963dc6 to leaf_N_3512.rp_970ef7da9f850ce1 {
            attribute originalConnectionId : String = "CG-5CC6DABFA52A640C8BC115E5";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_5CC6DABFA52A640C8BC115E5";
        }
        interface c_CG_7CA35F612B7EF59664CE06F0 : IF_IF_PHY_013 connect leaf_N_3132.rp_6069e8d0fbf298c5 to leaf_BOUNDARY_THERMAL_ENVIRONMENT.bp_2ac3a221090b246a {
            attribute originalConnectionId : String = "CG-7CA35F612B7EF59664CE06F0";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_7CA35F612B7EF59664CE06F0";
        }
        interface c_CG_89DF67BFD358C3EEF4DB05F2 : IF_IF_MEA_004 connect leaf_N_3644.rp_08c271db56ce8427 to leaf_N_8125.rp_4e582bfad9ebbf1d {
            attribute originalConnectionId : String = "CG-89DF67BFD358C3EEF4DB05F2";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_89DF67BFD358C3EEF4DB05F2";
        }
        interface c_CG_91B4F6F81C7185E848BAF73E : IF_IF_PHY_013 connect leaf_N_3133.rp_24fa6cb520a8e2e2 to leaf_BOUNDARY_THERMAL_ENVIRONMENT.bp_2ac3a221090b246a {
            attribute originalConnectionId : String = "CG-91B4F6F81C7185E848BAF73E";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_91B4F6F81C7185E848BAF73E";
        }
        interface c_CG_943AD35B9C94E8B079F6212A : IF_IF_CMD_032 connect leaf_N_3811.rp_3a8ce42fcde5acd8 to leaf_N_3813.rp_d951497aaa9989f0 {
            attribute originalConnectionId : String = "CG-943AD35B9C94E8B079F6212A";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_943AD35B9C94E8B079F6212A";
        }
        interface c_CG_AF75A5003A9B1A8DE28924E1 : IF_IF_PHY_005 connect leaf_N_3121.rp_6464b6253314b208 to leaf_N_3112.rp_6917242b1f7fc50f {
            attribute originalConnectionId : String = "CG-AF75A5003A9B1A8DE28924E1";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_AF75A5003A9B1A8DE28924E1";
        }
        interface c_CG_C53D41B4A1F64D70B4607AA4 : IF_IF_PHY_006 connect leaf_N_3111.rp_8ee7c79c0fe26b93 to leaf_BOUNDARY_RAIL.bp_cf72f055f5b12b85 {
            attribute originalConnectionId : String = "CG-C53D41B4A1F64D70B4607AA4";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_C53D41B4A1F64D70B4607AA4";
        }
        interface c_CG_C81A2253CDA9FC6173740074 : IF_IF_PHY_005 connect leaf_N_3112.rp_c530418a51140052 to leaf_N_3111.rp_f0350fc816a551ff {
            attribute originalConnectionId : String = "CG-C81A2253CDA9FC6173740074";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_C81A2253CDA9FC6173740074";
        }
        interface c_CG_D9940860A6DB9E6BD5200881 : IF_IF_PHY_013 connect leaf_N_3131.rp_ec78c2de89f1a17c to leaf_BOUNDARY_THERMAL_ENVIRONMENT.bp_2ac3a221090b246a {
            attribute originalConnectionId : String = "CG-D9940860A6DB9E6BD5200881";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_D9940860A6DB9E6BD5200881";
        }
        interface c_CG_E5A3740D9F06BF31CB55A481 : IF_IF_PHY_012 connect leaf_N_3813.rp_c843e562c7ec3ed9 to leaf_N_3814.rp_43d42f25a744fe07 {
            attribute originalConnectionId : String = "CG-E5A3740D9F06BF31CB55A481";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_E5A3740D9F06BF31CB55A481";
        }
        interface c_CG_FA31DFA220FEF0D6FAC8EB67 : IF_IF_PHY_005 connect leaf_N_3641.rp_4ddc6037e5eea6fc to leaf_N_3112.rp_c530418a51140052 {
            attribute originalConnectionId : String = "CG-FA31DFA220FEF0D6FAC8EB67";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_FA31DFA220FEF0D6FAC8EB67";
        }
        view RV_05_CONNECTIONS_SOURCE_L1_3000 {
            expose leaf_N_3111;
            expose leaf_N_3112;
            expose leaf_N_3121;
            expose leaf_N_3131;
            expose leaf_N_3132;
            expose leaf_N_3133;
            expose leaf_N_3511;
            expose leaf_N_3512;
            expose leaf_N_3514;
            expose leaf_N_3641;
            expose leaf_N_3643;
            expose leaf_N_3644;
            expose leaf_N_3811;
            expose leaf_N_3813;
            expose leaf_N_3814;
            expose leaf_N_5311;
            expose leaf_N_8125;
            expose leaf_BOUNDARY_RAIL;
            expose leaf_BOUNDARY_THERMAL_ENVIRONMENT;
            expose c_CG_07AF42BFA3927EF22F7BDDE7;
            expose c_CG_3CA6C3BF7D7B4F80CF0990D0;
            expose c_CG_4B59832BB120B07245DB82FA;
            expose c_CG_4CB0735167799FD438F90DD2;
            expose c_CG_5CC6DABFA52A640C8BC115E5;
            expose c_CG_7CA35F612B7EF59664CE06F0;
            expose c_CG_89DF67BFD358C3EEF4DB05F2;
            expose c_CG_91B4F6F81C7185E848BAF73E;
            expose c_CG_943AD35B9C94E8B079F6212A;
            expose c_CG_AF75A5003A9B1A8DE28924E1;
            expose c_CG_C53D41B4A1F64D70B4607AA4;
            expose c_CG_C81A2253CDA9FC6173740074;
            expose c_CG_D9940860A6DB9E6BD5200881;
            expose c_CG_E5A3740D9F06BF31CB55A481;
            expose c_CG_FA31DFA220FEF0D6FAC8EB67;
        }
    }
    package BySourceL1_4000 {
        part leaf_N_4111 : P_N_4111;
        part leaf_N_411C : P_N_411C;
        part leaf_N_4211 : P_N_4211;
        part leaf_N_4212 : P_N_4212;
        part leaf_N_4235 : P_N_4235;
        part leaf_N_4236 : P_N_4236;
        part leaf_N_4238 : P_N_4238;
        part leaf_N_4239 : P_N_4239;
        part leaf_N_4241 : P_N_4241;
        part leaf_N_4411 : P_N_4411;
        part leaf_N_4412 : P_N_4412;
        part leaf_N_4413 : P_N_4413;
        part leaf_N_4511 : P_N_4511;
        part leaf_N_4513 : P_N_4513;
        part leaf_N_4517 : P_N_4517;
        part leaf_N_4518 : P_N_4518;
        part leaf_N_5111 : P_N_5111;
        part leaf_N_5121 : P_N_5121;
        part leaf_N_5122 : P_N_5122;
        part leaf_N_8151 : P_N_8151;
        part leaf_N_8166 : P_N_8166;
        part leaf_BOUNDARY_CATENARY_25KV : B_BOUNDARY_CATENARY_25KV;
        part leaf_BOUNDARY_RAIL : B_BOUNDARY_RAIL;
        part leaf_BOUNDARY_THERMAL_ENVIRONMENT : B_BOUNDARY_THERMAL_ENVIRONMENT;
        interface c_CG_002543DBE0F9A7FBC2A3FDD3 : IF_IF_MEA_005 connect leaf_N_4235.rp_6fea4b377f978aac to leaf_N_5111.rp_5f90d6dd8fba4321 {
            attribute originalConnectionId : String = "CG-002543DBE0F9A7FBC2A3FDD3";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_002543DBE0F9A7FBC2A3FDD3";
        }
        interface c_CG_0B7698B3C627150EF560B4B0 : IF_IF_STA_014 connect leaf_N_4212.rp_62a902ccb2d5edf3 to leaf_N_4238.rp_b46091b51fbac2ba {
            attribute originalConnectionId : String = "CG-0B7698B3C627150EF560B4B0";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_0B7698B3C627150EF560B4B0";
        }
        interface c_CG_117A3F0E6C8FF8FF0013A46B : IF_IF_PHY_014 connect leaf_N_4513.rp_f597e9dc63931270 to leaf_N_5122.rp_0b57347688ba1240 {
            attribute originalConnectionId : String = "CG-117A3F0E6C8FF8FF0013A46B";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_117A3F0E6C8FF8FF0013A46B";
        }
        interface c_CG_118F2C2B84D1D301C7BE63F8 : IF_IF_PHY_014 connect leaf_N_4513.rp_f597e9dc63931270 to leaf_N_5121.rp_9dedfe88c8a34261 {
            attribute originalConnectionId : String = "CG-118F2C2B84D1D301C7BE63F8";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_118F2C2B84D1D301C7BE63F8";
        }
        interface c_CG_1687BE836F7FC44BCDADF2D2 : IF_IF_MEA_022 connect leaf_N_4517.rp_b094956bc66dfaad to leaf_N_4518.rp_f46b3d97e0fceb9e {
            attribute originalConnectionId : String = "CG-1687BE836F7FC44BCDADF2D2";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_1687BE836F7FC44BCDADF2D2";
        }
        interface c_CG_1803BC1FF5BB8C1A4F69CBA8 : IF_IF_PHY_014 connect leaf_N_4511.rp_a6f93ee77144741e to leaf_N_4513.rp_88e2bd038f100aa3 {
            attribute originalConnectionId : String = "CG-1803BC1FF5BB8C1A4F69CBA8";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_1803BC1FF5BB8C1A4F69CBA8";
        }
        interface c_CG_1C5FC46A1E7682144A3BDDDF : IF_IF_MEA_005 connect leaf_N_4238.rp_5576b5e0dbb912ba to leaf_N_8166.rp_573e029523ef9946 {
            attribute originalConnectionId : String = "CG-1C5FC46A1E7682144A3BDDDF";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_1C5FC46A1E7682144A3BDDDF";
        }
        interface c_CG_20C0A22ECCF07864FDBA3F5A : IF_IF_MEA_006 connect leaf_N_4236.rp_9107465175683792 to leaf_N_5111.rp_651700e69b7dccba {
            attribute originalConnectionId : String = "CG-20C0A22ECCF07864FDBA3F5A";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_20C0A22ECCF07864FDBA3F5A";
        }
        interface c_CG_2274BA128E639FDE4D4F56EC : IF_IF_STA_016 connect leaf_N_4517.rp_b93b1716e8b4e844 to leaf_N_4238.rp_11b7e7965ec2e386 {
            attribute originalConnectionId : String = "CG-2274BA128E639FDE4D4F56EC";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_2274BA128E639FDE4D4F56EC";
        }
        interface c_CG_2C24BA16EF5F2F7E99733CD6 : IF_IF_PHY_013 connect leaf_N_4412.rp_b031f017471c85ee to leaf_BOUNDARY_THERMAL_ENVIRONMENT.bp_2ac3a221090b246a {
            attribute originalConnectionId : String = "CG-2C24BA16EF5F2F7E99733CD6";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_2C24BA16EF5F2F7E99733CD6";
        }
        interface c_CG_2EE117B4B0633E38D394B904 : IF_IF_CMD_018 connect leaf_N_4238.rp_9744a4b3a255a6e8 to leaf_N_411C.rp_201c13a158f19a88 {
            attribute originalConnectionId : String = "CG-2EE117B4B0633E38D394B904";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_2EE117B4B0633E38D394B904";
        }
        interface c_CG_3632726B793CD5429112CAD4 : IF_IF_PHY_001 connect leaf_N_4211.rp_ee92cd728b152a90 to leaf_N_4212.rp_4b65d610848833a3 {
            attribute originalConnectionId : String = "CG-3632726B793CD5429112CAD4";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_3632726B793CD5429112CAD4";
        }
        interface c_CG_37792F42F4274C7C51C63270 : IF_IF_STA_013 connect leaf_N_4238.rp_0674d2b80a6a72da to leaf_N_4518.rp_67eef246e016ac82 {
            attribute originalConnectionId : String = "CG-37792F42F4274C7C51C63270";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_37792F42F4274C7C51C63270";
        }
        interface c_CG_4104726E8B8410405C176AF3 : IF_IF_CMD_017 connect leaf_N_4238.rp_ed1efa73e618c52f to leaf_N_4212.rp_a29d16c43fc8d044 {
            attribute originalConnectionId : String = "CG-4104726E8B8410405C176AF3";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_4104726E8B8410405C176AF3";
        }
        interface c_CG_43EF4A944142319DE5088758 : IF_IF_MEA_006 connect leaf_N_4238.rp_c7dcc306b020116f to leaf_N_4241.rp_f81c0f4a108acec4 {
            attribute originalConnectionId : String = "CG-43EF4A944142319DE5088758";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_43EF4A944142319DE5088758";
        }
        interface c_CG_48B77E7B4DEB11D4F5543CCB : IF_IF_PHY_011 connect leaf_N_4413.rp_cb582bd13ed15889 to leaf_BOUNDARY_RAIL.bp_3a29560c03050dbe {
            attribute originalConnectionId : String = "CG-48B77E7B4DEB11D4F5543CCB";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_48B77E7B4DEB11D4F5543CCB";
        }
        interface c_CG_51C22959FEAD177C3827B364 : IF_IF_PHY_001 connect leaf_N_4235.rp_3e2b71c6b8d79136 to leaf_N_4212.rp_e1689d643b97d378 {
            attribute originalConnectionId : String = "CG-51C22959FEAD177C3827B364";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_51C22959FEAD177C3827B364";
        }
        interface c_CG_676A4A51307B0199D39544B7 : IF_IF_CMD_017 connect leaf_N_4239.rp_e30c550b4d4e8d52 to leaf_N_4238.rp_f6362be8ea9a501f {
            attribute originalConnectionId : String = "CG-676A4A51307B0199D39544B7";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_676A4A51307B0199D39544B7";
        }
        interface c_CG_6C6B569AD3F71A70A799D067 : IF_IF_MEA_005 connect leaf_N_4238.rp_5576b5e0dbb912ba to leaf_N_4239.rp_2802b0f2f54a548a {
            attribute originalConnectionId : String = "CG-6C6B569AD3F71A70A799D067";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_6C6B569AD3F71A70A799D067";
        }
        interface c_CG_76271B14A422D23C0C6E327D : IF_IF_PHY_013 connect leaf_N_4411.rp_c61d1b462f69be85 to leaf_BOUNDARY_THERMAL_ENVIRONMENT.bp_2ac3a221090b246a {
            attribute originalConnectionId : String = "CG-76271B14A422D23C0C6E327D";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_76271B14A422D23C0C6E327D";
        }
        interface c_CG_8E2E18108BE2E7B2FB898537 : IF_IF_STA_015 connect leaf_N_4238.rp_86fe03530d5b3c05 to leaf_N_4239.rp_f3be8ead57323593 {
            attribute originalConnectionId : String = "CG-8E2E18108BE2E7B2FB898537";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_8E2E18108BE2E7B2FB898537";
        }
        interface c_CG_8EE395387745CC0A6FB55207 : IF_IF_MEA_005 connect leaf_N_4235.rp_6fea4b377f978aac to leaf_N_4238.rp_c88ddcdfe3b55c9e {
            attribute originalConnectionId : String = "CG-8EE395387745CC0A6FB55207";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_8EE395387745CC0A6FB55207";
        }
        interface c_CG_8F81398231970DBDB0A7F854 : IF_IF_STA_015 connect leaf_N_411C.rp_72d2eed2608e1b56 to leaf_N_4238.rp_d9d25dfbac32d1e3 {
            attribute originalConnectionId : String = "CG-8F81398231970DBDB0A7F854";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_8F81398231970DBDB0A7F854";
        }
        interface c_CG_992C677E70DA53B7B40EA26C : IF_IF_PHY_001 connect leaf_N_4111.rp_695b20573c740008 to leaf_BOUNDARY_CATENARY_25KV.bp_6fe914f662252c4d {
            attribute originalConnectionId : String = "CG-992C677E70DA53B7B40EA26C";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_992C677E70DA53B7B40EA26C";
        }
        interface c_CG_9ACDE46A41EE650430438B91 : IF_IF_CMD_016 connect leaf_N_4238.rp_65aacc4600de3990 to leaf_N_8151.rp_d7d7f4cb9554ff03 {
            attribute originalConnectionId : String = "CG-9ACDE46A41EE650430438B91";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_9ACDE46A41EE650430438B91";
        }
        interface c_CG_9EB19436ED0A54ECCF52C717 : IF_IF_PHY_001 connect leaf_N_4111.rp_ca65ceda639dfc7a to leaf_N_4211.rp_bba7ece236be8f3c {
            attribute originalConnectionId : String = "CG-9EB19436ED0A54ECCF52C717";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_9EB19436ED0A54ECCF52C717";
        }
        interface c_CG_A7173AC81E21DD801A82E73D : IF_IF_STA_016 connect leaf_N_4238.rp_9458944450b0dd4c to leaf_N_4239.rp_be1480d12bc9092c {
            attribute originalConnectionId : String = "CG-A7173AC81E21DD801A82E73D";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_A7173AC81E21DD801A82E73D";
        }
        interface c_CG_B483D5C4E4EC5F805E3B0F19 : IF_IF_PHY_001 connect leaf_N_4236.rp_78e99abb7d77c156 to leaf_N_4511.rp_c782fb362436088e {
            attribute originalConnectionId : String = "CG-B483D5C4E4EC5F805E3B0F19";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_B483D5C4E4EC5F805E3B0F19";
        }
        interface c_CG_BF14D9A0947A4893C7260661 : IF_IF_PHY_001 connect leaf_N_4212.rp_e1689d643b97d378 to leaf_N_4236.rp_bb6f3fee449fd865 {
            attribute originalConnectionId : String = "CG-BF14D9A0947A4893C7260661";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_BF14D9A0947A4893C7260661";
        }
        interface c_CG_C346B9ABBAE556A332DA422F : IF_IF_MEA_006 connect leaf_N_4236.rp_9107465175683792 to leaf_N_4238.rp_afb7b0997d28e7cb {
            attribute originalConnectionId : String = "CG-C346B9ABBAE556A332DA422F";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_C346B9ABBAE556A332DA422F";
        }
        interface c_CG_C3FD4BDC3D0E9ABF609DAE81 : IF_IF_CMD_018 connect leaf_N_4239.rp_327ede77d6565c4b to leaf_N_4238.rp_71811e4b68798212 {
            attribute originalConnectionId : String = "CG-C3FD4BDC3D0E9ABF609DAE81";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_C3FD4BDC3D0E9ABF609DAE81";
        }
        interface c_CG_C64E0682EDDBDDD748BA13CA : IF_IF_STA_013 connect leaf_N_4238.rp_0674d2b80a6a72da to leaf_N_4239.rp_1fd23591362c1d8d {
            attribute originalConnectionId : String = "CG-C64E0682EDDBDDD748BA13CA";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_C64E0682EDDBDDD748BA13CA";
        }
        interface c_CG_C9CA06B236DB453EEFEC07E6 : IF_IF_STA_013 connect leaf_N_4211.rp_5301bf8bda8fba16 to leaf_N_4238.rp_b26de8005dff4962 {
            attribute originalConnectionId : String = "CG-C9CA06B236DB453EEFEC07E6";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_C9CA06B236DB453EEFEC07E6";
        }
        interface c_CG_CD05C34D37DBECA08731CAFA : IF_IF_MEA_006 connect leaf_N_4238.rp_c7dcc306b020116f to leaf_N_4239.rp_1a7ff383166e59f0 {
            attribute originalConnectionId : String = "CG-CD05C34D37DBECA08731CAFA";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_CD05C34D37DBECA08731CAFA";
        }
        interface c_CG_CE2820923CC0CB141833E11D : IF_IF_STA_016 connect leaf_N_4238.rp_9458944450b0dd4c to leaf_N_4518.rp_a87c9390595138d6 {
            attribute originalConnectionId : String = "CG-CE2820923CC0CB141833E11D";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_CE2820923CC0CB141833E11D";
        }
        interface c_CG_D2E26B7066F1A62115B06D59 : IF_IF_STA_014 connect leaf_N_4238.rp_7fe2b8fd826583f2 to leaf_N_4239.rp_30bf7d79603b941d {
            attribute originalConnectionId : String = "CG-D2E26B7066F1A62115B06D59";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_D2E26B7066F1A62115B06D59";
        }
        interface c_CG_D44FA955851A05FB81FD0837 : IF_IF_MEA_005 connect leaf_N_4238.rp_5576b5e0dbb912ba to leaf_N_4241.rp_2b7dd272027fdc0b {
            attribute originalConnectionId : String = "CG-D44FA955851A05FB81FD0837";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_D44FA955851A05FB81FD0837";
        }
        interface c_CG_E0DB6C9771E2E272BC041D82 : IF_IF_CMD_016 connect leaf_N_4238.rp_65aacc4600de3990 to leaf_N_4211.rp_17bc6a2a377dffab {
            attribute originalConnectionId : String = "CG-E0DB6C9771E2E272BC041D82";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_E0DB6C9771E2E272BC041D82";
        }
        interface c_CG_F85BCC7C68AD281053865693 : IF_IF_CMD_016 connect leaf_N_4239.rp_e67f315619e85b76 to leaf_N_4238.rp_d6b968957e3167c7 {
            attribute originalConnectionId : String = "CG-F85BCC7C68AD281053865693";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_F85BCC7C68AD281053865693";
        }
        interface c_CG_FE573ED935CFF37491A053E8 : IF_IF_MEA_006 connect leaf_N_4238.rp_c7dcc306b020116f to leaf_N_8166.rp_d9d89be1583c0e18 {
            attribute originalConnectionId : String = "CG-FE573ED935CFF37491A053E8";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_FE573ED935CFF37491A053E8";
        }
        view RV_05_CONNECTIONS_SOURCE_L1_4000 {
            expose leaf_N_4111;
            expose leaf_N_411C;
            expose leaf_N_4211;
            expose leaf_N_4212;
            expose leaf_N_4235;
            expose leaf_N_4236;
            expose leaf_N_4238;
            expose leaf_N_4239;
            expose leaf_N_4241;
            expose leaf_N_4411;
            expose leaf_N_4412;
            expose leaf_N_4413;
            expose leaf_N_4511;
            expose leaf_N_4513;
            expose leaf_N_4517;
            expose leaf_N_4518;
            expose leaf_N_5111;
            expose leaf_N_5121;
            expose leaf_N_5122;
            expose leaf_N_8151;
            expose leaf_N_8166;
            expose leaf_BOUNDARY_CATENARY_25KV;
            expose leaf_BOUNDARY_RAIL;
            expose leaf_BOUNDARY_THERMAL_ENVIRONMENT;
            expose c_CG_002543DBE0F9A7FBC2A3FDD3;
            expose c_CG_0B7698B3C627150EF560B4B0;
            expose c_CG_117A3F0E6C8FF8FF0013A46B;
            expose c_CG_118F2C2B84D1D301C7BE63F8;
            expose c_CG_1687BE836F7FC44BCDADF2D2;
            expose c_CG_1803BC1FF5BB8C1A4F69CBA8;
            expose c_CG_1C5FC46A1E7682144A3BDDDF;
            expose c_CG_20C0A22ECCF07864FDBA3F5A;
            expose c_CG_2274BA128E639FDE4D4F56EC;
            expose c_CG_2C24BA16EF5F2F7E99733CD6;
            expose c_CG_2EE117B4B0633E38D394B904;
            expose c_CG_3632726B793CD5429112CAD4;
            expose c_CG_37792F42F4274C7C51C63270;
            expose c_CG_4104726E8B8410405C176AF3;
            expose c_CG_43EF4A944142319DE5088758;
            expose c_CG_48B77E7B4DEB11D4F5543CCB;
            expose c_CG_51C22959FEAD177C3827B364;
            expose c_CG_676A4A51307B0199D39544B7;
            expose c_CG_6C6B569AD3F71A70A799D067;
            expose c_CG_76271B14A422D23C0C6E327D;
            expose c_CG_8E2E18108BE2E7B2FB898537;
            expose c_CG_8EE395387745CC0A6FB55207;
            expose c_CG_8F81398231970DBDB0A7F854;
            expose c_CG_992C677E70DA53B7B40EA26C;
            expose c_CG_9ACDE46A41EE650430438B91;
            expose c_CG_9EB19436ED0A54ECCF52C717;
            expose c_CG_A7173AC81E21DD801A82E73D;
            expose c_CG_B483D5C4E4EC5F805E3B0F19;
            expose c_CG_BF14D9A0947A4893C7260661;
            expose c_CG_C346B9ABBAE556A332DA422F;
            expose c_CG_C3FD4BDC3D0E9ABF609DAE81;
            expose c_CG_C64E0682EDDBDDD748BA13CA;
            expose c_CG_C9CA06B236DB453EEFEC07E6;
            expose c_CG_CD05C34D37DBECA08731CAFA;
            expose c_CG_CE2820923CC0CB141833E11D;
            expose c_CG_D2E26B7066F1A62115B06D59;
            expose c_CG_D44FA955851A05FB81FD0837;
            expose c_CG_E0DB6C9771E2E272BC041D82;
            expose c_CG_F85BCC7C68AD281053865693;
            expose c_CG_FE573ED935CFF37491A053E8;
        }
    }
    package BySourceL1_5000 {
        part leaf_N_3511 : P_N_3511;
        part leaf_N_5111 : P_N_5111;
        part leaf_N_5112 : P_N_5112;
        part leaf_N_5113 : P_N_5113;
        part leaf_N_5121 : P_N_5121;
        part leaf_N_5122 : P_N_5122;
        part leaf_N_5131 : P_N_5131;
        part leaf_N_5132 : P_N_5132;
        part leaf_N_5133 : P_N_5133;
        part leaf_N_5142 : P_N_5142;
        part leaf_N_5145 : P_N_5145;
        part leaf_N_5311 : P_N_5311;
        part leaf_N_8122 : P_N_8122;
        part leaf_N_8125 : P_N_8125;
        part leaf_N_8166 : P_N_8166;
        part leaf_BOUNDARY_THERMAL_ENVIRONMENT : B_BOUNDARY_THERMAL_ENVIRONMENT;
        interface c_CG_08375F15DCE75E45D4C45CE8 : IF_IF_LIM_005 connect leaf_N_5111.rp_cd7720cf9a4eae22 to leaf_N_8125.rp_1809c94f1581c7f8 {
            attribute originalConnectionId : String = "CG-08375F15DCE75E45D4C45CE8";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_08375F15DCE75E45D4C45CE8";
        }
        interface c_CG_13AAF69570338FD5B6C27BC3 : IF_IF_PHY_014 connect leaf_N_5122.rp_0b57347688ba1240 to leaf_N_5131.rp_32d77ca0c1d88b50 {
            attribute originalConnectionId : String = "CG-13AAF69570338FD5B6C27BC3";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_13AAF69570338FD5B6C27BC3";
        }
        interface c_CG_338D68ABEF709ACD5E0DDCC6 : IF_IF_PHY_005 connect leaf_N_5311.rp_97eb613c06ae1b2e to leaf_N_3511.rp_aa7691c6f81e4771 {
            attribute originalConnectionId : String = "CG-338D68ABEF709ACD5E0DDCC6";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_338D68ABEF709ACD5E0DDCC6";
        }
        interface c_CG_37ECA5B04E215AC3E6A4B472 : IF_IF_MEA_011 connect leaf_N_5311.rp_537e9856bafa2a02 to leaf_N_5112.rp_21e86fb073b61523 {
            attribute originalConnectionId : String = "CG-37ECA5B04E215AC3E6A4B472";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_37ECA5B04E215AC3E6A4B472";
        }
        interface c_CG_3BD24EBE88F37EEFFE563597 : IF_IF_PHY_004 connect leaf_N_5132.rp_770f7e1c507cc073 to leaf_N_5311.rp_57f3c317ac0c860d {
            attribute originalConnectionId : String = "CG-3BD24EBE88F37EEFFE563597";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_3BD24EBE88F37EEFFE563597";
        }
        interface c_CG_3BE61F5C037C7491E88F4334 : IF_IF_CMD_015 connect leaf_N_5145.rp_e58f80e07056f3fb to leaf_N_5133.rp_77ee52e55ac1ca4e {
            attribute originalConnectionId : String = "CG-3BE61F5C037C7491E88F4334";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_3BE61F5C037C7491E88F4334";
        }
        interface c_CG_40ADD911FF2840BEEAA67F8D : IF_IF_ACC_002 connect leaf_N_5132.rp_75d86c9dc39b94b8 to leaf_N_8122.rp_bd78e8d84d334672 {
            attribute originalConnectionId : String = "CG-40ADD911FF2840BEEAA67F8D";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_40ADD911FF2840BEEAA67F8D";
        }
        interface c_CG_46A1EE350324445D016EAF45 : IF_IF_MEA_004 connect leaf_N_5311.rp_79c695a1342df24f to leaf_N_5112.rp_780596fabcc73a0f {
            attribute originalConnectionId : String = "CG-46A1EE350324445D016EAF45";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_46A1EE350324445D016EAF45";
        }
        interface c_CG_4DBAA813D3DED180F94E9B7F : IF_IF_PHY_014 connect leaf_N_5121.rp_9dedfe88c8a34261 to leaf_N_5131.rp_32d77ca0c1d88b50 {
            attribute originalConnectionId : String = "CG-4DBAA813D3DED180F94E9B7F";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_4DBAA813D3DED180F94E9B7F";
        }
        interface c_CG_4E4C49F08CEE642A5C3C67EB : IF_IF_MEA_009 connect leaf_N_5145.rp_a9cc4822e30a5ede to leaf_N_8166.rp_3b0068559b0ca1e4 {
            attribute originalConnectionId : String = "CG-4E4C49F08CEE642A5C3C67EB";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_4E4C49F08CEE642A5C3C67EB";
        }
        interface c_CG_55513667B46680F5B87A0939 : IF_IF_STA_019 connect leaf_N_5113.rp_d93ff3dea2be11bd to leaf_N_8122.rp_81e596aab3f0fe4c {
            attribute originalConnectionId : String = "CG-55513667B46680F5B87A0939";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_55513667B46680F5B87A0939";
        }
        interface c_CG_57C4C380DFA4E14C0890F4FC : IF_IF_MEA_008 connect leaf_N_5145.rp_1680714c67f7d311 to leaf_N_5111.rp_a9ddcab662f35564 {
            attribute originalConnectionId : String = "CG-57C4C380DFA4E14C0890F4FC";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_57C4C380DFA4E14C0890F4FC";
        }
        interface c_CG_62B37C74D7B0F1346E00D437 : IF_IF_CMD_011 connect leaf_N_5112.rp_c98f6aa887541378 to leaf_N_5132.rp_406d292901368d53 {
            attribute originalConnectionId : String = "CG-62B37C74D7B0F1346E00D437";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_62B37C74D7B0F1346E00D437";
        }
        interface c_CG_65E377DBF988541FA5778D1E : IF_IF_MEA_012 connect leaf_N_5311.rp_10bb4c4f0063bc18 to leaf_N_8125.rp_1faca3fc4ff0e741 {
            attribute originalConnectionId : String = "CG-65E377DBF988541FA5778D1E";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_65E377DBF988541FA5778D1E";
        }
        interface c_CG_732BB9F5922B7AC9420BB2D0 : IF_IF_MEA_008 connect leaf_N_5145.rp_1680714c67f7d311 to leaf_N_8122.rp_361eac651ec9fd05 {
            attribute originalConnectionId : String = "CG-732BB9F5922B7AC9420BB2D0";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_732BB9F5922B7AC9420BB2D0";
        }
        interface c_CG_9731BEC15024660A6C266D47 : IF_IF_MEA_008 connect leaf_N_5145.rp_1680714c67f7d311 to leaf_N_5133.rp_60d9996fadd55bff {
            attribute originalConnectionId : String = "CG-9731BEC15024660A6C266D47";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_9731BEC15024660A6C266D47";
        }
        interface c_CG_A35E2178763C6233BE73AA36 : IF_IF_ACC_005 connect leaf_N_5142.rp_ff09931c451e831b to leaf_N_8122.rp_dae173a1561f3f35 {
            attribute originalConnectionId : String = "CG-A35E2178763C6233BE73AA36";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_A35E2178763C6233BE73AA36";
        }
        interface c_CG_A424455519797490E4F865AA : IF_IF_MEA_008 connect leaf_N_5145.rp_1680714c67f7d311 to leaf_N_8166.rp_54d624d57f57843b {
            attribute originalConnectionId : String = "CG-A424455519797490E4F865AA";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_A424455519797490E4F865AA";
        }
        interface c_CG_A467E486FE1FCC1FD2410729 : IF_IF_MEA_009 connect leaf_N_5145.rp_a9cc4822e30a5ede to leaf_N_5112.rp_6ad9df7ab3c91425 {
            attribute originalConnectionId : String = "CG-A467E486FE1FCC1FD2410729";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_A467E486FE1FCC1FD2410729";
        }
        interface c_CG_B399D92EE15558C08A95FA03 : IF_IF_ACC_003 connect leaf_N_5131.rp_95979f7c6bb276e7 to leaf_N_8122.rp_eb1cf5594b5796be {
            attribute originalConnectionId : String = "CG-B399D92EE15558C08A95FA03";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_B399D92EE15558C08A95FA03";
        }
        interface c_CG_B99AB8690BDE418D1F8055E3 : IF_IF_CMD_010 connect leaf_N_5111.rp_3c696476f82c2ae5 to leaf_N_5131.rp_c06b535bf90fa905 {
            attribute originalConnectionId : String = "CG-B99AB8690BDE418D1F8055E3";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_B99AB8690BDE418D1F8055E3";
        }
        interface c_CG_BDBC6DE36D711BE7257BA6A4 : IF_IF_PHY_013 connect leaf_N_5142.rp_7c7ad9996d24b706 to leaf_BOUNDARY_THERMAL_ENVIRONMENT.bp_2ac3a221090b246a {
            attribute originalConnectionId : String = "CG-BDBC6DE36D711BE7257BA6A4";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_BDBC6DE36D711BE7257BA6A4";
        }
        interface c_CG_BDD8747118488C9BE895D95F : IF_IF_LIM_005 connect leaf_N_5111.rp_cd7720cf9a4eae22 to leaf_N_8122.rp_abc36140248d0eef {
            attribute originalConnectionId : String = "CG-BDD8747118488C9BE895D95F";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_BDD8747118488C9BE895D95F";
        }
        interface c_CG_BDE1416487389FCF7B495D3E : IF_IF_MEA_010 connect leaf_N_5113.rp_4be030fa7e242206 to leaf_N_5112.rp_3db204c2f5a83c7f {
            attribute originalConnectionId : String = "CG-BDE1416487389FCF7B495D3E";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_BDE1416487389FCF7B495D3E";
        }
        interface c_CG_C8FE042475056BF85CFA2B40 : IF_IF_MEA_008 connect leaf_N_5145.rp_1680714c67f7d311 to leaf_N_8125.rp_7262595caaf3b8d8 {
            attribute originalConnectionId : String = "CG-C8FE042475056BF85CFA2B40";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_C8FE042475056BF85CFA2B40";
        }
        interface c_CG_D338FAEF97B977B2FE95051B : IF_IF_MEA_008 connect leaf_N_5145.rp_1680714c67f7d311 to leaf_N_5112.rp_69252f780afe77e0 {
            attribute originalConnectionId : String = "CG-D338FAEF97B977B2FE95051B";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_D338FAEF97B977B2FE95051B";
        }
        interface c_CG_D4DF5719633CB5B375F35094 : IF_IF_MEA_012 connect leaf_N_5311.rp_10bb4c4f0063bc18 to leaf_N_5112.rp_4557e9b0656c46f5 {
            attribute originalConnectionId : String = "CG-D4DF5719633CB5B375F35094";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_D4DF5719633CB5B375F35094";
        }
        interface c_CG_E85E42C2A83EE58624438A26 : IF_IF_MEA_009 connect leaf_N_5145.rp_a9cc4822e30a5ede to leaf_N_5111.rp_0e00d1e837346b81 {
            attribute originalConnectionId : String = "CG-E85E42C2A83EE58624438A26";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_E85E42C2A83EE58624438A26";
        }
        view RV_05_CONNECTIONS_SOURCE_L1_5000 {
            expose leaf_N_3511;
            expose leaf_N_5111;
            expose leaf_N_5112;
            expose leaf_N_5113;
            expose leaf_N_5121;
            expose leaf_N_5122;
            expose leaf_N_5131;
            expose leaf_N_5132;
            expose leaf_N_5133;
            expose leaf_N_5142;
            expose leaf_N_5145;
            expose leaf_N_5311;
            expose leaf_N_8122;
            expose leaf_N_8125;
            expose leaf_N_8166;
            expose leaf_BOUNDARY_THERMAL_ENVIRONMENT;
            expose c_CG_08375F15DCE75E45D4C45CE8;
            expose c_CG_13AAF69570338FD5B6C27BC3;
            expose c_CG_338D68ABEF709ACD5E0DDCC6;
            expose c_CG_37ECA5B04E215AC3E6A4B472;
            expose c_CG_3BD24EBE88F37EEFFE563597;
            expose c_CG_3BE61F5C037C7491E88F4334;
            expose c_CG_40ADD911FF2840BEEAA67F8D;
            expose c_CG_46A1EE350324445D016EAF45;
            expose c_CG_4DBAA813D3DED180F94E9B7F;
            expose c_CG_4E4C49F08CEE642A5C3C67EB;
            expose c_CG_55513667B46680F5B87A0939;
            expose c_CG_57C4C380DFA4E14C0890F4FC;
            expose c_CG_62B37C74D7B0F1346E00D437;
            expose c_CG_65E377DBF988541FA5778D1E;
            expose c_CG_732BB9F5922B7AC9420BB2D0;
            expose c_CG_9731BEC15024660A6C266D47;
            expose c_CG_A35E2178763C6233BE73AA36;
            expose c_CG_A424455519797490E4F865AA;
            expose c_CG_A467E486FE1FCC1FD2410729;
            expose c_CG_B399D92EE15558C08A95FA03;
            expose c_CG_B99AB8690BDE418D1F8055E3;
            expose c_CG_BDBC6DE36D711BE7257BA6A4;
            expose c_CG_BDD8747118488C9BE895D95F;
            expose c_CG_BDE1416487389FCF7B495D3E;
            expose c_CG_C8FE042475056BF85CFA2B40;
            expose c_CG_D338FAEF97B977B2FE95051B;
            expose c_CG_D4DF5719633CB5B375F35094;
            expose c_CG_E85E42C2A83EE58624438A26;
        }
    }
    package BySourceL1_7000 {
        part leaf_N_3131 : P_N_3131;
        part leaf_N_7142 : P_N_7142;
        part leaf_N_7211 : P_N_7211;
        part leaf_N_7213 : P_N_7213;
        part leaf_N_7222 : P_N_7222;
        part leaf_N_7225 : P_N_7225;
        part leaf_N_7227 : P_N_7227;
        part leaf_N_7228 : P_N_7228;
        part leaf_N_722A : P_N_722A;
        part leaf_N_722B : P_N_722B;
        part leaf_N_722C : P_N_722C;
        part leaf_N_7252 : P_N_7252;
        part leaf_N_7254 : P_N_7254;
        part leaf_N_7255 : P_N_7255;
        part leaf_N_7281 : P_N_7281;
        part leaf_N_7284 : P_N_7284;
        part leaf_N_7285 : P_N_7285;
        part leaf_N_8121 : P_N_8121;
        part leaf_N_8122 : P_N_8122;
        part leaf_N_8125 : P_N_8125;
        part leaf_N_8128 : P_N_8128;
        part leaf_BOUNDARY_THERMAL_ENVIRONMENT : B_BOUNDARY_THERMAL_ENVIRONMENT;
        interface c_CG_1102EBD35D52A38B96D5D2E7 : IF_IF_STA_003 connect leaf_N_7211.rp_c021f63639408eff to leaf_N_8122.rp_b1fb8856841fb7cf {
            attribute originalConnectionId : String = "CG-1102EBD35D52A38B96D5D2E7";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_1102EBD35D52A38B96D5D2E7";
        }
        interface c_CG_1A5B4FFFE2C9C8ED85759C3D : IF_IF_STA_005 connect leaf_N_7211.rp_ef5148faa6dc1c65 to leaf_N_7281.rp_28b3abdb6d1d1e9e {
            attribute originalConnectionId : String = "CG-1A5B4FFFE2C9C8ED85759C3D";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_1A5B4FFFE2C9C8ED85759C3D";
        }
        interface c_CG_1D4D143F52B7F4D880B3CB30 : IF_IF_CMD_019 connect leaf_N_7211.rp_abc190a288d4c9d5 to leaf_N_7227.rp_f645a5b55a3683c6 {
            attribute originalConnectionId : String = "CG-1D4D143F52B7F4D880B3CB30";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_1D4D143F52B7F4D880B3CB30";
        }
        interface c_CG_2B17DCC398F786E916C9C8DC : IF_IF_CMD_022 connect leaf_N_7211.rp_c4074d88ed5949ec to leaf_N_7225.rp_8e705d6c34197ff6 {
            attribute originalConnectionId : String = "CG-2B17DCC398F786E916C9C8DC";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_2B17DCC398F786E916C9C8DC";
        }
        interface c_CG_3981A8B947B66F597AA9E03F : IF_IF_CMD_020 connect leaf_N_7211.rp_a882b33038ce4623 to leaf_N_7285.rp_c016d56a46e739fc {
            attribute originalConnectionId : String = "CG-3981A8B947B66F597AA9E03F";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_3981A8B947B66F597AA9E03F";
        }
        interface c_CG_56E4DA6D8C7C1FCFA93A8C7B : IF_IF_CMD_023 connect leaf_N_7211.rp_91854864e6254d28 to leaf_N_722A.rp_afe779aaa3b0be62 {
            attribute originalConnectionId : String = "CG-56E4DA6D8C7C1FCFA93A8C7B";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_56E4DA6D8C7C1FCFA93A8C7B";
        }
        interface c_CG_5E309780F220E97DE29B2A38 : IF_IF_STA_009 connect leaf_N_722C.rp_6f3dd380decaae91 to leaf_N_7211.rp_19f11c6ee3cbf055 {
            attribute originalConnectionId : String = "CG-5E309780F220E97DE29B2A38";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_5E309780F220E97DE29B2A38";
        }
        interface c_CG_686A357580FCAB93907E7B31 : IF_IF_PHY_007 connect leaf_N_7252.rp_b403e112a25e1c53 to leaf_N_7254.rp_d9511ef0fa1c17df {
            attribute originalConnectionId : String = "CG-686A357580FCAB93907E7B31";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_686A357580FCAB93907E7B31";
        }
        interface c_CG_739E53DD845C8CD2646C8E39 : IF_IF_MEA_014 connect leaf_N_7142.rp_52f3b82b80918b84 to leaf_N_8128.rp_ccc90acd04ba0ccc {
            attribute originalConnectionId : String = "CG-739E53DD845C8CD2646C8E39";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_739E53DD845C8CD2646C8E39";
        }
        interface c_CG_7AAA105058D4FD893E634E16 : IF_IF_STA_004 connect leaf_N_7211.rp_77f0053899ab19da to leaf_N_7281.rp_b9ead4720ad37cb5 {
            attribute originalConnectionId : String = "CG-7AAA105058D4FD893E634E16";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_7AAA105058D4FD893E634E16";
        }
        interface c_CG_7D415C2FE2A98E99E69F2808 : IF_IF_PHY_007 connect leaf_N_7255.rp_4c45e349056154be to leaf_N_7252.rp_b403e112a25e1c53 {
            attribute originalConnectionId : String = "CG-7D415C2FE2A98E99E69F2808";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_7D415C2FE2A98E99E69F2808";
        }
        interface c_CG_944069F2CBBFA2A01274A9DB : IF_IF_STA_003 connect leaf_N_7211.rp_c021f63639408eff to leaf_N_8121.rp_1c14ea3cdc439198 {
            attribute originalConnectionId : String = "CG-944069F2CBBFA2A01274A9DB";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_944069F2CBBFA2A01274A9DB";
        }
        interface c_CG_9B0510538F8E21B452D8C165 : IF_IF_STA_006 connect leaf_N_7211.rp_43e35aa64c833efc to leaf_N_7281.rp_5158f71b0a56da87 {
            attribute originalConnectionId : String = "CG-9B0510538F8E21B452D8C165";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_9B0510538F8E21B452D8C165";
        }
        interface c_CG_B251741505CB19FE47559F29 : IF_IF_CMD_006 connect leaf_N_7211.rp_0194ebfed505dfb5 to leaf_N_8125.rp_d69905c106b65d8f {
            attribute originalConnectionId : String = "CG-B251741505CB19FE47559F29";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_B251741505CB19FE47559F29";
        }
        interface c_CG_C7C6703197747322B57096B5 : IF_IF_MEA_017 connect leaf_N_7252.rp_6e046e892954d0de to leaf_N_7211.rp_5b7be52aa5b6e9d0 {
            attribute originalConnectionId : String = "CG-C7C6703197747322B57096B5";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_C7C6703197747322B57096B5";
        }
        interface c_CG_CCE3D228C7F2AEE6207C1B6A : IF_IF_CMD_020 connect leaf_N_7211.rp_a882b33038ce4623 to leaf_N_7284.rp_0b1d53051662d3f2 {
            attribute originalConnectionId : String = "CG-CCE3D228C7F2AEE6207C1B6A";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_CCE3D228C7F2AEE6207C1B6A";
        }
        interface c_CG_D1D66AE9099CD7FA32C270A6 : IF_IF_CMD_021 connect leaf_N_7211.rp_dff51f26bbd38512 to leaf_N_7222.rp_ddeea781987ee55c {
            attribute originalConnectionId : String = "CG-D1D66AE9099CD7FA32C270A6";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_D1D66AE9099CD7FA32C270A6";
        }
        interface c_CG_DA869E241F8A36DBAAC07E48 : IF_IF_PHY_007 connect leaf_N_7254.rp_d9511ef0fa1c17df to leaf_N_3131.rp_06d152ddc255f2eb {
            attribute originalConnectionId : String = "CG-DA869E241F8A36DBAAC07E48";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_DA869E241F8A36DBAAC07E48";
        }
        interface c_CG_E9224B53F74EDFCCFDA0FC70 : IF_IF_MEA_016 connect leaf_N_722B.rp_8d219d5375ded80b to leaf_N_8128.rp_cc7a917501039195 {
            attribute originalConnectionId : String = "CG-E9224B53F74EDFCCFDA0FC70";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_E9224B53F74EDFCCFDA0FC70";
        }
        interface c_CG_E9AAF8010953F56E28D65ACF : IF_IF_CMD_031 connect leaf_N_7211.rp_0209c7a801f78e7e to leaf_N_7213.rp_de845d22bfa40612 {
            attribute originalConnectionId : String = "CG-E9AAF8010953F56E28D65ACF";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_E9AAF8010953F56E28D65ACF";
        }
        interface c_CG_F69B9F4B8E034908EE3FE467 : IF_IF_PHY_013 connect leaf_N_7254.rp_a60f1e83b03ea6d4 to leaf_BOUNDARY_THERMAL_ENVIRONMENT.bp_2ac3a221090b246a {
            attribute originalConnectionId : String = "CG-F69B9F4B8E034908EE3FE467";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_F69B9F4B8E034908EE3FE467";
        }
        interface c_CG_FD763799DECBFD4A6F4F94AD : IF_IF_CMD_020 connect leaf_N_7211.rp_a882b33038ce4623 to leaf_N_7228.rp_8b8dde76f47ec820 {
            attribute originalConnectionId : String = "CG-FD763799DECBFD4A6F4F94AD";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_FD763799DECBFD4A6F4F94AD";
        }
        view RV_05_CONNECTIONS_SOURCE_L1_7000 {
            expose leaf_N_3131;
            expose leaf_N_7142;
            expose leaf_N_7211;
            expose leaf_N_7213;
            expose leaf_N_7222;
            expose leaf_N_7225;
            expose leaf_N_7227;
            expose leaf_N_7228;
            expose leaf_N_722A;
            expose leaf_N_722B;
            expose leaf_N_722C;
            expose leaf_N_7252;
            expose leaf_N_7254;
            expose leaf_N_7255;
            expose leaf_N_7281;
            expose leaf_N_7284;
            expose leaf_N_7285;
            expose leaf_N_8121;
            expose leaf_N_8122;
            expose leaf_N_8125;
            expose leaf_N_8128;
            expose leaf_BOUNDARY_THERMAL_ENVIRONMENT;
            expose c_CG_1102EBD35D52A38B96D5D2E7;
            expose c_CG_1A5B4FFFE2C9C8ED85759C3D;
            expose c_CG_1D4D143F52B7F4D880B3CB30;
            expose c_CG_2B17DCC398F786E916C9C8DC;
            expose c_CG_3981A8B947B66F597AA9E03F;
            expose c_CG_56E4DA6D8C7C1FCFA93A8C7B;
            expose c_CG_5E309780F220E97DE29B2A38;
            expose c_CG_686A357580FCAB93907E7B31;
            expose c_CG_739E53DD845C8CD2646C8E39;
            expose c_CG_7AAA105058D4FD893E634E16;
            expose c_CG_7D415C2FE2A98E99E69F2808;
            expose c_CG_944069F2CBBFA2A01274A9DB;
            expose c_CG_9B0510538F8E21B452D8C165;
            expose c_CG_B251741505CB19FE47559F29;
            expose c_CG_C7C6703197747322B57096B5;
            expose c_CG_CCE3D228C7F2AEE6207C1B6A;
            expose c_CG_D1D66AE9099CD7FA32C270A6;
            expose c_CG_DA869E241F8A36DBAAC07E48;
            expose c_CG_E9224B53F74EDFCCFDA0FC70;
            expose c_CG_E9AAF8010953F56E28D65ACF;
            expose c_CG_F69B9F4B8E034908EE3FE467;
            expose c_CG_FD763799DECBFD4A6F4F94AD;
        }
    }
    package BySourceL1_8000 {
        part leaf_N_3811 : P_N_3811;
        part leaf_N_4239 : P_N_4239;
        part leaf_N_5112 : P_N_5112;
        part leaf_N_7211 : P_N_7211;
        part leaf_N_7226 : P_N_7226;
        part leaf_N_8121 : P_N_8121;
        part leaf_N_8122 : P_N_8122;
        part leaf_N_8125 : P_N_8125;
        part leaf_N_8127 : P_N_8127;
        part leaf_N_8128 : P_N_8128;
        part leaf_N_8151 : P_N_8151;
        part leaf_N_8152 : P_N_8152;
        part leaf_N_8154 : P_N_8154;
        part leaf_N_8166 : P_N_8166;
        part leaf_X112 : P_X112;
        interface c_CG_071B7693DAFA8B87ADA0A61E : IF_IF_CMD_004 connect leaf_N_8121.rp_a9c7eff84933cd80 to leaf_N_7211.rp_faa6c7c9931b0a58 {
            attribute originalConnectionId : String = "CG-071B7693DAFA8B87ADA0A61E";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_071B7693DAFA8B87ADA0A61E";
        }
        interface c_CG_121266057FF9E69E8769A5CA : IF_IF_CMD_002 connect leaf_N_8121.rp_809f8275c004ab18 to leaf_N_8122.rp_c39f0a202834bb12 {
            attribute originalConnectionId : String = "CG-121266057FF9E69E8769A5CA";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_121266057FF9E69E8769A5CA";
        }
        interface c_CG_14318213721CBD91F198F77B : IF_IF_CMD_008 connect leaf_N_8121.rp_c49f12594ff56025 to leaf_N_8125.rp_d86bd7909c634e71 {
            attribute originalConnectionId : String = "CG-14318213721CBD91F198F77B";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_14318213721CBD91F198F77B";
        }
        interface c_CG_14D79A46EA4824EAC69F2DCF : IF_IF_STA_002 connect leaf_N_8125.rp_dae11d7502a6c37a to leaf_N_8122.rp_ca63e6a6492a217f {
            attribute originalConnectionId : String = "CG-14D79A46EA4824EAC69F2DCF";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_14D79A46EA4824EAC69F2DCF";
        }
        interface c_CG_1ACF37CC65D3FF235E8BD75C : IF_IF_STA_002 connect leaf_N_8125.rp_dae11d7502a6c37a to leaf_N_7211.rp_d26568a796272d7a {
            attribute originalConnectionId : String = "CG-1ACF37CC65D3FF235E8BD75C";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_1ACF37CC65D3FF235E8BD75C";
        }
        interface c_CG_1AE13610E33C0DC7055CFCED : IF_IF_CMD_027 connect leaf_N_8122.rp_4683a7cb63e55daf to leaf_X112.rp_81f1c1da5d6d3173 {
            attribute originalConnectionId : String = "CG-1AE13610E33C0DC7055CFCED";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_1AE13610E33C0DC7055CFCED";
        }
        interface c_CG_1AEA8B915E14A5D0FFEE30D9 : IF_IF_MEA_016 connect leaf_N_8128.rp_0e19632016b69ff2 to leaf_N_7211.rp_f786158194c89c8a {
            attribute originalConnectionId : String = "CG-1AEA8B915E14A5D0FFEE30D9";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_1AEA8B915E14A5D0FFEE30D9";
        }
        interface c_CG_1D8165FC25AEFF761DD29797 : IF_IF_CMD_004 connect leaf_N_8121.rp_a9c7eff84933cd80 to leaf_N_8122.rp_361e7dc74e9287e3 {
            attribute originalConnectionId : String = "CG-1D8165FC25AEFF761DD29797";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_1D8165FC25AEFF761DD29797";
        }
        interface c_CG_25DC22E45A984D1CB28D188B : IF_IF_CMD_026 connect leaf_N_8122.rp_a4aac084c46e1e57 to leaf_X112.rp_1164249ec859b807 {
            attribute originalConnectionId : String = "CG-25DC22E45A984D1CB28D188B";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_25DC22E45A984D1CB28D188B";
        }
        interface c_CG_2C4335E39D698D9A34096F73 : IF_IF_CMD_009 connect leaf_N_8121.rp_f4c8eaaf49d11d3d to leaf_N_8154.rp_c3d327abebd9ecfd {
            attribute originalConnectionId : String = "CG-2C4335E39D698D9A34096F73";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_2C4335E39D698D9A34096F73";
        }
        interface c_CG_2CE5C7F366544DF5F5AB234B : IF_IF_STA_025 connect leaf_N_8152.rp_ae53feffb1e116e3 to leaf_N_8128.rp_eea6ab94a057e9f5 {
            attribute originalConnectionId : String = "CG-2CE5C7F366544DF5F5AB234B";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_2CE5C7F366544DF5F5AB234B";
        }
        interface c_CG_3352802713B03806EB2934A1 : IF_IF_STA_025 connect leaf_N_8128.rp_9f2f985b6764bfa7 to leaf_N_8121.rp_36991cec1f7be17b {
            attribute originalConnectionId : String = "CG-3352802713B03806EB2934A1";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_3352802713B03806EB2934A1";
        }
        interface c_CG_410B8D702206200512DD3731 : IF_IF_CMD_003 connect leaf_N_8121.rp_d82e5c8a7afb4b7b to leaf_N_8122.rp_898e3aba50ea7cb4 {
            attribute originalConnectionId : String = "CG-410B8D702206200512DD3731";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_410B8D702206200512DD3731";
        }
        interface c_CG_4163C3EB1F2D16B7AFCB21C9 : IF_IF_CMD_004 connect leaf_N_8121.rp_a9c7eff84933cd80 to leaf_N_7226.rp_5f6a9d81cebde2d3 {
            attribute originalConnectionId : String = "CG-4163C3EB1F2D16B7AFCB21C9";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_4163C3EB1F2D16B7AFCB21C9";
        }
        interface c_CG_44890BAD0E32A867EFFB7EBB : IF_IF_STA_026 connect leaf_N_8154.rp_492d0ced994652db to leaf_N_8128.rp_9819959a053f9c06 {
            attribute originalConnectionId : String = "CG-44890BAD0E32A867EFFB7EBB";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_44890BAD0E32A867EFFB7EBB";
        }
        interface c_CG_44E8AB4EA7ED953642770E4E : IF_IF_CMD_009 connect leaf_N_8121.rp_f4c8eaaf49d11d3d to leaf_N_8125.rp_0e01f3a589418f6c {
            attribute originalConnectionId : String = "CG-44E8AB4EA7ED953642770E4E";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_44E8AB4EA7ED953642770E4E";
        }
        interface c_CG_464B2D6F08DDD0D4287D0294 : IF_IF_STA_026 connect leaf_N_8128.rp_aad98cbe8fa3b27e to leaf_N_8125.rp_90deb6e5a4e470f1 {
            attribute originalConnectionId : String = "CG-464B2D6F08DDD0D4287D0294";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_464B2D6F08DDD0D4287D0294";
        }
        interface c_CG_50AB5ECD4830D34487B7B557 : IF_IF_CMD_008 connect leaf_N_8121.rp_c49f12594ff56025 to leaf_N_8154.rp_a8fff2340df81262 {
            attribute originalConnectionId : String = "CG-50AB5ECD4830D34487B7B557";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_50AB5ECD4830D34487B7B557";
        }
        interface c_CG_53ADA5E90929843D3AD53312 : IF_IF_CMD_024 connect leaf_N_8122.rp_f0886e48bf75472f to leaf_N_8128.rp_26589bfc82ed6979 {
            attribute originalConnectionId : String = "CG-53ADA5E90929843D3AD53312";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_53ADA5E90929843D3AD53312";
        }
        interface c_CG_565AF053FC6E3FF333FD7433 : IF_IF_CMD_024 connect leaf_N_8128.rp_5accd69f9c3a8b0c to leaf_N_3811.rp_81d4e1a7092e0653 {
            attribute originalConnectionId : String = "CG-565AF053FC6E3FF333FD7433";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_565AF053FC6E3FF333FD7433";
        }
        interface c_CG_6546CFCB7800C785459AC8E1 : IF_IF_STA_026 connect leaf_N_8128.rp_aad98cbe8fa3b27e to leaf_N_8121.rp_de2d35d2bcb08b0b {
            attribute originalConnectionId : String = "CG-6546CFCB7800C785459AC8E1";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_6546CFCB7800C785459AC8E1";
        }
        interface c_CG_697084EEC1DCA9E975638C14 : IF_IF_CMD_030 connect leaf_N_8127.rp_8f3091a86214dd4e to leaf_N_8152.rp_1e4f882572b04df5 {
            attribute originalConnectionId : String = "CG-697084EEC1DCA9E975638C14";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_697084EEC1DCA9E975638C14";
        }
        interface c_CG_70D940D7F34BF27762FED746 : IF_IF_STA_024 connect leaf_N_8151.rp_c6902e30a0122c0e to leaf_N_8128.rp_2b9604597ff0c9ac {
            attribute originalConnectionId : String = "CG-70D940D7F34BF27762FED746";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_70D940D7F34BF27762FED746";
        }
        interface c_CG_7365C853DD9391D9914E0C8A : IF_IF_CMD_012 connect leaf_N_8125.rp_70a8e2c4b0887b4d to leaf_N_5112.rp_6ce5fb5c81d47ab4 {
            attribute originalConnectionId : String = "CG-7365C853DD9391D9914E0C8A";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_7365C853DD9391D9914E0C8A";
        }
        interface c_CG_7664DA49869213FC03120E3B : IF_IF_MEA_013 connect leaf_N_8125.rp_36a59f5828d4c515 to leaf_N_8122.rp_f36629c6f163833f {
            attribute originalConnectionId : String = "CG-7664DA49869213FC03120E3B";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_7664DA49869213FC03120E3B";
        }
        interface c_CG_767F79CB763B96968C94D7AD : IF_IF_CMD_001 connect leaf_N_8121.rp_8fbe2a98ba0ac28c to leaf_N_8122.rp_ac60006ecd824aae {
            attribute originalConnectionId : String = "CG-767F79CB763B96968C94D7AD";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_767F79CB763B96968C94D7AD";
        }
        interface c_CG_7A2381DC8C36A40B747035A5 : IF_IF_CMD_025 connect leaf_N_8122.rp_77c439392dea95b4 to leaf_X112.rp_843fa8c83311440e {
            attribute originalConnectionId : String = "CG-7A2381DC8C36A40B747035A5";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_7A2381DC8C36A40B747035A5";
        }
        interface c_CG_7AEA5BA2801064550BBE6D02 : IF_IF_CMD_002 connect leaf_N_8121.rp_809f8275c004ab18 to leaf_N_8125.rp_713c697d47d94da9 {
            attribute originalConnectionId : String = "CG-7AEA5BA2801064550BBE6D02";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_7AEA5BA2801064550BBE6D02";
        }
        interface c_CG_979C19823B520B68E370ECB6 : IF_IF_CMD_003 connect leaf_N_8121.rp_d82e5c8a7afb4b7b to leaf_N_7211.rp_77afbfa330bfb95e {
            attribute originalConnectionId : String = "CG-979C19823B520B68E370ECB6";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_979C19823B520B68E370ECB6";
        }
        interface c_CG_9AE6E470A1C767E917CAED42 : IF_IF_CMD_030 connect leaf_N_8127.rp_8f3091a86214dd4e to leaf_N_8122.rp_ab848f3c1a74117a {
            attribute originalConnectionId : String = "CG-9AE6E470A1C767E917CAED42";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_9AE6E470A1C767E917CAED42";
        }
        interface c_CG_9D3B4C2BDF604CDEBBA07160 : IF_IF_ACC_015 connect leaf_N_8166.rp_0d75944292125dac to leaf_N_8122.rp_b11b9e2ada11927e {
            attribute originalConnectionId : String = "CG-9D3B4C2BDF604CDEBBA07160";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_9D3B4C2BDF604CDEBBA07160";
        }
        interface c_CG_A0B82CF482DDFB4553F8CFCA : IF_IF_MEA_014 connect leaf_N_8128.rp_8d19f6989a5bebad to leaf_N_7211.rp_04cfaf63bfa3ed70 {
            attribute originalConnectionId : String = "CG-A0B82CF482DDFB4553F8CFCA";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_A0B82CF482DDFB4553F8CFCA";
        }
        interface c_CG_ACA2BC6B6BBEF201778733FC : IF_IF_STA_027 connect leaf_N_8128.rp_58e3c9dfabb04a51 to leaf_N_8121.rp_d5423b06aaccb6ac {
            attribute originalConnectionId : String = "CG-ACA2BC6B6BBEF201778733FC";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_ACA2BC6B6BBEF201778733FC";
        }
        interface c_CG_B1E191297C1D862473B2D371 : IF_IF_STA_001 connect leaf_N_8125.rp_04f0621818e40445 to leaf_N_8122.rp_b6a69bd683685d04 {
            attribute originalConnectionId : String = "CG-B1E191297C1D862473B2D371";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_B1E191297C1D862473B2D371";
        }
        interface c_CG_B5CE3B88204C1D03AD0527D2 : IF_IF_LIM_001 connect leaf_N_8125.rp_b60dd66dcfd10afa to leaf_N_8122.rp_e0814e233fa0db3e {
            attribute originalConnectionId : String = "CG-B5CE3B88204C1D03AD0527D2";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_B5CE3B88204C1D03AD0527D2";
        }
        interface c_CG_BB962E06FB56D8459F9A2BF0 : IF_IF_STA_001 connect leaf_N_8125.rp_04f0621818e40445 to leaf_N_8121.rp_37e2c2d63c55e098 {
            attribute originalConnectionId : String = "CG-BB962E06FB56D8459F9A2BF0";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_BB962E06FB56D8459F9A2BF0";
        }
        interface c_CG_BE9EAF0E7F50C277DA344138 : IF_IF_LIM_004 connect leaf_N_8125.rp_91d8f479934c65da to leaf_N_8122.rp_3aaf955421310ab3 {
            attribute originalConnectionId : String = "CG-BE9EAF0E7F50C277DA344138";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_BE9EAF0E7F50C277DA344138";
        }
        interface c_CG_BEDE0932E86628B2EFCA8CCD : IF_IF_LIM_001 connect leaf_N_8125.rp_b60dd66dcfd10afa to leaf_N_7211.rp_e4d6047a07b1416e {
            attribute originalConnectionId : String = "CG-BEDE0932E86628B2EFCA8CCD";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_BEDE0932E86628B2EFCA8CCD";
        }
        interface c_CG_C0F5EB5317440FA36F0491AE : IF_IF_STA_024 connect leaf_N_8128.rp_cb74be2d7d4a54c7 to leaf_N_8121.rp_2455eff74badb007 {
            attribute originalConnectionId : String = "CG-C0F5EB5317440FA36F0491AE";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_C0F5EB5317440FA36F0491AE";
        }
        interface c_CG_C6A9FBA7CCD28311320F3552 : IF_IF_CMD_030 connect leaf_N_8127.rp_8f3091a86214dd4e to leaf_N_8121.rp_4325db72e2d88769 {
            attribute originalConnectionId : String = "CG-C6A9FBA7CCD28311320F3552";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_C6A9FBA7CCD28311320F3552";
        }
        interface c_CG_CE151D40A2BF816F41762F4C : IF_IF_STA_025 connect leaf_N_8152.rp_ae53feffb1e116e3 to leaf_N_7211.rp_daaf414c1711f2bd {
            attribute originalConnectionId : String = "CG-CE151D40A2BF816F41762F4C";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_CE151D40A2BF816F41762F4C";
        }
        interface c_CG_D8FCE908D4FD9343C6353985 : IF_IF_CMD_029 connect leaf_N_8122.rp_47c78247980cc3a5 to leaf_X112.rp_b84f02a624b9982f {
            attribute originalConnectionId : String = "CG-D8FCE908D4FD9343C6353985";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_D8FCE908D4FD9343C6353985";
        }
        interface c_CG_D9CD1E8933F596F319A67625 : IF_IF_CMD_028 connect leaf_N_8122.rp_f704c2e7bab06749 to leaf_X112.rp_5ff890136d5d49bf {
            attribute originalConnectionId : String = "CG-D9CD1E8933F596F319A67625";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_D9CD1E8933F596F319A67625";
        }
        interface c_CG_E8DAA56D71F2BE4B5E1C9BBF : IF_IF_MEA_013 connect leaf_N_8125.rp_36a59f5828d4c515 to leaf_N_7211.rp_179bcc3fb8dacbbf {
            attribute originalConnectionId : String = "CG-E8DAA56D71F2BE4B5E1C9BBF";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_E8DAA56D71F2BE4B5E1C9BBF";
        }
        interface c_CG_ED49C68C1459BB1005D412BB : IF_IF_CMD_030 connect leaf_N_8127.rp_8f3091a86214dd4e to leaf_N_7211.rp_da3049ae66223d22 {
            attribute originalConnectionId : String = "CG-ED49C68C1459BB1005D412BB";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_ED49C68C1459BB1005D412BB";
        }
        interface c_CG_F55B5E17D8CBFAC80E0961C2 : IF_IF_STA_024 connect leaf_N_8128.rp_cb74be2d7d4a54c7 to leaf_N_4239.rp_c9c4c887a8c7b2f0 {
            attribute originalConnectionId : String = "CG-F55B5E17D8CBFAC80E0961C2";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_F55B5E17D8CBFAC80E0961C2";
        }
        view RV_05_CONNECTIONS_SOURCE_L1_8000 {
            expose leaf_N_3811;
            expose leaf_N_4239;
            expose leaf_N_5112;
            expose leaf_N_7211;
            expose leaf_N_7226;
            expose leaf_N_8121;
            expose leaf_N_8122;
            expose leaf_N_8125;
            expose leaf_N_8127;
            expose leaf_N_8128;
            expose leaf_N_8151;
            expose leaf_N_8152;
            expose leaf_N_8154;
            expose leaf_N_8166;
            expose leaf_X112;
            expose c_CG_071B7693DAFA8B87ADA0A61E;
            expose c_CG_121266057FF9E69E8769A5CA;
            expose c_CG_14318213721CBD91F198F77B;
            expose c_CG_14D79A46EA4824EAC69F2DCF;
            expose c_CG_1ACF37CC65D3FF235E8BD75C;
            expose c_CG_1AE13610E33C0DC7055CFCED;
            expose c_CG_1AEA8B915E14A5D0FFEE30D9;
            expose c_CG_1D8165FC25AEFF761DD29797;
            expose c_CG_25DC22E45A984D1CB28D188B;
            expose c_CG_2C4335E39D698D9A34096F73;
            expose c_CG_2CE5C7F366544DF5F5AB234B;
            expose c_CG_3352802713B03806EB2934A1;
            expose c_CG_410B8D702206200512DD3731;
            expose c_CG_4163C3EB1F2D16B7AFCB21C9;
            expose c_CG_44890BAD0E32A867EFFB7EBB;
            expose c_CG_44E8AB4EA7ED953642770E4E;
            expose c_CG_464B2D6F08DDD0D4287D0294;
            expose c_CG_50AB5ECD4830D34487B7B557;
            expose c_CG_53ADA5E90929843D3AD53312;
            expose c_CG_565AF053FC6E3FF333FD7433;
            expose c_CG_6546CFCB7800C785459AC8E1;
            expose c_CG_697084EEC1DCA9E975638C14;
            expose c_CG_70D940D7F34BF27762FED746;
            expose c_CG_7365C853DD9391D9914E0C8A;
            expose c_CG_7664DA49869213FC03120E3B;
            expose c_CG_767F79CB763B96968C94D7AD;
            expose c_CG_7A2381DC8C36A40B747035A5;
            expose c_CG_7AEA5BA2801064550BBE6D02;
            expose c_CG_979C19823B520B68E370ECB6;
            expose c_CG_9AE6E470A1C767E917CAED42;
            expose c_CG_9D3B4C2BDF604CDEBBA07160;
            expose c_CG_A0B82CF482DDFB4553F8CFCA;
            expose c_CG_ACA2BC6B6BBEF201778733FC;
            expose c_CG_B1E191297C1D862473B2D371;
            expose c_CG_B5CE3B88204C1D03AD0527D2;
            expose c_CG_BB962E06FB56D8459F9A2BF0;
            expose c_CG_BE9EAF0E7F50C277DA344138;
            expose c_CG_BEDE0932E86628B2EFCA8CCD;
            expose c_CG_C0F5EB5317440FA36F0491AE;
            expose c_CG_C6A9FBA7CCD28311320F3552;
            expose c_CG_CE151D40A2BF816F41762F4C;
            expose c_CG_D8FCE908D4FD9343C6353985;
            expose c_CG_D9CD1E8933F596F319A67625;
            expose c_CG_E8DAA56D71F2BE4B5E1C9BBF;
            expose c_CG_ED49C68C1459BB1005D412BB;
            expose c_CG_F55B5E17D8CBFAC80E0961C2;
        }
    }
    package BySourceL1_D000 {
        part leaf_N_8121 : P_N_8121;
        part leaf_N_8152 : P_N_8152;
        part leaf_D112 : P_D112;
        part leaf_D113 : P_D113;
        part leaf_D114 : P_D114;
        part leaf_D121 : P_D121;
        interface c_CG_2E8F3CC8A8EBCDE6B7CF4D27 : IF_IF_CMD_002 connect leaf_D113.rp_9ca0d9d396f8ffd0 to leaf_N_8121.rp_a49a67fafe112278 {
            attribute originalConnectionId : String = "CG-2E8F3CC8A8EBCDE6B7CF4D27";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_2E8F3CC8A8EBCDE6B7CF4D27";
        }
        interface c_CG_41AD09EEB4EAB9DC956C08F8 : IF_IF_CMD_003 connect leaf_D114.rp_d3d5739989ecf2dd to leaf_N_8121.rp_0b58c63caeaf2f6d {
            attribute originalConnectionId : String = "CG-41AD09EEB4EAB9DC956C08F8";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_41AD09EEB4EAB9DC956C08F8";
        }
        interface c_CG_663CDC611495882DCD3E5B8F : IF_IF_CMD_004 connect leaf_D121.rp_d32b32814a84a88a to leaf_N_8152.rp_93024c6ed1623fbd {
            attribute originalConnectionId : String = "CG-663CDC611495882DCD3E5B8F";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_663CDC611495882DCD3E5B8F";
        }
        interface c_CG_8EED0159D22D9EDC70A9EA67 : IF_IF_CMD_004 connect leaf_D121.rp_d32b32814a84a88a to leaf_N_8121.rp_1e34bb2697325127 {
            attribute originalConnectionId : String = "CG-8EED0159D22D9EDC70A9EA67";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_8EED0159D22D9EDC70A9EA67";
        }
        interface c_CG_A3B31951ADAE62C498E76260 : IF_IF_CMD_001 connect leaf_D112.rp_8962dea15ad904c6 to leaf_N_8121.rp_2ee1cd48c6d41ac7 {
            attribute originalConnectionId : String = "CG-A3B31951ADAE62C498E76260";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_A3B31951ADAE62C498E76260";
        }
        view RV_05_CONNECTIONS_SOURCE_L1_D000 {
            expose leaf_N_8121;
            expose leaf_N_8152;
            expose leaf_D112;
            expose leaf_D113;
            expose leaf_D114;
            expose leaf_D121;
            expose c_CG_2E8F3CC8A8EBCDE6B7CF4D27;
            expose c_CG_41AD09EEB4EAB9DC956C08F8;
            expose c_CG_663CDC611495882DCD3E5B8F;
            expose c_CG_8EED0159D22D9EDC70A9EA67;
            expose c_CG_A3B31951ADAE62C498E76260;
        }
    }
    package BySourceL1_E000 {
        part leaf_N_8127 : P_N_8127;
        part leaf_N_8128 : P_N_8128;
        part leaf_E100 : P_E100;
        interface c_CG_0D68248E62957CCB92C5A2A5 : IF_IF_STA_027 connect leaf_E100.rp_0307dc18d9537f9d to leaf_N_8127.rp_a916a9847aeadebb {
            attribute originalConnectionId : String = "CG-0D68248E62957CCB92C5A2A5";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_0D68248E62957CCB92C5A2A5";
        }
        interface c_CG_86987C60BCB826208FEFEF31 : IF_IF_CMD_030 connect leaf_E100.rp_7273a171b473f816 to leaf_N_8127.rp_be0fc7194a7f0161 {
            attribute originalConnectionId : String = "CG-86987C60BCB826208FEFEF31";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_86987C60BCB826208FEFEF31";
        }
        interface c_CG_89318B491DF9CED18997C36D : IF_IF_STA_027 connect leaf_E100.rp_0307dc18d9537f9d to leaf_N_8128.rp_ce6397cb7b81dd94 {
            attribute originalConnectionId : String = "CG-89318B491DF9CED18997C36D";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_89318B491DF9CED18997C36D";
        }
        view RV_05_CONNECTIONS_SOURCE_L1_E000 {
            expose leaf_N_8127;
            expose leaf_N_8128;
            expose leaf_E100;
            expose c_CG_0D68248E62957CCB92C5A2A5;
            expose c_CG_86987C60BCB826208FEFEF31;
            expose c_CG_89318B491DF9CED18997C36D;
        }
    }
    package BySourceL1_X000 {
        part leaf_N_8122 : P_N_8122;
        part leaf_BOUNDARY_THERMAL_ENVIRONMENT : B_BOUNDARY_THERMAL_ENVIRONMENT;
        part leaf_X111 : P_X111;
        part leaf_X112 : P_X112;
        part leaf_X113 : P_X113;
        part leaf_X121 : P_X121;
        part leaf_X122 : P_X122;
        part leaf_X123 : P_X123;
        part leaf_X124 : P_X124;
        part leaf_X131 : P_X131;
        part leaf_X132 : P_X132;
        part leaf_X133 : P_X133;
        interface c_CG_093EFCE58F3AB220CFEC48AC : IF_IF_ACC_004 connect leaf_X112.rp_a59821acb0d73604 to leaf_N_8122.rp_a095b9b42ab5cc7d {
            attribute originalConnectionId : String = "CG-093EFCE58F3AB220CFEC48AC";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_093EFCE58F3AB220CFEC48AC";
        }
        interface c_CG_166B9301CD54035D82DA7711 : IF_IF_STA_034 connect leaf_X133.rp_ffcdb33099ab8a28 to leaf_X112.rp_00da2edc928b715d {
            attribute originalConnectionId : String = "CG-166B9301CD54035D82DA7711";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_166B9301CD54035D82DA7711";
        }
        interface c_CG_169E84593A2DDD6DA3BAE4D5 : IF_IF_MEA_028 connect leaf_X121.rp_b6cf5a49ced52abf to leaf_X112.rp_ced58e17348ff578 {
            attribute originalConnectionId : String = "CG-169E84593A2DDD6DA3BAE4D5";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_169E84593A2DDD6DA3BAE4D5";
        }
        interface c_CG_1BA0ACBF380D191A9BED4AE4 : IF_IF_MEA_027 connect leaf_X124.rp_5083db510ca305a5 to leaf_X112.rp_848f140649f8e2ae {
            attribute originalConnectionId : String = "CG-1BA0ACBF380D191A9BED4AE4";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_1BA0ACBF380D191A9BED4AE4";
        }
        interface c_CG_1BF39653E0AA099A8515E223 : IF_IF_PHY_013 connect leaf_X124.rp_4d5eafc70549d9c0 to leaf_X121.rp_387cdae1b4483182 {
            attribute originalConnectionId : String = "CG-1BF39653E0AA099A8515E223";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_1BF39653E0AA099A8515E223";
        }
        interface c_CG_585503C9572B9BF371266D8B : IF_IF_PHY_013 connect leaf_X121.rp_387cdae1b4483182 to leaf_BOUNDARY_THERMAL_ENVIRONMENT.bp_2ac3a221090b246a {
            attribute originalConnectionId : String = "CG-585503C9572B9BF371266D8B";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_585503C9572B9BF371266D8B";
        }
        interface c_CG_61CA88D0219D5B46EEFA0E92 : IF_IF_CMD_026 connect leaf_X112.rp_f980a38f780089b6 to leaf_X111.rp_6085b3266f1baf9d {
            attribute originalConnectionId : String = "CG-61CA88D0219D5B46EEFA0E92";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_61CA88D0219D5B46EEFA0E92";
        }
        interface c_CG_686E1C0741D80B3DE2EEBA80 : IF_IF_MEA_008 connect leaf_X113.rp_0e45c7ab357a42e6 to leaf_X112.rp_89849c49127b2dfb {
            attribute originalConnectionId : String = "CG-686E1C0741D80B3DE2EEBA80";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_686E1C0741D80B3DE2EEBA80";
        }
        interface c_CG_734E10C63B7A36C2BB06360D : IF_IF_STA_033 connect leaf_X132.rp_53191daa39f85d49 to leaf_X112.rp_3ecd9966c9972a7e {
            attribute originalConnectionId : String = "CG-734E10C63B7A36C2BB06360D";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_734E10C63B7A36C2BB06360D";
        }
        interface c_CG_79EB6BEB9B0AE9B2B06844A4 : IF_IF_CMD_027 connect leaf_X112.rp_2ea4241545e6ca09 to leaf_X131.rp_b06975e1baff62be {
            attribute originalConnectionId : String = "CG-79EB6BEB9B0AE9B2B06844A4";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_79EB6BEB9B0AE9B2B06844A4";
        }
        interface c_CG_86C48EA2DE057325EEB9853C : IF_IF_MEA_026 connect leaf_X123.rp_9b6812b4ca482c66 to leaf_X112.rp_e8341f592e73af5e {
            attribute originalConnectionId : String = "CG-86C48EA2DE057325EEB9853C";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_86C48EA2DE057325EEB9853C";
        }
        interface c_CG_9465AAC3F0B0B115DC3EF9FD : IF_IF_MEA_028 connect leaf_X121.rp_b6cf5a49ced52abf to leaf_N_8122.rp_6437aa0577c9ccd7 {
            attribute originalConnectionId : String = "CG-9465AAC3F0B0B115DC3EF9FD";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_9465AAC3F0B0B115DC3EF9FD";
        }
        interface c_CG_9A05AF4B79F0AC70EEBB8C27 : IF_IF_MEA_025 connect leaf_X122.rp_370359531bcbeddd to leaf_X112.rp_fc5798a77b6a020d {
            attribute originalConnectionId : String = "CG-9A05AF4B79F0AC70EEBB8C27";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_9A05AF4B79F0AC70EEBB8C27";
        }
        interface c_CG_A0E50849D53632A6F599B298 : IF_IF_CMD_025 connect leaf_X112.rp_1ca011606f062f80 to leaf_X111.rp_3ad794182f43f4d8 {
            attribute originalConnectionId : String = "CG-A0E50849D53632A6F599B298";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_A0E50849D53632A6F599B298";
        }
        interface c_CG_A6D783BBFCF6C6DA11FFCF2D : IF_IF_MEA_029 connect leaf_X111.rp_9828766df3df1904 to leaf_N_8122.rp_e1808e35289aaba6 {
            attribute originalConnectionId : String = "CG-A6D783BBFCF6C6DA11FFCF2D";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_A6D783BBFCF6C6DA11FFCF2D";
        }
        interface c_CG_A9A3297C8A71DEFC8975FC31 : IF_IF_PHY_013 connect leaf_X124.rp_4d5eafc70549d9c0 to leaf_BOUNDARY_THERMAL_ENVIRONMENT.bp_2ac3a221090b246a {
            attribute originalConnectionId : String = "CG-A9A3297C8A71DEFC8975FC31";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_A9A3297C8A71DEFC8975FC31";
        }
        interface c_CG_BC53696D702792E563E6C045 : IF_IF_LIM_007 connect leaf_X113.rp_d9c32040ebe6917e to leaf_X112.rp_1f01277587ee6905 {
            attribute originalConnectionId : String = "CG-BC53696D702792E563E6C045";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_BC53696D702792E563E6C045";
        }
        interface c_CG_C003C81FB79009EC9E0DAC6B : IF_IF_CMD_028 connect leaf_X112.rp_adb78cdbb75469df to leaf_X132.rp_4d68d3f9ee4e0009 {
            attribute originalConnectionId : String = "CG-C003C81FB79009EC9E0DAC6B";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_C003C81FB79009EC9E0DAC6B";
        }
        interface c_CG_C03EBDD9B3CFF4E6611E41A1 : IF_IF_STA_030 connect leaf_X112.rp_3b946767139d884a to leaf_N_8122.rp_1967a947dd39d4a5 {
            attribute originalConnectionId : String = "CG-C03EBDD9B3CFF4E6611E41A1";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_C03EBDD9B3CFF4E6611E41A1";
        }
        interface c_CG_C113ED5B462ACDD4ACE56E91 : IF_IF_STA_031 connect leaf_X112.rp_e5eadfefaf46ac0a to leaf_N_8122.rp_9d3500c169fe7103 {
            attribute originalConnectionId : String = "CG-C113ED5B462ACDD4ACE56E91";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_C113ED5B462ACDD4ACE56E91";
        }
        interface c_CG_C2F8D7B23A3941D29EE9543F : IF_IF_MEA_029 connect leaf_X111.rp_9828766df3df1904 to leaf_X112.rp_4659cbe7e3b50b58 {
            attribute originalConnectionId : String = "CG-C2F8D7B23A3941D29EE9543F";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_C2F8D7B23A3941D29EE9543F";
        }
        interface c_CG_C5E43804F4CA212D668FD997 : IF_IF_STA_032 connect leaf_X131.rp_c029b3b1472e957d to leaf_X112.rp_f929a9fa6b633837 {
            attribute originalConnectionId : String = "CG-C5E43804F4CA212D668FD997";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_C5E43804F4CA212D668FD997";
        }
        interface c_CG_CB302083C9F33A1345D9C406 : IF_IF_LIM_009 connect leaf_X112.rp_388d943a537916a7 to leaf_N_8122.rp_8c3ed075d33335e8 {
            attribute originalConnectionId : String = "CG-CB302083C9F33A1345D9C406";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_CB302083C9F33A1345D9C406";
        }
        interface c_CG_D9445FD2D7B8285174B3AE22 : IF_IF_MEA_030 connect leaf_X113.rp_30a4f2a71d158c56 to leaf_X112.rp_88bb7293920adfa8 {
            attribute originalConnectionId : String = "CG-D9445FD2D7B8285174B3AE22";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_D9445FD2D7B8285174B3AE22";
        }
        interface c_CG_DAF7D43DDD825831F29A70F8 : IF_IF_LIM_010 connect leaf_X112.rp_73067cce4e6a7eeb to leaf_N_8122.rp_35b0ef67b409e840 {
            attribute originalConnectionId : String = "CG-DAF7D43DDD825831F29A70F8";
            attribute originalSysMLPath : String = "SystemDefinition::railSystem.c_CG_DAF7D43DDD825831F29A70F8";
        }
        view RV_05_CONNECTIONS_SOURCE_L1_X000 {
            expose leaf_N_8122;
            expose leaf_BOUNDARY_THERMAL_ENVIRONMENT;
            expose leaf_X111;
            expose leaf_X112;
            expose leaf_X113;
            expose leaf_X121;
            expose leaf_X122;
            expose leaf_X123;
            expose leaf_X124;
            expose leaf_X131;
            expose leaf_X132;
            expose leaf_X133;
            expose c_CG_093EFCE58F3AB220CFEC48AC;
            expose c_CG_166B9301CD54035D82DA7711;
            expose c_CG_169E84593A2DDD6DA3BAE4D5;
            expose c_CG_1BA0ACBF380D191A9BED4AE4;
            expose c_CG_1BF39653E0AA099A8515E223;
            expose c_CG_585503C9572B9BF371266D8B;
            expose c_CG_61CA88D0219D5B46EEFA0E92;
            expose c_CG_686E1C0741D80B3DE2EEBA80;
            expose c_CG_734E10C63B7A36C2BB06360D;
            expose c_CG_79EB6BEB9B0AE9B2B06844A4;
            expose c_CG_86C48EA2DE057325EEB9853C;
            expose c_CG_9465AAC3F0B0B115DC3EF9FD;
            expose c_CG_9A05AF4B79F0AC70EEBB8C27;
            expose c_CG_A0E50849D53632A6F599B298;
            expose c_CG_A6D783BBFCF6C6DA11FFCF2D;
            expose c_CG_A9A3297C8A71DEFC8975FC31;
            expose c_CG_BC53696D702792E563E6C045;
            expose c_CG_C003C81FB79009EC9E0DAC6B;
            expose c_CG_C03EBDD9B3CFF4E6611E41A1;
            expose c_CG_C113ED5B462ACDD4ACE56E91;
            expose c_CG_C2F8D7B23A3941D29EE9543F;
            expose c_CG_C5E43804F4CA212D668FD997;
            expose c_CG_CB302083C9F33A1345D9C406;
            expose c_CG_D9445FD2D7B8285174B3AE22;
            expose c_CG_DAF7D43DDD825831F29A70F8;
        }
    }
}
