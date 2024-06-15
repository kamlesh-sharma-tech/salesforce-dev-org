trigger OpportunityTrigger1 on Opportunity (before insert,before update,before delete,after insert,after update,after delete,after undelete) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            OpportunityTrigger1Handler.updateDesc(Trigger.new);
        }
    }

}