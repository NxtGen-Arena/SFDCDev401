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

<h3> Procedural Loops </h3>

To iterate over collection of data, Apex offers multiple loop statements. 

### do-while
Execute code block and then the expression is validated. Code block is always executed once in the execution; then based on the expression result may stop.

```
do {
statement block to be executed
} while (Boolean_condition);
```

### while
Executes clode block only if the expression evalutes true.

```
while (Boolean_condition)
{
  statement block to be executed
}
```

### Traditional For Loop

When executing this type of for loop, the Apex runtime engine performs the following steps, in order:

1. Execute the init_stmt component of the loop. Note that multiple variables can be declared and/or initialized in this statement, separated by commas.
2. Perform the exit_condition check. If true, the loop continues. If false, the loop exits.
3. Execute the code_block.
4. Execute the increment_stmt statement.
5. Return to Step 2.

```
for (initialization; Boolean_exit_condition; increment)
{
  statement block to be executed
}
```

### List or Set Iteration for Loops 

Iterate over the collections stored in List, Maps or Sets. This is also referred as For-Each loop. We do not need to incerment index in these types of loops.

```
for (declare variable : array_or_set)
{
  statement block to be executed
}
```
### SOQL for Loops 

SOQL for loops iterate over all of the sObject records returned by a SOQL query.SOQL queries returns 50k records in single execution. This loop internally divides the SOQL results in multiple batches and is capable to handle more records. 

>[!Note]
> SOQL for loops retrieve all sObjects, using efficient chunking with calls to the query and queryMore methods of SOAP API. Developers can avoid the limit on heap size by using a SOQL for loop to process query results that return multiple records. However, this approach can result in more CPU cycles being used.

```
for (declare variable : array_or_set)
{
  statement block to be executed
}
```

Also, Apex supports loop controls like -

* break; exits the entire loop
* continue; skips to the next iteration of the loop
  
<h2>  </h2>
