import { LightningElement,api,wire,track } from 'lwc';
import getAllContacts from '@salesforce/apex/AccountHelper.getAllContacts';

export default class LightningDataTableLWCExample extends LightningElement {
    contactList;
    error;
    limit = 5;
    @api myRecordId;
    // @wire(getAllContacts,{lmt: '$limit'})
    // wiredAccounts({
    //     error, data
    // }) {
    //     if(data){
    //         this.contactList = data;
    //     } else if(error){
    //         this.error = error;
    //     }
    // }

    connectedCallback(){
        this.getContacts();
    }

    getContacts(){
        getAllContacts({ lmt: this.limit})
        .then(result => {
            this.contactList = result;
        })
        .catch(error =>{
            this.error = error;
        })
    }

    handleLimit(event){
        this.limit = event.target.value;
        this.getContacts();
    }

    get acceptedFormats() {
        return ['.pdf', '.png'];
    }

    handleUploadFinished(event){
        const uploadFiles = event.detail.files;
        alert('No. of uploaded files '+ uploadFiles.length());
    }

}