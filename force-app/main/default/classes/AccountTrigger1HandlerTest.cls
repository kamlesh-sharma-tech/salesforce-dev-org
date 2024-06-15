@isTest
private class AccountTrigger1HandlerTest {
    @isTest 
    private static void testUpdateRating(){
        List<Account> accList = new List<Account>();
        for(Integer i=0;i<5;i++){
            Account acc = new Account();
            acc.Name='Test'+i;
            acc.Industry='Media';
            accList.add(acc);
        }
        insert accList;

        List<Account> updatedAccList = [SELECT Id,Rating FROM Account WHERE Id =: accList[0].Id];

        Assert.areEqual('Hot', updatedAccList[0].Rating);

    }

    @isTest 
    private static void testCopyBillingToShipping(){
        List<Account> accList = new List<Account>();
        for(Integer i=0;i<5;i++){
            Account acc = new Account();
            acc.Name='Test'+i;
            acc.CopyBillingToShipping__c = true;
            acc.BillingCity = 'Jaipur';
            acc.BillingPostalCode = '1234';
            acc.BillingStreet = 'Test Street';
            acc.BillingCountry = 'India';
            acc.BillingState = 'Rajasthan';
            accList.add(acc);
        }
        insert accList;

        List<Account> updatedAccount = [SELECT Id,ShippingState FROM Account WHERE ID =: accList[0].Id];

        Assert.areEqual('Rajasthan', updatedAccount[0].ShippingState);
    }

    @isTest
    private static void testCreatedRelatedContact(){
        List<Account> accList = new List<Account>();
        for(Integer i=0;i<5;i++){
            Account acc = new Account();
            acc.Name = 'Test Account'+i;
            accList.add(acc);
        }
        insert accList;

        List<Account> result = [SELECT Id, Name FROM Account WHERE Id =: accList[0].Id];

        Assert.areEqual('Test Account0', result[0].Name);
    }

}