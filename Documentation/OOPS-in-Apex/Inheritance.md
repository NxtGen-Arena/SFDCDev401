# What is Inheritance?
Inheritance is a fundamental concept in object-oriented programming (OOP) that allows a class (called a child or subclass) to inherit properties and methods from another class (called a parent or superclass). In Salesforce Apex, inheritance enables developers to create efficient, reusable code by defining common functionality in a parent class and extending or customizing it in child classes.

In Salesforce Apex, inheritance allows one class to inherit the properties and methods of another class. This promotes code reuse, reduces redundancy, and supports the "DRY" (Don't Repeat Yourself) principle. 

Use inheritance when you have common functionality shared between multiple classes. Inheritance helps organize the code and improves maintainability, as changes to common behaviors only need to be made in the base class. Extend class to provide more specialized behaviour using the override keyword in the method definition. 

Overriding a virtual method allows you to provide a different implementation for an existing method. Also referred as Runtime Polymorphism.
This means that the behavior of a particular method is different based on the object you’re calling it on. Class can only Extend only one other class.

> [!Note]
> Apex supports only single inheritance in practice, though you can create class chains that resemble multi-level inheritance.

![image](https://github.com/user-attachments/assets/f2645221-3ae7-45cc-86ef-387ab5783407)


## Inheritance is useful when:
- You have common functionality in multiple classes.
- You want to define a generalized class and have specialized classes extend it.
 - You need to override specific behaviors of a base class in child classes.

## Key Concepts:

*Parent Class (Superclass): A class that defines common attributes and behaviors that are inherited by child classes.
*Child Class (Subclass): A class that extends a parent class, inheriting its attributes and behaviors, and may also add its own unique attributes and behaviors.

**Types of Inheritance in Salesforce Apex:**

There are two main types of inheritance in Salesforce Apex:
1. Single Inheritance
2. Multi-Level Inheritance
   
**1. Single Inheritance:**
In single inheritance, a subclass inherits properties and methods from only one superclass.

Example:

Let’s say we have a superclass called Animal with a method makeSound().
```
public class Animal {
    public void makeSound() {
        System.debug('Generic animal sound');
    }
}
Now, we create a subclass called Dog that inherits from Animal and adds its own method bark().

public class Dog extends Animal {
    public void bark() {
        System.debug('Woof woof');
    }
}
```

In this example, Dog inherits the makeSound() method from Animal, and it also has its own method bark().

**2. Multi-Level Inheritance:**
In multi-level inheritance, a subclass can inherit properties and methods from a superclass, which in turn can inherit from another superclass.

Example:
```
public class Mammal {
    public void giveBirth() {
        System.debug('Giving birth to live young');
    }
}
Now, we’ll create a subclass called Dog that inherits from both Animal and Mammal.

public class Dog extends Animal {
    public void bark() {
        System.debug('Woof woof');
    }
}
In this case, Dog indirectly inherits the giveBirth() method from Mammal through the chain of inheritance (Dog -> Animal -> Mammal).

// Animal superclass
public class Animal {
    public void makeSound() {
        System.debug('Generic animal sound');
    }
}

// Mammal subclass extending Animal
public class Mammal extends Animal {
    public void giveBirth() {
        System.debug('Mammal giving birth to live young');
    }
}

// Dog subclass extending Mammal
public class Dog extends Mammal {
    public void bark() {
        System.debug('Dog barks: Woof woof');
    }
}

// Whale subclass extending Mammal
public class Whale extends Mammal {
    public void swim() {
        System.debug('Whale swimming gracefully');
    }
}
```
