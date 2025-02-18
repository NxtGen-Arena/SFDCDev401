# Encapsulation in Apex

<h1>What is Encapsulation</h1>
  
In Apex, encapsulation is the process of binding a variable and a method together in a class to protect the class's variable. It's a way to restrict direct access to some components of an object,
preventing unauthorized parties from accessing the data. 
  
To encapsulate a variable in Apex, you can declare it as private and provide access to it with getter and setter methods. Reason - End user or other apex class is not interested in understanding what's     happening in background operation and we do not want to expose the core logic. Encapsulation helps organize code into modular units, making it easier to understand and manage.

<h1> How Encapsulation Works</h1>
  
Encapsulation involves defining a class with private variables (data members) and public methods (member functions). The private variables can only be accessed and modified within the class itself, while the public methods provide controlled access to these variables from outside the class.

<h1> Why Should I Use Encapsulation? </h1>
  
* Provides namespaces/unique names for application data and functionality making code more manageable. With classes you can group functionality into classes.    
* Protecting data that is read-only or irrelevant to the consumer.
* Control over how variables are managed e.g. validating input before assigning it to a variable.
* Code is easier to read, maintain and extend.

<h1>Benefits of Encapsulation </h1>
  
* **Data Hiding:** Encapsulation hides the internal state of an object, preventing unauthorized access and manipulation.
* **Modularity:** By encapsulating related data and methods within a class, code becomes modular and easier to maintain.
* **Controlled Access**: Encapsulation allows controlled access to data, enforcing validation and business rules through methods.


<h1> References and Further Read</h1>

  1. [Encapsulation demo](/CodeBase/OOPS-in-Apex/EncapsulationDemo.cls)
  2. [Encapsulation](https://www.youtube.com/watch?v=JLF8rpfIYjI)

