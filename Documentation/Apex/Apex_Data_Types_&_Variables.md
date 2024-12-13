# Apex Data Types

- Apex is a block structured language, which means we write blocks of the code.
- Blocks are defined with curly braces {} and All the statements end with semicolon ;
- A class can contain variables and methods, constructors.
- Primitiive Data types are all objects and allows to call methods from these objects.


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
</details>


# References 
[Constants in Apex](https://beyondthecloud.dev/blog/constants-in-apex)

