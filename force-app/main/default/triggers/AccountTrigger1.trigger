trigger AccountTrigger1 on Account (before insert,before update,before delete,after insert,after update,after delete,after undelete) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            AccountTrigger1Handler.updateRating(Trigger.new);
            AccountTrigger1Handler.copyBillingToShipping(Trigger.new);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            AccountTrigger1Handler.createdRelatedContact(Trigger.new);
        }
    }

}