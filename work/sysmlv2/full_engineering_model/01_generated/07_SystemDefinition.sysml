package SystemDefinition {
    private import ScalarValues::*;
    private import InterfaceDefinitions::*;
    private import ProductDefinitions::*;
    part railSystem : RailSystemContext {
        interface c_CG_002543DBE0F9A7FBC2A3FDD3 : IF_IF_MEA_005 connect p_N_4000.p_N_4200.p_N_4230.p_N_4235.rp_6fea4b377f978aac to p_N_5000.p_N_5100.p_N_5110.p_N_5111.rp_5f90d6dd8fba4321 {
            attribute connectionId : String = "CG-002543DBE0F9A7FBC2A3FDD3";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4235::PORT::4235::高压线路电压输出::ITM-MEA-005::输出 -> 5111::PORT::5111::高压线路电压输入::ITM-MEA-005::输入";
        }
        interface c_CG_071B7693DAFA8B87ADA0A61E : IF_IF_CMD_004 connect p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_a9c7eff84933cd80 to p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_faa6c7c9931b0a58 {
            attribute connectionId : String = "CG-071B7693DAFA8B87ADA0A61E";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8121::PORT::8121::紧急制动请求输出::ITM-CMD-004::输出 -> 7211::PORT::7211::紧急制动请求输入::ITM-CMD-004::输入";
        }
        interface c_CG_07AF42BFA3927EF22F7BDDE7 : IF_IF_PHY_005 connect p_N_3000.p_N_3600.p_N_3640.p_N_3644.rp_af1c1b2c65382775 to p_N_5000.p_N_5300.p_N_5310.p_N_5311.rp_97eb613c06ae1b2e {
            attribute connectionId : String = "CG-07AF42BFA3927EF22F7BDDE7";
            attribute connectionType : String = "TAP";
            attribute originalPath : String = "3644::PORT::3644::旋转机械能端口::ITM-PHY-005::双向物理 -> 5311::PORT::5311::旋转机械能端口::ITM-PHY-005::双向物理";
        }
        interface c_CG_08375F15DCE75E45D4C45CE8 : IF_IF_LIM_005 connect p_N_5000.p_N_5100.p_N_5110.p_N_5111.rp_cd7720cf9a4eae22 to p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_1809c94f1581c7f8 {
            attribute connectionId : String = "CG-08375F15DCE75E45D4C45CE8";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5111::PORT::5111::接触网可接收功率输出::ITM-LIM-005::输出 -> 8125::PORT::8125::接触网可接收功率输入::ITM-LIM-005::输入";
        }
        interface c_CG_093EFCE58F3AB220CFEC48AC : IF_IF_ACC_004 connect p_X000.p_X100.p_X110.p_X112.rp_a59821acb0d73604 to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_a095b9b42ab5cc7d {
            attribute connectionId : String = "CG-093EFCE58F3AB220CFEC48AC";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X112::PORT::X112::储能吸收功率输出::ITM-ACC-004::输出 -> 8122::PORT::8122::储能吸收功率输入::ITM-ACC-004::输入";
        }
        interface c_CG_0B7698B3C627150EF560B4B0 : IF_IF_STA_014 connect p_N_4000.p_N_4200.p_N_4210.p_N_4212.rp_62a902ccb2d5edf3 to p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_b46091b51fbac2ba {
            attribute connectionId : String = "CG-0B7698B3C627150EF560B4B0";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4212::PORT::4212::高压隔离开关状态输出::ITM-STA-014::输出 -> 4238::PORT::4238::高压隔离开关状态输入::ITM-STA-014::输入";
        }
        interface c_CG_0D68248E62957CCB92C5A2A5 : IF_IF_STA_027 connect p_E000.p_E100.rp_0307dc18d9537f9d to p_N_8000.p_N_8100.p_N_8120.p_N_8127.rp_a916a9847aeadebb {
            attribute connectionId : String = "CG-0D68248E62957CCB92C5A2A5";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "E100::PORT::E100::ATP_外部安全系统状态输出::ITM-STA-027::输出 -> 8127::PORT::8127::ATP_外部安全系统状态输入::ITM-STA-027::输入";
        }
        interface c_CG_1102EBD35D52A38B96D5D2E7 : IF_IF_STA_003 connect p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_c021f63639408eff to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_b1fb8856841fb7cf {
            attribute connectionId : String = "CG-1102EBD35D52A38B96D5D2E7";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "7211::PORT::7211::制动系统可用状态输出::ITM-STA-003::输出 -> 8122::PORT::8122::制动系统可用状态输入::ITM-STA-003::输入";
        }
        interface c_CG_117A3F0E6C8FF8FF0013A46B : IF_IF_PHY_014 connect p_N_4000.p_N_4500.p_N_4510.p_N_4513.rp_f597e9dc63931270 to p_N_5000.p_N_5100.p_N_5120.p_N_5122.rp_0b57347688ba1240 {
            attribute connectionId : String = "CG-117A3F0E6C8FF8FF0013A46B";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "4513::PORT::4513::第二交流电能端口::ITM-PHY-014::双向物理 -> 5122::PORT::5122::牵引变压器次级交流电能端口::ITM-PHY-014::双向物理";
        }
        interface c_CG_118F2C2B84D1D301C7BE63F8 : IF_IF_PHY_014 connect p_N_4000.p_N_4500.p_N_4510.p_N_4513.rp_f597e9dc63931270 to p_N_5000.p_N_5100.p_N_5120.p_N_5121.rp_9dedfe88c8a34261 {
            attribute connectionId : String = "CG-118F2C2B84D1D301C7BE63F8";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "4513::PORT::4513::第二交流电能端口::ITM-PHY-014::双向物理 -> 5121::PORT::5121::牵引变压器次级交流电能端口::ITM-PHY-014::双向物理";
        }
        interface c_CG_121266057FF9E69E8769A5CA : IF_IF_CMD_002 connect p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_809f8275c004ab18 to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_c39f0a202834bb12 {
            attribute connectionId : String = "CG-121266057FF9E69E8769A5CA";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8121::PORT::8121::牵引指令输出::ITM-CMD-002::输出 -> 8122::PORT::8122::牵引指令输入::ITM-CMD-002::输入";
        }
        interface c_CG_13AAF69570338FD5B6C27BC3 : IF_IF_PHY_014 connect p_N_5000.p_N_5100.p_N_5120.p_N_5122.rp_0b57347688ba1240 to p_N_5000.p_N_5100.p_N_5130.p_N_5131.rp_32d77ca0c1d88b50 {
            attribute connectionId : String = "CG-13AAF69570338FD5B6C27BC3";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "5122::PORT::5122::牵引变压器次级交流电能端口::ITM-PHY-014::双向物理 -> 5131::PORT::5131::牵引变压器次级交流电能端口::ITM-PHY-014::双向物理";
        }
        interface c_CG_14318213721CBD91F198F77B : IF_IF_CMD_008 connect p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_c49f12594ff56025 to p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_d86bd7909c634e71 {
            attribute connectionId : String = "CG-14318213721CBD91F198F77B";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8121::PORT::8121::牵引切除请求输出::ITM-CMD-008::输出 -> 8125::PORT::8125::牵引切除请求输入::ITM-CMD-008::输入";
        }
        interface c_CG_14D79A46EA4824EAC69F2DCF : IF_IF_STA_002 connect p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_dae11d7502a6c37a to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_ca63e6a6492a217f {
            attribute connectionId : String = "CG-14D79A46EA4824EAC69F2DCF";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8125::PORT::8125::动态制动可用状态输出::ITM-STA-002::输出 -> 8122::PORT::8122::动态制动可用状态输入::ITM-STA-002::输入";
        }
        interface c_CG_166B9301CD54035D82DA7711 : IF_IF_STA_034 connect p_X000.p_X100.p_X130.p_X133.rp_ffcdb33099ab8a28 to p_X000.p_X100.p_X110.p_X112.rp_00da2edc928b715d {
            attribute connectionId : String = "CG-166B9301CD54035D82DA7711";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X133::PORT::X133::储能保护跳闸状态输出::ITM-STA-034::输出 -> X112::PORT::X112::储能保护跳闸状态输入::ITM-STA-034::输入";
        }
        interface c_CG_1687BE836F7FC44BCDADF2D2 : IF_IF_MEA_022 connect p_N_4000.p_N_4500.p_N_4510.p_N_4517.rp_b094956bc66dfaad to p_N_4000.p_N_4500.p_N_4510.p_N_4518.rp_f46b3d97e0fceb9e {
            attribute connectionId : String = "CG-1687BE836F7FC44BCDADF2D2";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4517::PORT::4517::主变压器温度输出::ITM-MEA-022::输出 -> 4518::PORT::4518::主变压器温度输入::ITM-MEA-022::输入";
        }
        interface c_CG_169E84593A2DDD6DA3BAE4D5 : IF_IF_MEA_028 connect p_X000.p_X100.p_X120.p_X121.rp_b6cf5a49ced52abf to p_X000.p_X100.p_X110.p_X112.rp_ced58e17348ff578 {
            attribute connectionId : String = "CG-169E84593A2DDD6DA3BAE4D5";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X121::PORT::X121::超级电容SOC输出::ITM-MEA-028::输出 -> X112::PORT::X112::超级电容SOC输入::ITM-MEA-028::输入";
        }
        interface c_CG_1803BC1FF5BB8C1A4F69CBA8 : IF_IF_PHY_014 connect p_N_4000.p_N_4500.p_N_4510.p_N_4511.rp_a6f93ee77144741e to p_N_4000.p_N_4500.p_N_4510.p_N_4513.rp_88e2bd038f100aa3 {
            attribute connectionId : String = "CG-1803BC1FF5BB8C1A4F69CBA8";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "4511::PORT::4511::牵引变压器次级交流电能端口::ITM-PHY-014::双向物理 -> 4513::PORT::4513::第一交流电能端口::ITM-PHY-014::双向物理";
        }
        interface c_CG_1A5B4FFFE2C9C8ED85759C3D : IF_IF_STA_005 connect p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_ef5148faa6dc1c65 to p_N_7000.p_N_7200.p_N_7280.p_N_7281.rp_28b3abdb6d1d1e9e {
            attribute connectionId : String = "CG-1A5B4FFFE2C9C8ED85759C3D";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "7211::PORT::7211::制动缓解状态输出::ITM-STA-005::输出 -> 7281::PORT::7281::制动缓解状态输入::ITM-STA-005::输入";
        }
        interface c_CG_1ACF37CC65D3FF235E8BD75C : IF_IF_STA_002 connect p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_dae11d7502a6c37a to p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_d26568a796272d7a {
            attribute connectionId : String = "CG-1ACF37CC65D3FF235E8BD75C";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8125::PORT::8125::动态制动可用状态输出::ITM-STA-002::输出 -> 7211::PORT::7211::动态制动可用状态输入::ITM-STA-002::输入";
        }
        interface c_CG_1AE13610E33C0DC7055CFCED : IF_IF_CMD_027 connect p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_4683a7cb63e55daf to p_X000.p_X100.p_X110.p_X112.rp_81f1c1da5d6d3173 {
            attribute connectionId : String = "CG-1AE13610E33C0DC7055CFCED";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8122::PORT::8122::储能主接触器指令输出::ITM-CMD-027::输出 -> X112::PORT::X112::储能主接触器指令输入::ITM-CMD-027::输入";
        }
        interface c_CG_1AEA8B915E14A5D0FFEE30D9 : IF_IF_MEA_016 connect p_N_8000.p_N_8100.p_N_8120.p_N_8128.rp_0e19632016b69ff2 to p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_f786158194c89c8a {
            attribute connectionId : String = "CG-1AEA8B915E14A5D0FFEE30D9";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8128::PORT::8128::制动缸压力输出::ITM-MEA-016::输出 -> 7211::PORT::7211::制动缸压力输入::ITM-MEA-016::输入";
        }
        interface c_CG_1BA0ACBF380D191A9BED4AE4 : IF_IF_MEA_027 connect p_X000.p_X100.p_X120.p_X124.rp_5083db510ca305a5 to p_X000.p_X100.p_X110.p_X112.rp_848f140649f8e2ae {
            attribute connectionId : String = "CG-1BA0ACBF380D191A9BED4AE4";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X124::PORT::X124::超级电容温度输出::ITM-MEA-027::输出 -> X112::PORT::X112::超级电容温度输入::ITM-MEA-027::输入";
        }
        interface c_CG_1BF39653E0AA099A8515E223 : IF_IF_PHY_013 connect p_X000.p_X100.p_X120.p_X124.rp_4d5eafc70549d9c0 to p_X000.p_X100.p_X120.p_X121.rp_387cdae1b4483182 {
            attribute connectionId : String = "CG-1BF39653E0AA099A8515E223";
            attribute connectionType : String = "TAP";
            attribute originalPath : String = "X124::PORT::X124::超级电容热能感知端口::ITM-PHY-013::双向物理 -> X121::PORT::X121::热能_热流端口::ITM-PHY-013::双向物理";
        }
        interface c_CG_1C5FC46A1E7682144A3BDDDF : IF_IF_MEA_005 connect p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_5576b5e0dbb912ba to p_N_8000.p_N_8100.p_N_8160.p_N_8166.rp_573e029523ef9946 {
            attribute connectionId : String = "CG-1C5FC46A1E7682144A3BDDDF";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4238::PORT::4238::高压线路电压输出::ITM-MEA-005::输出 -> 8166::PORT::8166::高压线路电压输入::ITM-MEA-005::输入";
        }
        interface c_CG_1D4D143F52B7F4D880B3CB30 : IF_IF_CMD_019 connect p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_abc190a288d4c9d5 to p_N_7000.p_N_7200.p_N_7220.p_N_7227.rp_f645a5b55a3683c6 {
            attribute connectionId : String = "CG-1D4D143F52B7F4D880B3CB30";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "7211::PORT::7211::制动缓解指令输出::ITM-CMD-019::输出 -> 7227::PORT::7227::制动缓解指令输入::ITM-CMD-019::输入";
        }
        interface c_CG_1D8165FC25AEFF761DD29797 : IF_IF_CMD_004 connect p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_a9c7eff84933cd80 to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_361e7dc74e9287e3 {
            attribute connectionId : String = "CG-1D8165FC25AEFF761DD29797";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8121::PORT::8121::紧急制动请求输出::ITM-CMD-004::输出 -> 8122::PORT::8122::紧急制动请求输入::ITM-CMD-004::输入";
        }
        interface c_CG_20C0A22ECCF07864FDBA3F5A : IF_IF_MEA_006 connect p_N_4000.p_N_4200.p_N_4230.p_N_4236.rp_9107465175683792 to p_N_5000.p_N_5100.p_N_5110.p_N_5111.rp_651700e69b7dccba {
            attribute connectionId : String = "CG-20C0A22ECCF07864FDBA3F5A";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4236::PORT::4236::高压线路电流输出::ITM-MEA-006::输出 -> 5111::PORT::5111::高压线路电流输入::ITM-MEA-006::输入";
        }
        interface c_CG_2274BA128E639FDE4D4F56EC : IF_IF_STA_016 connect p_N_4000.p_N_4500.p_N_4510.p_N_4517.rp_b93b1716e8b4e844 to p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_11b7e7965ec2e386 {
            attribute connectionId : String = "CG-2274BA128E639FDE4D4F56EC";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4517::PORT::4517::高压系统故障状态输出::ITM-STA-016::输出 -> 4238::PORT::4238::高压系统故障状态输入::ITM-STA-016::输入";
        }
        interface c_CG_25DC22E45A984D1CB28D188B : IF_IF_CMD_026 connect p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_a4aac084c46e1e57 to p_X000.p_X100.p_X110.p_X112.rp_1164249ec859b807 {
            attribute connectionId : String = "CG-25DC22E45A984D1CB28D188B";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8122::PORT::8122::双向DC_DC使能输出::ITM-CMD-026::输出 -> X112::PORT::X112::双向DC_DC使能输入::ITM-CMD-026::输入";
        }
        interface c_CG_2B17DCC398F786E916C9C8DC : IF_IF_CMD_022 connect p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_c4074d88ed5949ec to p_N_7000.p_N_7200.p_N_7220.p_N_7225.rp_8e705d6c34197ff6 {
            attribute connectionId : String = "CG-2B17DCC398F786E916C9C8DC";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "7211::PORT::7211::制动电磁阀指令输出::ITM-CMD-022::输出 -> 7225::PORT::7225::制动电磁阀指令输入::ITM-CMD-022::输入";
        }
        interface c_CG_2C24BA16EF5F2F7E99733CD6 : IF_IF_PHY_013 connect p_N_4000.p_N_4400.p_N_4410.p_N_4412.rp_b031f017471c85ee to boundary_BOUNDARY_THERMAL_ENVIRONMENT.bp_2ac3a221090b246a {
            attribute connectionId : String = "CG-2C24BA16EF5F2F7E99733CD6";
            attribute connectionType : String = "BOUNDARY";
            attribute originalPath : String = "4412::PORT::4412::热能_热流端口::ITM-PHY-013::双向物理 -> BOUNDARY-THERMAL-ENVIRONMENT::BPORT::BOUNDARY-THERMAL-ENVIRONMENT::ITM-PHY-013";
        }
        interface c_CG_2C4335E39D698D9A34096F73 : IF_IF_CMD_009 connect p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_f4c8eaaf49d11d3d to p_N_8000.p_N_8100.p_N_8150.p_N_8154.rp_c3d327abebd9ecfd {
            attribute connectionId : String = "CG-2C4335E39D698D9A34096F73";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8121::PORT::8121::牵引使能指令输出::ITM-CMD-009::输出 -> 8154::PORT::8154::牵引使能指令输入::ITM-CMD-009::输入";
        }
        interface c_CG_2CE5C7F366544DF5F5AB234B : IF_IF_STA_025 connect p_N_8000.p_N_8100.p_N_8150.p_N_8152.rp_ae53feffb1e116e3 to p_N_8000.p_N_8100.p_N_8120.p_N_8128.rp_eea6ab94a057e9f5 {
            attribute connectionId : String = "CG-2CE5C7F366544DF5F5AB234B";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8152::PORT::8152::制动安全回路状态输出::ITM-STA-025::输出 -> 8128::PORT::8128::制动安全回路状态输入::ITM-STA-025::输入";
        }
        interface c_CG_2E8F3CC8A8EBCDE6B7CF4D27 : IF_IF_CMD_002 connect p_D000.p_D100.p_D110.p_D113.rp_9ca0d9d396f8ffd0 to p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_a49a67fafe112278 {
            attribute connectionId : String = "CG-2E8F3CC8A8EBCDE6B7CF4D27";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "D113::PORT::D113::牵引指令输出::ITM-CMD-002::输出 -> 8121::PORT::8121::牵引指令输入::ITM-CMD-002::输入";
        }
        interface c_CG_2EE117B4B0633E38D394B904 : IF_IF_CMD_018 connect p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_9744a4b3a255a6e8 to p_N_4000.p_N_4100.p_N_4110.p_N_411C.rp_201c13a158f19a88 {
            attribute connectionId : String = "CG-2EE117B4B0633E38D394B904";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4238::PORT::4238::受电弓控制指令输出::ITM-CMD-018::输出 -> 411C::PORT::411C::受电弓控制指令输入::ITM-CMD-018::输入";
        }
        interface c_CG_3352802713B03806EB2934A1 : IF_IF_STA_025 connect p_N_8000.p_N_8100.p_N_8120.p_N_8128.rp_9f2f985b6764bfa7 to p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_36991cec1f7be17b {
            attribute connectionId : String = "CG-3352802713B03806EB2934A1";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8128::PORT::8128::制动安全回路状态输出::ITM-STA-025::输出 -> 8121::PORT::8121::制动安全回路状态输入::ITM-STA-025::输入";
        }
        interface c_CG_338D68ABEF709ACD5E0DDCC6 : IF_IF_PHY_005 connect p_N_5000.p_N_5300.p_N_5310.p_N_5311.rp_97eb613c06ae1b2e to p_N_3000.p_N_3500.p_N_3510.p_N_3511.rp_aa7691c6f81e4771 {
            attribute connectionId : String = "CG-338D68ABEF709ACD5E0DDCC6";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "5311::PORT::5311::旋转机械能端口::ITM-PHY-005::双向物理 -> 3511::PORT::3511::第一连接面旋转机械能端口::ITM-PHY-005::双向物理";
        }
        interface c_CG_3632726B793CD5429112CAD4 : IF_IF_PHY_001 connect p_N_4000.p_N_4200.p_N_4210.p_N_4211.rp_ee92cd728b152a90 to p_N_4000.p_N_4200.p_N_4210.p_N_4212.rp_4b65d610848833a3 {
            attribute connectionId : String = "CG-3632726B793CD5429112CAD4";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "4211::PORT::4211::出线侧高压交流电能端口::ITM-PHY-001::双向物理 -> 4212::PORT::4212::进线侧高压交流电能端口::ITM-PHY-001::双向物理";
        }
        interface c_CG_37792F42F4274C7C51C63270 : IF_IF_STA_013 connect p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_0674d2b80a6a72da to p_N_4000.p_N_4500.p_N_4510.p_N_4518.rp_67eef246e016ac82 {
            attribute connectionId : String = "CG-37792F42F4274C7C51C63270";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4238::PORT::4238::高压断路器状态输出::ITM-STA-013::输出 -> 4518::PORT::4518::高压断路器状态输入::ITM-STA-013::输入";
        }
        interface c_CG_37ECA5B04E215AC3E6A4B472 : IF_IF_MEA_011 connect p_N_5000.p_N_5300.p_N_5310.p_N_5311.rp_537e9856bafa2a02 to p_N_5000.p_N_5100.p_N_5110.p_N_5112.rp_21e86fb073b61523 {
            attribute connectionId : String = "CG-37ECA5B04E215AC3E6A4B472";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5311::PORT::5311::电机侧相电压输出::ITM-MEA-011::输出 -> 5112::PORT::5112::电机侧相电压输入::ITM-MEA-011::输入";
        }
        interface c_CG_3981A8B947B66F597AA9E03F : IF_IF_CMD_020 connect p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_a882b33038ce4623 to p_N_7000.p_N_7200.p_N_7280.p_N_7285.rp_c016d56a46e739fc {
            attribute connectionId : String = "CG-3981A8B947B66F597AA9E03F";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "7211::PORT::7211::制动隔离指令输出::ITM-CMD-020::输出 -> 7285::PORT::7285::制动隔离指令输入::ITM-CMD-020::输入";
        }
        interface c_CG_3BD24EBE88F37EEFFE563597 : IF_IF_PHY_004 connect p_N_5000.p_N_5100.p_N_5130.p_N_5132.rp_770f7e1c507cc073 to p_N_5000.p_N_5300.p_N_5310.p_N_5311.rp_57f3c317ac0c860d {
            attribute connectionId : String = "CG-3BD24EBE88F37EEFFE563597";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "5132::PORT::5132::三相交流电能端口::ITM-PHY-004::双向物理 -> 5311::PORT::5311::三相交流电能端口::ITM-PHY-004::双向物理";
        }
        interface c_CG_3BE61F5C037C7491E88F4334 : IF_IF_CMD_015 connect p_N_5000.p_N_5100.p_N_5140.p_N_5145.rp_e58f80e07056f3fb to p_N_5000.p_N_5100.p_N_5130.p_N_5133.rp_77ee52e55ac1ca4e {
            attribute connectionId : String = "CG-3BE61F5C037C7491E88F4334";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5145::PORT::5145::制动斩波器指令输出::ITM-CMD-015::输出 -> 5133::PORT::5133::制动斩波器指令输入::ITM-CMD-015::输入";
        }
        interface c_CG_3CA6C3BF7D7B4F80CF0990D0 : IF_IF_PHY_005 connect p_N_3000.p_N_3500.p_N_3510.p_N_3512.rp_c455741f6ca5a597 to p_N_3000.p_N_3100.p_N_3120.p_N_3121.rp_fdcd27ee9b0a936f {
            attribute connectionId : String = "CG-3CA6C3BF7D7B4F80CF0990D0";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "3512::PORT::3512::第二连接面旋转机械能端口::ITM-PHY-005::双向物理 -> 3121::PORT::3121::高速轴旋转机械能端口::ITM-PHY-005::双向物理";
        }
        interface c_CG_40ADD911FF2840BEEAA67F8D : IF_IF_ACC_002 connect p_N_5000.p_N_5100.p_N_5130.p_N_5132.rp_75d86c9dc39b94b8 to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_bd78e8d84d334672 {
            attribute connectionId : String = "CG-40ADD911FF2840BEEAA67F8D";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5132::PORT::5132::实际再生功率输出::ITM-ACC-002::输出 -> 8122::PORT::8122::实际再生功率输入::ITM-ACC-002::输入";
        }
        interface c_CG_4104726E8B8410405C176AF3 : IF_IF_CMD_017 connect p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_ed1efa73e618c52f to p_N_4000.p_N_4200.p_N_4210.p_N_4212.rp_a29d16c43fc8d044 {
            attribute connectionId : String = "CG-4104726E8B8410405C176AF3";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4238::PORT::4238::高压隔离开关指令输出::ITM-CMD-017::输出 -> 4212::PORT::4212::高压隔离开关指令输入::ITM-CMD-017::输入";
        }
        interface c_CG_410B8D702206200512DD3731 : IF_IF_CMD_003 connect p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_d82e5c8a7afb4b7b to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_898e3aba50ea7cb4 {
            attribute connectionId : String = "CG-410B8D702206200512DD3731";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8121::PORT::8121::服务制动请求输出::ITM-CMD-003::输出 -> 8122::PORT::8122::服务制动请求输入::ITM-CMD-003::输入";
        }
        interface c_CG_4163C3EB1F2D16B7AFCB21C9 : IF_IF_CMD_004 connect p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_a9c7eff84933cd80 to p_N_7000.p_N_7200.p_N_7220.p_N_7226.rp_5f6a9d81cebde2d3 {
            attribute connectionId : String = "CG-4163C3EB1F2D16B7AFCB21C9";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8121::PORT::8121::紧急制动请求输出::ITM-CMD-004::输出 -> 7226::PORT::7226::紧急制动请求输入::ITM-CMD-004::输入";
        }
        interface c_CG_41AD09EEB4EAB9DC956C08F8 : IF_IF_CMD_003 connect p_D000.p_D100.p_D110.p_D114.rp_d3d5739989ecf2dd to p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_0b58c63caeaf2f6d {
            attribute connectionId : String = "CG-41AD09EEB4EAB9DC956C08F8";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "D114::PORT::D114::服务制动请求输出::ITM-CMD-003::输出 -> 8121::PORT::8121::服务制动请求输入::ITM-CMD-003::输入";
        }
        interface c_CG_43EF4A944142319DE5088758 : IF_IF_MEA_006 connect p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_c7dcc306b020116f to p_N_4000.p_N_4200.p_N_4240.p_N_4241.rp_f81c0f4a108acec4 {
            attribute connectionId : String = "CG-43EF4A944142319DE5088758";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4238::PORT::4238::高压线路电流输出::ITM-MEA-006::输出 -> 4241::PORT::4241::高压线路电流输入::ITM-MEA-006::输入";
        }
        interface c_CG_44890BAD0E32A867EFFB7EBB : IF_IF_STA_026 connect p_N_8000.p_N_8100.p_N_8150.p_N_8154.rp_492d0ced994652db to p_N_8000.p_N_8100.p_N_8120.p_N_8128.rp_9819959a053f9c06 {
            attribute connectionId : String = "CG-44890BAD0E32A867EFFB7EBB";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8154::PORT::8154::牵引安全回路状态输出::ITM-STA-026::输出 -> 8128::PORT::8128::牵引安全回路状态输入::ITM-STA-026::输入";
        }
        interface c_CG_44E8AB4EA7ED953642770E4E : IF_IF_CMD_009 connect p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_f4c8eaaf49d11d3d to p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_0e01f3a589418f6c {
            attribute connectionId : String = "CG-44E8AB4EA7ED953642770E4E";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8121::PORT::8121::牵引使能指令输出::ITM-CMD-009::输出 -> 8125::PORT::8125::牵引使能指令输入::ITM-CMD-009::输入";
        }
        interface c_CG_464B2D6F08DDD0D4287D0294 : IF_IF_STA_026 connect p_N_8000.p_N_8100.p_N_8120.p_N_8128.rp_aad98cbe8fa3b27e to p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_90deb6e5a4e470f1 {
            attribute connectionId : String = "CG-464B2D6F08DDD0D4287D0294";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8128::PORT::8128::牵引安全回路状态输出::ITM-STA-026::输出 -> 8125::PORT::8125::牵引安全回路状态输入::ITM-STA-026::输入";
        }
        interface c_CG_46A1EE350324445D016EAF45 : IF_IF_MEA_004 connect p_N_5000.p_N_5300.p_N_5310.p_N_5311.rp_79c695a1342df24f to p_N_5000.p_N_5100.p_N_5110.p_N_5112.rp_780596fabcc73a0f {
            attribute connectionId : String = "CG-46A1EE350324445D016EAF45";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5311::PORT::5311::牵引电机转速输出::ITM-MEA-004::输出 -> 5112::PORT::5112::牵引电机转速输入::ITM-MEA-004::输入";
        }
        interface c_CG_48B77E7B4DEB11D4F5543CCB : IF_IF_PHY_011 connect p_N_4000.p_N_4400.p_N_4410.p_N_4413.rp_cb582bd13ed15889 to boundary_BOUNDARY_RAIL.bp_3a29560c03050dbe {
            attribute connectionId : String = "CG-48B77E7B4DEB11D4F5543CCB";
            attribute connectionType : String = "BOUNDARY";
            attribute originalPath : String = "4413::PORT::4413::固定端回流电流端口::ITM-PHY-011::双向物理 -> BOUNDARY-RAIL::BPORT::BOUNDARY-RAIL::ITM-PHY-011";
        }
        interface c_CG_4B59832BB120B07245DB82FA : IF_IF_PHY_005 connect p_N_3000.p_N_3500.p_N_3510.p_N_3511.rp_813a305545723d57 to p_N_3000.p_N_3500.p_N_3510.p_N_3514.rp_b12dc4cc17618821 {
            attribute connectionId : String = "CG-4B59832BB120B07245DB82FA";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "3511::PORT::3511::第二连接面旋转机械能端口::ITM-PHY-005::双向物理 -> 3514::PORT::3514::第一轴端旋转机械能端口::ITM-PHY-005::双向物理";
        }
        interface c_CG_4CB0735167799FD438F90DD2 : IF_IF_PHY_005 connect p_N_3000.p_N_3600.p_N_3640.p_N_3643.rp_48ddc723a7d58137 to p_N_3000.p_N_3100.p_N_3120.p_N_3121.rp_6464b6253314b208 {
            attribute connectionId : String = "CG-4CB0735167799FD438F90DD2";
            attribute connectionType : String = "TAP";
            attribute originalPath : String = "3643::PORT::3643::旋转机械能端口::ITM-PHY-005::双向物理 -> 3121::PORT::3121::低速轴旋转机械能端口::ITM-PHY-005::双向物理";
        }
        interface c_CG_4DBAA813D3DED180F94E9B7F : IF_IF_PHY_014 connect p_N_5000.p_N_5100.p_N_5120.p_N_5121.rp_9dedfe88c8a34261 to p_N_5000.p_N_5100.p_N_5130.p_N_5131.rp_32d77ca0c1d88b50 {
            attribute connectionId : String = "CG-4DBAA813D3DED180F94E9B7F";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "5121::PORT::5121::牵引变压器次级交流电能端口::ITM-PHY-014::双向物理 -> 5131::PORT::5131::牵引变压器次级交流电能端口::ITM-PHY-014::双向物理";
        }
        interface c_CG_4E4C49F08CEE642A5C3C67EB : IF_IF_MEA_009 connect p_N_5000.p_N_5100.p_N_5140.p_N_5145.rp_a9cc4822e30a5ede to p_N_8000.p_N_8100.p_N_8160.p_N_8166.rp_3b0068559b0ca1e4 {
            attribute connectionId : String = "CG-4E4C49F08CEE642A5C3C67EB";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5145::PORT::5145::中间直流母线电流输出::ITM-MEA-009::输出 -> 8166::PORT::8166::中间直流母线电流输入::ITM-MEA-009::输入";
        }
        interface c_CG_50AB5ECD4830D34487B7B557 : IF_IF_CMD_008 connect p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_c49f12594ff56025 to p_N_8000.p_N_8100.p_N_8150.p_N_8154.rp_a8fff2340df81262 {
            attribute connectionId : String = "CG-50AB5ECD4830D34487B7B557";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8121::PORT::8121::牵引切除请求输出::ITM-CMD-008::输出 -> 8154::PORT::8154::牵引切除请求输入::ITM-CMD-008::输入";
        }
        interface c_CG_51C22959FEAD177C3827B364 : IF_IF_PHY_001 connect p_N_4000.p_N_4200.p_N_4230.p_N_4235.rp_3e2b71c6b8d79136 to p_N_4000.p_N_4200.p_N_4210.p_N_4212.rp_e1689d643b97d378 {
            attribute connectionId : String = "CG-51C22959FEAD177C3827B364";
            attribute connectionType : String = "TAP";
            attribute originalPath : String = "4235::PORT::4235::高压交流电能端口::ITM-PHY-001::双向物理 -> 4212::PORT::4212::出线侧高压交流电能端口::ITM-PHY-001::双向物理";
        }
        interface c_CG_53ADA5E90929843D3AD53312 : IF_IF_CMD_024 connect p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_f0886e48bf75472f to p_N_8000.p_N_8100.p_N_8120.p_N_8128.rp_26589bfc82ed6979 {
            attribute connectionId : String = "CG-53ADA5E90929843D3AD53312";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8122::PORT::8122::撒砂请求输出::ITM-CMD-024::输出 -> 8128::PORT::8128::撒砂请求输入::ITM-CMD-024::输入";
        }
        interface c_CG_55513667B46680F5B87A0939 : IF_IF_STA_019 connect p_N_5000.p_N_5100.p_N_5110.p_N_5113.rp_d93ff3dea2be11bd to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_81e596aab3f0fe4c {
            attribute connectionId : String = "CG-55513667B46680F5B87A0939";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5113::PORT::5113::牵引变流器故障状态输出::ITM-STA-019::输出 -> 8122::PORT::8122::牵引变流器故障状态输入::ITM-STA-019::输入";
        }
        interface c_CG_565AF053FC6E3FF333FD7433 : IF_IF_CMD_024 connect p_N_8000.p_N_8100.p_N_8120.p_N_8128.rp_5accd69f9c3a8b0c to p_N_3000.p_N_3800.p_N_3810.p_N_3811.rp_81d4e1a7092e0653 {
            attribute connectionId : String = "CG-565AF053FC6E3FF333FD7433";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8128::PORT::8128::撒砂请求输出::ITM-CMD-024::输出 -> 3811::PORT::3811::撒砂请求输入::ITM-CMD-024::输入";
        }
        interface c_CG_56E4DA6D8C7C1FCFA93A8C7B : IF_IF_CMD_023 connect p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_91854864e6254d28 to p_N_7000.p_N_7200.p_N_7220.p_N_722A.rp_afe779aaa3b0be62 {
            attribute connectionId : String = "CG-56E4DA6D8C7C1FCFA93A8C7B";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "7211::PORT::7211::防滑干预指令输出::ITM-CMD-023::输出 -> 722A::PORT::722A::防滑干预指令输入::ITM-CMD-023::输入";
        }
        interface c_CG_57C4C380DFA4E14C0890F4FC : IF_IF_MEA_008 connect p_N_5000.p_N_5100.p_N_5140.p_N_5145.rp_1680714c67f7d311 to p_N_5000.p_N_5100.p_N_5110.p_N_5111.rp_a9ddcab662f35564 {
            attribute connectionId : String = "CG-57C4C380DFA4E14C0890F4FC";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5145::PORT::5145::中间直流母线电压输出::ITM-MEA-008::输出 -> 5111::PORT::5111::中间直流母线电压输入::ITM-MEA-008::输入";
        }
        interface c_CG_585503C9572B9BF371266D8B : IF_IF_PHY_013 connect p_X000.p_X100.p_X120.p_X121.rp_387cdae1b4483182 to boundary_BOUNDARY_THERMAL_ENVIRONMENT.bp_2ac3a221090b246a {
            attribute connectionId : String = "CG-585503C9572B9BF371266D8B";
            attribute connectionType : String = "BOUNDARY";
            attribute originalPath : String = "X121::PORT::X121::热能_热流端口::ITM-PHY-013::双向物理 -> BOUNDARY-THERMAL-ENVIRONMENT::BPORT::BOUNDARY-THERMAL-ENVIRONMENT::ITM-PHY-013";
        }
        interface c_CG_5CC6DABFA52A640C8BC115E5 : IF_IF_PHY_005 connect p_N_3000.p_N_3500.p_N_3510.p_N_3514.rp_4569aa8f56963dc6 to p_N_3000.p_N_3500.p_N_3510.p_N_3512.rp_970ef7da9f850ce1 {
            attribute connectionId : String = "CG-5CC6DABFA52A640C8BC115E5";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "3514::PORT::3514::第二轴端旋转机械能端口::ITM-PHY-005::双向物理 -> 3512::PORT::3512::第一连接面旋转机械能端口::ITM-PHY-005::双向物理";
        }
        interface c_CG_5E309780F220E97DE29B2A38 : IF_IF_STA_009 connect p_N_7000.p_N_7200.p_N_7220.p_N_722C.rp_6f3dd380decaae91 to p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_19f11c6ee3cbf055 {
            attribute connectionId : String = "CG-5E309780F220E97DE29B2A38";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "722C::PORT::722C::低风压状态输出::ITM-STA-009::输出 -> 7211::PORT::7211::低风压状态输入::ITM-STA-009::输入";
        }
        interface c_CG_61CA88D0219D5B46EEFA0E92 : IF_IF_CMD_026 connect p_X000.p_X100.p_X110.p_X112.rp_f980a38f780089b6 to p_X000.p_X100.p_X110.p_X111.rp_6085b3266f1baf9d {
            attribute connectionId : String = "CG-61CA88D0219D5B46EEFA0E92";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X112::PORT::X112::双向DC_DC使能输出::ITM-CMD-026::输出 -> X111::PORT::X111::双向DC_DC使能输入::ITM-CMD-026::输入";
        }
        interface c_CG_62B37C74D7B0F1346E00D437 : IF_IF_CMD_011 connect p_N_5000.p_N_5100.p_N_5110.p_N_5112.rp_c98f6aa887541378 to p_N_5000.p_N_5100.p_N_5130.p_N_5132.rp_406d292901368d53 {
            attribute connectionId : String = "CG-62B37C74D7B0F1346E00D437";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5112::PORT::5112::电机侧变流控制指令输出::ITM-CMD-011::输出 -> 5132::PORT::5132::电机侧变流控制指令输入::ITM-CMD-011::输入";
        }
        interface c_CG_6546CFCB7800C785459AC8E1 : IF_IF_STA_026 connect p_N_8000.p_N_8100.p_N_8120.p_N_8128.rp_aad98cbe8fa3b27e to p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_de2d35d2bcb08b0b {
            attribute connectionId : String = "CG-6546CFCB7800C785459AC8E1";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8128::PORT::8128::牵引安全回路状态输出::ITM-STA-026::输出 -> 8121::PORT::8121::牵引安全回路状态输入::ITM-STA-026::输入";
        }
        interface c_CG_65E377DBF988541FA5778D1E : IF_IF_MEA_012 connect p_N_5000.p_N_5300.p_N_5310.p_N_5311.rp_10bb4c4f0063bc18 to p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_1faca3fc4ff0e741 {
            attribute connectionId : String = "CG-65E377DBF988541FA5778D1E";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5311::PORT::5311::牵引电机实际转矩输出::ITM-MEA-012::输出 -> 8125::PORT::8125::牵引电机实际转矩输入::ITM-MEA-012::输入";
        }
        interface c_CG_663CDC611495882DCD3E5B8F : IF_IF_CMD_004 connect p_D000.p_D100.p_D120.p_D121.rp_d32b32814a84a88a to p_N_8000.p_N_8100.p_N_8150.p_N_8152.rp_93024c6ed1623fbd {
            attribute connectionId : String = "CG-663CDC611495882DCD3E5B8F";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "D121::PORT::D121::紧急制动请求输出::ITM-CMD-004::输出 -> 8152::PORT::8152::紧急制动请求输入::ITM-CMD-004::输入";
        }
        interface c_CG_676A4A51307B0199D39544B7 : IF_IF_CMD_017 connect p_N_4000.p_N_4200.p_N_4230.p_N_4239.rp_e30c550b4d4e8d52 to p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_f6362be8ea9a501f {
            attribute connectionId : String = "CG-676A4A51307B0199D39544B7";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4239::PORT::4239::高压隔离开关指令输出::ITM-CMD-017::输出 -> 4238::PORT::4238::高压隔离开关指令输入::ITM-CMD-017::输入";
        }
        interface c_CG_686A357580FCAB93907E7B31 : IF_IF_PHY_007 connect p_N_7000.p_N_7200.p_N_7250.p_N_7252.rp_b403e112a25e1c53 to p_N_7000.p_N_7200.p_N_7250.p_N_7254.rp_d9511ef0fa1c17df {
            attribute connectionId : String = "CG-686A357580FCAB93907E7B31";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "7252::PORT::7252::摩擦制动机械作用端口::ITM-PHY-007::双向物理 -> 7254::PORT::7254::摩擦制动机械作用端口::ITM-PHY-007::双向物理";
        }
        interface c_CG_686E1C0741D80B3DE2EEBA80 : IF_IF_MEA_008 connect p_X000.p_X100.p_X110.p_X113.rp_0e45c7ab357a42e6 to p_X000.p_X100.p_X110.p_X112.rp_89849c49127b2dfb {
            attribute connectionId : String = "CG-686E1C0741D80B3DE2EEBA80";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X113::PORT::X113::中间直流母线电压输出::ITM-MEA-008::输出 -> X112::PORT::X112::中间直流母线电压输入::ITM-MEA-008::输入";
        }
        interface c_CG_697084EEC1DCA9E975638C14 : IF_IF_CMD_030 connect p_N_8000.p_N_8100.p_N_8120.p_N_8127.rp_8f3091a86214dd4e to p_N_8000.p_N_8100.p_N_8150.p_N_8152.rp_1e4f882572b04df5 {
            attribute connectionId : String = "CG-697084EEC1DCA9E975638C14";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8127::PORT::8127::安全停车_制动请求输出::ITM-CMD-030::输出 -> 8152::PORT::8152::安全停车_制动请求输入::ITM-CMD-030::输入";
        }
        interface c_CG_6C6B569AD3F71A70A799D067 : IF_IF_MEA_005 connect p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_5576b5e0dbb912ba to p_N_4000.p_N_4200.p_N_4230.p_N_4239.rp_2802b0f2f54a548a {
            attribute connectionId : String = "CG-6C6B569AD3F71A70A799D067";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4238::PORT::4238::高压线路电压输出::ITM-MEA-005::输出 -> 4239::PORT::4239::高压线路电压输入::ITM-MEA-005::输入";
        }
        interface c_CG_70D940D7F34BF27762FED746 : IF_IF_STA_024 connect p_N_8000.p_N_8100.p_N_8150.p_N_8151.rp_c6902e30a0122c0e to p_N_8000.p_N_8100.p_N_8120.p_N_8128.rp_2b9604597ff0c9ac {
            attribute connectionId : String = "CG-70D940D7F34BF27762FED746";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8151::PORT::8151::高压安全回路状态输出::ITM-STA-024::输出 -> 8128::PORT::8128::高压安全回路状态输入::ITM-STA-024::输入";
        }
        interface c_CG_732BB9F5922B7AC9420BB2D0 : IF_IF_MEA_008 connect p_N_5000.p_N_5100.p_N_5140.p_N_5145.rp_1680714c67f7d311 to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_361eac651ec9fd05 {
            attribute connectionId : String = "CG-732BB9F5922B7AC9420BB2D0";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5145::PORT::5145::中间直流母线电压输出::ITM-MEA-008::输出 -> 8122::PORT::8122::中间直流母线电压输入::ITM-MEA-008::输入";
        }
        interface c_CG_734E10C63B7A36C2BB06360D : IF_IF_STA_033 connect p_X000.p_X100.p_X130.p_X132.rp_53191daa39f85d49 to p_X000.p_X100.p_X110.p_X112.rp_3ecd9966c9972a7e {
            attribute connectionId : String = "CG-734E10C63B7A36C2BB06360D";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X132::PORT::X132::储能预充电状态输出::ITM-STA-033::输出 -> X112::PORT::X112::储能预充电状态输入::ITM-STA-033::输入";
        }
        interface c_CG_7365C853DD9391D9914E0C8A : IF_IF_CMD_012 connect p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_70a8e2c4b0887b4d to p_N_5000.p_N_5100.p_N_5110.p_N_5112.rp_6ce5fb5c81d47ab4 {
            attribute connectionId : String = "CG-7365C853DD9391D9914E0C8A";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8125::PORT::8125::牵引电机转矩请求输出::ITM-CMD-012::输出 -> 5112::PORT::5112::牵引电机转矩请求输入::ITM-CMD-012::输入";
        }
        interface c_CG_739E53DD845C8CD2646C8E39 : IF_IF_MEA_014 connect p_N_7000.p_N_7100.p_N_7140.p_N_7142.rp_52f3b82b80918b84 to p_N_8000.p_N_8100.p_N_8120.p_N_8128.rp_ccc90acd04ba0ccc {
            attribute connectionId : String = "CG-739E53DD845C8CD2646C8E39";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "7142::PORT::7142::总风管压力输出::ITM-MEA-014::输出 -> 8128::PORT::8128::总风管压力输入::ITM-MEA-014::输入";
        }
        interface c_CG_76271B14A422D23C0C6E327D : IF_IF_PHY_013 connect p_N_4000.p_N_4400.p_N_4410.p_N_4411.rp_c61d1b462f69be85 to boundary_BOUNDARY_THERMAL_ENVIRONMENT.bp_2ac3a221090b246a {
            attribute connectionId : String = "CG-76271B14A422D23C0C6E327D";
            attribute connectionType : String = "BOUNDARY";
            attribute originalPath : String = "4411::PORT::4411::热能_热流端口::ITM-PHY-013::双向物理 -> BOUNDARY-THERMAL-ENVIRONMENT::BPORT::BOUNDARY-THERMAL-ENVIRONMENT::ITM-PHY-013";
        }
        interface c_CG_7664DA49869213FC03120E3B : IF_IF_MEA_013 connect p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_36a59f5828d4c515 to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_f36629c6f163833f {
            attribute connectionId : String = "CG-7664DA49869213FC03120E3B";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8125::PORT::8125::实际动态制动力输出::ITM-MEA-013::输出 -> 8122::PORT::8122::实际动态制动力输入::ITM-MEA-013::输入";
        }
        interface c_CG_767F79CB763B96968C94D7AD : IF_IF_CMD_001 connect p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_8fbe2a98ba0ac28c to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_ac60006ecd824aae {
            attribute connectionId : String = "CG-767F79CB763B96968C94D7AD";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8121::PORT::8121::列车方向指令输出::ITM-CMD-001::输出 -> 8122::PORT::8122::列车方向指令输入::ITM-CMD-001::输入";
        }
        interface c_CG_79EB6BEB9B0AE9B2B06844A4 : IF_IF_CMD_027 connect p_X000.p_X100.p_X110.p_X112.rp_2ea4241545e6ca09 to p_X000.p_X100.p_X130.p_X131.rp_b06975e1baff62be {
            attribute connectionId : String = "CG-79EB6BEB9B0AE9B2B06844A4";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X112::PORT::X112::储能主接触器指令输出::ITM-CMD-027::输出 -> X131::PORT::X131::储能主接触器指令输入::ITM-CMD-027::输入";
        }
        interface c_CG_7A2381DC8C36A40B747035A5 : IF_IF_CMD_025 connect p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_77c439392dea95b4 to p_X000.p_X100.p_X110.p_X112.rp_843fa8c83311440e {
            attribute connectionId : String = "CG-7A2381DC8C36A40B747035A5";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8122::PORT::8122::储能功率请求输出::ITM-CMD-025::输出 -> X112::PORT::X112::储能功率请求输入::ITM-CMD-025::输入";
        }
        interface c_CG_7AAA105058D4FD893E634E16 : IF_IF_STA_004 connect p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_77f0053899ab19da to p_N_7000.p_N_7200.p_N_7280.p_N_7281.rp_b9ead4720ad37cb5 {
            attribute connectionId : String = "CG-7AAA105058D4FD893E634E16";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "7211::PORT::7211::制动施加状态输出::ITM-STA-004::输出 -> 7281::PORT::7281::制动施加状态输入::ITM-STA-004::输入";
        }
        interface c_CG_7AEA5BA2801064550BBE6D02 : IF_IF_CMD_002 connect p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_809f8275c004ab18 to p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_713c697d47d94da9 {
            attribute connectionId : String = "CG-7AEA5BA2801064550BBE6D02";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8121::PORT::8121::牵引指令输出::ITM-CMD-002::输出 -> 8125::PORT::8125::牵引指令输入::ITM-CMD-002::输入";
        }
        interface c_CG_7CA35F612B7EF59664CE06F0 : IF_IF_PHY_013 connect p_N_3000.p_N_3100.p_N_3130.p_N_3132.rp_6069e8d0fbf298c5 to boundary_BOUNDARY_THERMAL_ENVIRONMENT.bp_2ac3a221090b246a {
            attribute connectionId : String = "CG-7CA35F612B7EF59664CE06F0";
            attribute connectionType : String = "BOUNDARY";
            attribute originalPath : String = "3132::PORT::3132::热能_热流端口::ITM-PHY-013::双向物理 -> BOUNDARY-THERMAL-ENVIRONMENT::BPORT::BOUNDARY-THERMAL-ENVIRONMENT::ITM-PHY-013";
        }
        interface c_CG_7D415C2FE2A98E99E69F2808 : IF_IF_PHY_007 connect p_N_7000.p_N_7200.p_N_7250.p_N_7255.rp_4c45e349056154be to p_N_7000.p_N_7200.p_N_7250.p_N_7252.rp_b403e112a25e1c53 {
            attribute connectionId : String = "CG-7D415C2FE2A98E99E69F2808";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "7255::PORT::7255::摩擦制动机械作用端口::ITM-PHY-007::双向物理 -> 7252::PORT::7252::摩擦制动机械作用端口::ITM-PHY-007::双向物理";
        }
        interface c_CG_86987C60BCB826208FEFEF31 : IF_IF_CMD_030 connect p_E000.p_E100.rp_7273a171b473f816 to p_N_8000.p_N_8100.p_N_8120.p_N_8127.rp_be0fc7194a7f0161 {
            attribute connectionId : String = "CG-86987C60BCB826208FEFEF31";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "E100::PORT::E100::安全停车_制动请求输出::ITM-CMD-030::输出 -> 8127::PORT::8127::安全停车_制动请求输入::ITM-CMD-030::输入";
        }
        interface c_CG_86C48EA2DE057325EEB9853C : IF_IF_MEA_026 connect p_X000.p_X100.p_X120.p_X123.rp_9b6812b4ca482c66 to p_X000.p_X100.p_X110.p_X112.rp_e8341f592e73af5e {
            attribute connectionId : String = "CG-86C48EA2DE057325EEB9853C";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X123::PORT::X123::超级电容电流输出::ITM-MEA-026::输出 -> X112::PORT::X112::超级电容电流输入::ITM-MEA-026::输入";
        }
        interface c_CG_89318B491DF9CED18997C36D : IF_IF_STA_027 connect p_E000.p_E100.rp_0307dc18d9537f9d to p_N_8000.p_N_8100.p_N_8120.p_N_8128.rp_ce6397cb7b81dd94 {
            attribute connectionId : String = "CG-89318B491DF9CED18997C36D";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "E100::PORT::E100::ATP_外部安全系统状态输出::ITM-STA-027::输出 -> 8128::PORT::8128::ATP_外部安全系统状态输入::ITM-STA-027::输入";
        }
        interface c_CG_89DF67BFD358C3EEF4DB05F2 : IF_IF_MEA_004 connect p_N_3000.p_N_3600.p_N_3640.p_N_3644.rp_08c271db56ce8427 to p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_4e582bfad9ebbf1d {
            attribute connectionId : String = "CG-89DF67BFD358C3EEF4DB05F2";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "3644::PORT::3644::牵引电机转速输出::ITM-MEA-004::输出 -> 8125::PORT::8125::牵引电机转速输入::ITM-MEA-004::输入";
        }
        interface c_CG_8E2E18108BE2E7B2FB898537 : IF_IF_STA_015 connect p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_86fe03530d5b3c05 to p_N_4000.p_N_4200.p_N_4230.p_N_4239.rp_f3be8ead57323593 {
            attribute connectionId : String = "CG-8E2E18108BE2E7B2FB898537";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4238::PORT::4238::受电弓状态输出::ITM-STA-015::输出 -> 4239::PORT::4239::受电弓状态输入::ITM-STA-015::输入";
        }
        interface c_CG_8EE395387745CC0A6FB55207 : IF_IF_MEA_005 connect p_N_4000.p_N_4200.p_N_4230.p_N_4235.rp_6fea4b377f978aac to p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_c88ddcdfe3b55c9e {
            attribute connectionId : String = "CG-8EE395387745CC0A6FB55207";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4235::PORT::4235::高压线路电压输出::ITM-MEA-005::输出 -> 4238::PORT::4238::高压线路电压输入::ITM-MEA-005::输入";
        }
        interface c_CG_8EED0159D22D9EDC70A9EA67 : IF_IF_CMD_004 connect p_D000.p_D100.p_D120.p_D121.rp_d32b32814a84a88a to p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_1e34bb2697325127 {
            attribute connectionId : String = "CG-8EED0159D22D9EDC70A9EA67";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "D121::PORT::D121::紧急制动请求输出::ITM-CMD-004::输出 -> 8121::PORT::8121::紧急制动请求输入::ITM-CMD-004::输入";
        }
        interface c_CG_8F81398231970DBDB0A7F854 : IF_IF_STA_015 connect p_N_4000.p_N_4100.p_N_4110.p_N_411C.rp_72d2eed2608e1b56 to p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_d9d25dfbac32d1e3 {
            attribute connectionId : String = "CG-8F81398231970DBDB0A7F854";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "411C::PORT::411C::受电弓状态输出::ITM-STA-015::输出 -> 4238::PORT::4238::受电弓状态输入::ITM-STA-015::输入";
        }
        interface c_CG_91B4F6F81C7185E848BAF73E : IF_IF_PHY_013 connect p_N_3000.p_N_3100.p_N_3130.p_N_3133.rp_24fa6cb520a8e2e2 to boundary_BOUNDARY_THERMAL_ENVIRONMENT.bp_2ac3a221090b246a {
            attribute connectionId : String = "CG-91B4F6F81C7185E848BAF73E";
            attribute connectionType : String = "BOUNDARY";
            attribute originalPath : String = "3133::PORT::3133::热能_热流端口::ITM-PHY-013::双向物理 -> BOUNDARY-THERMAL-ENVIRONMENT::BPORT::BOUNDARY-THERMAL-ENVIRONMENT::ITM-PHY-013";
        }
        interface c_CG_943AD35B9C94E8B079F6212A : IF_IF_CMD_032 connect p_N_3000.p_N_3800.p_N_3810.p_N_3811.rp_3a8ce42fcde5acd8 to p_N_3000.p_N_3800.p_N_3810.p_N_3813.rp_d951497aaa9989f0 {
            attribute connectionId : String = "CG-943AD35B9C94E8B079F6212A";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "3811::PORT::3811::撒砂执行指令输出::ITM-CMD-032::输出 -> 3813::PORT::3813::撒砂执行指令输入::ITM-CMD-032::输入";
        }
        interface c_CG_944069F2CBBFA2A01274A9DB : IF_IF_STA_003 connect p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_c021f63639408eff to p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_1c14ea3cdc439198 {
            attribute connectionId : String = "CG-944069F2CBBFA2A01274A9DB";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "7211::PORT::7211::制动系统可用状态输出::ITM-STA-003::输出 -> 8121::PORT::8121::制动系统可用状态输入::ITM-STA-003::输入";
        }
        interface c_CG_9465AAC3F0B0B115DC3EF9FD : IF_IF_MEA_028 connect p_X000.p_X100.p_X120.p_X121.rp_b6cf5a49ced52abf to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_6437aa0577c9ccd7 {
            attribute connectionId : String = "CG-9465AAC3F0B0B115DC3EF9FD";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X121::PORT::X121::超级电容SOC输出::ITM-MEA-028::输出 -> 8122::PORT::8122::超级电容SOC输入::ITM-MEA-028::输入";
        }
        interface c_CG_9731BEC15024660A6C266D47 : IF_IF_MEA_008 connect p_N_5000.p_N_5100.p_N_5140.p_N_5145.rp_1680714c67f7d311 to p_N_5000.p_N_5100.p_N_5130.p_N_5133.rp_60d9996fadd55bff {
            attribute connectionId : String = "CG-9731BEC15024660A6C266D47";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5145::PORT::5145::中间直流母线电压输出::ITM-MEA-008::输出 -> 5133::PORT::5133::中间直流母线电压输入::ITM-MEA-008::输入";
        }
        interface c_CG_979C19823B520B68E370ECB6 : IF_IF_CMD_003 connect p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_d82e5c8a7afb4b7b to p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_77afbfa330bfb95e {
            attribute connectionId : String = "CG-979C19823B520B68E370ECB6";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8121::PORT::8121::服务制动请求输出::ITM-CMD-003::输出 -> 7211::PORT::7211::服务制动请求输入::ITM-CMD-003::输入";
        }
        interface c_CG_992C677E70DA53B7B40EA26C : IF_IF_PHY_001 connect p_N_4000.p_N_4100.p_N_4110.p_N_4111.rp_695b20573c740008 to boundary_BOUNDARY_CATENARY_25KV.bp_6fe914f662252c4d {
            attribute connectionId : String = "CG-992C677E70DA53B7B40EA26C";
            attribute connectionType : String = "BOUNDARY";
            attribute originalPath : String = "4111::PORT::4111::接触面高压交流电能端口::ITM-PHY-001::双向物理 -> BOUNDARY-CATENARY-25KV::BPORT::BOUNDARY-CATENARY-25KV::ITM-PHY-001";
        }
        interface c_CG_9A05AF4B79F0AC70EEBB8C27 : IF_IF_MEA_025 connect p_X000.p_X100.p_X120.p_X122.rp_370359531bcbeddd to p_X000.p_X100.p_X110.p_X112.rp_fc5798a77b6a020d {
            attribute connectionId : String = "CG-9A05AF4B79F0AC70EEBB8C27";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X122::PORT::X122::超级电容电压输出::ITM-MEA-025::输出 -> X112::PORT::X112::超级电容电压输入::ITM-MEA-025::输入";
        }
        interface c_CG_9ACDE46A41EE650430438B91 : IF_IF_CMD_016 connect p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_65aacc4600de3990 to p_N_8000.p_N_8100.p_N_8150.p_N_8151.rp_d7d7f4cb9554ff03 {
            attribute connectionId : String = "CG-9ACDE46A41EE650430438B91";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4238::PORT::4238::高压断路器指令输出::ITM-CMD-016::输出 -> 8151::PORT::8151::高压断路器指令输入::ITM-CMD-016::输入";
        }
        interface c_CG_9AE6E470A1C767E917CAED42 : IF_IF_CMD_030 connect p_N_8000.p_N_8100.p_N_8120.p_N_8127.rp_8f3091a86214dd4e to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_ab848f3c1a74117a {
            attribute connectionId : String = "CG-9AE6E470A1C767E917CAED42";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8127::PORT::8127::安全停车_制动请求输出::ITM-CMD-030::输出 -> 8122::PORT::8122::安全停车_制动请求输入::ITM-CMD-030::输入";
        }
        interface c_CG_9B0510538F8E21B452D8C165 : IF_IF_STA_006 connect p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_43e35aa64c833efc to p_N_7000.p_N_7200.p_N_7280.p_N_7281.rp_5158f71b0a56da87 {
            attribute connectionId : String = "CG-9B0510538F8E21B452D8C165";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "7211::PORT::7211::制动隔离状态输出::ITM-STA-006::输出 -> 7281::PORT::7281::制动隔离状态输入::ITM-STA-006::输入";
        }
        interface c_CG_9D3B4C2BDF604CDEBBA07160 : IF_IF_ACC_015 connect p_N_8000.p_N_8100.p_N_8160.p_N_8166.rp_0d75944292125dac to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_b11b9e2ada11927e {
            attribute connectionId : String = "CG-9D3B4C2BDF604CDEBBA07160";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8166::PORT::8166::能量回收率输出::ITM-ACC-015::输出 -> 8122::PORT::8122::能量回收率输入::ITM-ACC-015::输入";
        }
        interface c_CG_9EB19436ED0A54ECCF52C717 : IF_IF_PHY_001 connect p_N_4000.p_N_4100.p_N_4110.p_N_4111.rp_ca65ceda639dfc7a to p_N_4000.p_N_4200.p_N_4210.p_N_4211.rp_bba7ece236be8f3c {
            attribute connectionId : String = "CG-9EB19436ED0A54ECCF52C717";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "4111::PORT::4111::导流端高压交流电能端口::ITM-PHY-001::双向物理 -> 4211::PORT::4211::进线侧高压交流电能端口::ITM-PHY-001::双向物理";
        }
        interface c_CG_A0B82CF482DDFB4553F8CFCA : IF_IF_MEA_014 connect p_N_8000.p_N_8100.p_N_8120.p_N_8128.rp_8d19f6989a5bebad to p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_04cfaf63bfa3ed70 {
            attribute connectionId : String = "CG-A0B82CF482DDFB4553F8CFCA";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8128::PORT::8128::总风管压力输出::ITM-MEA-014::输出 -> 7211::PORT::7211::总风管压力输入::ITM-MEA-014::输入";
        }
        interface c_CG_A0E50849D53632A6F599B298 : IF_IF_CMD_025 connect p_X000.p_X100.p_X110.p_X112.rp_1ca011606f062f80 to p_X000.p_X100.p_X110.p_X111.rp_3ad794182f43f4d8 {
            attribute connectionId : String = "CG-A0E50849D53632A6F599B298";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X112::PORT::X112::储能功率请求输出::ITM-CMD-025::输出 -> X111::PORT::X111::储能功率请求输入::ITM-CMD-025::输入";
        }
        interface c_CG_A35E2178763C6233BE73AA36 : IF_IF_ACC_005 connect p_N_5000.p_N_5100.p_N_5140.p_N_5142.rp_ff09931c451e831b to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_dae173a1561f3f35 {
            attribute connectionId : String = "CG-A35E2178763C6233BE73AA36";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5142::PORT::5142::制动电阻耗散功率输出::ITM-ACC-005::输出 -> 8122::PORT::8122::制动电阻耗散功率输入::ITM-ACC-005::输入";
        }
        interface c_CG_A3B31951ADAE62C498E76260 : IF_IF_CMD_001 connect p_D000.p_D100.p_D110.p_D112.rp_8962dea15ad904c6 to p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_2ee1cd48c6d41ac7 {
            attribute connectionId : String = "CG-A3B31951ADAE62C498E76260";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "D112::PORT::D112::列车方向指令输出::ITM-CMD-001::输出 -> 8121::PORT::8121::列车方向指令输入::ITM-CMD-001::输入";
        }
        interface c_CG_A424455519797490E4F865AA : IF_IF_MEA_008 connect p_N_5000.p_N_5100.p_N_5140.p_N_5145.rp_1680714c67f7d311 to p_N_8000.p_N_8100.p_N_8160.p_N_8166.rp_54d624d57f57843b {
            attribute connectionId : String = "CG-A424455519797490E4F865AA";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5145::PORT::5145::中间直流母线电压输出::ITM-MEA-008::输出 -> 8166::PORT::8166::中间直流母线电压输入::ITM-MEA-008::输入";
        }
        interface c_CG_A467E486FE1FCC1FD2410729 : IF_IF_MEA_009 connect p_N_5000.p_N_5100.p_N_5140.p_N_5145.rp_a9cc4822e30a5ede to p_N_5000.p_N_5100.p_N_5110.p_N_5112.rp_6ad9df7ab3c91425 {
            attribute connectionId : String = "CG-A467E486FE1FCC1FD2410729";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5145::PORT::5145::中间直流母线电流输出::ITM-MEA-009::输出 -> 5112::PORT::5112::中间直流母线电流输入::ITM-MEA-009::输入";
        }
        interface c_CG_A6D783BBFCF6C6DA11FFCF2D : IF_IF_MEA_029 connect p_X000.p_X100.p_X110.p_X111.rp_9828766df3df1904 to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_e1808e35289aaba6 {
            attribute connectionId : String = "CG-A6D783BBFCF6C6DA11FFCF2D";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X111::PORT::X111::双向DC_DC实际功率输出::ITM-MEA-029::输出 -> 8122::PORT::8122::双向DC_DC实际功率输入::ITM-MEA-029::输入";
        }
        interface c_CG_A7173AC81E21DD801A82E73D : IF_IF_STA_016 connect p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_9458944450b0dd4c to p_N_4000.p_N_4200.p_N_4230.p_N_4239.rp_be1480d12bc9092c {
            attribute connectionId : String = "CG-A7173AC81E21DD801A82E73D";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4238::PORT::4238::高压系统故障状态输出::ITM-STA-016::输出 -> 4239::PORT::4239::高压系统故障状态采集输入::ITM-STA-016::输入";
        }
        interface c_CG_A9A3297C8A71DEFC8975FC31 : IF_IF_PHY_013 connect p_X000.p_X100.p_X120.p_X124.rp_4d5eafc70549d9c0 to boundary_BOUNDARY_THERMAL_ENVIRONMENT.bp_2ac3a221090b246a {
            attribute connectionId : String = "CG-A9A3297C8A71DEFC8975FC31";
            attribute connectionType : String = "BOUNDARY";
            attribute originalPath : String = "X124::PORT::X124::超级电容热能感知端口::ITM-PHY-013::双向物理 -> BOUNDARY-THERMAL-ENVIRONMENT::BPORT::BOUNDARY-THERMAL-ENVIRONMENT::ITM-PHY-013";
        }
        interface c_CG_ACA2BC6B6BBEF201778733FC : IF_IF_STA_027 connect p_N_8000.p_N_8100.p_N_8120.p_N_8128.rp_58e3c9dfabb04a51 to p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_d5423b06aaccb6ac {
            attribute connectionId : String = "CG-ACA2BC6B6BBEF201778733FC";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8128::PORT::8128::ATP_外部安全系统状态输出::ITM-STA-027::输出 -> 8121::PORT::8121::ATP_外部安全系统状态输入::ITM-STA-027::输入";
        }
        interface c_CG_AF75A5003A9B1A8DE28924E1 : IF_IF_PHY_005 connect p_N_3000.p_N_3100.p_N_3120.p_N_3121.rp_6464b6253314b208 to p_N_3000.p_N_3100.p_N_3110.p_N_3112.rp_6917242b1f7fc50f {
            attribute connectionId : String = "CG-AF75A5003A9B1A8DE28924E1";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "3121::PORT::3121::低速轴旋转机械能端口::ITM-PHY-005::双向物理 -> 3112::PORT::3112::传动段旋转机械能端口::ITM-PHY-005::双向物理";
        }
        interface c_CG_B1E191297C1D862473B2D371 : IF_IF_STA_001 connect p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_04f0621818e40445 to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_b6a69bd683685d04 {
            attribute connectionId : String = "CG-B1E191297C1D862473B2D371";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8125::PORT::8125::牵引可用状态输出::ITM-STA-001::输出 -> 8122::PORT::8122::牵引可用状态输入::ITM-STA-001::输入";
        }
        interface c_CG_B251741505CB19FE47559F29 : IF_IF_CMD_006 connect p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_0194ebfed505dfb5 to p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_d69905c106b65d8f {
            attribute connectionId : String = "CG-B251741505CB19FE47559F29";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "7211::PORT::7211::动态制动力请求输出::ITM-CMD-006::输出 -> 8125::PORT::8125::动态制动力请求输入::ITM-CMD-006::输入";
        }
        interface c_CG_B399D92EE15558C08A95FA03 : IF_IF_ACC_003 connect p_N_5000.p_N_5100.p_N_5130.p_N_5131.rp_95979f7c6bb276e7 to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_eb1cf5594b5796be {
            attribute connectionId : String = "CG-B399D92EE15558C08A95FA03";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5131::PORT::5131::回馈电网功率输出::ITM-ACC-003::输出 -> 8122::PORT::8122::回馈电网功率输入::ITM-ACC-003::输入";
        }
        interface c_CG_B483D5C4E4EC5F805E3B0F19 : IF_IF_PHY_001 connect p_N_4000.p_N_4200.p_N_4230.p_N_4236.rp_78e99abb7d77c156 to p_N_4000.p_N_4500.p_N_4510.p_N_4511.rp_c782fb362436088e {
            attribute connectionId : String = "CG-B483D5C4E4EC5F805E3B0F19";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "4236::PORT::4236::第二测量端高压交流电能端口::ITM-PHY-001::双向物理 -> 4511::PORT::4511::高压交流电能端口::ITM-PHY-001::双向物理";
        }
        interface c_CG_B5CE3B88204C1D03AD0527D2 : IF_IF_LIM_001 connect p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_b60dd66dcfd10afa to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_e0814e233fa0db3e {
            attribute connectionId : String = "CG-B5CE3B88204C1D03AD0527D2";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8125::PORT::8125::可用动态制动力输出::ITM-LIM-001::输出 -> 8122::PORT::8122::可用动态制动力输入::ITM-LIM-001::输入";
        }
        interface c_CG_B99AB8690BDE418D1F8055E3 : IF_IF_CMD_010 connect p_N_5000.p_N_5100.p_N_5110.p_N_5111.rp_3c696476f82c2ae5 to p_N_5000.p_N_5100.p_N_5130.p_N_5131.rp_c06b535bf90fa905 {
            attribute connectionId : String = "CG-B99AB8690BDE418D1F8055E3";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5111::PORT::5111::网侧变流控制指令输出::ITM-CMD-010::输出 -> 5131::PORT::5131::网侧变流控制指令输入::ITM-CMD-010::输入";
        }
        interface c_CG_BB962E06FB56D8459F9A2BF0 : IF_IF_STA_001 connect p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_04f0621818e40445 to p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_37e2c2d63c55e098 {
            attribute connectionId : String = "CG-BB962E06FB56D8459F9A2BF0";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8125::PORT::8125::牵引可用状态输出::ITM-STA-001::输出 -> 8121::PORT::8121::牵引可用状态输入::ITM-STA-001::输入";
        }
        interface c_CG_BC53696D702792E563E6C045 : IF_IF_LIM_007 connect p_X000.p_X100.p_X110.p_X113.rp_d9c32040ebe6917e to p_X000.p_X100.p_X110.p_X112.rp_1f01277587ee6905 {
            attribute connectionId : String = "CG-BC53696D702792E563E6C045";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X113::PORT::X113::直流母线电压上限输出::ITM-LIM-007::输出 -> X112::PORT::X112::直流母线电压上限输入::ITM-LIM-007::输入";
        }
        interface c_CG_BDBC6DE36D711BE7257BA6A4 : IF_IF_PHY_013 connect p_N_5000.p_N_5100.p_N_5140.p_N_5142.rp_7c7ad9996d24b706 to boundary_BOUNDARY_THERMAL_ENVIRONMENT.bp_2ac3a221090b246a {
            attribute connectionId : String = "CG-BDBC6DE36D711BE7257BA6A4";
            attribute connectionType : String = "BOUNDARY";
            attribute originalPath : String = "5142::PORT::5142::热能_热流端口::ITM-PHY-013::双向物理 -> BOUNDARY-THERMAL-ENVIRONMENT::BPORT::BOUNDARY-THERMAL-ENVIRONMENT::ITM-PHY-013";
        }
        interface c_CG_BDD8747118488C9BE895D95F : IF_IF_LIM_005 connect p_N_5000.p_N_5100.p_N_5110.p_N_5111.rp_cd7720cf9a4eae22 to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_abc36140248d0eef {
            attribute connectionId : String = "CG-BDD8747118488C9BE895D95F";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5111::PORT::5111::接触网可接收功率输出::ITM-LIM-005::输出 -> 8122::PORT::8122::接触网可接收功率输入::ITM-LIM-005::输入";
        }
        interface c_CG_BDE1416487389FCF7B495D3E : IF_IF_MEA_010 connect p_N_5000.p_N_5100.p_N_5110.p_N_5113.rp_4be030fa7e242206 to p_N_5000.p_N_5100.p_N_5110.p_N_5112.rp_3db204c2f5a83c7f {
            attribute connectionId : String = "CG-BDE1416487389FCF7B495D3E";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5113::PORT::5113::电机侧相电流输出::ITM-MEA-010::输出 -> 5112::PORT::5112::电机侧相电流输入::ITM-MEA-010::输入";
        }
        interface c_CG_BE9EAF0E7F50C277DA344138 : IF_IF_LIM_004 connect p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_91d8f479934c65da to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_3aaf955421310ab3 {
            attribute connectionId : String = "CG-BE9EAF0E7F50C277DA344138";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8125::PORT::8125::再生功率上限输出::ITM-LIM-004::输出 -> 8122::PORT::8122::再生功率上限输入::ITM-LIM-004::输入";
        }
        interface c_CG_BEDE0932E86628B2EFCA8CCD : IF_IF_LIM_001 connect p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_b60dd66dcfd10afa to p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_e4d6047a07b1416e {
            attribute connectionId : String = "CG-BEDE0932E86628B2EFCA8CCD";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8125::PORT::8125::可用动态制动力输出::ITM-LIM-001::输出 -> 7211::PORT::7211::可用动态制动力输入::ITM-LIM-001::输入";
        }
        interface c_CG_BF14D9A0947A4893C7260661 : IF_IF_PHY_001 connect p_N_4000.p_N_4200.p_N_4210.p_N_4212.rp_e1689d643b97d378 to p_N_4000.p_N_4200.p_N_4230.p_N_4236.rp_bb6f3fee449fd865 {
            attribute connectionId : String = "CG-BF14D9A0947A4893C7260661";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "4212::PORT::4212::出线侧高压交流电能端口::ITM-PHY-001::双向物理 -> 4236::PORT::4236::第一测量端高压交流电能端口::ITM-PHY-001::双向物理";
        }
        interface c_CG_C003C81FB79009EC9E0DAC6B : IF_IF_CMD_028 connect p_X000.p_X100.p_X110.p_X112.rp_adb78cdbb75469df to p_X000.p_X100.p_X130.p_X132.rp_4d68d3f9ee4e0009 {
            attribute connectionId : String = "CG-C003C81FB79009EC9E0DAC6B";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X112::PORT::X112::储能预充电指令输出::ITM-CMD-028::输出 -> X132::PORT::X132::储能预充电指令输入::ITM-CMD-028::输入";
        }
        interface c_CG_C03EBDD9B3CFF4E6611E41A1 : IF_IF_STA_030 connect p_X000.p_X100.p_X110.p_X112.rp_3b946767139d884a to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_1967a947dd39d4a5 {
            attribute connectionId : String = "CG-C03EBDD9B3CFF4E6611E41A1";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X112::PORT::X112::储能系统可用状态输出::ITM-STA-030::输出 -> 8122::PORT::8122::储能系统可用状态输入::ITM-STA-030::输入";
        }
        interface c_CG_C0F5EB5317440FA36F0491AE : IF_IF_STA_024 connect p_N_8000.p_N_8100.p_N_8120.p_N_8128.rp_cb74be2d7d4a54c7 to p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_2455eff74badb007 {
            attribute connectionId : String = "CG-C0F5EB5317440FA36F0491AE";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8128::PORT::8128::高压安全回路状态输出::ITM-STA-024::输出 -> 8121::PORT::8121::高压安全回路状态输入::ITM-STA-024::输入";
        }
        interface c_CG_C113ED5B462ACDD4ACE56E91 : IF_IF_STA_031 connect p_X000.p_X100.p_X110.p_X112.rp_e5eadfefaf46ac0a to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_9d3500c169fe7103 {
            attribute connectionId : String = "CG-C113ED5B462ACDD4ACE56E91";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X112::PORT::X112::储能系统故障状态输出::ITM-STA-031::输出 -> 8122::PORT::8122::储能系统故障状态输入::ITM-STA-031::输入";
        }
        interface c_CG_C2F8D7B23A3941D29EE9543F : IF_IF_MEA_029 connect p_X000.p_X100.p_X110.p_X111.rp_9828766df3df1904 to p_X000.p_X100.p_X110.p_X112.rp_4659cbe7e3b50b58 {
            attribute connectionId : String = "CG-C2F8D7B23A3941D29EE9543F";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X111::PORT::X111::双向DC_DC实际功率输出::ITM-MEA-029::输出 -> X112::PORT::X112::双向DC_DC实际功率输入::ITM-MEA-029::输入";
        }
        interface c_CG_C346B9ABBAE556A332DA422F : IF_IF_MEA_006 connect p_N_4000.p_N_4200.p_N_4230.p_N_4236.rp_9107465175683792 to p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_afb7b0997d28e7cb {
            attribute connectionId : String = "CG-C346B9ABBAE556A332DA422F";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4236::PORT::4236::高压线路电流输出::ITM-MEA-006::输出 -> 4238::PORT::4238::高压线路电流输入::ITM-MEA-006::输入";
        }
        interface c_CG_C3FD4BDC3D0E9ABF609DAE81 : IF_IF_CMD_018 connect p_N_4000.p_N_4200.p_N_4230.p_N_4239.rp_327ede77d6565c4b to p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_71811e4b68798212 {
            attribute connectionId : String = "CG-C3FD4BDC3D0E9ABF609DAE81";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4239::PORT::4239::受电弓控制指令输出::ITM-CMD-018::输出 -> 4238::PORT::4238::受电弓控制指令输入::ITM-CMD-018::输入";
        }
        interface c_CG_C53D41B4A1F64D70B4607AA4 : IF_IF_PHY_006 connect p_N_3000.p_N_3100.p_N_3110.p_N_3111.rp_8ee7c79c0fe26b93 to boundary_BOUNDARY_RAIL.bp_cf72f055f5b12b85 {
            attribute connectionId : String = "CG-C53D41B4A1F64D70B4607AA4";
            attribute connectionType : String = "BOUNDARY";
            attribute originalPath : String = "3111::PORT::3111::轮轨纵向机械作用端口::ITM-PHY-006::双向物理 -> BOUNDARY-RAIL::BPORT::BOUNDARY-RAIL::ITM-PHY-006";
        }
        interface c_CG_C5E43804F4CA212D668FD997 : IF_IF_STA_032 connect p_X000.p_X100.p_X130.p_X131.rp_c029b3b1472e957d to p_X000.p_X100.p_X110.p_X112.rp_f929a9fa6b633837 {
            attribute connectionId : String = "CG-C5E43804F4CA212D668FD997";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X131::PORT::X131::储能主接触器状态输出::ITM-STA-032::输出 -> X112::PORT::X112::储能主接触器状态输入::ITM-STA-032::输入";
        }
        interface c_CG_C64E0682EDDBDDD748BA13CA : IF_IF_STA_013 connect p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_0674d2b80a6a72da to p_N_4000.p_N_4200.p_N_4230.p_N_4239.rp_1fd23591362c1d8d {
            attribute connectionId : String = "CG-C64E0682EDDBDDD748BA13CA";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4238::PORT::4238::高压断路器状态输出::ITM-STA-013::输出 -> 4239::PORT::4239::高压断路器状态输入::ITM-STA-013::输入";
        }
        interface c_CG_C6A9FBA7CCD28311320F3552 : IF_IF_CMD_030 connect p_N_8000.p_N_8100.p_N_8120.p_N_8127.rp_8f3091a86214dd4e to p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_4325db72e2d88769 {
            attribute connectionId : String = "CG-C6A9FBA7CCD28311320F3552";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8127::PORT::8127::安全停车_制动请求输出::ITM-CMD-030::输出 -> 8121::PORT::8121::安全停车_制动请求输入::ITM-CMD-030::输入";
        }
        interface c_CG_C7C6703197747322B57096B5 : IF_IF_MEA_017 connect p_N_7000.p_N_7200.p_N_7250.p_N_7252.rp_6e046e892954d0de to p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_5b7be52aa5b6e9d0 {
            attribute connectionId : String = "CG-C7C6703197747322B57096B5";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "7252::PORT::7252::实际摩擦制动力输出::ITM-MEA-017::输出 -> 7211::PORT::7211::实际摩擦制动力输入::ITM-MEA-017::输入";
        }
        interface c_CG_C81A2253CDA9FC6173740074 : IF_IF_PHY_005 connect p_N_3000.p_N_3100.p_N_3110.p_N_3112.rp_c530418a51140052 to p_N_3000.p_N_3100.p_N_3110.p_N_3111.rp_f0350fc816a551ff {
            attribute connectionId : String = "CG-C81A2253CDA9FC6173740074";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "3112::PORT::3112::轮对段旋转机械能端口::ITM-PHY-005::双向物理 -> 3111::PORT::3111::轮轴旋转机械能端口::ITM-PHY-005::双向物理";
        }
        interface c_CG_C8FE042475056BF85CFA2B40 : IF_IF_MEA_008 connect p_N_5000.p_N_5100.p_N_5140.p_N_5145.rp_1680714c67f7d311 to p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_7262595caaf3b8d8 {
            attribute connectionId : String = "CG-C8FE042475056BF85CFA2B40";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5145::PORT::5145::中间直流母线电压输出::ITM-MEA-008::输出 -> 8125::PORT::8125::中间直流母线电压输入::ITM-MEA-008::输入";
        }
        interface c_CG_C9CA06B236DB453EEFEC07E6 : IF_IF_STA_013 connect p_N_4000.p_N_4200.p_N_4210.p_N_4211.rp_5301bf8bda8fba16 to p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_b26de8005dff4962 {
            attribute connectionId : String = "CG-C9CA06B236DB453EEFEC07E6";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4211::PORT::4211::高压断路器状态输出::ITM-STA-013::输出 -> 4238::PORT::4238::高压断路器状态输入::ITM-STA-013::输入";
        }
        interface c_CG_CB302083C9F33A1345D9C406 : IF_IF_LIM_009 connect p_X000.p_X100.p_X110.p_X112.rp_388d943a537916a7 to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_8c3ed075d33335e8 {
            attribute connectionId : String = "CG-CB302083C9F33A1345D9C406";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X112::PORT::X112::储能可用充电功率输出::ITM-LIM-009::输出 -> 8122::PORT::8122::储能可用充电功率输入::ITM-LIM-009::输入";
        }
        interface c_CG_CCE3D228C7F2AEE6207C1B6A : IF_IF_CMD_020 connect p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_a882b33038ce4623 to p_N_7000.p_N_7200.p_N_7280.p_N_7284.rp_0b1d53051662d3f2 {
            attribute connectionId : String = "CG-CCE3D228C7F2AEE6207C1B6A";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "7211::PORT::7211::制动隔离指令输出::ITM-CMD-020::输出 -> 7284::PORT::7284::制动隔离指令输入::ITM-CMD-020::输入";
        }
        interface c_CG_CD05C34D37DBECA08731CAFA : IF_IF_MEA_006 connect p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_c7dcc306b020116f to p_N_4000.p_N_4200.p_N_4230.p_N_4239.rp_1a7ff383166e59f0 {
            attribute connectionId : String = "CG-CD05C34D37DBECA08731CAFA";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4238::PORT::4238::高压线路电流输出::ITM-MEA-006::输出 -> 4239::PORT::4239::高压线路电流输入::ITM-MEA-006::输入";
        }
        interface c_CG_CE151D40A2BF816F41762F4C : IF_IF_STA_025 connect p_N_8000.p_N_8100.p_N_8150.p_N_8152.rp_ae53feffb1e116e3 to p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_daaf414c1711f2bd {
            attribute connectionId : String = "CG-CE151D40A2BF816F41762F4C";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8152::PORT::8152::制动安全回路状态输出::ITM-STA-025::输出 -> 7211::PORT::7211::制动安全回路状态输入::ITM-STA-025::输入";
        }
        interface c_CG_CE2820923CC0CB141833E11D : IF_IF_STA_016 connect p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_9458944450b0dd4c to p_N_4000.p_N_4500.p_N_4510.p_N_4518.rp_a87c9390595138d6 {
            attribute connectionId : String = "CG-CE2820923CC0CB141833E11D";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4238::PORT::4238::高压系统故障状态输出::ITM-STA-016::输出 -> 4518::PORT::4518::高压系统故障状态输入::ITM-STA-016::输入";
        }
        interface c_CG_D1D66AE9099CD7FA32C270A6 : IF_IF_CMD_021 connect p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_dff51f26bbd38512 to p_N_7000.p_N_7200.p_N_7220.p_N_7222.rp_ddeea781987ee55c {
            attribute connectionId : String = "CG-D1D66AE9099CD7FA32C270A6";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "7211::PORT::7211::电空转换阀指令输出::ITM-CMD-021::输出 -> 7222::PORT::7222::电空转换阀指令输入::ITM-CMD-021::输入";
        }
        interface c_CG_D2E26B7066F1A62115B06D59 : IF_IF_STA_014 connect p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_7fe2b8fd826583f2 to p_N_4000.p_N_4200.p_N_4230.p_N_4239.rp_30bf7d79603b941d {
            attribute connectionId : String = "CG-D2E26B7066F1A62115B06D59";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4238::PORT::4238::高压隔离开关状态输出::ITM-STA-014::输出 -> 4239::PORT::4239::高压隔离开关状态输入::ITM-STA-014::输入";
        }
        interface c_CG_D338FAEF97B977B2FE95051B : IF_IF_MEA_008 connect p_N_5000.p_N_5100.p_N_5140.p_N_5145.rp_1680714c67f7d311 to p_N_5000.p_N_5100.p_N_5110.p_N_5112.rp_69252f780afe77e0 {
            attribute connectionId : String = "CG-D338FAEF97B977B2FE95051B";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5145::PORT::5145::中间直流母线电压输出::ITM-MEA-008::输出 -> 5112::PORT::5112::中间直流母线电压输入::ITM-MEA-008::输入";
        }
        interface c_CG_D44FA955851A05FB81FD0837 : IF_IF_MEA_005 connect p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_5576b5e0dbb912ba to p_N_4000.p_N_4200.p_N_4240.p_N_4241.rp_2b7dd272027fdc0b {
            attribute connectionId : String = "CG-D44FA955851A05FB81FD0837";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4238::PORT::4238::高压线路电压输出::ITM-MEA-005::输出 -> 4241::PORT::4241::高压线路电压输入::ITM-MEA-005::输入";
        }
        interface c_CG_D4DF5719633CB5B375F35094 : IF_IF_MEA_012 connect p_N_5000.p_N_5300.p_N_5310.p_N_5311.rp_10bb4c4f0063bc18 to p_N_5000.p_N_5100.p_N_5110.p_N_5112.rp_4557e9b0656c46f5 {
            attribute connectionId : String = "CG-D4DF5719633CB5B375F35094";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5311::PORT::5311::牵引电机实际转矩输出::ITM-MEA-012::输出 -> 5112::PORT::5112::牵引电机实际转矩输入::ITM-MEA-012::输入";
        }
        interface c_CG_D8FCE908D4FD9343C6353985 : IF_IF_CMD_029 connect p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_47c78247980cc3a5 to p_X000.p_X100.p_X110.p_X112.rp_b84f02a624b9982f {
            attribute connectionId : String = "CG-D8FCE908D4FD9343C6353985";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8122::PORT::8122::储能故障复位指令输出::ITM-CMD-029::输出 -> X112::PORT::X112::储能故障复位指令输入::ITM-CMD-029::输入";
        }
        interface c_CG_D9445FD2D7B8285174B3AE22 : IF_IF_MEA_030 connect p_X000.p_X100.p_X110.p_X113.rp_30a4f2a71d158c56 to p_X000.p_X100.p_X110.p_X112.rp_88bb7293920adfa8 {
            attribute connectionId : String = "CG-D9445FD2D7B8285174B3AE22";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X113::PORT::X113::双向DC_DC电流输出::ITM-MEA-030::输出 -> X112::PORT::X112::双向DC_DC电流输入::ITM-MEA-030::输入";
        }
        interface c_CG_D9940860A6DB9E6BD5200881 : IF_IF_PHY_013 connect p_N_3000.p_N_3100.p_N_3130.p_N_3131.rp_ec78c2de89f1a17c to boundary_BOUNDARY_THERMAL_ENVIRONMENT.bp_2ac3a221090b246a {
            attribute connectionId : String = "CG-D9940860A6DB9E6BD5200881";
            attribute connectionType : String = "BOUNDARY";
            attribute originalPath : String = "3131::PORT::3131::热能_热流端口::ITM-PHY-013::双向物理 -> BOUNDARY-THERMAL-ENVIRONMENT::BPORT::BOUNDARY-THERMAL-ENVIRONMENT::ITM-PHY-013";
        }
        interface c_CG_D9CD1E8933F596F319A67625 : IF_IF_CMD_028 connect p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_f704c2e7bab06749 to p_X000.p_X100.p_X110.p_X112.rp_5ff890136d5d49bf {
            attribute connectionId : String = "CG-D9CD1E8933F596F319A67625";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8122::PORT::8122::储能预充电指令输出::ITM-CMD-028::输出 -> X112::PORT::X112::储能预充电指令输入::ITM-CMD-028::输入";
        }
        interface c_CG_DA869E241F8A36DBAAC07E48 : IF_IF_PHY_007 connect p_N_7000.p_N_7200.p_N_7250.p_N_7254.rp_d9511ef0fa1c17df to p_N_3000.p_N_3100.p_N_3130.p_N_3131.rp_06d152ddc255f2eb {
            attribute connectionId : String = "CG-DA869E241F8A36DBAAC07E48";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "7254::PORT::7254::摩擦制动机械作用端口::ITM-PHY-007::双向物理 -> 3131::PORT::3131::摩擦制动机械作用端口::ITM-PHY-007::双向物理";
        }
        interface c_CG_DAF7D43DDD825831F29A70F8 : IF_IF_LIM_010 connect p_X000.p_X100.p_X110.p_X112.rp_73067cce4e6a7eeb to p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_35b0ef67b409e840 {
            attribute connectionId : String = "CG-DAF7D43DDD825831F29A70F8";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "X112::PORT::X112::储能可用放电功率输出::ITM-LIM-010::输出 -> 8122::PORT::8122::储能可用放电功率输入::ITM-LIM-010::输入";
        }
        interface c_CG_E0DB6C9771E2E272BC041D82 : IF_IF_CMD_016 connect p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_65aacc4600de3990 to p_N_4000.p_N_4200.p_N_4210.p_N_4211.rp_17bc6a2a377dffab {
            attribute connectionId : String = "CG-E0DB6C9771E2E272BC041D82";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4238::PORT::4238::高压断路器指令输出::ITM-CMD-016::输出 -> 4211::PORT::4211::高压断路器指令输入::ITM-CMD-016::输入";
        }
        interface c_CG_E5A3740D9F06BF31CB55A481 : IF_IF_PHY_012 connect p_N_3000.p_N_3800.p_N_3810.p_N_3813.rp_c843e562c7ec3ed9 to p_N_3000.p_N_3800.p_N_3810.p_N_3814.rp_43d42f25a744fe07 {
            attribute connectionId : String = "CG-E5A3740D9F06BF31CB55A481";
            attribute connectionType : String = "SERIES";
            attribute originalPath : String = "3813::PORT::3813::砂流端口::ITM-PHY-012::双向物理 -> 3814::PORT::3814::砂流端口::ITM-PHY-012::双向物理";
        }
        interface c_CG_E85E42C2A83EE58624438A26 : IF_IF_MEA_009 connect p_N_5000.p_N_5100.p_N_5140.p_N_5145.rp_a9cc4822e30a5ede to p_N_5000.p_N_5100.p_N_5110.p_N_5111.rp_0e00d1e837346b81 {
            attribute connectionId : String = "CG-E85E42C2A83EE58624438A26";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "5145::PORT::5145::中间直流母线电流输出::ITM-MEA-009::输出 -> 5111::PORT::5111::中间直流母线电流输入::ITM-MEA-009::输入";
        }
        interface c_CG_E8DAA56D71F2BE4B5E1C9BBF : IF_IF_MEA_013 connect p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_36a59f5828d4c515 to p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_179bcc3fb8dacbbf {
            attribute connectionId : String = "CG-E8DAA56D71F2BE4B5E1C9BBF";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8125::PORT::8125::实际动态制动力输出::ITM-MEA-013::输出 -> 7211::PORT::7211::实际动态制动力输入::ITM-MEA-013::输入";
        }
        interface c_CG_E9224B53F74EDFCCFDA0FC70 : IF_IF_MEA_016 connect p_N_7000.p_N_7200.p_N_7220.p_N_722B.rp_8d219d5375ded80b to p_N_8000.p_N_8100.p_N_8120.p_N_8128.rp_cc7a917501039195 {
            attribute connectionId : String = "CG-E9224B53F74EDFCCFDA0FC70";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "722B::PORT::722B::制动缸压力输出::ITM-MEA-016::输出 -> 8128::PORT::8128::制动缸压力输入::ITM-MEA-016::输入";
        }
        interface c_CG_E9AAF8010953F56E28D65ACF : IF_IF_CMD_031 connect p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_0209c7a801f78e7e to p_N_7000.p_N_7200.p_N_7210.p_N_7213.rp_de845d22bfa40612 {
            attribute connectionId : String = "CG-E9AAF8010953F56E28D65ACF";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "7211::PORT::7211::制动控制接触器指令输出::ITM-CMD-031::输出 -> 7213::PORT::7213::制动控制接触器指令输入::ITM-CMD-031::输入";
        }
        interface c_CG_ED49C68C1459BB1005D412BB : IF_IF_CMD_030 connect p_N_8000.p_N_8100.p_N_8120.p_N_8127.rp_8f3091a86214dd4e to p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_da3049ae66223d22 {
            attribute connectionId : String = "CG-ED49C68C1459BB1005D412BB";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8127::PORT::8127::安全停车_制动请求输出::ITM-CMD-030::输出 -> 7211::PORT::7211::安全停车_制动请求输入::ITM-CMD-030::输入";
        }
        interface c_CG_F55B5E17D8CBFAC80E0961C2 : IF_IF_STA_024 connect p_N_8000.p_N_8100.p_N_8120.p_N_8128.rp_cb74be2d7d4a54c7 to p_N_4000.p_N_4200.p_N_4230.p_N_4239.rp_c9c4c887a8c7b2f0 {
            attribute connectionId : String = "CG-F55B5E17D8CBFAC80E0961C2";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "8128::PORT::8128::高压安全回路状态输出::ITM-STA-024::输出 -> 4239::PORT::4239::高压安全回路状态输入::ITM-STA-024::输入";
        }
        interface c_CG_F69B9F4B8E034908EE3FE467 : IF_IF_PHY_013 connect p_N_7000.p_N_7200.p_N_7250.p_N_7254.rp_a60f1e83b03ea6d4 to boundary_BOUNDARY_THERMAL_ENVIRONMENT.bp_2ac3a221090b246a {
            attribute connectionId : String = "CG-F69B9F4B8E034908EE3FE467";
            attribute connectionType : String = "BOUNDARY";
            attribute originalPath : String = "7254::PORT::7254::热能_热流端口::ITM-PHY-013::双向物理 -> BOUNDARY-THERMAL-ENVIRONMENT::BPORT::BOUNDARY-THERMAL-ENVIRONMENT::ITM-PHY-013";
        }
        interface c_CG_F85BCC7C68AD281053865693 : IF_IF_CMD_016 connect p_N_4000.p_N_4200.p_N_4230.p_N_4239.rp_e67f315619e85b76 to p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_d6b968957e3167c7 {
            attribute connectionId : String = "CG-F85BCC7C68AD281053865693";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4239::PORT::4239::高压断路器指令输出::ITM-CMD-016::输出 -> 4238::PORT::4238::高压断路器指令输入::ITM-CMD-016::输入";
        }
        interface c_CG_FA31DFA220FEF0D6FAC8EB67 : IF_IF_PHY_005 connect p_N_3000.p_N_3600.p_N_3640.p_N_3641.rp_4ddc6037e5eea6fc to p_N_3000.p_N_3100.p_N_3110.p_N_3112.rp_c530418a51140052 {
            attribute connectionId : String = "CG-FA31DFA220FEF0D6FAC8EB67";
            attribute connectionType : String = "TAP";
            attribute originalPath : String = "3641::PORT::3641::旋转机械能端口::ITM-PHY-005::双向物理 -> 3112::PORT::3112::轮对段旋转机械能端口::ITM-PHY-005::双向物理";
        }
        interface c_CG_FD763799DECBFD4A6F4F94AD : IF_IF_CMD_020 connect p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_a882b33038ce4623 to p_N_7000.p_N_7200.p_N_7220.p_N_7228.rp_8b8dde76f47ec820 {
            attribute connectionId : String = "CG-FD763799DECBFD4A6F4F94AD";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "7211::PORT::7211::制动隔离指令输出::ITM-CMD-020::输出 -> 7228::PORT::7228::制动隔离指令输入::ITM-CMD-020::输入";
        }
        interface c_CG_FE573ED935CFF37491A053E8 : IF_IF_MEA_006 connect p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_c7dcc306b020116f to p_N_8000.p_N_8100.p_N_8160.p_N_8166.rp_d9d89be1583c0e18 {
            attribute connectionId : String = "CG-FE573ED935CFF37491A053E8";
            attribute connectionType : String = "SIGNAL";
            attribute originalPath : String = "4238::PORT::4238::高压线路电流输出::ITM-MEA-006::输出 -> 8166::PORT::8166::高压线路电流输入::ITM-MEA-006::输入";
        }
    }
}
