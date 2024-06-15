import { LightningElement } from 'lwc';
import { loadStyle } from 'lightning/platformResourceLoader';
import FontAwesome from '@salesforce/resourceUrl/FontAwesome';

export default class SupportFooter extends LightningElement {
    connectedCallback() {
        Promise.all([
            loadStyle(this, FontAwesome + '/font-awesome-4.2.0/css/font-awesome.css')
        ]).then(() => {
            // Handle success if needed
            console.log('Styles loaded successfully');
        }).catch(error => {
            console.error('Error loading styles:', error);
        });
    }
}