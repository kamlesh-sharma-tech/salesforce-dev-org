import { LightningElement, api } from 'lwc';

export default class ComponentB extends LightningElement {
   @api firstName = '';
   @api lastName = '';

   handleFirstNameChange(event){
    this.firstName = event.target.value;
   }

   handleLastNameChange(event){
    this.lastName = event.target.value;
   }
   sendNameToParent(){
    const event = new CustomEvent('sendname',{
        detail:{
            firstName: this.firstName,
            lastName: this.lastName
        }
    });
    this.dispatchEvent(event);
   }
}