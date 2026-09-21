import { LightningElement,wire } from 'lwc';

import getInstitutes from '@salesforce/apex/InstituteController.getInstitutes';

export default class InstituteList extends LightningElement{

@wire(getInstitutes)

institutes;

}
