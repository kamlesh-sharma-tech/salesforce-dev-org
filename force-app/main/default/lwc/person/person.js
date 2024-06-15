import { LightningElement,api,track } from 'lwc';

export default class Person extends LightningElement {
    @api setLocation;
    @track user = {
        firstName : 'Kamlesh',
        lastName : 'Sharma'
    }

    @api updateUser(){
        console.log('function called');
        // this.user = {
        //     firstName : 'Rohit',
        //     lastName : 'Sharma'
        // }
        this.user.firstName = 'Ayush';
    }
}