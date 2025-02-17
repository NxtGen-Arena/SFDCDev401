# Polymorphism in Apex

## Introduction
Classes to understand Compile Time (Method Overloading) and Run Time Polymorphism (Method Overriding) in Apex. 

## Table of contents

1. [Hotel Registration](#HotelRegistration.cls) - This is a parent class containing base functionality for registration
2. [RegularCustomerRegistration](#RegularCustomerRegistration.cls) - (inherits from HotelRegistration and overrides discount logic
3. [CorporateCustomerRegistration](#CorporateCustomerRegistration.cls) - (inherits from HotelRegistration and applies a corporate discount).

# Detailed Explanation

This implementation of polymorphism in Apex successfully demonstrates:

* Method Overloading (Compile-time Polymorphism) to handle different discount scenarios.
* Method Overriding (Runtime Polymorphism) to allow subclass-specific discount logic.


<h3> Method Overloading (Compile-time Polymorphism)</h3>
✅ Multiple calculateDiscount methods have the same name but accept different parameter types:

* No parameters → Default discount.
* String parameter → Discount for customer types.
* Integer parameter → Age-based discount.
* Two parameters → Membership-based discount.
* Boolean & Integer → Corporate discount.

✅ Based on the method signature, the correct method is called at compile-time.

<h3> Method Overriding (Runtime Polymorphism)</h3>

✅ We use method overriding by defining a calculateDiscount() method in child classes (RegularCustomerRegistration and CorporateCustomerRegistration). <br/>
✅ The overridden methods provide custom discount calculations based on the customer type.<br/>
✅ The method that gets executed is determined at runtime, based on the actual object type (RegularCustomerRegistration or CorporateCustomerRegistration).

