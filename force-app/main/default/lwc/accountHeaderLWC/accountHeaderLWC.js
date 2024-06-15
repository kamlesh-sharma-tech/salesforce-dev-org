import { LightningElement, wire, api } from 'lwc';
import { NavigationMixin } from "lightning/navigation";
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Account.Name';

export default class AccountHeaderLWC extends NavigationMixin(LightningElement) {
  @api recordId;
  @api showRefresh;

  @wire(getRecord, {
    recordId: "$recordId", 
    fields: [NAME_FIELD],
    optionalFields: [],
  })
  accountDetail;

  get isLoading(){
    return (this.accountName == null);
  }

  get accountName(){
    return getFieldValue(this.accountDetail.data, NAME_FIELD);
  }

  handleRefresh(){
    location.reload();
  }
}