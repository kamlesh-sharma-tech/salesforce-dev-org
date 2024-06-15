trigger OpportunityLineItemTrigger on OpportunityLineItem (before insert,before update,before delete,after insert,after delete, after undelete, after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            OpportunityLineItemTriggerHelper.sendEmailToOwner(Trigger.new);
        }
    }
}