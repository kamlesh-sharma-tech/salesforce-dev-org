import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createOrUpdateRecord from '@salesforce/apex/ContactController.createOrUpdateRecord';
export default class ContactRecordModal extends LightningElement {
    @api contactDetails;
    @api isEditMode;
    @api isViewMode;
    contactId = '';
    first_name = '';
    last_name = '';
    email = '';
    phone = '';
    zipCode = '';
    zipCodeErrorMessage = '';
    selectedCountry = 'USA';
    isFirstNameError = false;
    isLastNameError = false;
    isEmailError = false;
    isPhoneError = false;
    isZipCodeError = false;
    isLoading = false;
    isDisabled = true;

    countryOptions = [
        { label: 'USA', value: 'USA' },
        { label: 'Canada', value: 'Canada' }
    ];

    connectedCallback(){
        if(this.contactDetails){
            this.contactId = this.contactDetails.contactId;
            this.first_name = this.contactDetails.contactFirstName;
            this.last_name = this.contactDetails.contactLastName;
            this.email = this.contactDetails.contactEmail;
            this.phone = this.contactDetails.contactPhone;
            this.zipCode = this.contactDetails.contactZipCode;
        }else{
            this.contactId = '';
            this.first_name = '';
            this.last_name = '';
            this.email = '';
            this.phone = '';
            this.zipCode = '';
        }
    }

    handleFirstNameChange(event){
        this.first_name = event.target.value;
        if (this.first_name.length < 3){
            this.isDisabled = true;
            this.isFirstNameError = true;
        }else{
            this.isDisabled = false;
            this.isFirstNameError = false;
        } 
    }

    handleLastNameChange(event){
        this.last_name = event.target.value;
        if (this.last_name.length < 3){
            this.isDisabled = true;
            this.isLastNameError = true;
        }else{
            this.isDisabled = false;
            this.isLastNameError = false;
        }   
    }

    handleEmailChange(event){
        this.email = event.target.value;
        const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        const isEmailValid = emailRegex.test(this.email);
        if (!isEmailValid){
            this.isDisabled = true;
            this.isEmailError = true;
        }else{
            this.isDisabled = false;
            this.isEmailError = false;
        }
    }

    handlePhoneChange(event){
        this.phone = event.target.value;
        if (!this.phone.match(/^\d{10}$/)){
            this.isDisabled = true;
            this.isPhoneError = true;
        }else{
            this.isDisabled = false;
            this.isPhoneError = false;
        }
    }

    handleCountryChange(event){
        this.selectedCountry = event.target.value;
        this.validateForm();
    }

    handleZipCodeChange(event){
        this.zipCode = event.target.value;
        this.validateForm();
    }

    validateForm() {
        const usaZipCodePattern = /^[0-9]{5}(?:-[0-9]{4})?$/;
        const canadaZipCodePattern = /^[A-Za-z]\d[A-Za-z]\d[A-Za-z]\d$/;
        
        const isValidZipCode = this.selectedCountry === 'USA'
                ? usaZipCodePattern.test(this.zipCode)
                : canadaZipCodePattern.test(this.zipCode);
        if (isValidZipCode) {
            this.isDisabled = false;
            this.isZipCodeError = false;
        } else {
            this.isDisabled = true;
            this.isZipCodeError = !isValidZipCode;
            this.zipCodeErrorMessage = this.selectedCountry === 'USA' ? "invalid usa zip code" : "Invalid canada zip code";
        }
    }

    editContact(){
        this.isEditMode = true;
        this.isViewMode = false;
    }

    handleDeleteClick(event){
        const contactId = this.contactDetails.contactId;
        const deleteEvent = new CustomEvent('deletecontact',{
            detail:{
                contactId : contactId
            }
        });
        this.dispatchEvent(deleteEvent);
    }

    hideModalBox(){
        const closeModalEvent = new CustomEvent('closemodal');
        this.dispatchEvent(closeModalEvent);
        
    }

    createContact(event){

        this.isLoading = true;
        createOrUpdateRecord( { id:this.contactDetails.contactId, fname: this.first_name, lname: this.last_name, email: this.email, phone:this.phone, zip:this.zipCode } )
            .then(result => {

                this.isLoading = false;
                alert(result);

                const closeModalEvent = new CustomEvent('closemodal');
                this.dispatchEvent(closeModalEvent);

                const contactSavedEvent = new CustomEvent('contactsaved', {
                    detail: result
                });
                this.dispatchEvent(contactSavedEvent);
                
                const event = new ShowToastEvent({
                    title: 'Contact created',
                    message: 'New Contact '+ this.first_name +' '+ this.last_name +' created.',
                    variant: 'success'
                });
                this.dispatchEvent(event);
            
        })
        .catch(error => {
            this.isLoading = false;
            
            console.error('Error creating contact:', error);
        });

    }

}