public with sharing class stripInaccessible3 {
    public stripInaccessible3() {
        List<Account> newAccounts = new List<Account>();
        Account a = new Account(Name='Acme Corporation');
        Account b = new Account(Name='Blaze Comics', Rating='Warm');
        newAccounts.add(a);
        newAccounts.add(b);
        
        SObjectAccessDecision securityDecision = Security.stripInaccessible(
        AccessType.CREATABLE,
        newAccounts);
        
        // No exceptions are thrown and no rating is set
        insert securityDecision.getRecords();
        System.debug(securityDecision.getRemovedFields().get('Account')); // Prints "Rating"
        System.debug(securityDecision.getModifiedIndexes()); // Prints "1"
    }
}
