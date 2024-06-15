import { LightningElement, api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api firstName = '';
    @api lastName = '';
    @api fullName = '';

    connectedCallback() {
        this.updateFullName();
    }

    updateFullName() {
        this.fullName = `${this.firstName} ${this.lastName}`;
    }
}