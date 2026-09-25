package PhysicalNetworks {
    private import ScalarValues::*;
    private import ProductDefinitions::*;
    part physicalNetworkContext : RailSystemContext {
        connection net_NET_DC_LINK_01 connect (p_N_5000.p_N_5100.p_N_5120.p_N_5121.rp_e5b052bb75ba8a31, p_N_5000.p_N_5100.p_N_5120.p_N_5122.rp_6e156eb66bd95a75, p_N_5000.p_N_5100.p_N_5130.p_N_5131.rp_f010ea68f7dddd01, p_N_5000.p_N_5100.p_N_5130.p_N_5132.rp_e9be022214796a74, p_N_5000.p_N_5100.p_N_5140.p_N_5142.rp_14fbc389883862a8, p_X000.p_X100.p_X110.p_X111.rp_565c4036e651287e, p_X000.p_X100.p_X110.p_X113.rp_571e6f079e1116ac) {
            attribute netId : String = "NET-DC-LINK-01";
            attribute itemCode : String = "ITM-PHY-003";
        }
        connection net_NET_LVDC_CONTROL_01 connect (p_N_3000.p_N_3800.p_N_3810.p_N_3811.rp_ad36be2404e763eb, p_N_4000.p_N_4100.p_N_4110.p_N_411C.rp_d6a2171160c4b693, p_N_4000.p_N_4200.p_N_4230.p_N_4238.rp_dc173bda6489186d, p_N_4000.p_N_4200.p_N_4230.p_N_4239.rp_9c4bbbf0c73d853e, p_N_4000.p_N_4200.p_N_4240.p_N_4241.rp_efc0e0ead5465ae4, p_N_4000.p_N_4500.p_N_4510.p_N_4517.rp_fa22ceafa52cda89, p_N_4000.p_N_4500.p_N_4510.p_N_4518.rp_950aee7777f5ea28, p_N_5000.p_N_5100.p_N_5110.p_N_5111.rp_9ceb0295e403e673, p_N_5000.p_N_5100.p_N_5110.p_N_5112.rp_c60f875ac7e265d0, p_N_5000.p_N_5100.p_N_5110.p_N_5113.rp_6f5e3f6e1f0f9b1a, p_N_5000.p_N_5100.p_N_5130.p_N_5133.rp_b97ef71e558464ef, p_N_5000.p_N_5100.p_N_5140.p_N_5145.rp_b22756bb5d4e9b69, p_N_7000.p_N_7200.p_N_7210.p_N_7211.rp_b34d5a11f0a32260, p_N_7000.p_N_7200.p_N_7210.p_N_7213.rp_de41681b082603dc, p_N_7000.p_N_7200.p_N_7280.p_N_7281.rp_2e35e3bc261ab52a, p_N_8000.p_N_8100.p_N_8120.p_N_8121.rp_d2dfdd1f41baec7a, p_N_8000.p_N_8100.p_N_8120.p_N_8122.rp_8b55477454952732, p_N_8000.p_N_8100.p_N_8120.p_N_8125.rp_5184547f4558dae5, p_N_8000.p_N_8100.p_N_8120.p_N_8127.rp_903b55a0b6383446, p_N_8000.p_N_8100.p_N_8120.p_N_8128.rp_3b5ccced6e75cf2c, p_N_8000.p_N_8100.p_N_8150.p_N_8151.rp_b128738a40d9fcd8, p_N_8000.p_N_8100.p_N_8150.p_N_8152.rp_1e9ebcfb3cef3e9d, p_N_8000.p_N_8100.p_N_8150.p_N_8154.rp_caee94e6ee66a74d, p_N_8000.p_N_8100.p_N_8160.p_N_8166.rp_937652db70f809a4, p_X000.p_X100.p_X110.p_X112.rp_569130817376da24, p_X000.p_X100.p_X110.p_X113.rp_9f0c62635f9ae105, p_X000.p_X100.p_X130.p_X133.rp_da93423081013940) {
            attribute netId : String = "NET-LVDC-CONTROL-01";
            attribute itemCode : String = "ITM-PHY-015";
        }
        connection net_NET_MAIN_RETURN_01 connect (p_N_4000.p_N_4400.p_N_4410.p_N_4411.rp_45b0eaf9bb476ccf, p_N_4000.p_N_4400.p_N_4410.p_N_4411.rp_5e63cd1bffa78a41, p_N_4000.p_N_4400.p_N_4410.p_N_4412.rp_e2c805a6993ee3dc, p_N_4000.p_N_4400.p_N_4410.p_N_4412.rp_f330d9bb72a522df, p_N_4000.p_N_4400.p_N_4410.p_N_4413.rp_c808ea5883784df8) {
            attribute netId : String = "NET-MAIN-RETURN-01";
            attribute itemCode : String = "ITM-PHY-011";
        }
        connection net_NET_PNEU_BRAKE_SUPPLY_01 connect (p_N_7000.p_N_7200.p_N_7220.p_N_7222.rp_43816dbefe351165, p_N_7000.p_N_7200.p_N_7220.p_N_7223.rp_9441f85d6ac8b0ed, p_N_7000.p_N_7200.p_N_7220.p_N_7224.rp_0714bcd5930c027b, p_N_7000.p_N_7200.p_N_7220.p_N_7225.rp_99bc109c3b70dfed, p_N_7000.p_N_7200.p_N_7220.p_N_7226.rp_0f31359846cbf234, p_N_7000.p_N_7200.p_N_7220.p_N_7229.rp_a8a0abe4af23248d) {
            attribute netId : String = "NET-PNEU-BRAKE-SUPPLY-01";
            attribute itemCode : String = "ITM-PHY-009";
        }
        connection net_NET_PNEU_CYLINDER_01 connect (p_N_7000.p_N_7200.p_N_7220.p_N_7223.rp_26b22e117179b62a, p_N_7000.p_N_7200.p_N_7220.p_N_7226.rp_afce9ce1d2c43605, p_N_7000.p_N_7200.p_N_7220.p_N_7227.rp_26311db59efd1104, p_N_7000.p_N_7200.p_N_7220.p_N_7228.rp_9f256ce20a2eedba, p_N_7000.p_N_7200.p_N_7220.p_N_7228.rp_e8a2cfb94eeae29a, p_N_7000.p_N_7200.p_N_7220.p_N_722A.rp_0093bc65af2a8f0a, p_N_7000.p_N_7200.p_N_7220.p_N_722A.rp_1d96067b68d03c9c, p_N_7000.p_N_7200.p_N_7220.p_N_722B.rp_4861b172f136b92e, p_N_7000.p_N_7200.p_N_7220.p_N_722C.rp_041b8e496fc7f6c1, p_N_7000.p_N_7200.p_N_7250.p_N_7252.rp_7e02e65996d4ca82, p_N_7000.p_N_7200.p_N_7250.p_N_7255.rp_734246fb536f2b68, p_N_7000.p_N_7200.p_N_7280.p_N_7284.rp_3e963340985cb7bd, p_N_7000.p_N_7200.p_N_7280.p_N_7284.rp_c958e15a33eb790f, p_N_7000.p_N_7200.p_N_7280.p_N_7285.rp_337ee35177e1c114, p_N_7000.p_N_7200.p_N_7280.p_N_7285.rp_73c5051041203267) {
            attribute netId : String = "NET-PNEU-CYLINDER-01";
            attribute itemCode : String = "ITM-PHY-010";
        }
        connection net_NET_PNEU_MAIN_01 connect (p_N_3000.p_N_3800.p_N_3810.p_N_3813.rp_3f7e961856b812d2, p_N_7000.p_N_7100.p_N_7120.p_N_7124.rp_732b5a3acb4e2be0, p_N_7000.p_N_7100.p_N_7130.p_N_7131.rp_e275cbf47ef42c02, p_N_7000.p_N_7100.p_N_7130.p_N_7131.rp_e73ffca5021e0883, p_N_7000.p_N_7100.p_N_7140.p_N_7142.rp_b1c762907b90d07b, p_N_7000.p_N_7200.p_N_7220.p_N_7222.rp_d9d50ab5a08a26a5, p_N_7000.p_N_7200.p_N_7220.p_N_7223.rp_4abc41bc202f61af, p_N_7000.p_N_7200.p_N_7220.p_N_7224.rp_291ee811748691f6, p_N_7000.p_N_7200.p_N_7220.p_N_7225.rp_f6a9fd98bacfc4e3, p_N_7000.p_N_7200.p_N_7220.p_N_7226.rp_5cccca40a5c3ac4f, p_N_7000.p_N_7200.p_N_7220.p_N_7229.rp_b38d34e10f750709) {
            attribute netId : String = "NET-PNEU-MAIN-01";
            attribute itemCode : String = "ITM-PHY-008";
        }
        connection net_NET_STORAGE_DC_AFTER_CONTACTOR_01 connect (p_X000.p_X100.p_X130.p_X131.rp_6bdc28fa4761142d, p_X000.p_X100.p_X130.p_X132.rp_1d9e411fc4e0ebf9, p_X000.p_X100.p_X130.p_X133.rp_06282bbd1af76861) {
            attribute netId : String = "NET-STORAGE-DC-AFTER-CONTACTOR-01";
            attribute itemCode : String = "ITM-PHY-016";
        }
        connection net_NET_STORAGE_DC_BUS_01 connect (p_X000.p_X100.p_X110.p_X111.rp_f6cc38ed3ebf357f, p_X000.p_X100.p_X110.p_X113.rp_5e8b7419342ecb12, p_X000.p_X100.p_X130.p_X131.rp_ef3e7082da0c5648, p_X000.p_X100.p_X130.p_X132.rp_0fa709507856ec0b) {
            attribute netId : String = "NET-STORAGE-DC-BUS-01";
            attribute itemCode : String = "ITM-PHY-016";
        }
        connection net_NET_STORAGE_DC_SC_01 connect (p_X000.p_X100.p_X120.p_X121.rp_e7b0b50420861015, p_X000.p_X100.p_X120.p_X122.rp_0b3c69b37f8b252c, p_X000.p_X100.p_X120.p_X123.rp_b6c8109cae13eea5, p_X000.p_X100.p_X130.p_X133.rp_49a2b1a2497ebf63) {
            attribute netId : String = "NET-STORAGE-DC-SC-01";
            attribute itemCode : String = "ITM-PHY-016";
        }
    }
}
