public class AccountUpdateClass {
    public void updateAccount(Id accountId){
        Account account = [SELECT Name FROM Account WHERE Id = :accountId];
        account.Name = account.Name + ' - MyFirstAccount';
        update account;
    }
}