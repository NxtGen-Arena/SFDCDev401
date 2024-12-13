# Runtime Polymorphism in Salesforce

In Apex (and object-oriented programming in general), runtime polymorphism is achieved through method overriding, where a subclass provides a specific implementation of a method that is already defined in its parent class.
This allows for dynamic method dispatch, where the method that gets executed depends on the actual type of the object at runtime, not the compile-time type.
This is very useful when you have multiple subclasses that can share the same interface, but the actual behavior depends on the subclass.

## **When to use it: **
Use runtime polymorphism when you have a parent class with a method, and subclasses that need to implement their own versions of that method.

## **How it works:** 
The method in the parent class is declared as virtual (to allow overriding). 
The subclass uses the override keyword to provide a specific implementation. 
When a method is called on a reference of the parent class, the runtime determines which version of the method to invoke based on the actual object type.


