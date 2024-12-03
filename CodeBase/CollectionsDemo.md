# Collections in Apex

Collections in Apex are data structures that allow you to store, manage, and manipulate multiple elements in a single variable. Apex supports three main types of collections:

1. Lists: Ordered collections of elements.
2. Sets: Unordered collections of unique elements.
3. Maps: Collections of key-value pairs where each key is unique.

> [!Tip] Each collection type serves a different purpose, and choosing the right collection depends on the requirements of the problem you're solving.

### When to Choose Which Collection
| Collection Type	| Description	                  | Use Cases	          |Advantages	                | Disadvantages|
------------------|-------------------------------|---------------------|---------------------------|--------------|
|List	            |Ordered collection of elements,|When you need to maintain order of elements
                  |can contain duplicates	
- When duplicates are allowed
- When you need random access via index	- Maintains order
- Allows duplicates
- Access elements by index	- Slower for searching elements compared to Set
Set	Unordered collection of unique elements	- When you need to ensure all elements are unique
- Fast membership testing	- Prevents duplicates
- Efficient for searching	- Cannot access elements by index
- No guarantee of order
Map	Key-value pair collection where keys are unique	- When you need to associate values with unique keys
- Fast lookups by key	- Fast lookups by key
- Allows storing complex relationships	- Keys must be unique
- No guarantee of order for keys or values
Common Use Cases
List: Storing records in order, such as a list of Contact or Account objects.
Set: Filtering out duplicates, such as ensuring there are no duplicate IDs or email addresses in a dataset.
Map: Associating records with unique identifiers, such as mapping Account records to their corresponding IDs.
Comparison of Collections
Feature	List	Set	Map
Order	Maintained	Not maintained	Not maintained for keys
Duplicates	Allowed	Not allowed	Not allowed for keys
Index Access	Yes	No	No
Membership Testing	Linear search (O(n))	Constant time (O(1))	Constant time (O(1))
Key-Value Pair	No	No	Yes
Common Errors and How to Handle Them
Null Pointer Exception:

Cause: Accessing or modifying a collection before it has been initialized.
Fix: Always initialize collections before use.
apex
Copy code
List<String> myList = new List<String>();
Index Out of Bounds Exception:

Cause: Trying to access an element outside the valid index range of a List.
Fix: Ensure the index is within the bounds of the list.
apex
Copy code
if (index >= 0 && index < myList.size()) {
    // Safe to access
}
Duplicate Value Exception in Set:

Cause: Attempting to insert duplicate values into a Set.
Fix: Handle cases where duplicates might arise, or check for the presence of the value before inserting.
apex
Copy code
if (!mySet.contains(value)) {
    mySet.add(value);
}
Key-Value Duplicate Exception in Map:

Cause: Attempting to insert duplicate keys into a Map.
Fix: Use Map.containsKey(key) to check if the key already exists.
apex
Copy code
if (!myMap.containsKey(key)) {
    myMap.put(key, value);
}
Concurrent Modification Exception:

Cause: Modifying a collection while iterating over it.
Fix: Use a temporary collection for storing items to be removed or added.
apex
Copy code
for (String key : myMap.keySet()) {
    if (someCondition) {
        keysToRemove.add(key);
    }
}
Limitations of Collections in Apex
Governor Limits:

Apex enforces governor limits on the number of collection elements you can process in a single transaction. For example, you cannot have more than 50,000 records in a List or Set in one execution context.
Handling: Use bulk operations and ensure proper batching using Batch Apex or Queueable Apex if large datasets need to be processed.
Memory Usage:

Collections can consume large amounts of memory, especially with large datasets, leading to out-of-memory errors.
Handling: Minimize memory usage by clearing unused collections and using smaller data structures where possible.
Set and Map Uniqueness:

Set and Map enforce uniqueness based on the hashcode and equals methods of the objects being stored. If you store custom objects, you may need to override these methods for proper behavior.
Handling: Override hashCode and equals methods in your custom objects to ensure correct behavior when used in Sets and Maps.
Order of Elements:

Set and Map do not guarantee any order of elements.
Handling: If you need order, use a List or sort the data separately.
By understanding the purpose of each collection and how to handle common pitfalls, you can optimize your Apex code to work effectively with collections.
