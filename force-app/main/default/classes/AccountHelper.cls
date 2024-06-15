public with sharing class AccountHelper {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getAllContacts(Integer lmt){
        return [SELECT Id, FirstName, LastName, Email, Phone, MailingPostalCode FROM Contact LIMIT :lmt]; 
    }
}