package RailSysONConnectionProjectionTest {
    private import ProductDefinitions::*;
    private import InterfaceDefinitions::*;
    part leaf_4235 : P_N_4235;
    part leaf_5111 : P_N_5111;
    interface c_CG_002543DBE0F9A7FBC2A3FDD3 : IF_IF_MEA_005 connect leaf_4235.rp_6fea4b377f978aac to leaf_5111.rp_5f90d6dd8fba4321;
    view RV_TEST_FLAT_CONNECTION {
        expose leaf_4235;
        expose leaf_5111;
        expose c_CG_002543DBE0F9A7FBC2A3FDD3;
    }
}
