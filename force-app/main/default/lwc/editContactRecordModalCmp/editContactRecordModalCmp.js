import { LightningElement,api,track } from 'lwc';

export default class EditContactRecordModalCmp extends LightningElement {
    @api contactId; // The Id of the contact being edited
    @track editedFirstName;
    @track editedLastName;
    @track editedEmail;
    @track editedPhone;
    @track showModal = false; // Controls modal visibility

    // Open the modal
    openModal() {
        this.showModal = true;
    }

    // Close the modal
    closeModal() {
        this.showModal = false;
    }

    // Handle input field changes
    handleFirstNameChange(event) {
        this.editedFirstName = event.target.value;
    }

    handleLastNameChange(event) {
        this.editedLastName = event.target.value;
    }

    handleEmailChange(event) {
        this.editedEmail = event.target.value;
    }

    handlePhoneChange(event) {
        this.editedPhone = event.target.value;
    }

    // Handle save button click
    handleSaveClick() {
        // Perform record update logic here using wire service or Apex
        // Then close the modal
        this.closeModal();
    }
}