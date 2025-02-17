
# Abstraction in Apex

## Why Abstraction?

Abstraction is a principle of Object-Oriented Programming (OOP) where we hide implementation details and expose only relevant functionalities. In Apex, we achieve abstraction using abstract classes and interfaces.

Abstraction is a design pattern used in Apex programming to hide complexity and provide functionality for a class. 
It is useful when multiple classes have methods that share similar logic or when there is a possibility of adding new methods in the future. 
The main advantage of using an abstract class is that it enables seamless updating of the logic for all its child classes (with the exception of overrides) - you only need to change the implementation in the abstract class. Using an abstract class also helps to keep code DRY (Don't Repeat Yourself) and easier to maintain.

In Apex, abstraction is a fundamental concept that allows developers to hide complex implementation details while providing essential functionalities to users. It enables developers to focus on what an object does rather than how it does it, promoting clarity, simplicity, and maintainability in code.

## What is Abstract class?
An abstract class is a class that contains at least one abstract method, which is a method without a body (implementation). 
An abstract class cannot be instantiated on its own, but it can be inherited by other classes. 
When a class extends an abstract class, it must provide an implementation for all the abstract methods that are defined in the abstract class, otherwise, it should also be declared as an abstract class.

## Considerations for Abstract
**Abstract classes can have both abstract and non-abstract methods:** In addition to abstract methods, abstract classes can also have non-abstract methods with an implementation. These methods can be called from the inheriting classes without any modifications.

**Abstract classes can have constructors:** Abstract classes can have constructors that are called when an instance of the inheriting class is created. However, the constructor of an abstract class cannot be called directly, but only through the constructor of the inheriting class.

**Abstract classes can implement interfaces:** An abstract class can implement one or more interfaces. In this case, the abstract class must provide an implementation for all the methods defined in the interface(s) it implements.

**Abstract classes can provide default implementations for methods:** Since Java 8, abstract classes can provide default implementations for methods. These methods can be overridden by the inheriting classes, but they provide a default behaviour that can be used if no overriding is needed.

**Abstract classes can have final methods:** Abstract classes can also have final methods that cannot be overridden by the inheriting classes. This can be useful if the abstract class wants to enforce a specific behaviour that should not be changed by the inheriting classes.

## Summary
* Define: public abstract class MyAbstractClass {}.
* Use: public class MyChildClass extends MyAbstractClass {}.
* child classes inherit all the methods and properties of the extended class.
* can contain virtual and abstract methods.
* abstract class is child super-type.
* cannot be initialized.
* class can extend only one abstract class.

<h2> References and Further Reading </h2>

1. Refer Sample Class -
  1.1. [HotelRegistration.cls](/CodeBase/Abstraction/HotelRegistration.cls)
  1.2. [LuxuryHotel.cls](/CodeBase/Abstraction/LuxuryHotel.cls)
  1.3. [BudgetHotel.cls](/CodeBase/Abstraction/BudgetHotel.cls)



