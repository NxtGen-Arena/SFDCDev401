# Structure of Apex Language

- Apex uses [classes](Apex_Class_Overview.md) to define code to be executed. 
- Salesforce also provides out of the box classes which you can use in the Apex.
- Apex is strongly typed so we need to define the data type and return types for methods and variables.
- Code blocks starts and ends with  { } and contains Statements which must end with semi-colon(;)
- Class Names, Variables and Methods Names are case-insensitive.

Like any other language Apex also consists of programming elements like

1. [Variables](Apex-Data-Types-and-Variables.md) - Variables are declared with a name and a data type
2. Statements (assignments, declarations) & Methods to process, exceute business logic
3. [Control Structures (branching)](Control-Structures.md) - If (If, If-Else, Nested If-Else), Do-While, While, For etc
4. [Collections](Collections-in-Apex.md) - Lists, Maps, Sets
5. [DML](Data_Persistence_using_DML.md) and [SOQL](Retrieve-Data-usingSOQL.md) for data
7. Exception handling using standard (Try-Catch) & Custom 

<details>
  <Summary>Apex Class Structure</Summary>

  ```
  /*
- Initialization = is the assignment of an initial value for a data object or variable.
- The complement of initialization is finalization, which is primarily used for objects, but not variables.
- Initialization is done either by statically embedding the value at compile time, or else by assignment at run time. 
- Initialization code may be part of a constructor (class method) or an initializer (instance method). 

- Declaration  = is a language construct that specifies properties of an identifier: it declares what a word (identifier) "means"
- Declarations are most commonly used for functions, variables, constants, and classes, but can also be used for other entities such as enumerations and type definitions.
- Declaration is used to announce the existence of the entity to the compiler

- Constructor is a special type of subroutine called to create an object.
- It prepares the new object for use, often accepting arguments that the constructor uses to set required member variables.
- A constructor resembles an instance method, but it differs from a method in that it has no explicit return type, it is not implicitly inherited and it usually has different rules for scope modifiers. 
- Constructors often have the same name as the declaring class.
- They have the task of initializing the object's data members and of establishing the invariant of the class, failing if the invariant is invalid. 
- A properly written constructor leaves the resulting object in a valid state. 
- Immutable objects must be initialized in a constructor.
*/


public class IntegrationEngine { // Class and its methods are implicitly final by default (no overridable)
  public final Integer RECORD_COUNTER;
  public final Integer RETRY_COUNT; // A final class variable can be assogned only at declaration or in a constructor
  
  Static {
    RECORD_COUNTER = 3; // Static final var can be assigned at declaration or in static initialization
  }
  
  Public IntegrationEngine() {
    RETRY_COUNT = 1; // A final class variable can be assogned only at declaration or in a constructor
  }
}

```
</details>

### Execution Context
An execution context has two characteristics:
* It defines the scope and lifetime of static variables.
* It defines the context for those governor limits that are preset between execution contexts.

# Apex Classes,Variables & Methods

## Apex Class

Apex classes are important for adding new features and customizing Salesforce to fit different business needs.

Class: Blueprint defining properties and behaviors.

- Apex classes are similar to object constructors used for creating custom objects and business logic within Salesforce. They serve as blueprints for creating instances of objects.
- Unlike traditional programming languages, Apex classes are stored on Salesforce servers and executed in a cloud environment.
- A class can contain variables and methods.A class can contain other classes, exception types and initialization code.
- In Apex Classes are fundamental units of code that define the behavior of objects.They encapsulate data and methods to operate on that data. Apex classes are stored and executed on Salesforce servers. Class can implement Interfaces and can be extended.

Classes Consists of:
  * Class Body: Actual code of the class. Statements to be executed
  * Access Modifiers: Decides who can access the class
  * Variables: Store the specific data temporary within class and method.used to specify state of an object, such as the object Name and Type. Since these variables are associated with a class and are members of it, they are commonly refered to as **member variables**.
  * Methods: Process the business logic using I/P parameters and returns void or results.
  * Constructors: First entry intializers for classes.

### To define a class
1. You must use one of the access modifiers (such as public) in definition of the top-level class
2. You do not have to use access modifier for the declaration of the inner level class
3. Required: the keyword class followed by the name of the class

>[!IMPORTANT]
> A class can implement multiple interfaces, but only extend one existing class. This restriction means that Apex does not support "multiple inheritance".

### How classes are defined in Apex
  ```
  public class Dog {
    public static final Integer LEGS = 4; //constants
    public static final Integer EYES = 2; //constants
    String breed,name,color;      //Variable declaration

    public Dog() //Default constructor
    {
        this.name = 'Tara';
        this.color = 'Black and Brown';
        this.breed = 'German Shephard';
        system.debug(' Default constructor.');
    }

    public Dog(String name, String color, String breed)
    {
        this.name = name;
        this.color = color;
        this.breed = breed;
        system.debug(' constructor with parameters called.');
    }
    void displayInfo()   //Method to display information
    {
      system.debug('Name: ' + this.name + ', breed: ' + this.breed);
    }
    static void dontBark()  // static method
    {
      system.debug('Don't bark '+ this.Name);
    }
  }
  ```
### Class Access Modifiers who can perform what actions with the class. 

| Access Modifier       | Purpose                                | 
|-----------------------|----------------------------------------|
| Public                | Class is visible within the application or namespace |
| Private               | Class known only locally inner classes are private |
| Global                | can be accessed from anywhere within Apex. All webservice classes are global |
| Virtual               | class allows extension and overrides.You cannot override a method with the override keyword unless the class has been defined as virtual. |
| Abstract              | class contains abstract methods, that is, methods that only have their signature declared and no body defined.|

