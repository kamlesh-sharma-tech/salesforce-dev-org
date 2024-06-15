public class AccountOnAction {
	@InvocableMethod
    public static List<String> getAccountNames(List<Id> ids){
        List<String> accountNames = new List<String>();
        for(Account acc : [SELECT Name FROM Account WHERE Id in: ids]){
            accountNames.add(acc.Name);
        }
        return accountNames;
    }
}