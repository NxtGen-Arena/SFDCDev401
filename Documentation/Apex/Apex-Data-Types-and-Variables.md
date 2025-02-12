# Apex Variables and Data Types

## Variables

* Variables are declared with a name and a data type with the scope for the specific variable through access modifiers.
* Variables are declared and initialized. Values can be assigned in the variables while declaration or even later.
* Salesforce has – Primitive (Passed by value) and Non-Primitive(Passed by reference) Data Types
* If you declare a variable and don't initialize it with a value, it will be null.
* A class can contain variables and methods, constructors. Primitiive Data types are all objects and allows to call methods from these objects.
* In Apex, variables must be declared with a specific data type before they can be used. 

> [!Tip]
> At compile time strict type checking is enforced and class will fail to compile if mismatch occurred.

### Declaring Variables

[public |private | protected | global] [FINAL] [static] data_type variable_name [=value]

### Access Modifiers for Variables

| Modifier | Description |
| --- | --- |
|`private`|method or variable is accessible only within the Apex class in which it’s defined. If no access modifier is specified, the method or variable is private.
|`public`|methodor variable is accessible by all Apex within a specific package.
|`protected`|method or variable is visible to any inner classes in the defining Apex class, and to the classes that extend the defining Apex class. Can be used for instance methods and member variables only.This setting is strictly more permissive than the default (private) setting.
|`global`|method or variable can be used by any Apex code that has access to the class, not just the Apex code in the same application. must be used for any method that must be referenced outside of the application, either in SOAP API or by other Apex code. If you declare a method or variable as global, you must also declare the class that contains it as global.


### Additional Keywords

| Keywords | Description |
| --- | --- |
| `static`|define static variables to store data that is shared within the class. Methods can be accessed without creating instance of a class.Static variables are not memory constants.All instances of the same class share a single copy of the static variable.This can be a technique used for setting flags to prevent recursive triggers.
|`Final`| Final keyword is used to define constants – this indicates that the variable can only be assigned once, either in the declaration itself or with a static initializer method if the constant is defined in the class.
|`Transient`|This keyword declares instance variables that cannot be saved, and should not be transmitted as part of the view state, in Visualforce controllers and extensions.

<h3>Assigning Values to Variables</h3>
Variables can be initialized with static values, expressions or results from SOQL and SOSL. An assignment means placing value in variable. 
Apex allows to use different assignment operators:

 | Operator | Description                         | Example                   |COmments|
 |-----------|-------------------------------------|---------------------------|----------|
 | = | Equals operator. Assign value from right side of operator in variable.| Integer iCount = 10;
 | += | Increment value from variable |  iCount = iCount + 10 is similar to iCount += 10;| Use *= in similar way.
 | ++ | Increment oprator with default increment step as 1| iCount++| Use -- in similar way

<h3>Variable Initialization</h3>
Variable initialization refers to the process of assigning an initial value to a variable at the time of declaration. This ensures that the variable is properly initialized and ready for use.

You can initialize variables:
1. While declaring variables
2. In Constructors
3. Dynamically based on runtime calculations and expressions.

>[!Note]
>Variables without initialization are assigned as _NULL_ and not blank. So, if you try to access these variables **NullPointerException**__ is thrown.

### Data Type for Variables

Apex is strongly typed language. All avriables and expressions must have a data type. Apex supports premitive and non-premitive data types.
1. Primitives - Integer,Double,Long,Date,DateTime,String,Id,Boolean
2. sObject - type casting to objects. Specific custom or standard objects and sObjects.
3. Collection - storing collection of data. Map, List,Sets
4. Enums - define constant list for easy access. Typed list of values.
5. System Defined - objects created from system defined classes
6. Custom defined - objects created from user defined classes
   
<h2> Primitive Data Types</h2> 

  | Data Type | Description                         | Example                   |
  |-----------|-------------------------------------|---------------------------|
  |Integer    | 32-bit number withou decimal point  | Integer iCount = 1;       |
  |Decimal    | number with decimal point           | Decimal amount = 120.40;  |
  |Double     | 64-bit number with decimal          | Double pi = 3.14159;      |
  |Blob       | Single object stores binary data    |                           |
  |String     | Characters set within single quotes | String name = 'Apex';     |
  |Boolean    | A value with true, false or null    | Boolean isValid = true;   |
  |Id         |store Salesforce record identifiers. |Id accountId = ‘0012w00000XXXXX’;|
  

<h2> Declaring Constants</h2> 

Apex constants are variables whose values don’t change after being initialized once. Constants can be defined using the final keyword. 
The final keyword means that the variable can be assigned at most once, either in the declaration itself, or with a static initializer method if the constant is defined in a class.

> [!Tip]
> Even though it's not a manadate, defining constants in CAPS is best practice.

### Defining Constant Variables

STATIC FINAL Integer No_OF_RETRIES = 4;

> [!NOTE]
> Picklist values, profile and permission set names, common business values – all constants can be scattered across Apex code. The best practice is to store them in one place to avoid repetitions. (DRY)
The most common approach to resolve it is Constants class, which contains all final variables. You can create a metadata to define these or if there are too many approach is to define them in the apex class.
</details>



<h2> References & Further Read</h2>

1. [Constants in Apex](https://beyondthecloud.dev/blog/constants-in-apex)
2. [Reference Code](/CodeBase/Apex/ApexDataTypes.cls)

