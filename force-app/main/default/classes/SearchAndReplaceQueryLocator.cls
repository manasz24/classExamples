public with sharing class SearchAndReplaceQueryLocator {
    public SearchAndReplaceQueryLocator(String q, String e, String f, String v){

        Query=q; Entity=e; Field=f;Value=v;
     }


     global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
     }
  
     global void execute(Database.BatchableContext BC, List<sObject> scope){
       for(sobject s : scope){
       s.put(Field,Value); 
       }
       update scope;
      }
  
     global void finish(Database.BatchableContext BC){
     }
  
}
