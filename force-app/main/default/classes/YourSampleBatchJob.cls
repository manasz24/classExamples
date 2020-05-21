public with sharing class YourSampleBatchJob implements Database.Batchable<SObject>, Database.RaisesPlatformEvents{ 
   // class implementation 
} 

/** 

trigger MarkDirtyIfFail on BatchApexErrorEvent (after insert) {
    Set<Id> asyncApexJobIds = new Set<Id>();
    for(BatchApexErrorEvent evt:Trigger.new){
        asyncApexJobIds.add(evt.AsyncApexJobId);
    }
    
    Map<Id,AsyncApexJob> jobs = new Map<Id,AsyncApexJob>(
        [SELECT id, ApexClass.Name FROM AsyncApexJob WHERE Id IN :asyncApexJobIds]
    );
    
    List<Account> records = new List<Account>();
    for(BatchApexErrorEvent evt:Trigger.new){
        //only handle events for the job(s) we care about
        if(jobs.get(evt.AsyncApexJobId).ApexClass.Name == 'AccountUpdaterJob'){
            for (String item : evt.JobScope.split(',')) {
                Account a = new Account(
                    Id = (Id)item,
                    ExceptionType__c = evt.ExceptionType,
                    Dirty__c = true
                );
                records.add(a);
            }
        }
    }
    update records;
}


*/