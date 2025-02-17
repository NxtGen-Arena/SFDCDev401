# Interfaces in Salesforce

In Salesforce, interfaces are similar to abstract classes in the sense that they define methods without implementing them. Interfaces are a powerful tool for promoting code reusability, flexibility, and abstraction. 

Salesforce provides several standard interfaces like Comparable, Schedulable, Batchable, and Database.AllowsCallouts for handling sorting, scheduling, batch processing, and making callouts, respectively.

Use interfaces when you need multiple classes to implement similar behavior or when you want to separate the behavior from the class's specific implementation.

## When to Use Interfaces in Apex

* Interfaces in Apex define method signatures without providing an implementation.
* They allow different classes to implement the same method differently, promoting loose coupling and flexibility.
* Useful in scenarios like:
  * Implementing common behaviors across multiple classes.
  * Supporting dependency injection and mocking in unit tests.
  * Enabling dynamic polymorphism, where different objects can be processed in the same way.


## Syntax

``
public interface InterfaceName {
  void method1();
  void method2();
}
``

<h3>Business Case</h3>

A hotel registration system needs different types of registration processes for various customer categories. Some customers might book online, some via phone, and VIP customers may have a special reservation process.

