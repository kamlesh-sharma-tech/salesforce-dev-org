@isTest
private class AccountHandlerTest {
    @isTest
    static void testGetAccountList(){
        List<Account> accList = new List<Account>{
            new Account(Name='Account 1',Phone='38539393'),
            new Account(Name='Account 2',Phone='20103833')
        };
        insert accList;

        Test.startTest();
        List<Account> result = AccountHandler.getAccountList();
        Test.stopTest();
        Assert.areEqual(2, result.size());
    }
    @isTest 
    static void testGetAccountByName(){
        Account acc = new Account(Name='Test Account');
        insert acc;
        Test.startTest();
        Account result = AccountHandler.getAccountByName(acc.Name);
        Test.stopTest();
        Assert.areEqual('Test Account', result.Name);
    }
}