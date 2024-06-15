// contactAccountList.js
import { LightningElement } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import { NavigationMixin } from 'lightning/navigation';


export default class ContactAccountList extends NavigationMixin(LightningElement) {

    // Redirect to all account records page
    redirectToAllAccounts() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'list'
            }
        });
    }
}