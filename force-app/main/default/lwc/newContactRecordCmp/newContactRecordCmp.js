import { LightningElement,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import createContactRecord from '@salesforce/apex/ContactController.createContactRecord';

export default class NewContactRecordCmp extends LightningElement {
    first_name = '';
    last_name = '';
    email = '';
    phone = '';
    isLoading = false;
    isDisabled = true;
    // @track contactCity = '';
    // @track contactAddress = '';
    // @track contactZip = '';

    handleFirstNameChange(event){
        this.first_name = event.target.value;
        this.validateForm();
    }

    handleLastNameChange(event){
        this.last_name = event.target.value;
        this.validateForm();
    }

    handleEmailChange(event){
        this.email = event.target.value;
        this.validateForm();
    }

    handlePhoneChange(event){
        this.phone = event.target.value;
        this.validateForm();
    }

    // handleCityChange(event){
    //     this.contactCity = event.target.value;
    // }

    // handleAddressChange(event){
    //     this.contactAddress = event.target.value;
    // }

    // handleZipChange(event){
    //     this.contactZip = event.target.value;
    // }

    validateForm() {
        const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        const isEmailValid = emailRegex.test(this.email);
        if (
            this.first_name.length >= 3 &&
            this.last_name.length >= 3 &&
            isEmailValid &&
            this.phone.match(/^\d{10}$/) 
        ) {
            this.isDisabled = false;
        } else {
            this.isDisabled = true;
        }
    }

    createContact(event){

        this.isLoading = true;
        createContactRecord( { fname:this.first_name, lname:this.last_name, email:this.email, phone:this.phone} )
            .then(result => {
            
            this.isLoading = false;
            const event = new ShowToastEvent({
                title: 'Contact created',
                message: 'New Contact '+ this.first_name +' '+ this.last_name +' created.',
                variant: 'success'
            });
            this.dispatchEvent(event);
            
            
            this.first_name = '';
            this.last_name = '';
            this.email = '';
            this.phone = '';
            this.isDisabled = true;
        })
        .catch(error => {
            this.isLoading = false;
            
            console.error('Error creating contact:', error);
        });

    }


}