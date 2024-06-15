@isTest
private class ContactControllerTest {
    @isTest 
    private static void testCreateOrUpdateRecord(){

    }

    @isTest 
    private static void testFetchContactDetails(){
        List<Contact> conList = new List<Contact>();
        for(Integer i=0;i<2;i++){
            Contact con = new Contact();
            con.FirstName = 'Test';
            con.LastName = 'Contact';
            con.Email = 'abc@example.com';
            con.Phone = '1234';
            con.MailingPostalCode = '1234';
            conList.add(con);
        }

        insert conList;

        ContactController.ContactWrapper result = ContactController.fetchContactDetails(conList[0].Id);

        Assert.areEqual(conList[0].Id, result.contactId);
    }

    @isTest 
    private static void testDeleteContactRecord(){

    }

    @isTest
    private static void testGetAllContacts(){

    }

    @isTest 
    private static void testGetFieldSuggestions(){

    }
}