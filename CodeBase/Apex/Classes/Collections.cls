//Limits of collections - 100000 elements can be stored in collection
//Apex throws runtime expections if limit exceeded
//APX CPU time limit may exceed because of too many elements ot nested collections

public with sharing class CollectionsHandler {

    //Naming convetion: Methods and variables should follow camelCase
    //1. ordered collection of elements
    //2. Lists are indexed and zero-indexed
    //3. Can contain - Primitive or custom data types
    //4. List are mutable and can store duplicate values
    //5. Lists are similar to Arrays in OOP
    //List are immutable. Once declared, elements cannot be added or removed, but you can reset or overwrite it.
    public static void listMethods(){
        //List - A list is an ordered collection of objects. 
        
        //Declaration of the list. List will be assigned as NULL value.
        List<Integer> numbersList;

        //Error: System.NullPointerException: Attempt to de-reference a null object
        //reason: List is not initialized.
       // numbersList.add(10);
        
        numbersList = new List<Integer>();
        numbersList.add(10);

        //Declaration and initialization. Allocated a memeory on heap.
        List<Integer> evenNumbersList = new List<Integer>();
        List<Integer> oddNumbersList = new List<Integer>();

        //Calling method Add to insert elements in the list at the end
        oddNumbersList.add(11); //index = 0
        oddNumbersList.add(13); //index = 1
        oddNumbersList.add(15); //index = 1
        evenNumbersList.add(4);
        
        
        System.debug('numbersList ' + numbersList);
        System.debug('evenNumbersList ' + evenNumbersList);
        //returns the number of elements in the list
        System.debug('numbersList length ' + numbersList.size());
        System.debug('oddNumbersList ' + oddNumbersList);
        //returns the element at the specified index.
        System.debug('oddNumbersList contains element at index 1 ' + oddNumbersList.get(1));

        //add an element at a specific index will not replace element at that index
        //pushes the down the value at that index to next index
        oddNumbersList.add(1, 25);
        System.debug('after adding element at index 1 ' + oddNumbersList);

        //Remove element from list
        //oddNumbersList.remove();   // throw compile time error since there is no remove method
        //System.debug('oddNumbersList after remove method' + oddNumbersList);

        oddNumbersList.remove(0);
        System.debug('oddNumbersList after removing element from index 0' + oddNumbersList);

        //clear all the elements from list
        numbersList.clear();
        System.debug('after clear all elements from list ' + numbersList);

        //cloning the elements from list
        List<Integer> cloneOfList = new List<Integer>();
        cloneOfList = oddNumbersList.clone();
        System.debug('cloneOfList ' + cloneOfList);
        cloneOfList.add(1,30);
        System.debug('cloneOfList after adding new element ' + cloneOfList);

        cloneOfList.add(2,30);
         System.debug('cloneOfList after adding new element ' + cloneOfList); //adding duplicate
        //Check if list contain specific value
        System.debug('oddNumbersList contains 10 ' + oddNumbersList.contains(10)); 

        //addall elements from one list to another of similar type
        cloneOfList.addAll(evenNumbersList);
        System.debug('cloneOfList after adding all elements' + cloneOfList);

        //Equals method to compare lists
        System.debug('evenNumbersList equals to cloneOfList ' + evenNumbersList.equals(cloneOfList));

        //list of sobjects - any standard object, custom object or sObject
        List<Account> listAccounts = new List<Account>();
        listAccounts.add(new Account(Name = 'Amazon', BillingCity = 'London'));
        listAccounts.add(new Account(Name = 'Dell', BillingCity = 'Pune'));

        System.debug('List of Accounts ' + listAccounts);

        List<Contact> contactsList = [SELECT Name FROM Contact LIMIT 2];
        System.debug('List of contacts ' + contactsList); //[0]

        //list of sObjects 
        List<SObject> sObjectsList = new List<SObject>();
        sObjectsList.add(new Account(Name = 'Apple', BillingCity = 'Mumbai'));
        sObjectsList.add(new Contact(LastName = 'Gopal', FirstName = 'Raju'));

        System.debug('List of sObjects ' + sObjectsList);
    }

    //unordered collection of elements - no index
    //unique elements - no duplicates
    //no control on the order of elements
    //can contain - primitives, sobjects, user defined types, apex types
    public static void setMethods(){
        //Set<element_type> = new Set<element_type>();
        Set<Integer> setIntegers = new Set<Integer>();

        //Add method - add new element
        //if element already exists method will not work
        setIntegers.add(20);
        setIntegers.add(30);
        System.debug('Set of Integers ' + setIntegers);

        //adding duplicate element to the set
        setIntegers.add(30); // since element is duplicate it will not be added and no exception will be thrown
        System.debug('Set of Integers ' + setIntegers);

        //addAll method - add all elements of list to set
        List<Integer> listIntegers = new List<Integer>();
        listIntegers.add(40);
        listIntegers.add(50);
        listIntegers.add(60);

        //to add all the elements from set use addAll method
        setIntegers.addAll(listIntegers);
        System.debug('Set of integers with list of integers ' + setIntegers);

        //remove element  from set
        setIntegers.remove(20);
        System.debug('Set of integers ' + setIntegers);

        //size of the set
        System.debug('Size of the set ' + setIntegers.size()); //number of elements in the set

        //isEmpty - to check if there is any element in the set
        System.debug('is the set empty? ' + setIntegers.isEmpty());

        //contains - to check if set contains the element or not
        System.debug('Set of integers contains 50? ' + setIntegers.contains(50));

        //Set of accounts
        Set<Account> acccountsSet = new Set<Account>();
        acccountsSet.add(new Account(Name = 'Amazon', BillingCity = 'London'));
        acccountsSet.add(new Account(Name = 'Dell', BillingCity = 'Pune'));

        System.debug('Set of Accounts ' + acccountsSet);

        //Set of sObjects
        Set<SObject> sObjectSet = new Set<SObject>();
        sObjectSet.add(new Account(Name = 'Apple', BillingCity = 'Mumbai'));
        sObjectSet.add(new Contact(LastName = 'Gopal', FirstName = 'Raju'));

        System.debug('Set of sObjects ' + sObjectSet);

    }

    //Map - A map is a collection of key value pairs where each unique key maps to a single value.
    //Keys and Values can be of any type - primitives, sObjects, user defined types, apex types
    //Map<Primititve,Primitive>, Map<Primitive, sObject>, Map<Primitive, userDefinedType>, 
    //Map<Primitive, ApexType>, Map<sobject, Primitive>, Map<sobject, sobject>, Map<sobject, userDefinedType>, Map<sobject, apexType>
    public static void mapMethods(){

        Map<Integer,String> employessWithCodeMap = new Map<Integer,String>();
        employessWithCodeMap.put(1001,'Madhu');
        employessWithCodeMap.put(201,'Sri');
        employessWithCodeMap.put(399,'Husey');
        System.debug('Map of employees ' + employessWithCodeMap);

        //retriveing an element at given key
        System.debug('Name of employee ' + employessWithCodeMap.get(201)); //returns Sri

        //Check if map contains given key or not
        System.debug('Map contains key 201 ' + employessWithCodeMap.containsKey(201)); //true

        //remove key and its value from map
        employessWithCodeMap.remove(201);
        System.debug('Map of employees ' + employessWithCodeMap);

        //Size of the map
        System.debug('Size of the map ' + employessWithCodeMap.size()); 

        employessWithCodeMap.put(201,'Massey');
        System.debug('Map of employees for 201 with new value ' + employessWithCodeMap);

        employessWithCodeMap.put(201,'Sassy');
        System.debug('Map of employees for 201 with new value ' + employessWithCodeMap);  // value will be replaced at given key

        //keyset - > Returns the list of all the keys in the map.
        Set<Integer> keys = employessWithCodeMap.keySet();
        System.debug('Keys in the map ' + keys);

        //vaules - > Returns the list of all the values in the map.
        List<String> values = employessWithCodeMap.values();
        System.debug('Values in the map ' + values);

        //Putall - > It is used to populate the entries of the map from the list of key value pairs
        Map<Integer,String> employeesMap = new Map<Integer,String>();
        employeesMap.putAll(employessWithCodeMap);
        System.debug('Map of Employees ' + employeesMap);

        //map of accounts - SOQL 
        Map<Id, Account> accountsMap = new Map<Id, Account>([SELECT Id, Name FROM Account LIMIT 2]);
        System.debug('Map of Accounts ' + accountsMap);
       // System.debug('First Account name ', + accountsMap.values().get(0).Name);

        //Another way to map
        Map<Integer,String> monthsMap = new Map<Integer,String>{1=>'Jan', 2=>'Feb'};
        system.debug('monthsMap ' + monthsMap);

        //clone - > It is used to copy the entries of the map.
        Map<Integer,String> clonedMap = employeesMap.clone();
        System.debug('clonedMap ' + clonedMap);

        //clear - > It is used to remove all of the entries from the map.
        clonedMap.clear();
        System.debug('clonedMap ' + clonedMap);
    }


    //Nested collevtions may become tricky and impact the performance of the code.
    //If the list of list contains the primitive data type it will not create a copy of the list but the reference of the list.
    //It will return the copy of the list of list.
    public static void nestedCollections(){

        //Nested Collection - List of list
        List<List<Integer>> nestedLst = new List<List<Integer>>();
        nestedLst.add(new List<Integer>{1,2,3});
        nestedLst.add(new List<Integer>{4,5,6});
        nestedLst.add(new List<Integer>{7,8,9});
        System.debug('Nested List ' + nestedLst);

        //Nested Collection - List of set
        List<Set<Integer>> nestedSet = new List<Set<Integer>>();
        nestedSet.add(new Set<Integer>{1,2,3});
        nestedSet.add(new Set<Integer>{4,5,6});
        nestedSet.add(new Set<Integer>{7,8,9});
        System.debug('Nested Set ' + nestedSet);

        //Nested Collection - List of map
        List<Map<String,Integer>> nestedMap = new List<Map<String,Integer>>();
        nestedMap.add(new Map<String,Integer>{'First'=>1,'Second'=>2,'Third'=>3});
        nestedMap.add(new Map<String,Integer>{'Fourth'=>4,'Forth'=>5,'Fifth'=>6});
        nestedMap.add(new Map<String,Integer>{'Seventh'=>7,'Eighth'=>8,'Ninth'=>9});
        System.debug('Nested Map ' + nestedMap);

        //Nested Collection - Set of map
        Set<Map<String,Integer>> nestedSetOfMap = new Set<Map<String,Integer>>();
        nestedSetOfMap.add(new Map<String,Integer>{'First'=>1,'Second'=>2,'Third'=>3});
        nestedSetOfMap.add(new Map<String,Integer>{'Fourth'=>4,'Forth'=>5,'Fifth'=>6});
        nestedSetOfMap.add(new Map<String,Integer>{'Seventh'=>7,'Eighth'=>8,'Ninth'=>9});
        System.debug('Nested Set of Map ' + nestedSetOfMap);

        //List within a Map - This is used when each key needs to store multiple values in the form of list
        Map<String, List<String>> employeeListMap = new Map<String, List<String>>();
        employeeListMap.put('Sales', new List<String>{'Steve', 'Rob', 'John', 'Mark'});
        employeeListMap.put('IT', new List<String>{'Steve', 'Rob', 'John', 'Mark', 'Yolanda'});

        //accessing the values in the map
        System.debug('employeeListMap >>> ' + employeeListMap);

        Map<Account,List<Contact>> contactsMap = new Map<Account,List<Contact>>();
    
    }

}
