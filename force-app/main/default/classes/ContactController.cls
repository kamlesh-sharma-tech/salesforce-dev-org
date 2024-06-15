public with sharing class ContactController {

    // Method for insert or update the record
    @AuraEnabled
    public static ContactWrapper createOrUpdateRecord(String id,String fname, 
    String lname, String email, String phone, String zip) {
        ContactWrapper result = new ContactWrapper();
        try {
            if (String.isNotBlank(id)) {
                Contact existingContact = [SELECT Id FROM Contact WHERE Id = :id LIMIT 1];
                if (existingContact != null) {
                    existingContact.FirstName = fname;
                    existingContact.LastName = lname;
                    existingContact.Email = email;
                    existingContact.Phone = phone;
                    existingContact.MailingPostalCode = zip;
                    update existingContact;
                    result.contactId = existingContact.Id;
                    result.contactFirstName = existingContact.FirstName;
                    result.contactLastName = existingContact.LastName;
                    result.contactEmail = existingContact.Email;
                    result.contactPhone = existingContact.Phone;
                    result.contactZipCode = existingContact.MailingPostalCode;
                } else {
                    // result.status = 'error';
                    // result.message = 'Contact not found for update';
                }
            }else{
                Contact newContact = new Contact();
                newContact.FirstName = fname;
                newContact.LastName = lname;
                newContact.Email = email;
                newContact.Phone = phone;
                newContact.MailingPostalCode = zip;
                insert newContact;
                result.contactId = newContact.Id;
                result.contactFirstName = newContact.FirstName;
                result.contactLastName = newContact.LastName;
                result.contactEmail = newContact.Email;
                result.contactPhone = newContact.Phone;
                result.contactZipCode = newContact.MailingPostalCode;
            } 
        }catch (Exception e) {
            result.contactId = '';
            result.contactFirstName = '';
            result.contactLastName = '';
            result.contactEmail = '';
            result.contactPhone = '';
            result.contactZipCode = '';
        }
        return result;
    }

    @AuraEnabled(cacheable=true)
    public static ContactWrapper fetchContactDetails(String contactId) {
        ContactWrapper contactWrapper = new ContactWrapper();
        Contact contactRecord = [SELECT Id, FirstName, LastName, Email, Phone, MailingPostalCode FROM Contact WHERE Id = :contactId LIMIT 1];
        if (contactRecord != null) {
            contactWrapper.contactId = contactRecord.Id;
            contactWrapper.contactFirstName = contactRecord.FirstName;
            contactWrapper.contactLastName = contactRecord.LastName;
            contactWrapper.contactEmail = contactRecord.Email;
            contactWrapper.contactPhone = contactRecord.Phone;
            contactWrapper.contactZipCode = contactRecord.MailingPostalCode;
        }
        return contactWrapper;
    }

    @AuraEnabled
    public static String deleteContactRecord(String contactId) {
        try {
            Contact contactToDelete = [SELECT Id FROM Contact WHERE Id = :contactId LIMIT 1];
            delete contactToDelete;
            return 'success';
        } catch (Exception e) {
            return 'error';
        }
    }

    // @AuraEnabled
    // public static Contact createContactRecord(String id,String fname, String lname, String email, String phone, String zip){
    //     try {
    //         Contact con = new Contact(
    //             Id = id, 
    //             FirstName = fname,
    //             LastName = lname,
    //             Email = email,
    //             Phone = phone,
    //             MailingPostalCode = zip
    //         );

    //         upsert con;
    
    //         return con;
    //     } catch (DmlException e) {
    //         // Handle any DML exceptions here
    //         System.debug('Error creating/updating contact: ' + e.getMessage());
    //         return null;
    //     }
    // }

    public class ContactWrapper {
        @AuraEnabled public String contactId;
        @AuraEnabled public String contactFirstName;
        @AuraEnabled public String contactLastName;
        @AuraEnabled public String contactEmail;
        @AuraEnabled public String contactPhone;
        @AuraEnabled public String contactZipCode;
    }


    @AuraEnabled(cacheable=true)
    public static List<ContactWrapper> getAllContacts(String sortBy, String sortDirection,String firstName,String lastName,String email, String phone,  String zip) {

        // Integer offset = (currentPage - 1) * recordsPerPage;
        String searchFirstName = '%' + firstName + '%';
        String searchLastName = '%' + lastName + '%';
        String searchEmail = '%' + email + '%';
        String searchPhone = '%' + phone + '%';
        String searchZip = '%' + zip + '%';
        String query = 'SELECT Id, FirstName, LastName, Email, Phone, MailingPostalCode FROM Contact';

        if (String.isNotBlank(firstName) || String.isNotBlank(lastName) || String.isNotBlank(email) || String.isNotBlank(phone) || String.isNotBlank(zip)) {
            query += ' WHERE';
        }

        if (String.isNotBlank(firstName)) {
            query += ' FirstName LIKE :searchFirstName AND';
        }
    
        if (String.isNotBlank(lastName)) {
            query += ' LastName LIKE :searchLastName AND';
        }
    
        if (String.isNotBlank(email)) {
            query += ' Email LIKE :searchEmail AND';
        }
              
        if (String.isNotBlank(phone)) {
            query += ' Phone LIKE :searchPhone AND';
        }
    
        if (String.isNotBlank(zip)) {
            query += ' MailingPostalCode LIKE :searchZip AND';
        }
        query = query.removeEnd('AND');
        
        if (String.isNotBlank(sortBy) && String.isNotBlank(sortDirection)) {
            query += ' ORDER BY ' + sortBy + ' ' + sortDirection;
        }

        // query += ' LIMIT :recordsPerPage OFFSET :offset';
        List<ContactWrapper> contactList = new List<ContactWrapper>();
        for (Contact contactRecord : Database.query(query)) {
            ContactWrapper wrapper = new ContactWrapper();
            wrapper.contactId = contactRecord.Id;
            wrapper.contactFirstName = contactRecord.FirstName;
            wrapper.contactLastName = contactRecord.LastName;
            wrapper.contactEmail = contactRecord.Email;
            wrapper.contactPhone = contactRecord.Phone;
            wrapper.contactZipCode = contactRecord.MailingPostalCode;
            contactList.add(wrapper);
        }
        return contactList;
    }

    @AuraEnabled(cacheable=true)
    public static List<String> getFieldSuggestions(String fieldName, String fieldValue) {
        List<String> suggestions = new List<String>();
        if (fieldName != null && fieldValue != null) {
            String initialsPattern = '%' + fieldValue + '%';
            String query = 'SELECT ' + fieldName + ' FROM Contact WHERE ' + fieldName + ' LIKE :initialsPattern';
            for (Contact record : Database.query(query)) {
                suggestions.add(String.valueOf(record.get(fieldName)));
            }
        }
        return suggestions;
    }

}