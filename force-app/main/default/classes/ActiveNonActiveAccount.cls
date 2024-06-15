public with sharing class ActiveNonActiveAccount {

    @AuraEnabled(cacheable=true)
    public static List<ActiveNonActiveAccountListWrapper> getActiveNonActiveAccountList(String status){

        List<ActiveNonActiveAccountListWrapper> accWrapperList = new List<ActiveNonActiveAccountListWrapper>();
        Boolean activeorInactive = status == 'active'?true:false;
        
        List<Account> accList =  [SELECT Id, Name, AccountActive__c FROM Account  WHERE AccountActive__c=:activeorInactive ];
        if(!accList.isEmpty()){
            for(Account acc : accList){
                ActiveNonActiveAccountListWrapper accWrapper = new ActiveNonActiveAccountListWrapper();
                accWrapper.accName = acc.Name;
                accWrapper.isActive = acc.AccountActive__c;
                accWrapperList.add(accWrapper);
            }
        }  
        return accWrapperList;
    }

    //Wrapper class
    public class ActiveNonActiveAccountListWrapper{
        @AuraEnabled 
        public String accName{get;set;}
        @AuraEnabled
        public Boolean isActive{get;set;}
    }
    
}