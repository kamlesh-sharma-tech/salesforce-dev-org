import { LightningElement,api } from 'lwc';

export default class Pagination extends LightningElement {
    currentPage = 1;
    totalRecords;
    recordSize = 10;

    get records(){
        return this.visibleRecords;
    }

    @api
    set records(data){
        if(data){
            this.totalRecords = data;
            
            // this.totalPage = Math.ceil(data.length/this.recordSize);
            this.updateRecords();
        }
    }

    get totalPage() {
        return Math.ceil(this.totalRecords.length / this.recordSize);
    }

    get pageNumbers() {
        const totalPage = this.totalPage;
        return Array.from({ length: totalPage }, (_, i) => i + 1);
    }

    // get paginationText() {
    //     const startRecord = (this.currentPage - 1) * this.recordSize + 1;
    //     const endRecord = Math.min(this.currentPage * this.recordSize, this.totalRecords.length);
    //     return `Displaying ${startRecord} - ${endRecord} of ${this.totalRecords.length} Page`;
    // }

    previousHandler(){
        if(this.currentPage > 1){
            this.currentPage = this.currentPage - 1;
            this.updateRecords();
        }
    }

    nextHandler(){
        if(this.currentPage < this.totalPage){
            this.currentPage = this.currentPage + 1;
            this.updateRecords();
        }
    }

    navigateToPage(event) {
        this.currentPage = parseInt(event.target.dataset.page, 10);
        this.updateRecords();
    }

    updateRecords(){
        const start = (this.currentPage-1)*this.recordSize;
        const end = Math.min(this.recordSize * this.currentPage, this.totalRecords.length);
        this.visibleRecords = this.totalRecords.slice(start,end);
        this.dispatchEvent(new CustomEvent('update',{
            detail:{
                records:this.visibleRecords
            }
        }))
    }

}