package RequirementHierarchyV2 {
    private import RequirementDefinitionsV2::*;

    connection def RequirementDerivationConnection {
        end parentRequirement : RailRequirementV2;
        end derivedRequirement : RailRequirementV2;
    }

    connection derivation_001 : RequirementDerivationConnection connect (req_REQ_BRK_001, req_DRV_BRK_001) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_002 : RequirementDerivationConnection connect (req_REQ_BRK_012, req_DRV_BRK_001) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_003 : RequirementDerivationConnection connect (req_REQ_BRK_001, req_DRV_BRK_002) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_004 : RequirementDerivationConnection connect (req_REQ_BRK_004, req_DRV_BRK_002) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_005 : RequirementDerivationConnection connect (req_REQ_BRK_013, req_DRV_BRK_002) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_006 : RequirementDerivationConnection connect (req_REQ_TRAC_002, req_DRV_CTL_001) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_007 : RequirementDerivationConnection connect (req_REQ_BRK_001, req_DRV_CTL_001) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_008 : RequirementDerivationConnection connect (req_REQ_BRK_002, req_DRV_CTL_001) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_009 : RequirementDerivationConnection connect (req_REQ_TRAC_002, req_DRV_CTL_002) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_010 : RequirementDerivationConnection connect (req_REQ_BRK_014, req_DRV_CTL_002) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_011 : RequirementDerivationConnection connect (req_REQ_ENE_003, req_DRV_CTL_002) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_012 : RequirementDerivationConnection connect (req_REQ_BRK_014, req_DRV_CTL_003) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_013 : RequirementDerivationConnection connect (req_REQ_BRK_015, req_DRV_CTL_003) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_014 : RequirementDerivationConnection connect (req_REQ_TRAC_003, req_DRV_CTL_003) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_015 : RequirementDerivationConnection connect (req_PRJ_PWR_001, req_DRV_PWR_001) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_016 : RequirementDerivationConnection connect (req_PRJ_PWR_001, req_DRV_PWR_002) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_017 : RequirementDerivationConnection connect (req_PRJ_PWR_001, req_DRV_PWR_003) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_018 : RequirementDerivationConnection connect (req_REQ_TRAC_004, req_DRV_PWR_003) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_019 : RequirementDerivationConnection connect (req_REQ_TRAC_001, req_DRV_TRAC_001) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_020 : RequirementDerivationConnection connect (req_REQ_TRAC_004, req_DRV_TRAC_001) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_021 : RequirementDerivationConnection connect (req_REQ_TRAC_003, req_DRV_TRAC_002) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_022 : RequirementDerivationConnection connect (req_REQ_BRK_010, req_DRV_TRAC_002) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_023 : RequirementDerivationConnection connect (req_REQ_TRAC_001, req_DRV_TRAC_003) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_024 : RequirementDerivationConnection connect (req_REQ_TRAC_002, req_DRV_TRAC_003) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_025 : RequirementDerivationConnection connect (req_REQ_TRAC_004, req_DRV_TRAC_003) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_026 : RequirementDerivationConnection connect (req_REQ_TRAC_004, req_DRV_TRAC_004) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

    connection derivation_027 : RequirementDerivationConnection connect (req_PRJ_PWR_001, req_DRV_TRAC_004) {
        attribute relationType : String = "PARENT_TO_DERIVED_REQUIREMENT";
    }

}
