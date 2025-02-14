# Polymorphism (One name many forms) - Method Overloading (Compile Time Polymorphism)

Polymorphism is a key concept in object-oriented programming (OOP), where a single method can perform different tasks depending on the inputs. 
In Salesforce Apex, polymorphism enables you to write generic code that can work with different types of objects, providing flexibility and reusability in your code.

**Method overloading** -  creating methods with the same name but different parameter lists (different number of parameters, or parameters with different types). 

> [!Note]
> Unlike in some other object-oriented languages, Apex does not support polymorphism through method overriding in the strict sense. Apex primarily uses method overloading for polymorphism. This is 
 particularly useful when you want a method to handle different types of data or varying numbers of inputs in a flexible way.

## When to use Method Overloading - Benefits

**Flexible Behavior:**
When you want a method to handle multiple types of data but perform similar tasks (e.g., printing different types of messages). Method’s core functionality is the same but may vary slightly based on input

**Code Clarity:**
When you want the code to be clean and readable by keeping related logic under the same method name. Avoid having multiple method names like barkLoudly(), barkManyTimes(), etc. Instead, you use the same method name, making the code more intuitive and easier to maintain.

**Improved Reusability:**
Reduces the need to define multiple methods with different names for similar functionality, making the code more reusable.


![image](https://github.com/user-attachments/assets/243cd7a3-492a-4385-8910-ef32bd555595)

