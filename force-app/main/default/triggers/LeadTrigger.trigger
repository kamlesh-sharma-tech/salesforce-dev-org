trigger LeadTrigger on Lead ( before update, before delete, before insert,
                                                after undelete, after update, after delete, after insert) {
                                                      
    if(Trigger.isBefore){
        if(Trigger.IsInsert){
            LeadTriggerHelper.addPrefix(Trigger.new);
        }
    }
   
}