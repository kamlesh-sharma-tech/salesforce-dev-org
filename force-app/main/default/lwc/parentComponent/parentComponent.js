import { LightningElement, track } from 'lwc';

export default class ParentComponent extends LightningElement {
    @track firstName = '';
    @track lastName = '';
    @track fullName = '';

    handleFirstNameChange(event) {
        this.firstName = event.target.value;
    }

    handleLastNameChange(event) {
        this.lastName = event.target.value;
    }

    passValuesToChild() {
        this.fullName = `${this.firstName} ${this.lastName}`;
    }
}