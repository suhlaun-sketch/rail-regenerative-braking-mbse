package RailSysONPhysicalNetworkViews {
    private import ScalarValues::*;
    private import ProductDefinitions::*;
    package NET_DC_LINK_01 {
        part leaf_N_5121 : P_N_5121;
        part leaf_N_5122 : P_N_5122;
        part leaf_N_5131 : P_N_5131;
        part leaf_N_5132 : P_N_5132;
        part leaf_N_5142 : P_N_5142;
        part leaf_X111 : P_X111;
        part leaf_X113 : P_X113;
        connection net_NET_DC_LINK_01 connect (leaf_N_5121.rp_e5b052bb75ba8a31, leaf_N_5122.rp_6e156eb66bd95a75, leaf_N_5131.rp_f010ea68f7dddd01, leaf_N_5132.rp_e9be022214796a74, leaf_N_5142.rp_14fbc389883862a8, leaf_X111.rp_565c4036e651287e, leaf_X113.rp_571e6f079e1116ac) {
            attribute originalNetId : String = "NET-DC-LINK-01";
            attribute originalSysMLPath : String = "PhysicalNetworks::physicalNetworkContext.net_NET_DC_LINK_01";
        }
        view RV_08_PHYSICAL_NET_NET_DC_LINK_01 {
            expose leaf_N_5121;
            expose leaf_N_5122;
            expose leaf_N_5131;
            expose leaf_N_5132;
            expose leaf_N_5142;
            expose leaf_X111;
            expose leaf_X113;
            expose net_NET_DC_LINK_01;
        }
    }
    package NET_LVDC_CONTROL_01 {
        part leaf_N_3811 : P_N_3811;
        part leaf_N_411C : P_N_411C;
        part leaf_N_4238 : P_N_4238;
        part leaf_N_4239 : P_N_4239;
        part leaf_N_4241 : P_N_4241;
        part leaf_N_4517 : P_N_4517;
        part leaf_N_4518 : P_N_4518;
        part leaf_N_5111 : P_N_5111;
        part leaf_N_5112 : P_N_5112;
        part leaf_N_5113 : P_N_5113;
        part leaf_N_5133 : P_N_5133;
        part leaf_N_5145 : P_N_5145;
        part leaf_N_7211 : P_N_7211;
        part leaf_N_7213 : P_N_7213;
        part leaf_N_7281 : P_N_7281;
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
        part leaf_X113 : P_X113;
        part leaf_X133 : P_X133;
        connection net_NET_LVDC_CONTROL_01 connect (leaf_N_3811.rp_ad36be2404e763eb, leaf_N_411C.rp_d6a2171160c4b693, leaf_N_4238.rp_dc173bda6489186d, leaf_N_4239.rp_9c4bbbf0c73d853e, leaf_N_4241.rp_efc0e0ead5465ae4, leaf_N_4517.rp_fa22ceafa52cda89, leaf_N_4518.rp_950aee7777f5ea28, leaf_N_5111.rp_9ceb0295e403e673, leaf_N_5112.rp_c60f875ac7e265d0, leaf_N_5113.rp_6f5e3f6e1f0f9b1a, leaf_N_5133.rp_b97ef71e558464ef, leaf_N_5145.rp_b22756bb5d4e9b69, leaf_N_7211.rp_b34d5a11f0a32260, leaf_N_7213.rp_de41681b082603dc, leaf_N_7281.rp_2e35e3bc261ab52a, leaf_N_8121.rp_d2dfdd1f41baec7a, leaf_N_8122.rp_8b55477454952732, leaf_N_8125.rp_5184547f4558dae5, leaf_N_8127.rp_903b55a0b6383446, leaf_N_8128.rp_3b5ccced6e75cf2c, leaf_N_8151.rp_b128738a40d9fcd8, leaf_N_8152.rp_1e9ebcfb3cef3e9d, leaf_N_8154.rp_caee94e6ee66a74d, leaf_N_8166.rp_937652db70f809a4, leaf_X112.rp_569130817376da24, leaf_X113.rp_9f0c62635f9ae105, leaf_X133.rp_da93423081013940) {
            attribute originalNetId : String = "NET-LVDC-CONTROL-01";
            attribute originalSysMLPath : String = "PhysicalNetworks::physicalNetworkContext.net_NET_LVDC_CONTROL_01";
        }
        view RV_08_PHYSICAL_NET_NET_LVDC_CONTROL_01 {
            expose leaf_N_3811;
            expose leaf_N_411C;
            expose leaf_N_4238;
            expose leaf_N_4239;
            expose leaf_N_4241;
            expose leaf_N_4517;
            expose leaf_N_4518;
            expose leaf_N_5111;
            expose leaf_N_5112;
            expose leaf_N_5113;
            expose leaf_N_5133;
            expose leaf_N_5145;
            expose leaf_N_7211;
            expose leaf_N_7213;
            expose leaf_N_7281;
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
            expose leaf_X113;
            expose leaf_X133;
            expose net_NET_LVDC_CONTROL_01;
        }
    }
    package NET_MAIN_RETURN_01 {
        part leaf_N_4411 : P_N_4411;
        part leaf_N_4412 : P_N_4412;
        part leaf_N_4413 : P_N_4413;
        connection net_NET_MAIN_RETURN_01 connect (leaf_N_4411.rp_45b0eaf9bb476ccf, leaf_N_4411.rp_5e63cd1bffa78a41, leaf_N_4412.rp_e2c805a6993ee3dc, leaf_N_4412.rp_f330d9bb72a522df, leaf_N_4413.rp_c808ea5883784df8) {
            attribute originalNetId : String = "NET-MAIN-RETURN-01";
            attribute originalSysMLPath : String = "PhysicalNetworks::physicalNetworkContext.net_NET_MAIN_RETURN_01";
        }
        view RV_08_PHYSICAL_NET_NET_MAIN_RETURN_01 {
            expose leaf_N_4411;
            expose leaf_N_4412;
            expose leaf_N_4413;
            expose net_NET_MAIN_RETURN_01;
        }
    }
    package NET_PNEU_BRAKE_SUPPLY_01 {
        part leaf_N_7222 : P_N_7222;
        part leaf_N_7223 : P_N_7223;
        part leaf_N_7224 : P_N_7224;
        part leaf_N_7225 : P_N_7225;
        part leaf_N_7226 : P_N_7226;
        part leaf_N_7229 : P_N_7229;
        connection net_NET_PNEU_BRAKE_SUPPLY_01 connect (leaf_N_7222.rp_43816dbefe351165, leaf_N_7223.rp_9441f85d6ac8b0ed, leaf_N_7224.rp_0714bcd5930c027b, leaf_N_7225.rp_99bc109c3b70dfed, leaf_N_7226.rp_0f31359846cbf234, leaf_N_7229.rp_a8a0abe4af23248d) {
            attribute originalNetId : String = "NET-PNEU-BRAKE-SUPPLY-01";
            attribute originalSysMLPath : String = "PhysicalNetworks::physicalNetworkContext.net_NET_PNEU_BRAKE_SUPPLY_01";
        }
        view RV_08_PHYSICAL_NET_NET_PNEU_BRAKE_SUPPLY_01 {
            expose leaf_N_7222;
            expose leaf_N_7223;
            expose leaf_N_7224;
            expose leaf_N_7225;
            expose leaf_N_7226;
            expose leaf_N_7229;
            expose net_NET_PNEU_BRAKE_SUPPLY_01;
        }
    }
    package NET_PNEU_CYLINDER_01 {
        part leaf_N_7223 : P_N_7223;
        part leaf_N_7226 : P_N_7226;
        part leaf_N_7227 : P_N_7227;
        part leaf_N_7228 : P_N_7228;
        part leaf_N_722A : P_N_722A;
        part leaf_N_722B : P_N_722B;
        part leaf_N_722C : P_N_722C;
        part leaf_N_7252 : P_N_7252;
        part leaf_N_7255 : P_N_7255;
        part leaf_N_7284 : P_N_7284;
        part leaf_N_7285 : P_N_7285;
        connection net_NET_PNEU_CYLINDER_01 connect (leaf_N_7223.rp_26b22e117179b62a, leaf_N_7226.rp_afce9ce1d2c43605, leaf_N_7227.rp_26311db59efd1104, leaf_N_7228.rp_9f256ce20a2eedba, leaf_N_7228.rp_e8a2cfb94eeae29a, leaf_N_722A.rp_0093bc65af2a8f0a, leaf_N_722A.rp_1d96067b68d03c9c, leaf_N_722B.rp_4861b172f136b92e, leaf_N_722C.rp_041b8e496fc7f6c1, leaf_N_7252.rp_7e02e65996d4ca82, leaf_N_7255.rp_734246fb536f2b68, leaf_N_7284.rp_3e963340985cb7bd, leaf_N_7284.rp_c958e15a33eb790f, leaf_N_7285.rp_337ee35177e1c114, leaf_N_7285.rp_73c5051041203267) {
            attribute originalNetId : String = "NET-PNEU-CYLINDER-01";
            attribute originalSysMLPath : String = "PhysicalNetworks::physicalNetworkContext.net_NET_PNEU_CYLINDER_01";
        }
        view RV_08_PHYSICAL_NET_NET_PNEU_CYLINDER_01 {
            expose leaf_N_7223;
            expose leaf_N_7226;
            expose leaf_N_7227;
            expose leaf_N_7228;
            expose leaf_N_722A;
            expose leaf_N_722B;
            expose leaf_N_722C;
            expose leaf_N_7252;
            expose leaf_N_7255;
            expose leaf_N_7284;
            expose leaf_N_7285;
            expose net_NET_PNEU_CYLINDER_01;
        }
    }
    package NET_PNEU_MAIN_01 {
        part leaf_N_3813 : P_N_3813;
        part leaf_N_7124 : P_N_7124;
        part leaf_N_7131 : P_N_7131;
        part leaf_N_7142 : P_N_7142;
        part leaf_N_7222 : P_N_7222;
        part leaf_N_7223 : P_N_7223;
        part leaf_N_7224 : P_N_7224;
        part leaf_N_7225 : P_N_7225;
        part leaf_N_7226 : P_N_7226;
        part leaf_N_7229 : P_N_7229;
        connection net_NET_PNEU_MAIN_01 connect (leaf_N_3813.rp_3f7e961856b812d2, leaf_N_7124.rp_732b5a3acb4e2be0, leaf_N_7131.rp_e275cbf47ef42c02, leaf_N_7131.rp_e73ffca5021e0883, leaf_N_7142.rp_b1c762907b90d07b, leaf_N_7222.rp_d9d50ab5a08a26a5, leaf_N_7223.rp_4abc41bc202f61af, leaf_N_7224.rp_291ee811748691f6, leaf_N_7225.rp_f6a9fd98bacfc4e3, leaf_N_7226.rp_5cccca40a5c3ac4f, leaf_N_7229.rp_b38d34e10f750709) {
            attribute originalNetId : String = "NET-PNEU-MAIN-01";
            attribute originalSysMLPath : String = "PhysicalNetworks::physicalNetworkContext.net_NET_PNEU_MAIN_01";
        }
        view RV_08_PHYSICAL_NET_NET_PNEU_MAIN_01 {
            expose leaf_N_3813;
            expose leaf_N_7124;
            expose leaf_N_7131;
            expose leaf_N_7142;
            expose leaf_N_7222;
            expose leaf_N_7223;
            expose leaf_N_7224;
            expose leaf_N_7225;
            expose leaf_N_7226;
            expose leaf_N_7229;
            expose net_NET_PNEU_MAIN_01;
        }
    }
    package NET_STORAGE_DC_AFTER_CONTACTOR_01 {
        part leaf_X131 : P_X131;
        part leaf_X132 : P_X132;
        part leaf_X133 : P_X133;
        connection net_NET_STORAGE_DC_AFTER_CONTACTOR_01 connect (leaf_X131.rp_6bdc28fa4761142d, leaf_X132.rp_1d9e411fc4e0ebf9, leaf_X133.rp_06282bbd1af76861) {
            attribute originalNetId : String = "NET-STORAGE-DC-AFTER-CONTACTOR-01";
            attribute originalSysMLPath : String = "PhysicalNetworks::physicalNetworkContext.net_NET_STORAGE_DC_AFTER_CONTACTOR_01";
        }
        view RV_08_PHYSICAL_NET_NET_STORAGE_DC_AFTER_CONTACTOR_01 {
            expose leaf_X131;
            expose leaf_X132;
            expose leaf_X133;
            expose net_NET_STORAGE_DC_AFTER_CONTACTOR_01;
        }
    }
    package NET_STORAGE_DC_BUS_01 {
        part leaf_X111 : P_X111;
        part leaf_X113 : P_X113;
        part leaf_X131 : P_X131;
        part leaf_X132 : P_X132;
        connection net_NET_STORAGE_DC_BUS_01 connect (leaf_X111.rp_f6cc38ed3ebf357f, leaf_X113.rp_5e8b7419342ecb12, leaf_X131.rp_ef3e7082da0c5648, leaf_X132.rp_0fa709507856ec0b) {
            attribute originalNetId : String = "NET-STORAGE-DC-BUS-01";
            attribute originalSysMLPath : String = "PhysicalNetworks::physicalNetworkContext.net_NET_STORAGE_DC_BUS_01";
        }
        view RV_08_PHYSICAL_NET_NET_STORAGE_DC_BUS_01 {
            expose leaf_X111;
            expose leaf_X113;
            expose leaf_X131;
            expose leaf_X132;
            expose net_NET_STORAGE_DC_BUS_01;
        }
    }
    package NET_STORAGE_DC_SC_01 {
        part leaf_X121 : P_X121;
        part leaf_X122 : P_X122;
        part leaf_X123 : P_X123;
        part leaf_X133 : P_X133;
        connection net_NET_STORAGE_DC_SC_01 connect (leaf_X121.rp_e7b0b50420861015, leaf_X122.rp_0b3c69b37f8b252c, leaf_X123.rp_b6c8109cae13eea5, leaf_X133.rp_49a2b1a2497ebf63) {
            attribute originalNetId : String = "NET-STORAGE-DC-SC-01";
            attribute originalSysMLPath : String = "PhysicalNetworks::physicalNetworkContext.net_NET_STORAGE_DC_SC_01";
        }
        view RV_08_PHYSICAL_NET_NET_STORAGE_DC_SC_01 {
            expose leaf_X121;
            expose leaf_X122;
            expose leaf_X123;
            expose leaf_X133;
            expose net_NET_STORAGE_DC_SC_01;
        }
    }
}
