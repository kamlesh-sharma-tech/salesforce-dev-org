public class ContactRelatedToAccountsCtrl {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getRelatedContacts(String recordId){
        return [SELECT Id, LastName, Email, LeadSource FROM Contact WHERE AccountId =: recordId];
    }
}