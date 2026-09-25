package RequirementTraceDefinitions {
    private import ScalarValues::*;

    requirement def RailRequirement {
        attribute requirementId : String;
        attribute domain : String;
        attribute requirementName : String;
        attribute requirementText : String;
        attribute standardNo : String;
        attribute standardClause : String;
        attribute criteria : String;
        attribute applicableConditions : String;
        attribute requirementType : String;
        attribute verificationStatus : String;
        attribute sourceFile : String;
    }
}
