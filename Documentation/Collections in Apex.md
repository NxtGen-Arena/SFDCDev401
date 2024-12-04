# Collections in Apex
Collections in Apex are data structures that allow you to store, manage and manupulate multiple elements in a single variable. Apex supports three main types of collections:

1. Lists: Ordered collections of elements
2. Sets: Unordered collections of unique elements
3. Maps: Collection of key-value pairs where each key is unique.

Each collection type serves a different purpose and choosing the right collection depends on the requirements of the problem you're solving. 
Here is a Demo Class [^1].

<Details>
  <Summary> Lists </Summary>
  
 ### Description
 1. Ordered collection of elements, can contain duplicates
 2. Indexed starting with zero
 3. Can contains - primitives, sobjects, user defined data types

### Advantages
- Maintains Order of elements
- Duplicates are allowed
- Access elements by Index

### Disadvantages
- Slower for searching elements compared to set

</Details>

<Details>
  <Summary> Set </Summary>
  
 ### Description
 1. Unordered collection of elements, cannot contain duplicates
 3. Can contains - primitives, sobjects, user defined data types

### Advantages
- Duplicates are not allowed
- faster searching compared to lists

### Disadvantages
- No guarantee of order
- Cannot access element by index

</Details>

<Details>
  <Summary> Map </Summary>
  
 ### Description
1. Key Value pair with unique key values. Allows storing complex relationships
2. Keys and values can be any data type—primitive types, collections, sObjects, user-defined types, and built-in Apex types.
3. Apex uses a hash structure for all maps.
4.  map key can hold the null value.
5. Adding a map entry with a key that matches an existing key in the map overwrites the existing entry with that key with the new entry.
6. Map keys of type String are case-sensitive. 
7. Uniqueness of map keys of user-defined types is determined by the equals and hashCode methods, which you provide in your classes. Uniqueness
   of keys of all other non-primitive types, such as sObject keys, is determined by comparing the objects’ field values.

</Details>

# Limitations of Collections in Apex
- Apex enforces governor limits on the number of collection elements you can process in a single transaction. For example, you cannot have more than 50,000 records in a List or Set in one execution context.
- Collections can consume large amounts of memory, especially with large datasets, leading to out-of-memory errors. Minimize memory usage by clearing unused collections and using smaller data structures where possible.
- Set and Map enforce uniqueness based on the hashcode and equals methods of the objects being stored. If you store custom objects, you may need to override these methods for proper behavior. Override hashCode and equals methods in your custom objects to ensure correct behavior when used in Sets and Maps.

[^1]: [Collections.cls](CodeBase/Collections.cls)
