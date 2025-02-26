# Collections in Apex
Collections in Apex are data structures that allow you to store, manage and manupulate multiple elements in a single variable. Apex supports three main types of collections:

1. Lists: Ordered collections of elements
2. Sets: Unordered collections of unique elements
3. Maps: Collection of key-value pairs where each key is unique.

Each collection type serves a different purpose and choosing the right collection depends on the requirements of the problem you're solving. 
Here is a Demo Class [^1].

<h2>Lists </h2>
  
 ### Description
 1. Ordered collection of elements
 2. Lists can heave _duplicates_ and _null_ values
 3. Indexed starting with zero
 4. Can contains - primitives, sobjects, user defined data types
 5. DMLS can be performed on Lists

### Advantages
- Maintains Order of elements
- Duplicates are allowed
- Access elements by Index

### Disadvantages
- Slower for searching elements compared to set
- Duplicates may cause issue so proctive checks are required.

### Methods

|Method| Details|Example|
|------|--------|--------|
|add()|adds an element at the end of list. if the element already exists at the given index, elements are pushed down. | numList.add(100);
|add(index,element)|adds an element at the specified index. if the element already exists at the given index, elements are pushed down.|numList.add(3,100);
|addall(list) | adds elements from one list or to another|numList.addAll(evenList);
|remove(index)|removes the element from given index|numList.remove(3);
|clear()|clears the entire list and removes all elements from a collection|numList.clear();
|clone()|create a new instance of a collection that contains all the lements of the original collection|evenList = numList.clone();
|contains(element)|checks if the list has the mentioned value|evenList.contains(2);
|equals(list)| FOr primitives, checks if the lists contains same elements|Boolean isSame = evenList.equals(numList);
|size()|returns the size of the list|evenList.size()
|isEmpty()| checks if the list has any elements | Boolean hasELements = evenList.isEmpty()

>[!NOte]
> When you need to perform operations on list, and no of elements does not matter use "list.isEmmpty()" instead of "list.size()". It's faster as Salesforce only checks for first item index, rather than navigating till end of list to calculate size.

<h2> Set </h2>
  
 ### Description
 1. Unordered collection of elements, cannot contain duplicates
 3. Can contains - primitives, sobjects, user defined data types
 4. It’s incredibly useful when you need to ensure that each element appears only once, regardless of the order.
 5. Sets are often used for filtering and fast existence checks, due to their efficient data handling.
 6. Set elements are case sensitive.
 7. Apex uses a hash structure for all sets.

### Advantages
- Duplicates are not allowed
- faster searching compared to lists

### Disadvantages
- No guarantee of order
- Cannot access element by index

### Methods

|Method| Details|Example|
|------|--------|--------|
|add()|adds an element at the end of set. if the element already exists at the given index, elements are pushed down. | numSet.add(100);
|remove(index)|removes the element from given index|numSet.remove(3);
|clear()|clears the entire list and removes all elements from a collection|numSet.clear();
|clone()|create a new instance of a collection that contains all the lements of the original collection|evenSet = numSet.clone();
|contains(element)|checks if the list has the mentioned value|numSet.contains(2);
|size()|returns the size of the list|numSet.size()
|isEmpty()| checks if the list has any elements | Boolean hasELements = numSet.isEmpty()

<h2> Map </h2>
  
 ### Description
1. Key Value pair with unique key values. Allows storing complex relationships
2. Keys and values can be any data type—primitive types, collections, sObjects, user-defined types, and built-in Apex types.
3. Apex uses a hash structure for all maps.
4. map key can hold the null value.
5. Adding a map entry with a key that matches an existing key in the map overwrites the existing entry with that key with the new entry.
6. Map keys of type String are case-sensitive. 
7. Uniqueness of map keys of user-defined types is determined by the equals and hashCode methods, which you provide in your classes. Uniqueness
   of keys of all other non-primitive types, such as sObject keys, is determined by comparing the objects’ field values.

### Methods

|Method| Details|Example|
|------|--------|--------|
|put(key,value)|add an element to map with a key| nameAgeMap.put('Tom',60);
|addall(list) | adds elements from one list or to another|numListMap.addAll(nameAgeMap);
|clear()|clears the entire list and removes all elements from a collection|nameAgeMap.clear();
|clone()|create a new instance of a collection that contains all the lements of the original collection|nameAgeMap.clone();
|containsKey(element)|checks if the map contains certain value|nameAgeMap.contains(2);
|size()|returns the size of the list|nameAgeMap.size()
|isEmpty()| checks if the list has any elements | Boolean hasELements = nameAgeMap.isEmpty()


# Limitations of Collections in Apex
- Apex enforces governor limits on the number of collection elements you can process in a single transaction. For example, you cannot have more than 50,000 records in a List or Set in one execution context.
- Collections can consume large amounts of memory, especially with large datasets, leading to out-of-memory errors. Minimize memory usage by clearing unused collections and using smaller data structures where possible.
- Set and Map enforce uniqueness based on the hashcode and equals methods of the objects being stored. If you store custom objects, you may need to override these methods for proper behavior. Override hashCode and equals methods in your custom objects to ensure correct behavior when used in Sets and Maps.

<h2> When to choose What</h2>

![image](https://github.com/user-attachments/assets/b0d46878-14c8-4ef4-af9e-c410d14a7ff2)


![image](https://github.com/user-attachments/assets/dff5b0c9-e875-4ff1-a930-2778351582f0)

1. **Use Sets for Uniqueness:** If you need to ensure no duplicates, prefer Set over List. It is also faster for checking the existence of an element.
2. **Use Maps for Fast Lookups:** Maps are ideal when you need to associate a key with a value and perform quick lookups. Avoid unnecessary iterations over lists when a Map could serve better.
3. Avoid Deep Nesting: Excessive nesting of collections can make code hard to read and maintain. Try to avoid more than two levels of nesting and consider breaking logic into smaller parts.
4. **Governor Limit Awareness:** Keep an eye on Salesforce governor limits. Nested collections can quickly consume heap memory or exceed the limit of 100,000 elements.
Apex enforces governor limits on the number of collection elements you can process in a single transaction. For example, you cannot have more than 50,000 records in a List or Set in one execution context.
5. **Initialize Collections Before Use:** Always ensure collections are initialized (especially nested ones), or you might encounter a NullPointerException.
6. **Clear Collections:** Always clear collections once they're no longer needed, especially in large, long-running transactions, to free up memory.


<h2> References and Further Read</h2>

1. [Collections.cls](../CodeBase/Collections.cls)
