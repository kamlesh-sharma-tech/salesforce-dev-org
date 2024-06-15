public class AccountTriggerHelper {
   
   public static void checkDuplicateAccountWithName(List<Account> newAccounts){
        Set<String> accountName = new Set<String>();
        for(Account accVar : newAccounts){
            accountName.add(accVar.Name);
        }
        List<Account> duplicateAccounts = [SELECT Id,Name 
                                             FROM Account 
                                             WHERE Name IN :accountName];
        
       	for(Account acc : duplicateAccounts){ 
            if(duplicateAccounts.size() > 0){
                acc.Name.addError('Account cannot be inserted with same name!');
            }
        }
       
    }
    public static void createRelatedContact(List<Account> accList){
        List<Contact> conList = new List<Contact>();
        for(Account acc : accList){
            Contact c = new Contact();
            c.LastName = acc.Name;
            c.AccountId = acc.Id;
            conList.add(c);
        }
        if(!conList.isEmpty()){
            insert conList;
        }
    }
}