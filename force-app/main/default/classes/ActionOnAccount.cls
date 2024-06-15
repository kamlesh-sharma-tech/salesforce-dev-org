public class ActionOnAccount {
	@InvocableMethod
    public static List<String> returnAccountName(List<Id> ids){
        List<String> accountNames = new List<String>();
        
        List<Account> accounts = [SELECT Name From Account Where Id in: ids];
        
        for(Account account : accounts){
            accountNames.add(account.Name);
        }
        
        return accountNames;
    }
}