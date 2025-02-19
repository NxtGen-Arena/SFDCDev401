# Control Execution Flow using Control Structures

Control statements in Apex are essential as they allow us to direct the flow of code execution. These statements enable us to manage which sections of code are executed based on certain conditions, making our code adaptable, efficient, and logical. Allows handle various scenarios dynamically, which is crucial for creating robust and flexible applications in Salesforce.

There are different types of Control Statements:

<img src="https://github.com/user-attachments/assets/4e587d06-fb45-49ac-9dfe-186f40bf357a" alt="alt text" width="800" height="400" />

<h2> If - Else</h2>

Executes a block of code based on a condition. If the condition is true, it executes the code in the if block; otherwise, it executes the else block. 

<img src="https://github.com/user-attachments/assets/18f13d54-b024-42d9-a487-5be2e9dc6bc7" alt="alt text" width="800" height="400" />

<h2> Switch Statements </h2>

* Efficient way to handle branching based on a single value from variable or field. Without Switch developers had to write multiple if-else nested statements.
* Switch based when value can be a single value, multiple values, or sObject types. Each when value must be unique.
* If you include a when else block, it must be the last block in the switch statement.
* The switch statement evaluates the expression and executes the code block for the matching when value.
* If no value matches, the when else code block is executed. If there isn’t a when else block, no action is taken.
* There is no fall-through. After the code block is executed, the switch statement exits.
* Apex switch statement expressions can be one of the following types: Integer, Long, sObject, String, Enum

<img src="https://github.com/user-attachments/assets/bddfde11-8150-4dcc-92c6-057a7c224807" alt="alt text" width="550" height="400" />

<h3> Loops </h3>

To iterate over collection of data, Apex offers multiple loop statements. Apex supports procedural loops:

* do {statement} while (Boolean_condition);
* while (Boolean_condition) statement;
* Traditional For Loop: for (initialization; Boolean_exit_condition; increment) statement;
* For Each Loop for Collections: for (variable : array_or_set) statement;
* For Each Loop for SOQL resulrs: for (variable : [inline_soql_query]) statement;

Also, Apex supports loop controls like -

* break; exits the entire loop
* continue; skips to the next iteration of the loop
  