## Objects

> In object-oriented programming (OOP) concepts, an “object” refers to a specific instance of a class.
> When we create objects from a class, they inherit the properties and behaviors defined by that class.
> These objects have attributes (states) and methods (behaviors) associated with them.
> objects are instances of classes that represent real-world entities and encapsulate both data and behavior.
> Objects can invoke methods defined in classes they are part of.


### objects Instantiation
  ```
 Dog tara = new Dog();
 Dog jimmy = new Dog('Jimmy','White','Lab');
 jimmy.displayInfo();
 
  ```

## Apex variables and Data Types

- Apex supports various data types, including primitive types (e.g., Integer, Boolean), collections (e.g., List, Set, Map), and custom types (e.g., custom objects).
- Variables must be declared with a specific data type before they can be used.

 ### Variable Declaration:
 ```
    [public | private | protected | global] [final] [static] data_type variable_name [= value]
 ```

  1. **Optional**: Modifiers, such as public or final, as well as static.
  2. **Required**: The data type of the variable, such as String or Boolean.
  3. **Required**: The name of the variable.
  4. **Optional**: The value of the variable.
   
  ## Methods in Apex
  1. A method is a procedure associated with a class.
  2. A method defines the behavior of the objects that are created from the class. Another way to say this is that a method is an action that 
     an object is able to perform. 
  3. You can use override to override methods only in classes that have been defined as virtual or abstract.
  4. methods that return values can also be run as a statement if their results are not assigned to another variable. Can be recursive.
  5. Can have side effects, such as DML insert statements that initialize sObject record IDs.
  6. Can refer to themselves or to methods defined later in the same class or anonymous block. Apex parses methods in two phases, so forward 
     declarations are not needed.
  7. Can be polymorphic. For example, a method named example can be implemented in two ways, one with a single Integer parameter and one with 
     two Integer parameters.
  8. Depending on whether the method is called with one or two Integers, the Apex parser selects the appropriate implementation to execute. If 
     the parser cannot find an exact match, it then seeks an approximate match using type coercion rules.
  9. If the parser finds multiple approximate matches, a parse-time exception is generated.
  10. Methods with a void return type are typically invoked as a stand-alone statement in Apex code.

  ## Method Declaration:
  1. **Optional**: Modifiers, such as public or protected.
  2. **Required**: The data type of the value returned by the method, such as String or Integer. Use void if the method does not return a value.
  3. **Required**: A list of input parameters for the method, separated by commas, each preceded by its data type, and enclosed in parentheses (). If there are no parameters, use a set of empty parentheses.     A method can only have 32 input parameters.
  4. **Required**: The body of the method, enclosed in braces {}. All the code for the method, including any local variable declarations, is contained here.

   ## Method Structure:
   ```
    [public | private | protected | global] [override] [static] return_data_type method_name (input parameters) {
        // The body of the method
        return; 
        }
   ```

### Passing Method Arguments by Value
* all primitive data type arguments, such as Integer or String, are passed into methods by value. This fact means that any changes to the arguments exist only within the scope of the method. When the method returns, the changes to the arguments are lost.
* Non-primitive data type arguments, such as sObjects, are passed into methods by reference. Therefore, when the method returns, the passed-in argument still references the same object as before the method call. Within the method, the reference can't be changed to point to another object but the values of the object's fields can be changed.

<h2>Anonymous code execution</h2>

Executing anonymous Apex code in Salesforce allows developers to quickly test code snippets or perform one-time operations without the need to create a separate Apex class or trigger. Here are the steps to execute anonymous code in Salesforce:

<h3>Developer Console</h3>

1. Access Developer Console or Salesforce CLI: You can choose to execute anonymous Apex code either through the Developer Console or Salesforce CLI. Both methods provide similar capabilities, so use whichever you’re more comfortable with.
   
2. Open Developer Console:
* Log in to your Salesforce Developer Edition or sandbox environment.
* Navigate to the Developer Console by clicking on your name → Developer Console.
* In the Developer Console, go to the “Debug” menu.
* Select “Open Execute Anonymous Window.”
* Write your Apex code snippet. The code should be self-contained and not require any external dependencies.
* Once you’ve written your code snippet, click on the “Execute” button to run the code.
* Salesforce will compile and execute the Apex code snippet in a secure and isolated environment.

3. View Execution Results:
* After execution, the results will be displayed in the “Logs” tab at the bottom of the Developer Console.
* Review the debug logs for any errors, exceptions, or output generated by your code.

<h3> Salesforce CLI </h3>

1. Open Terminal or Command Prompt in VS Code
* Launch your preferred terminal or command prompt.
* Authenticate with your Salesforce org using Salesforce CLI if you haven’t already done so.
— Run the command:
```
 sfdx force:auth:web:login -d -a <alias>
```
* Replace "<alias>" with a name for your org connection.
* Create a Temporary Apex File: Create a new file with a ".apex" extension (e.g., "test.apex") and write your Apex code snippet in this file.
* Run the following Salesforce CLI command to execute the Apex code in the temporary file:
```
 sfdx force:apex:execute -f <path/to/apex/file>
 ```
 * Replace `<path/to/apex/file>` with the path to your temporary Apex file.
 * After execution, Salesforce CLI will display the execution results in the terminal.
 * Check for any errors or output generated by your code.
