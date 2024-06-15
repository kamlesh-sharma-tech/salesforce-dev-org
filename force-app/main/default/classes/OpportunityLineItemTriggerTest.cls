@isTest
private class OpportunityLineItemTriggerTest {
	@isTest
    private static void sendEmailToOwnerTest(){
        
        Account acc = new Account();
        acc.Name = 'Test Account 001';
        
        Opportunity opp1 = new Opportunity(
            Name = 'Opportunity 1',
            StageName = 'Closed Won',
            CloseDate = date.today(),
            Discount_Percent__c=40,
            Amount=1000
        );
        insert opp1;
        
        OpportunityLineItem oli = new OpportunityLineItem();
        oli.OpportunityId = opp1.Id;
        oli.Quantity = 2;
       
        Test.startTest();
        insert new List<OpportunityLineItem>{oli};
        Test.stopTest();
         
    }
}