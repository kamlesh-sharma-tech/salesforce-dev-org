import { LightningElement,api,wire } from 'lwc';
import getRelatedContacts from '@salesforce/apex/ContactRelatedToAccountsCtrl.getRelatedContacts';

export default class ContactRelatedToAccountsLwcCtrl extends LightningElement {
    contacts=[];
    @api recordId;
    
    connectedCallback(){
        getRelatedContacts( {recordId : this.recordId} )
        .then(result => {
            this.contacts = result;
        })
        .catch(error=>{
            
        });
}
}