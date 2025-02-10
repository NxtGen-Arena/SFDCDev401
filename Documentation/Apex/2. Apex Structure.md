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






