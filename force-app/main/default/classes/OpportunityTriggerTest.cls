@isTest
private class OpportunityTriggerTest {
	@isTest
    private static void methodTest(){
        Account acc = new Account();
        acc.Name = 'Test New Account 001';
        insert acc;
        
        Opportunity opp1 = new Opportunity(
            Name = 'Opportunity 1',
            AccountId = acc.Id,
            StageName = 'Closed Won',
            CloseDate = date.today(),
            Discount_Percent__c=40,
            Amount=1000
        );
        
        Opportunity opp2 = new Opportunity(
            Name = 'Opportunity 2',
            AccountId = acc.Id,
            StageName = 'Closed Won',
            CloseDate = date.today()+7,
            Discount_Percent__c=50,
            Amount=5000
        );
        
        Test.startTest();
        insert new List<Opportunity>{opp1,opp2};
        Test.stopTest();
        
        Account updatedAccount = [SELECT Id,Min_Date__c , Max_Date__c FROM Account WHERE Id =: acc.Id];
        
        System.assertEquals(opp1.CloseDate,updatedAccount.Min_Date__c);
        System.assertEquals(opp2.CloseDate,updatedAccount.Max_Date__c);
               
    }
}