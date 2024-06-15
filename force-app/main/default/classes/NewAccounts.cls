public class NewAccounts {
    public static void sObjectsInsert(Integer value){
        Integer counter = 1;
        List<Account> teaFactoryAccounts = new List<Account>();
        while(counter <= value){
            System.debug('Before incrementing '+counter);
            Account acct = new Account();
            acct.Name = 'The Tea Factory ' + counter;
            acct.AccountNumber = '293395'+counter;
            teaFactoryAccounts.add(acct);
            System.debug(teaFactoryAccounts);
            counter = counter+1;
            System.debug('After incrementing '+counter);
        }
        System.debug('List size '+teaFactoryAccounts.size());
        System.debug('Total Items in List '+teaFactoryAccounts);
        insert teaFactoryAccounts;
    }
}