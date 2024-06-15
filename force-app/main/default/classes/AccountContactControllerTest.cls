@isTest
private class AccountContactControllerTest {
    @isTest 
    static void testGetAccountContactList(){
         List<Account> accList = new List<Account>();
         for(Integer i=0;i<5;i++){
             Account acc = new Account(
                 Name = 'Test Account '+i,
                 BillingState = 'RJ',
                 Website = 'example.com',
                 Phone = '12345'
             );
             accList.add(acc);
         }
         insert accList;

         List<Contact> conList = new List<Contact>();
         for(Integer i=0;i<5;i++){
             Contact con = new Contact(
                 FirstName = 'Test'+i,
       	         LastName = 'Account'+i,
                 Email = 'abc.contact'+i+'@gmail.com',
                 AccountId = accList[i].Id
             );
             conList.add(con);
         }
         insert conList;

        Test.startTest();
        List<AccountContactController.AccountContactListWrapper> result = AccountContactController.getAccountContactList();
        Test.stopTest();

        Assert.areEqual(5, result.size());
    }
}