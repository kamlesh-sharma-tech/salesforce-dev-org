public with sharing class DataController {
    @AuraEnabled
    public static List<Account> getAccountNames() {

        return [SELECT Id, Name FROM Account order by Name asc LIMIT 5];
    }

    @AuraEnabled
    public static List<Contact> getContactNames() {

        return [SELECT Id,FirstName,LastName FROM Contact order by Name asc LIMIT 5];  
    }
}