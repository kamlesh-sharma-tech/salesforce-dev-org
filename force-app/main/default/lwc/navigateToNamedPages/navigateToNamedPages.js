import { LightningElement } from 'lwc';
import {NavigationMixin} from 'lightning/navigation';

export default class NavigateToNamedPages extends NavigationMixin(LightningElement) {

    navigateToChatter(){
        this[NavigationMixin.Navigate]({
            type: 'standard__namedPage',
            attributes:{
                pageName : 'chatter'
            }
        })
    }

    redirectToReport(evt) {
        evt.preventDefault();
        evt.stopPropagation();
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: '00O2w00000EL3lJEAT',
                objectApiName: 'Report',
                actionName: 'view'
            }
        });
    }

}