@isTest
private class LeadTriggerTest {
	@isTest
    private static void addPrefixTest(){
        List<Lead> leadList = new List<Lead>();
        
        Lead l1 = new Lead();
        l1.FirstName = 'John';
        l1.LastName = 'Doe';
        l1.Email = 'john123@gmail.com';
        l1.Company = 'In Time Tec';
        
        Lead l2 = new Lead();
        l2.FirstName = 'Mark';
        l2.LastName = 'Wood';
        l2.Email = 'mw123@gmail.com';
        l2.Company = 'Appsavio';
        
        leadList.add(l1);
        leadList.add(l2);
              
        Test.startTest();
        /* LeadTriggerHelper.addPrefix(new List<Lead>{l1}); */
        insert leadList;
        Test.stopTest();
        
        l1 = [SELECT Id,FirstName FROM Lead Where Id =: l1.Id];
        l2 = [SELECT Id,FirstName FROM Lead Where Id =: l2.Id];
        
        System.assertEquals('Dr. John',l1.FirstName);
        System.assertEquals('Dr. Mark',l2.FirstName);
             
    }
}