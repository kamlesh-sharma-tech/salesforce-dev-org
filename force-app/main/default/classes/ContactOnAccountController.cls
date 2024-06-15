public with sharing class ContactOnAccountController {
    @AuraEnabled 
    public static List<Contact> getAllContacts(String recordId){
        return [SELECT FirstName,LastName FROM Contact Where AccountId =: recordId];
    }
}