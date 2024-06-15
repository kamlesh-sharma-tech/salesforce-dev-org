import { LightningElement,track,api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { openTab } from 'lightning/platformWorkspaceApi';
import getRelatedContacts from '@salesforce/apex/AccountRelatedContactsController.getRelatedContacts';
import noContactFoundMessage from '@salesforce/label/c.No_Contacts_Found';

export default class AccountRelatedContactsLWC extends NavigationMixin(LightningElement) {
    @api title;
    @api viewCount;
    @api recordId;
    @track contacts;
    @track isloading = false;
    @track isExpanded = false;
    @track contactsFound = false;
    @track noContactMessage = noContactFoundMessage;

    connectedCallback() {
        this.contacts = null;
        this.fetchData(this.viewCount);
    }

    fetchData(numberofRecords) {
        getRelatedContacts({ accountId: this.recordId, maxCount: numberofRecords })
            .then(result => {
                this.isloading = true;
                if(result){
                    this.contacts = result;
                    if(this.contacts != null && this.contacts.length > 0){
                        this.contactsFound = true;
                        this.isloading = false;
                    }else{
                        this.contactsFound = false;
                        this.isloading = false;
                    }
                }
            })
            .catch(error => {
                this.error = error;
                this.isloading = false;
            });
    }

    handleNavigateToRecordPage(event) {
        //event.preventDefault();
        const recordIdToNavigate = event.currentTarget.dataset.id;
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordIdToNavigate,
                objectApiName: 'Contact',
                actionName: 'view',
            },
        }).then(generatedUrl => {
            //window.open(generatedUrl);
            openTab({
                url: generatedUrl,
                label: 'Contacts',
                focus: true
           }).catch((error) => {
                console.log(error);
           });
        });
    }

    handleViewLess(){
        this.isExpanded = false;
        this.isLoading = true;
        this.fetchData(this.viewCount);
    }

    handleViewMore(){
        this.isExpanded = true;
        this.isLoading = true;
        this.fetchData(100000);
    }
}