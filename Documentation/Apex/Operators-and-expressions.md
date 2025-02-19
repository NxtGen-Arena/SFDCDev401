# Operators and Expressions in Salesforce

Apex operators are used to perform different operations and evaluating expressions. 

## Type of Operators

1. **Arithmetic Operators:**
* Addition (+): Adds two values.
* Subtraction (-): Subtracts the second value from the first.
* Multiplication (*): Multiplies two values.
* Division (/): Divides the first value by the second.

```
Integer a = 5;
Integer b = 3;
 
Integer sum = a + b; // Addition
Integer difference = a - b; // Subtraction
Integer product = a * b; // Multiplication
Integer quotient = a / b; // Division
 
 
System.debug('Sum: ' + sum); // Output: Sum: 8
System.debug('Difference: ' + difference); // Output: Difference: 2
System.debug('Product: ' + product); // Output: Product: 15
System.debug('Quotient: ' + quotient); // Output: Quotient: 1

```
  
2. Comparison Operators:
* Equal to (==): Checks if two values are equal.
* Not equal to (!=): Checks if two values are not equal.
* Greater than (>): Checks if the first value is greater than the second.
* Less than (<): Checks if the first value is less than the second.
* Greater than or equal to (>=): Checks if the first value is greater than or equal to the second.
* Less than or equal to (<=): Checks if the first value is less than or equal to the second.

```
Integer a = 5;
Integer b = 3;
 
Boolean isEqual = a == b; // Equal to
Boolean isNotEqual = a != b; // Not equal to
Boolean isGreater = a > b; // Greater than
Boolean isLess = a < b; // Less than
Boolean isGreaterOrEqual = a >= b; // Greater than or equal to
Boolean isLessOrEqual = a <= b; // Less than or equal to
 
System.debug('Is Equal: ' + isEqual); // Output: Is Equal: false
System.debug('Is Not Equal: ' + isNotEqual); // Output: Is Not Equal: true
System.debug('Is Greater: ' + isGreater); // Output: Is Greater: true
System.debug('Is Less: ' + isLess); // Output: Is Less: false
System.debug('Is Greater or Equal: ' + isGreaterOrEqual); // Output: Is Greater or Equal: true
System.debug('Is Less or Equal: ' + isLessOrEqual); // Output: Is Less or Equal: false
```
  
3. Logical Operators:
* AND (&&): Returns true if both conditions are true.
* OR (||): Returns true if at least one condition is true.
* NOT (!): Returns the opposite of the condition.

```
Boolean condition1 = true;
Boolean condition2 = false;
 
Boolean andResult = condition1 && condition2; // AND
Boolean orResult = condition1 || condition2; // OR
Boolean notResult = !condition1; // NOT
 
System.debug('AND Result: ' + andResult); // Output: AND Result: false
System.debug('OR Result: ' + orResult); // Output: OR Result: true
System.debug('NOT Result: ' + notResult); // Output: NOT Result: false
```

4. Assignment Operators:
* Assign (=): Assigns a value to a variable.
* Increment/Decrement Operators:
* Increment (++) and decrement (–): Increase or decrease the value of a variable by 1.

5. String Concatenation Operator:
Plus (+): Concatenates two strings.

<h2>Safe Navigation Operator in Apex</h2>

Use the safe navigation operator (?.) to replace explicit, sequential checks for null references. This operator short-circuits expressions that attempt to operate on a null value and returns null instead of throwing a NullPointerException.
If the left-hand-side of the chain expression evaluates to null, the right-hand-side isn’t evaluated. Use the safe navigation operator (?.) in method, variable, and property chaining. The part of the expression that isn’t evaluated can include variable references, method references, or array expressions.

> [!Note]
> All Apex types are implicitly nullable and can hold a null value returned from the operator.

```
String s = contact.Account?.BillingCity;
/* Ternary Operator: Short-hand for if-else condition */
Integer max = (a > b) ? a : b; // If a > b, return a; otherwise, return b
System.debug('Max value using ternary operator: ' + max);

/* Null Safe Operator: Prevents null pointer exceptions */
String str = null;
System.debug('Null safe operator example: ' + (str?.length())); // Returns null if str is null
```
        
<h2>Further Read</h2>

1. [Expressions and Operators](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/langCon_apex_expressions.htm)
2. [ExpressionsAndOperators](Codebase/Apex/Expressions-and-operators.cls)
