@isTest
public class AccountUpdateClassTest {
	@isTest
    public static void updateAccountTest(){
        Account account = new Account();
        account.Name = 'Test Account';
        insert account;
        
        AccountUpdateClass accUpdtCls = new AccountUpdateClass();
        accUpdtCls.updateAccount(account.Id);
        
        account = [SELECT Name FROM Account WHERE Id = :account.Id];
        System.assertEquals('Test Account - MyFirstAccount',account.Name);
    }
}