import { LightningElement,track } from 'lwc';

export default class StudentTasks extends LightningElement{

@track tasks=[
{id:1,name:'Complete Assignment'},
{id:2,name:'Attend Weekend Batch'}
];

addTask(){

this.tasks=[
...this.tasks,
{
id:this.tasks.length+1,
name:'Practice LWC'
}
];

}

}
