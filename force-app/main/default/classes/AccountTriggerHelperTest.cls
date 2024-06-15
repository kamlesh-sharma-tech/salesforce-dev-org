@isTest(SeeAllData=false)
private class AccountTriggerHelperTest{
	@isTest
    private static void checkDuplicateAccountWithNameTest(){
        List<Account> acctList = new List<Account>();
        Account acc1 = new Account(Name = 'Test Account 12');
        Account acc2 = new Account(Name = 'Test Account 2');
        /*insert new List<Account>{acc1,acc2};*/
        acctList.add(acc1);
        acctList.add(acc2);
        insert acctList;
       	
        Account duplicateAccount = new Account(Name = 'Test Account 12');
        
        Test.startTest();
        /*AccountTriggerHelper.checkDuplicateAccountWithName(new List<Account>{duplicateAccount});*/
        insert duplicateAccount;
        Test.stopTest();
        
        duplicateAccount = [SELECT Id, Name FROM Account WHERE Id =: duplicateAccount.Id];
        
        System.assertEquals('Test Account 12', duplicateAccount.Name);  
    }
    
    // @isTest
    // private static void checkDuplicateAccountWithUpdateTest(){
    //     List<Account> acctList = new List<Account>();
    //     Account acc1 = new Account();
    //     acc1.Name = 'Test Account 1';
    //     Account acc2 = new Account();
    //     acc2.Name = 'Test Account 2';
    // }
    
}