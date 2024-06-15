trigger OpportunityTrigger on Opportunity (before update, before delete, before insert,
                                                after undelete, after update, after delete, after insert) {
	if(Trigger.isAfter){
        
    	if(Trigger.isInsert || Trigger.isUpdate){
        	OpportunityTriggerHelper.method(Trigger.new);
        }
        
    }
}