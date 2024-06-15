trigger AccountCustomTrigger on Account (before insert,before update,after update) {
    for(Account acc : Trigger.new){
        if(acc.Industry != null && (acc.Industry=='Banking' || acc.Industry == 'Healthcare')){
            acc.Rating = 'Hot';
        }
    }
}