import { LightningElement,track } from 'lwc';

export default class RenderCallBackCmp extends LightningElement {
    @track properties;
    @track hasRendered = true;
    renderedCallback(){
        if(this.hasRendered){
            this.properties = 'set by render call back';
            console.log('this.properties'+this.properties);
            this.hasRendered = false;
        }
    }
    handleButtonClick(){
        this.properties = 'set by button click';
    }
    
}