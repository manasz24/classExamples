Global with sharing class batchClassIItrerable {
    
   global Iterable start(Database.BatchableContext info){ 
    return new CustomAccountIterable(); 
}     
global void execute(Database.BatchableContext info, List<Account> scope){
    List<Account> accsToUpdate = new List<Account>();
    for(Account a : scope){ 
        a.Name = 'true'; 
        a.NumberOfEmployees = 70; 
        accsToUpdate.add(a); 
    } 
    update accsToUpdate; 
}     
global void finish(Database.BatchableContext info){     
} 
}
