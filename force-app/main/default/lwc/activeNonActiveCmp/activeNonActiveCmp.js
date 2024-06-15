import { LightningElement, track, wire } from 'lwc';
import getActiveNonActiveAccountList from '@salesforce/apex/ActiveNonActiveAccount.getActiveNonActiveAccountList';

export default class ActiveNonActiveCmp extends LightningElement {
    @track options = [
        { label: 'Active', value: 'active' },
        { label: 'Non-Active', value: 'nonactive' }
    ];
    @track selectedValue = '';
    @track isLoading = false;
    @track showActiveAccountData = false;
    @track showNonActiveAccountData = false;
    @track activeAccountList;
    @track nonActiveAccountList;

    @wire(getActiveNonActiveAccountList, { status: '$selectedValue'})
    accListValues({ error, data }) {
        console.log('@@@data=',JSON.stringify(data));
        this.isLoading = true;
        if (data) {
            this.isLoading = false;
            if (this.selectedValue == 'active') {
                this.showActiveAccountData = true;
                this.activeAccountList = data;
            } 
            if(this.selectedValue == 'nonactive'){
                this.nonActiveAccountList = data;
            }
        } else if (error) {
            console.log('@@@dataerror=',JSON.stringify(error));
            this.isLoading = false;
        }
    }


    // connectedCallback() {
    //     this.isLoading = true;
    //     getActiveNonActiveAccountList()
    //     .then(result => {
    //         let accountList = result;
    //         console.log('@@result=',JSON.stringify(result));
    //         for(let i = 0; i<accountList.length;i++){
    //             if(accountList[i].isActive){
    //                 this.activeAccountNames.push(accountList[i]);
    //             }
    //             else{
    //                 this.nonActiveAccountNames.push(accountList[i]);
    //             }

    //         }
    //         this.isLoading = false;
    //     })
    //     .catch(error => {
    //         console.error(error);
    //         this.isLoading = false;
    //     });
    // }

    handleRadioChange(event) {
        this.isLoading = true;
        this.selectedValue = event.detail.value;
        if (this.selectedValue === 'active') {
            
                this.showActiveAccountData = true;
                this.showNonActiveAccountData = false;
                this.isLoading = false;
           
                
        } else if (this.selectedValue === 'nonactive') {
           
                this.showActiveAccountData = false;
                this.showNonActiveAccountData = true;
                this.isLoading = false;
            
        } 
    }
}