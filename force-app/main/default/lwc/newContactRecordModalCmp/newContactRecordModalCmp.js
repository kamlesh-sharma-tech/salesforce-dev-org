import { LightningElement,api,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAllContacts from '@salesforce/apex/ContactController.getAllContacts';
import fetchContactDetails from '@salesforce/apex/ContactController.fetchContactDetails';
import deleteContactRecord from '@salesforce/apex/ContactController.deleteContactRecord';
import getFieldSuggestions from '@salesforce/apex/ContactController.getFieldSuggestions';

export default class NewContactRecordModalCmp extends LightningElement {

    visibleContacts;
    @api contactDetails = {};
    isEditMode = false;
    isViewMode = false;
    isLoading = false;
    isShowModal = false;
    isDisabled = true;
    firstname = '';
    lastname = '';
    email = '';
    phone = '';
    zip = '';
    contactFirstName = '';
    contactLastName = '';
    contactEmail = '';
    contactPhone = '';
    contactZipCode = '';
    contacts = [];
    showContacts = [];
    fieldname = '';
    sortDirection = 'DESC';
    sortBy = 'CreatedDate';

    
    // @track currentPage = 1;
    // @track recordsPerPage = 10;
    @track isFirstPage = true;
    @track isLastPage = false
    @track suggestions = [];
    @track showSuggestions = false;

    handleFirstNameChange(event){
        this.firstname = event.target.value;
        this.fieldname = event.target.dataset.id;
        this.fetchSuggestions('firstname', this.firstname);

        this.checkValidity();
    }

    handleLastNameChange(event){
        this.lastname = event.target.value;
        this.fieldname = event.target.dataset.id;
        this.fetchSuggestions('lastname', this.lastname);
        this.checkValidity();
    }

    handleEmailChange(event){
        this.email = event.target.value;
        this.fieldname = event.target.dataset.id;
        this.fetchSuggestions('email', this.email);
        const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        const isEmailValid = emailRegex.test(this.email);
        if(!isEmailValid){
            this.isDisabled = true;
        }else{
            
            this.isDisabled = false;
        }
    }

    handlePhoneChange(event){
        this.phone = event.target.value;
        this.fieldname = event.target.dataset.id;
        this.fetchSuggestions('phone', this.phone);
        if(!this.phone.match(/^\d{10}$/)){
            this.isDisabled = true;
        }else{
            
            this.isDisabled = false;
        }
    }

    handleZipCodeChange(event){
        this.zip = event.target.value;
        this.fieldname = event.target.dataset.id;
        this.fetchSuggestions('MailingPostalCode', this.zip);
        this.checkValidity();
    }

    checkValidity(){ 
        if(
            this.firstname || this.lastname || this.email || this.phone || this.zip
        ){
            this.isDisabled = false;
        }else{
             this.isDisabled = true;
        }
    }

    //To filter the record using input
    filterContacts(){
        this.isLoading = true;

        getAllContacts({sortBy:'',sortDirection:'',firstName:this.firstname, lastName:this.lastname, email:this.email, phone:this.phone, zip:this.zip })
            .then(result => {

                    this.contacts = result;
                    this.isLoading = false;
                
            })
            .catch(error => {
                console.error('Error fetching contacts filter:', error);
                alert(error);
                this.isLoading = false;
            });
    }

    connectedCallback() {
        this.isLoading = true;
        getAllContacts()
        .then(result => {
            this.contacts = result;
            console.log('@contacts -- > ',this.contacts);
            this.isLoading = false;
        })
        .catch(error => {
            console.error('Error fetching contacts load:', error);
            this.isLoading = false;
        });
    }


    // nextPage() {
    //     this.currentPage++;
    //     this.loadRecords();
    // }

    // // Handle previous page button click
    // previousPage() {
    //     if (this.currentPage > 1) {
    //         this.currentPage--;
    //         this.loadRecords();
    //     }
    // }
   

    openContactModal(){
        this.isShowModal = true;
        this.isEditMode = true;
        this.isViewMode = false;
        this.contactDetails = {};
    }

    handleCloseModal(){
        this.isShowModal = false;
    }

    handleContactSaved(event){  
        const savedContact = event.detail;
        
        this.visibleContacts = [savedContact, ...this.visibleContacts];
        this.loadRecords();
    }

    handleSort(event){
        const field = event.currentTarget.dataset.field;
        if (this.sortBy === field) {
            this.sortDirection = this.sortDirection === 'ASC' ? 'DESC' : 'ASC';
        } else {
            this.sortDirection = 'DESC';
        }

        this.sortBy = field;
        this.sortContacts();
    }


    // To sort the contacts asc or desc
    sortContacts(){
        this.isLoading = true;
        getAllContacts({sortBy:this.sortBy, sortDirection:this.sortDirection})
            .then(result => {
                this.contacts = result;
                console.log('@sort contact',result);
                this.isLoading = false;
            })
            .catch(error => {
                console.error('Error fetching contacts:', error);
                this.isLoading = false;
            });
    }


    // To show the specific contact data in the modal as edit clicks    
    editContact(event) {
        this.isLoading = true;
        this.isEditMode = true;
        this.isViewMode = false;
        const contactId = event.currentTarget.dataset.id;
        
        fetchContactDetails({ contactId })
            .then(result => {
                if (result) {
                    
                    this.isLoading = false;
                    this.contactDetails = result; 
                    this.isShowModal = true;
                    
                    
                } else {
                    this.isLoading = false;
                }
            })
            .catch(error => {
                this.isLoading = false;
            });

    }


    // To deleted the contact record as deleted clicks
    handleDeleteContact(event){
        this.isLoading = true;
        const contactId = event.detail.contactId;

        deleteContactRecord({ contactId })
            .then(result => {
                this.isLoading = false;
                if (result === 'success') {
                    const updatedContacts = this.visibleContacts.filter(contact => contact.contactId !== contactId);
                    this.visibleContacts = [...updatedContacts];
                    const event = new ShowToastEvent({
                        title: 'Success',
                        message: 'Contact Deleted Successfully!',
                        variant: 'success'
                    });
                    this.dispatchEvent(event);
                    this.isShowModal = false;
                    
                } else {
                    this.isLoading = false;
                }
            })
            .catch(error => {
                this.isLoading = false;
            });

    }



    deleteContact(event){
        this.isLoading = true;
        const contactId = event.currentTarget.dataset.id;
        
        deleteContactRecord({ contactId })
            .then(result => {
                this.isLoading = false;
                if (result === 'success') {
                    const updatedContacts = this.visibleContacts.filter(contact => contact.contactId !== contactId);
                    this.visibleContacts = [...updatedContacts];
                    const event = new ShowToastEvent({
                        title: 'Success',
                        message: 'Contact Deleted Successfully!',
                        variant: 'success'
                    });
                    this.dispatchEvent(event);
                    
                } else {
                    this.isLoading = false;
                }
            })
            .catch(error => {
                this.isLoading = false;
            });
    }

    showContactData(event){
        this.isLoading = true;
        this.isViewMode = true;
        this.isEditMode = false;
        const contactId = event.currentTarget.dataset.id;

        fetchContactDetails({ contactId })
            .then(result => {
                if (result) {
                    console.log('show contact data',result);
                    this.isShowModal = true;
                    this.isLoading = false;
                    
                    this.contactDetails = result;        
                } else {
                    this.isLoading = false;
                }
            })
            .catch(error => {
                this.isLoading = false;
                console.log('show contact data error',error);
            });
    }


    fetchSuggestions(fieldName, fieldValue) {
        this.isLoading = true;
        if(fieldValue.length >= 3){
        getFieldSuggestions({ fieldName, fieldValue })
            .then(result => {
                this.suggestions = result;
                this.showSuggestions = fieldValue.length > 0 && result.length > 0;
                this.isLoading = false;
            })
            .catch(error => {
                console.error('Error fetching suggestions', error);
                this.isLoading = false;
            });
        }else{
            this.suggestions = [];
            this.showSuggestions = false;
            this.isLoading = false;
        }
        
    }

    selectSuggestion(event) {
        const selectedSuggestion = event.target.textContent;

        if(this.fieldname === 'firstname'){
            this.firstname = selectedSuggestion;
        }
        else if(this.fieldname === 'lastname'){
            this.lastname = selectedSuggestion;
        }
        else if(this.fieldname === 'email'){
            this.email = selectedSuggestion;
        }
        else if(this.fieldname === 'phone'){
            this.phone = selectedSuggestion;
        }
        else if(this.fieldname === 'zip'){
            this.zip = selectedSuggestion;
        }
        
        this.showSuggestions = false;
    };

    updateContactHandler(event){
        this.visibleContacts = [...event.detail.records];
        // console.log(event.detail.records);
    }
    

}