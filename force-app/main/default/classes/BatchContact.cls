public class BatchContact implements Database.Batchable<sObject>{
    
   public String query;
   public Database.QueryLocator start(Database.BatchableContext bc){
       if( query == null && String.isBlank(query)){
           query = 'Select Id from Contact';
       }
      return Database.getQueryLocator(query);
   }

   public void execute(Database.BatchableContext bc, List<Contact> scope){
     for(Contact con : scope){
         con.LeadSource = 'Web';
     }
     update scope;
    }

   public void finish(Database.BatchableContext bc){
       System.debug('Contact updated successfully!');
   }
}