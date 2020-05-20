public with sharing class stripInaccessible1 {
    public stripInaccessible1() {

        Security.SObjectAccessDecision securityDecision = 
        Security.stripInaccessible(AccessType.READABLE,
                [SELECT Name, BudgetedCost, ActualCost FROM Campaign]
                );

   // Construct the output table
   if (securityDecision.getRemovedFields().get('Campaign').contains('ActualCost')) {
       for (Campaign c : securityDecision.getRecords()) {
       //System.debug Output: Name, BudgetedCost
       }
   } else {
       for (Campaign c : securityDecision.getRecords()) {
       //System.debug Output: Name, BudgetedCost, ActualCost
       }
}


    }
}
