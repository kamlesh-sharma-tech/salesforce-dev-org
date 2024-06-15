public class OpportunityLineItemTriggerHelper {
	
    public static void sendEmailToOwner(List<OpportunityLineItem> newOppsLineItem){
        
        Set<Id> oppIds = new Set<Id>();
        for(OpportunityLineItem oli : newOppsLineItem){
            oppIds.add(oli.OpportunityId);
        }
        
		Map<Id, Opportunity> opportunities = new Map<Id, Opportunity>([
        SELECT Id, Name, AccountId, OwnerId, Account.Owner.Email FROM Opportunity WHERE Id IN : oppIds
    		]);
    
    	List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    
    	for (OpportunityLineItem oli : newOppsLineItem) {
            Opportunity opp = opportunities.get(oli.OpportunityId);
            
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] { opp.Account.Owner.Email });
            email.setSubject('New Opportunity Line Item Created');
            email.setPlainTextBody('A new line item was created"' + opp.Name + '".');
            emails.add(email);
    	}
    
   		 Messaging.sendEmail(emails);        
        
    }
    
}