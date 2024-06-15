import { LightningElement } from 'lwc';

export default class DataBinding extends LightningElement {
    firstName = '';
    lastName = '';
    email = 'kamlesh@gmail.com';

    handleClick(event){
        var input = this.template.querySelectorAll("lightning-input");
        input.forEach(function(element){
            if(element.name == 'fname'){
                this.firstName = element.value;
            }else if(element.name == 'lname'){
                this.lastName = element.value;
            }else if(element.name == 'email'){
                this.email = element.value;
            }
        },this);
    }
}