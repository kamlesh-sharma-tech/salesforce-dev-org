public class LeadTriggerHelper {
    
    public static void addPrefix(List<Lead> newLeads){
        for(Lead l : newLeads){ 
                l.FirstName = 'Dr. ' + l.FirstName; 		
        }
    }
    
}