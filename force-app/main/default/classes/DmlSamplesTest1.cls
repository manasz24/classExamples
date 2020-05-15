@isTest
private class DmlSamplesTest {
   public static testMethod void testUpsertLeads() {
        /* We only need to test the insert side of upsert */
      List<Lead> leads = new List<Lead>();

      /* Create a set of leads for testing */
      for(Integer i = 0;i < 100; i++) {
         leads.add(new Lead(LastName = 'testLead', Company = 'testCompany'));
      }

      /* Switch to the runtime limit context */
      Test.startTest();

      /* Exercise the method */
      List<Database.upsertResult> results = DmlSamples.upsertLeads(leads);

      /* Switch back to the test context for limits */
      Test.stopTest();

      /* ID set for asserting the tasks were created as expected */
      Set<Id> ids = new Set<Id>();

      /* Iterate over the results, asserting success and adding the new ID
         to the set for use in the comprehensive assertion phase below. */
      for(Database.upsertResult result:results) {
         System.assert(result.isSuccess());
         ids.add(result.getId());
      }

      /* Assert that exactly one task exists for each lead that was inserted. */
      for(Lead l:[SELECT Id, (SELECT Subject FROM Tasks) FROM Lead WHERE Id IN :ids]) {
         System.assertEquals(1,l.tasks.size());
      }
   }
}