import { LightningElement, wire, track } from 'lwc';
import getAllAccountWithContactsList from '@salesforce/apex/AccountContactController.getAccountContactList';
export default class wrapperClassExampleLWC extends LightningElement {
    @track accountsWithContacts;
    @track error;
    @wire(getAllAccountWithContactsList)
    wiredAccountsWithContacts({ error, data }) {
        if (data) {
            this.accountsWithContacts = data;
        } else if (error) {
            console.log(error);
            this.error = error;
        }
    }
}