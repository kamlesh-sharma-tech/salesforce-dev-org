public class OpportunityBatch implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc){
        Date todaysDate = Date.today();
        String query = 'SELECT Id, CloseDate, StageName FROM Opportunity WHERE StageName != \'Closed Won\' AND StageName != \'Closed Lost\' AND CloseDate <: todaysDate  ';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc,List<Opportunity> scope){
        List<Opportunity> opptList = new List<Opportunity>();
        for(Opportunity opps : scope){
            opps.CloseDate = Date.today() + 7;
            opptList.add(opps);
        }
        update opptList;
        
    }
    
    public void finish(Database.BatchableContext bc){
        
    }
    
}