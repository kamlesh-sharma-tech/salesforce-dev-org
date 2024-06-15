public class AccountHandler {
    public static List<Account> getAccountList(){
        return [SELECT Id, Name, Phone FROM Account];
    }
    public static Account getAccountByName(String accName){
        return [SELECT Id, Name, Phone FROM Account WHERE Name =: accName];
    }
}