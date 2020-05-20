public with sharing class stripInaccessible2 {
    public stripInaccessible2() {


        List<Account> accountsWithContacts =
	[SELECT Id, Name, Phone,
	    (SELECT Id, LastName, Phone FROM Account.Contacts)
	FROM Account];
  
   // Strip fields that are not readable
   SObjectAccessDecision decision = Security.stripInaccessible(
	                                   AccessType.READABLE,
	                                   accountsWithContacts);
 
// Print stripped records
   for (Integer i = 0; i < accountsWithContacts.size(); i++) 
  {
      System.debug('Insecure record access: '+accountsWithContacts[i]);
      System.debug('Secure record access: '+decision.getRecords()[i]);
   }
 
// Print modified indexes
   System.debug('Records modified by stripInaccessible: '+decision.getModifiedIndexes());
 
// Print removed fields
   System.debug('Fields removed by stripInaccessible: '+decision.getRemovedFields());
    }
}
