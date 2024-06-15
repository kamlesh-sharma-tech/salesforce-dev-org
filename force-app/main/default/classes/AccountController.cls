public with sharing class AccountController {
    @AuraEnabled(cacheable = true)
    public static List<Account> getAllAccounts(){
        return [SELECT Id, Name, Type, AnnualRevenue, Phone, Website, Rating FROM Account LIMIT 10];
    }
}