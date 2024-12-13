# OOPs Concept in Salesforce

Salesforce Apex is a powerful tool for building flexible solutions within Salesforce. It uses Object-Oriented Programming (OOP) concepts, which are like building blocks for developers. Understanding these concepts is really important for developers to make the most out of Salesforce.By using OOP in Apex, developers can make their code more organized, easier to understand, and simpler to update. This helps them create better solutions for businesses using Salesforce.

Object-Oriented Programming (OOPs) concepts in Salesforce Apex refer to the principles of organizing code around objects, which are like blueprints for creating instances of data. OOPs concepts in Apex include classes, objects, inheritance, encapsulation, and polymorphism, which help in creating modular, reusable, and maintainable code.


## Classes
- Blueprints for making objects. Defines what information an object can hold and what it can do.

## Objects
- Container that holds information and is instanceOf Class.
- Methods and data from Class can be accessed by creating instance of the class.
- Static methods can be accessed without the instance.
- Instance is created using - NEW keyword which allocated Heap memory.
```
Dog myDog = new Dog();  //creating instance of class = object creation
myDog.bark();    //non-static method

Dog.dontBark();   //static method
```




