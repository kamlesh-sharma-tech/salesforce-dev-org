import { LightningElement } from 'lwc';

export default class ShowHideCardCmp extends LightningElement {
    myTitle = 'This is a show hide demo';
    showCard = false;
    showHideLabel = 'Show';
    handleShowBtn(event){
        const label = event.target.label;
        if(label === 'Show'){
            this.showCard = true;
            this.showHideLabel = 'Hide';
        }else{
            this.showCard = false;
            this.showHideLabel = 'Show';
        }
        
        
    }
    
}