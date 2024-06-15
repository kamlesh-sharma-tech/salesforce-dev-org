@isTest
private class CaseTriggerHelperTest{
   @isTest 
    private static void testUpdateCaseOriginForEscalated(){
        List<Case> caseList = new List<Case>();
        for(Integer i=0;i<2;i++){
            Case c = new Case();
            c.Status = 'Escalated';
            // c.Origin = 'Phone';
            caseList.add(c);
        }
        insert caseList;
        List<Case> result = [SELECT Id,Origin FROM Case WHERE Id =: caseList[0].Id];
        Assert.areEqual(null, caseList[0].Origin);
    }
    
    @isTest 
    private static void testUpdateCaseOriginForNew(){
        List<Case> caseList = new List<Case>();
        for(Integer i=0;i<2;i++){
            Case c = new Case();
            c.Status = 'New';
            // c.Origin = 'Phone';
            caseList.add(c);
        }
        insert caseList;
        List<Case> result = [SELECT Id,Origin FROM Case WHERE Id =: caseList[0].Id];
        Assert.areEqual(null, caseList[0].Origin);
    }
}