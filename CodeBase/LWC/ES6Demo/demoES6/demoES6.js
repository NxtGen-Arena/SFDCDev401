import { LightningElement } from 'lwc';

export default class Es6DemoApp extends LightningElement {

    //courses is intialized as an array of  objects - each representing a course
    //this list is being displayed in the <template for:each>
    courses = [
        { id: 1, name: 'LWC Fundamentals' },
        { id: 2, name: 'Apex Basics' }
    ];

    nextId = 3;

    // Arrow function with spread operator
    addCourse = () => {
        //this refers to the component context
        const newCourse = { id: this.nextId++, name: `New Course ${this.nextId}` }; // added at the end of the list
        //The spread operator (...this.courses) is used to create a new array, not mutating old one. Ensuring UI reactivity in LWC
        this.courses = [...this.courses, newCourse];
    }

    // querySelector usage
    highlight() {
        //this.template.querySelector () : allows to safely access DOm inside the componets shadow dom
        const box = this.template.querySelector('.highlight-box');
        box.style.backgroundColor = '#f5f242';
        box.style.fontWeight = 'bold';
    }
}
