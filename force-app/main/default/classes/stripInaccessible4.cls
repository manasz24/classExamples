public with sharing class stripInaccessible4 {
    public stripInaccessible4() {

        String jsonInput =
        '[' +
        '{' +
        '"Name": "InGen",' +
        '"AnnualRevenue": "100"' +
        '},' +
        '{' +
        '"Name": "Octan"' +
        '}' +
        ']';

        List<Account> accounts = (List<Account>)JSON.deserializeStrict(jsonInput, List<Account>.class);
        SObjectAccessDecision securityDecision = Security.stripInaccessible(
        AccessType.UPDATABLE,
        accounts);

        // Secure update
        update securityDecision.getRecords(); // Doesn’t update AnnualRevenue field
        System.debug(String.join(securityDecision.getRemovedFields().get('Account'), ', ')); // Prints "AnnualRevenue"
        System.debug(String.join(securityDecision.getModifiedIndexes(), ', ')); // Prints "0”

    }
}
