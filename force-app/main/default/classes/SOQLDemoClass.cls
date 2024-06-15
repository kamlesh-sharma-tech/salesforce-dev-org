public class SOQLDemoClass {
    public static void getData(){
        
        /*
         List<Account> accList = new List<Account>();
        accList = [SELECT Id,Name,Rating FROM Account WHERE
                  Rating='Hot'];
        for(Account acc : accList){
            System.debug(acc);
        }
		*/
        
        
        /*
         Account acc = [SELECT Id,Name FROM Account WHERE Name='My New Account' LIMIT 1];
        System.debug('@id -- >'+acc.Id);
        System.debug('@name -- >'+acc.Name);
		*/
        
        //Child to Parent Query (Standard Object)
        //Contact(Child) -> Account(Parent)
        
        List<Contact> contactList = new List<Contact>();
        contactList = [SELECT Id,Name FROM Contact];
        
            
            
            
            
            
            
            
            
            
        
    }
}