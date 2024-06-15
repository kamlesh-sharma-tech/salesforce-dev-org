public class OpportunityTriggerHelper {
    public static void method(List<Opportunity> newOpps){
        List<Account> accountToBeUpdated = new List<Account>();
        Set<Id> accountIds = new Set<Id>();
        for(Opportunity opp : newOpps){
            accountIds.add(opp.AccountId);
        }
        for(AggregateResult minMaxDate : [
            Select AccountId, min(CloseDate)minDate, max(CloseDate)maxDate From Opportunity Where AccountId IN:accountIds GROUP BY AccountId
        ]){
            Account acc = new Account();
            acc.Id = (Id)minMaxDate.get('AccountId');
            acc.Min_Date__c = (date)minMaxDate.get('minDate');
            acc.Max_Date__c = (date)minMaxDate.get('maxDate');
            accountToBeUpdated.add(acc);
        }
        update accountToBeUpdated;
    }
}