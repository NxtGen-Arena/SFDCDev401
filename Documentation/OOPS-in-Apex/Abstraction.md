
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

✅ Abstraction hides complex logic but enforces specific functionality in subclasses. <br/>
✅ Abstract classes provide common behavior while forcing subclasses to implement core methods.<br/>
✅ Apex supports both abstract classes and interfaces to enforce structure across related classes.<br/>

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


<h2> Business Case </h2>

### Business Problem
Currently, hotel registrations involve repetitive and inconsistent processes, leading to: 
* Redundant code for different hotel types
* Increased maintenance costs due to lack of a standard structure
* Difficulty in integrating new hotel categories without rewriting significant portions of the code
* Limited scalability for future expansion

### Proposed Solution

Managing hotel registrations efficiently is crucial for hospitality businesses. By implementing abstraction in Salesforce using Apex, we can standardize the hotel registration process while allowing different hotel types (Luxury, Budget) to have customized behaviors. This approach enhances code reusability, maintainability, and scalability, reducing manual effort and improving system efficiency.

By implementing abstraction using an Apex abstract class, we define a standard framework for hotel registrations while allowing different hotel types (Luxury, Budget) to implement their specific registration logic. The approach involves:

* A base abstract class (HotelRegistration) with common attributes and methods.
* Subclasses (LuxuryHotel, BudgetHotel) that implement the core registration logic tailored to their category.
* A structured execution class (HotelDemo) to demonstrate real-world usage.

### Implementation Approach

- Step 1: Define the Abstract Class
  - [HotelRegistration](/CodeBase/Abstraction/HotelRegistration.cls) with common attributes (hotelName, location) and methods (displayHotelDetails(), registerHotel()).
- Step 2: Create Concrete Subclasses
  - [LuxuryHotel](/CodeBase/Abstraction/LuxuryHotel.cls) and [BudgetHotel](/CodeBase/Abstraction/BudgetHotel.cls) implementing registerHotel() according to their category’s specific needs.
- Test the code :
  ```
  // Create a Luxury Hotel
  HotelRegistration luxuryHotel = new LuxuryHotel('Grand Palace', 'New York');
  luxuryHotel.displayHotelDetails();
  luxuryHotel.registerHotel();

  // Create a Budget Hotel
  HotelRegistration budgetHotel = new BudgetHotel('Easy Stay', 'Los Angeles');
  budgetHotel.displayHotelDetails();
  budgetHotel.registerHotel();
  ```

### Use Cases & Scenarios

| Use Case|Description|
|---------|------------|
| New hotel registration| Standardized process for all hotels while allowing category-specific customization.
|Expanding to new hotel types|Easily integrate BoutiqueHotel, ResortHotel, etc., without modifying the existing framework.


<h2> References and Further Reading </h2>
