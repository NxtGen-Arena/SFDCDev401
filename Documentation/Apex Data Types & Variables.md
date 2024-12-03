### Apex: Data Types

- Apex is a block structured language, which means we write blocks of the code.
- Blocks are defined with curly braces {} and All the statements end with semicolon ;
- A class can contain variables and methods, constructors.
- 
- Primitiive Data types are all objects and allows to call methods from these objects.


# What is Class?

A class is a template or bluprint from which objects are created. It basically describes the details.We will talk more about classes later. Public classes are accessible to application within which they are located. TO use class anywhere within Salesforce, define classes as Public.

# Variables 
As Apex is strongly typed all the variables must be declared with the Data Types. Variables are declared with a name and data type. and scoped based on the access modifiers. If not intiialized variables  they are assigned with null.


<details>
  <summary> Primitive Data Types</summary> 

  
  | Data Type | Description                         | Example                   |
  |-----------|-------------------------------------|---------------------------|
  |Integer    | 32-bit number withou decimal point  | Integer iCount = 1;       |
  |Decimal    | number with decimal point           | Decimal amount = 120.40;  |
  |Double     | 64-bit number with decimal          | Double pi = 3.14159;      |
  |Blob       | Single object stores binary data    |                           |
  |String     | Characters set within single quotes | String name = 'Apex';     |
  |Boolean    | A value with true, false or null    | Boolean isValid = true;   |
  
</details>

<details>
  <summary> Declaring Constants</summary> 
  Apex constants are variables whose values don’t change after being initialized once. Constants can be defined using the final keyword. The final keyword means that the variable can be assigned at most once, either in the declaration itself, or with a static initializer method if the constant is defined in a class.

> [!NOTE]

> Picklist values, profile and permission set names, common business values – all constants can be scattered across Apex code. The best practice is to store them in one place to avoid repetitions. (DRY)
The most common approach to resolve it is Constants class, which contains all final variables. You can create a metadata to define these or if there are too many approach is to define them in the apex class.

<details>
  <summary> References</summary> 
[^1]:  [Constants in Apex](https://beyondthecloud.dev/blog/constants-in-apex)
</details>
