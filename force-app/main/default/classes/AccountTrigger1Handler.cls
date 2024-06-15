public class AccountTrigger1Handler {
    public static void updateRating(List<Account> accList){
        for(Account acc : accList){
            if(acc.Industry == 'Media' || acc.Industry == 'Energy'){
                acc.Rating = 'Hot';
            }
        }
    }

    public static void copyBillingToShipping(List<Account> accList){
        for(Account acc : accList){
            if(acc.CopyBillingToShipping__c && acc.BillingState != null){
                acc.ShippingCity = acc.BillingCity;
                acc.ShippingCountry = acc.BillingCountry;
                acc.ShippingPostalCode = acc.BillingPostalCode;
                acc.ShippingState = acc.BillingState;
                acc.ShippingStreet = acc.BillingStreet;
            }
        }
    }

    public static void createdRelatedContact(List<Account> accList){
        List<Contact> conList = new List<Contact>();

        for(Account acc : accList){
            Contact con = new Contact();
            con.LastName = 'Test Contact';
            con.AccountId = acc.Id;
            conList.add(con);
        }
        if(!conList.isEmpty()){
            insert conList;
        }
    }

}