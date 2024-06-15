import { LightningElement } from 'lwc';

export default class CreateTask extends LightningElement {
    taskTitle;
    dueDate;
    showDueDate = false;
    showSaveBtn = false;

    handleInputChange(event){
        const fieldName = event.target.name;
        if(fieldName === 'taskTitle'){
            this.taskTitle = event.target.value;
            if(this.taskTitle !== ''){
                this.showDueDate = true;
            }
        }
        else if(fieldName === 'dueDate'){
            this.dueDate = event.target.value;
            if(this.dueDate !== ''){
                this.showSaveBtn = true;
            }
        }
    }
}