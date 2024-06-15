@isTest
private class DataControllerTest {
    @isTest
    static void testGetAccountNames(){
        List<Account> accList = new List<Account>{
            new Account(Name='Test Account1'),
            new Account(Name='Test Account2')
        };
        insert accList;
        List<Account> result = DataController.getAccountNames();
        Assert.areEqual(2, result.size());
    }

    @isTest 
    static void testGetContactNames(){
        List<Contact> conList = new List<Contact>{
            new Contact(FirstName='Test',LastName='Contact'),
            new Contact(FirstName='Test1',LastName='Contact1')
        };
        insert conList;
        List<Contact> result = DataController.getContactNames();
        Assert.areEqual(2, result.size());

    }
}