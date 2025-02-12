# Constructors and Methods

Constructors and Methods helps initialize data and process calculations. Access modifiers for classes, methods and variables control the visibility and accessibility of classes, variables, and methods in Apex. They ensure encapsulation and help in enforcing data hiding and abstraction principles.

Helps Break down complex functionalities into smaller, modular components (classes and methods) for better maintainability and reusability.

<h2>Constructors</h2>
A constructor is a special method that is invoked when an object of a class is created. It is used to initialize the object’s state. In Apex, constructors have the same name as the class and do not have a return type. There are two types of constructors: default constructor and parameterized constructor.

You do not need to write a constructor for every class. If a class doesn't have a user-defined constructor, a default, no-argument constructor with the same visibility as the containing class is generated.

>[!Important]
>Construtor has same name as class and never has an explicit return type and it is not inherited by the object created from it.
>When you define class you define a new data type like any other data types in Salesforce. So, you can use the class name in any place.


<img width="276" alt="image" src="https://github.com/user-attachments/assets/deab985a-7ee5-43c6-9273-6601a7281cb9" />


## Things to note

* If you write a constructor that takes arguments, you can then use that constructor to create an object using those arguments.
* If you create a constructor that takes arguments, and you still want to use a no-argument constructor, you must create your own no-argument constructor in your code. After you create a constructor for a class, you no longer have access to the default, no-argument public constructor.
* In Apex, a constructor can be overloaded, that is, there can be more than one constructor for a class, each having different parameters.
* you must use the _new_ keyword in order to instantiate an object from that class, using that constructor.
* Every constructor created for a class must have a different argument list.

## Default Constructor
If a class does not have any constructors defined, Apex provides a default constructor with no parameters.Once you create a constructor for a class, you no longer have access to the default, no-argument public constructor. You need manually define the no-argument constructor explicitly in class.

```
public class CustomerRegistration {
 // Default constructor
 public CustomerRegistration() {
 // Initialization code here
 }
}
```

## Parameterized Constructor
A parameterized constructor accepts parameters to initialize the object’s state. It allows you to pass values during object creation. 

```
public class StaffRegistration {
  // Default constructor
  public String firstName;
  public String lastName;
  public Account hotelName;
  public String department;
  public Boolean isActive = true;
  public MyClass(String firstName, String lastName, Account hotel, String department) {
    // Initialization code here
    this.firstName = firstName;
    this.lastName = lastName;
    this.hotel = hotel;
    this.department = department;
  }
}
```
##  Constructor Overloading
Constructor can be overloaded which means you can create define more than one constructor for a class, each having different parameters. 

##  Constructor Chaining
One constructor calls another constructor using the this(...) syntax


## Constructor in Action
<img width="437" alt="image" src="https://github.com/user-attachments/assets/e2cef7a9-0c33-4842-a156-3a0e160d7c9f" />


<h2>Methods</h2>

Methods are functions defined within a class that perform specific actions or provide functionality related to the class. They can access and manipulate the properties of the class. Methods in Apex can have access modifiers (public, private, global) to control their visibility and accessibility, Can be recursive, can call other methods. Methods can be overloaded, Can have statements where the return values are run as a statement if their results aren’t assigned to another variable.

![image](https://github.com/user-attachments/assets/5f1bbe32-f09b-4af5-8bb4-fd506147ef00)

### Method Structure

* Access Modifier (Optional): Modifiers, such as public or protected
* Return Type (Required): Data type of value returned by method. Void in case method doesn’t return value.
* Name (Required): The keyword class followed by the name of the method
* Input Parameters (Optional): Comma separated list of input parameters. Max 32 params, if no params ()

![image](https://github.com/user-attachments/assets/a640aed4-6909-4898-98f9-6c425baa3b56)

### Class Methods
Class can have static, instance methods.

![image](https://github.com/user-attachments/assets/5dae6ead-1979-4a38-a475-4adbaaad013e)


### Method Access Modifiers

**Public Methods**
Public methods are accessible from outside the class. They can be invoked by other classes or triggers. Public methods are typically used to expose functionality to other parts of the application

```
public class StaffRegistration {
  // Default constructor
  public String firstName;
  public String lastName;
  public Account hotelName;
  public String department;
  public Boolean isActive = true;
  public MyClass(String firstName, String lastName, Account hotel, String department) {
    // Initialization code here
    this.firstName = firstName;
    this.lastName = lastName;
    this.hotel = hotel;
    this.department = department;
  }

  public boolean registerStaff()
  {
    //registration logic
  }
}
```

**Private Methods**
Private methods are only accessible within the class in which they are defined. They cannot be invoked from outside the class. Private methods are useful for encapsulating logic that is internal to the class and not intended for external use.

```
public class StaffRegistration {
  // Default constructor
  public String firstName;
  public String lastName;
  public Account hotelName;
  public String department;
  public Boolean isActive = true;
  
  public MyClass(String firstName, String lastName, Account hotel, String department) {
    // Initialization code here
    this.firstName = firstName;
    this.lastName = lastName;
    this.hotel = hotel;
    this.department = department;
  }

  private boolean registerStaff()
  {
    //registration logic
  }
}
```

**Global Methods**
Global methods are accessible across different classes and namespaces within Salesforce. They are often used in managed packages or for integration purposes where external systems need to invoke Salesforce functionality. For Global access modifiers on methods, classes are also declared as Global.

