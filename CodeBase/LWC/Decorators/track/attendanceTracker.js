import { LightningElement,track } from 'lwc';

export default class AttendanceTracker extends LightningElement{

@track attendance={
present:18,
absent:2
};

markAbsent(){

this.attendance.absent++;

this.attendance.present--;

}

}
