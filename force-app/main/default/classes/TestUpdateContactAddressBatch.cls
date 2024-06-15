@isTest
private class TestUpdateContactAddressBatch {
    @testSetup
    static void setupMethod(){
        Account testAccount = new Account(
            Name = 'Test Account',
            BillingStreet = '123 Test St',
            BillingCity = 'Test City',
            BillingState = 'Test State',
            BillingPostalCode = '12345',
            BillingCountry = 'USA'
        );
        insert testAccount;
        
        Contact testContact1 = new Contact(
            FirstName = 'Test',
            LastName = 'Contact 1',
            AccountId = testAccount.Id
        );
        Contact testContact2 = new Contact(
            FirstName = 'Test',
            LastName = 'Contact 2',
            AccountId = testAccount.Id
        );
        insert new List<Contact>{testContact1, testContact2};
    }
    @isTest
    static void testBatchExecution() {
        
        Account testAccount = [SELECT Id FROM Account where name ='Test Account' limit 1];
        
        // Start the batch job
        Test.startTest();
        UpdateContactAddressBatch batchJob = new UpdateContactAddressBatch();
        Database.executeBatch(batchJob);
        Test.stopTest();
        
        // Verify that Contact mailing addresses have been updated
        List<Contact> updatedContacts = [SELECT Id, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry
                                         FROM Contact WHERE AccountId = :testAccount.Id];
        for (Contact con : updatedContacts) {
            System.assertEquals('123 Test St', con.MailingStreet);
            System.assertEquals('Test City', con.MailingCity);
            System.assertEquals('Test State', con.MailingState);
            System.assertEquals('12345', con.MailingPostalCode);
            System.assertEquals('USA', con.MailingCountry);
        }
    }
}