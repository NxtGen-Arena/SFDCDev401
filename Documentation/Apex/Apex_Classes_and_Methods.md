### Apex Classes

- A class can contain variables and methods.
- Variables are used to specify state of an object, such as the object Name and Type. Since these variables are associated with a class and are members of it, they are commonly refered to as member 
  variables.
- Methods are used to control behavior, such as "getOtherQuotes" or "copyLineItems"
- A class can contain other classes, exception types and initialization code.
- An "interface" is like a class in which none of the methods have been implemented.

### To define a class
1. You must use one of the access modifiers (such as public) in definition of the top-level class
2. You do not have to use access modifier for the declaration of the inner level class
3. Required: the keyword class followed by the name of the class
4. A class can implement multiple interfaces, but only extend one existing class. This restriction means that Apex does not support `multiple inheritance`.

| Access Modifier       | Purpose                                | 
|-----------------------|----------------------------------------|
| Public                | Class is visible within the application or namespace |
| Private               | Class known only locally inner classes are private |
| Global                | can be accessed from anywhere within Apex. All webservice classes are global |
| Virtual               | class allows extension and overrides.You cannot override a method with the override keyword unless the class has been defined as virtual. |
| Abstract              | class contains abstract methods, that is, methods that only have their signature declared and no body defined.|

### To declare a variable
1. **Optional**: Modifiers, such as public or final, as well as static.
2. **Required**: The data type of the variable, such as String or Boolean.
3. **Required**: The name of the variable.
4. **Optional**: The value of the variable.

  Variable Declaration:
    ```
     [public | private | protected | global] [final] [static] data_type variable_name [= value]
     ```
  
  ### To define a method
  1. **Optional**: Modifiers, such as public or protected.
  2. **Required**: The data type of the value returned by the method, such as String or Integer. Use void if the method does not return a value.
  3. **Required**: A list of input parameters for the method, separated by commas, each preceded by its data type, and enclosed in parentheses (). If there are no parameters, use a set of empty parentheses.     A method can only have 32 input parameters.
  4. **Required**: The body of the method, enclosed in braces {}. All the code for the method, including any local variable declarations, is contained here.

   Method Structure:
    ```
    [public | private | protected | global] [override] [static] data_type method_name (input parameters)
    {
        // The body of the method
    }
    ```
  5. You can use override to override methods only in classes that have been defined as virtual or abstract.
  6. methods that return values can also be run as a statement if their results are not assigned to another variable.
  7. Can be recursive.
  8. Can have side effects, such as DML insert statements that initialize sObject record IDs.
  9. Can refer to themselves or to methods defined later in the same class or anonymous block. Apex parses methods in two phases, so forward declarations are not needed.
  10. Can be polymorphic. For example, a method named example can be implemented in two ways, one with a single Integer parameter and one with two Integer parameters. Depending on whether the method is     
      called with one or two Integers, the Apex parser selects the appropriate implementation to execute. If the parser cannot find an exact match, it then seeks an approximate match using type coercion     
      rules.
  11. If the parser finds multiple approximate matches, a parse-time exception is generated.
  12. Methods with a void return type are typically invoked as a stand-alone statement in Apex code.

### Passing Method Arguments by Value
* all primitive data type arguments, such as Integer or String, are passed into methods by value. This fact means that any changes to the arguments exist only within the scope of the method. When the method returns, the changes to the arguments are lost.
* Non-primitive data type arguments, such as sObjects, are passed into methods by reference. Therefore, when the method returns, the passed-in argument still references the same object as before the method call. Within the method, the reference can't be changed to point to another object but the values of the object's fields can be changed.
