public with sharing class AccountRelatedContactsController {
    @AuraEnabled
    public static List<TicketWrapper> getRelatedContacts(String contactId, Integer maxCount){

        String queryString = 'SELECT Id, Name, Title, Department ';
        queryString += 'FROM Contact WHERE ';
        queryString += 'AccountId = :contactId ';
        queryString += 'ORDER BY CreatedDate DESC';

        List<Contact> contacts = (List<Contact>) Database.query(queryString);

        List<Contact> tempList = new List<Contact>();
        if(contacts.size() >= maxCount){
            for(Integer i=0; i<=maxCount-1; i++){
                tempList.add(contacts[i]);
            }
            contacts = tempList;
        }

        List<TicketWrapper> resultContactsList = new List<TicketWrapper>();
        for(Contact contactRecord : contacts){
            TicketWrapper dto = new TicketWrapper();
            dto.id = contactRecord.Id;
            dto.name = contactRecord.Name;
            dto.title = contactRecord.Title;
            dto.department = contactRecord.Department;
            resultContactsList.add(dto);
        }
        return resultContactsList;
    }

    public class TicketWrapper{
        @AuraEnabled
        public  String id;
        @AuraEnabled
        public  String name;
        @AuraEnabled
        public  String title;
        @AuraEnabled
        public  String department;
    }
}
