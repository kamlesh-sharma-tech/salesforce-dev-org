import { LightningElement, track } from 'lwc';
import getAccountNames from '@salesforce/apex/DataController.getAccountNames';
import getContactNames from '@salesforce/apex/DataController.getContactNames';

export default class RadioSelection extends LightningElement {
    @track options = [
        { label: 'Account', value: 'account' },
        { label: 'Contact', value: 'contact' }
    ];
    @track selectedValue = '';
    @track isLoading = false;
    @track showAccountData = false;
    @track showContactData = false;
    @track accountNames = [];
    @track contactNames = [];

  
    handleRadioChange(event) {
        this.selectedValue = event.detail.value;
        this.isLoading = true;

        if (this.selectedValue === 'account') {
            getAccountNames()
                .then(result => {
                    this.accountNames = result;
                    this.showAccountData = true;
                    this.showContactData = false;
                    this.isLoading = false;
                })
                .catch(error => {
                    console.error(error);
                    this.isLoading = false;
                });
        } 
        else if (this.selectedValue === 'contact') {
            getContactNames()
                .then(result => {
                    this.contactNames = result;
                    this.showAccountData = false;
                    this.showContactData = true;
                    this.isLoading = false;
                    console.log('contactresult',result)
                })
                .catch(error => {
                    console.error('error',error);
                    this.isLoading = false;
                });
        }
    }
}