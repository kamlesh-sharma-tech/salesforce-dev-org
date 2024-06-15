trigger CaseTrigger on Case (before insert,before update) {
    for(Case c : Trigger.new){
        if(c.Status == 'Escalated'){
            c.Origin = 'Web';
        }else{
            c.Origin = 'Phone';
        }
    }
}