public class AccountContactController {
  @AuraEnabled
  public static List<AccountContactListWrapper> getAccountContactList() {
    List<AccountContactListWrapper> accWrapperList = new List<AccountContactListWrapper>();
    List<Account> accList = [
      SELECT
        Id,
        Name,
        BillingState,
        Website,
        Phone,
        (SELECT Id, FirstName, LastName, Name, Email FROM Contacts)
      FROM Account
      LIMIT 5
    ];
    if (!accList.isEmpty()) {
      for (Account acc : accList) {
        AccountContactListWrapper accWrapper = new AccountContactListWrapper();
        accWrapper.accRecord = acc;
        accWrapper.contactList = acc.Contacts;
        accWrapper.contactCount = acc.Contacts.size();
        accWrapperList.add(accWrapper);
      }
    }
    return accWrapperList;
  }

  //Wrapper class
  public class AccountContactListWrapper {
    @AuraEnabled
    public Account accRecord { get; set; }
    @AuraEnabled
    public List<Contact> contactList { get; set; }
    @AuraEnabled
    public Integer contactCount { get; set; }
  }
}