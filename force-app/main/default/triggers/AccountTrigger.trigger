trigger AccountTrigger on Account (before insert, before delete, before update, after insert, after delete, after undelete, after update) {
       
    if(Trigger.isBefore){
            if(Trigger.isInsert || Trigger.isUpdate){
                AccountTriggerHelper.checkDuplicateAccountWithName(Trigger.new);
            }
            /*if(Trigger.isUpdate){
                AccountTriggerHelper.checkDuplicateAccount(Trigger.new);
            }*/
    } 
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            AccountTriggerHelper.createRelatedContact(Trigger.new);
        }
    }
    
}