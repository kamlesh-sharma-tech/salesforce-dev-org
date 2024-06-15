public class OpportunityTrigger1Handler {
    public static void updateDesc(List<Opportunity> oppList){
        for(Opportunity opp : oppList){
            if(opp.Amount >= 100000 && opp.Amount <= 500000){
                opp.Description = 'Hot Opportunity';
            }
        }
    }
}