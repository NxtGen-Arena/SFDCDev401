import { LightningElement, api } from 'lwc';

export default class CourseTile extends LightningElement {
    @api courseName; // Public property from parent
}
