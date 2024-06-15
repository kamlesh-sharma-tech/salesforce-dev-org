global class UpdateContactAddressBatch implements Database.Batchable<sObject>,Database.Stateful
{
    global String query;
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        if(query == null && String.isBlank(query)){
            query = 'SELECT Id,BillingState,BillingStreet,BillingCity,BillingPostalCode,BillingCountry,' + 
                '(SELECT Id, MailingState,MailingStreet,MailingCity,MailingPostalCode,MailingCountry from Contacts)' +
                'FROM Account WHERE BillingCountry = \'USA\'';
        }
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Account> scope)
    {
        List<Contact> contactList = new List<Contact>();
        for(Account acc : scope){
            for(Contact con : acc.Contacts){
                con.MailingStreet = acc.BillingStreet;
                con.MailingPostalCode = acc.BillingPostalCode;
                con.MailingCountry = acc.BillingCountry;
                con.MailingState = acc.BillingState;
                con.MailingCity = acc.BillingCity;
                contactList.add(con);
            }
        }
        if( contactList!=null && !contactList.isEmpty() ){
            update contactList;
        }
    }
    global void finish(Database.BatchableContext BC) {
    }
}