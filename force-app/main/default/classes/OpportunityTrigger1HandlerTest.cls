@isTest
private class OpportunityTrigger1HandlerTest {
    @isTest 
    static void testUpdateDesc(){
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=0;i<5;i++){
            Opportunity opp = new Opportunity();
            opp.Name='Test Opp'+i;
            opp.Amount = 200000;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();
            oppList.add(opp);
        }
        insert oppList;

        List<Opportunity> updatedOppList = [SELECT Id,Description FROM Opportunity WHERE Id =: oppList[0].Id];

        Assert.areEqual('Hot Opportunity', updatedOppList[0].Description);
    }
}