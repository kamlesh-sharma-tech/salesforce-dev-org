import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ComponentA extends LightningElement {
   fullName = '';
   handleNameFromChild(event){
    const { firstName, lastName } = event.detail;
    this.fullName = `${firstName} ${lastName}`;
   }
}