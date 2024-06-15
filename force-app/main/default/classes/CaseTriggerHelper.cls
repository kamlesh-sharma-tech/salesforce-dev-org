public class CaseTriggerHelper {

    public static void updateCaseOrigin(List<Case> caseList){
        for(Case c : caseList){
            if(c.Status == 'Escalated'){
                c.Origin = 'Web';
            }else{
                c.Origin = 'Phone';
            }
        }
    }

    public static void createRelatedContact(List<Case> caseList){
        List<Contact> conList = new List<Contact>();
        for(Case c : caseList){
            Contact con = new Contact();
            con.LastName = 'Case Name';
            // con.Cases = c.Id;
            conList.add(con);
        }
        if(!conList.isEmpty()){
            insert conList;
        }
    }

}