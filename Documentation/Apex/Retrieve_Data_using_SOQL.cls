//SOQL: Reading stored or saved records from Salesforce
//SOQL is embedded in Apex since it can directly fetch the query results. Hence called as INLINE SOQL
//Inline SOQL = Direct SOQL
//Ids are returned implicitly.

public with sharing class SOQLinApex 
{
    //Inline Queries -  simple and easy to write. Good for single-use queries
    public static void simpleSOQL() 
    {
        //Inline SOQL
        //Square brackets synatx and assign return value to collections

        //Retrieve all records from Account and returns array of Account sObjects.
        //Include fields - Name, Type and Phone
        Account[] accRec = [Select Name,Type,Phone From Account];
        System.debug('Inline SOQL Query Results ::::::::::::::::::::::::::::::::: '+accRec);

        List<Account> accList = [Select Name,Type,Phone From Account];
        System.debug('Inline SOQL Query Results ::::::::::::::::::::::::::::::::: '+accList);
    }

    //Inline query - tightly coupled, making them difficult to reuse and harder to maintain
    public static void soqlWithFilters() 
    {
        //Inline SOQL
        //Square brackets synatx and assign return value to collections

        //Retrieve all records from Account and returns array of Account sObjects.
        //Include fields - Name, Type and Phone
        List<Account> accList = [SELECT Name,Type,Phone 
                                FROM Account
                                WHERE Name = 'Apex Account'
                                AND NumberofEmployees > 20
                                ];
        System.debug('Inline SOQL Query Results ::::::::::::::::::::::::::::::::: '+accList);
    }

    public static void soqlWithBindVariable()
    {
        //Declarating and intialize the variable
        String accName = 'Apex Account';

        //Bind variables are useful when the data that is dynamic and can't be hard-coded.
        //Object dataType name = (Object) dataType.newInstance();
        //SOQL in APex can reference Apex code variables and expressions if they are preceded with a colon (:)
        //Bind - using local variable instead of hard coding the actual value in query
        List<Account> accList = [SELECT Name,Type,Phone 
                                FROM Account
                                WHERE Name = : accName];
        System.debug('Inline SOQL Query Results ::::::::::::::::::::::::::::::::: '+accList);

        Set<Id> accountIdSet = new Set<Id>();
        for(Account acc : accList)
        {
            accountIdSet.add(acc.Id);
        }

        //Sub query - A SOQL query that is embedded inside another SOQL query

        //Semi Join Query - A query that returns all the rows from the primary object 
        //where the related information is in another object
        //In this case - Account and Opportunity objects
        
        List<Contact> apexContactsList = [SELECT Firstname,LastName 
                                      FROM Contact 
                                      WHERE AccountId In : accountIdSet];
         System.debug('All contacts  associated with Aoex Accounts  ::::::::::::::::::::::::::::::::: '+apexContactsList);

         //Anti-Join Query - Useful in fetching all the records from the related table
         //that are not in the child table
         //In this case - Account and Opportunity objects
         List<Contact> nonapexContactsList = [SELECT Firstname,LastName 
                                      FROM Contact 
                                      WHERE AccountId NOT In : accountIdSet];
         System.debug('All contacts not associated with Aoex Accounts ::::::::::::::::::::::::::::::::: '+nonapexContactsList);
    }

    //Userful when query needs to be constructed dybamically
    //filter conditions in Wherre clause depends on user selection
    //SOQL injection may not be handled by SOQL
    public static void dynamicSOQL()
    {
         //Dynamic SOQL - Use variables in the query
         //use escape characters for string
        String soqlQuery = 'SELECT Type, Phone, Name FROM Account WHERE Name = \'Apex Account\'';

        //Database.query method can also be used to execute a dynamic query
        List<Account> accList = Database.query(soqlQuery);
        System.debug('Inline SOQL Query Results ::::::::::::::::::::::::::::::::: '+accList);


        //Retrive fields from field set
        //Get all the fields in a string
        //String fieldName = 'Id';
        List<Schema.FieldSetMember> fieldList = SObjectType.Account.FieldSets.InstituteFieldSet.getFields();
        System.debug('No. of fields retrieved ::::::::::::::::::::::::::::::::::: '+fieldList.size());

        //Create a string to store the fields
        String fieldNames = '';

        //Iterate the fields and append the fields to the string
        for(Schema.FieldSetMember field : fieldList) 
        {
            fieldNames += fieldNames==''? field.getFieldPath() : ',' + field.getFieldPath();
        }
         System.debug('fieldNames retrieved ::::::::::::::::::::::::::::::::::: '+fieldNames);

        soqlQuery = 'SELECT ' + fieldNames + ' FROM Account LIMIT 1';

        system.debug('soqlQuery>>>>'+ soqlQuery);
        //Database.query method can also be used to execute a dynamic query
        List<Account> accWithFieldSetList = Database.query(soqlQuery);
        System.debug('accWithFieldSetList SOQL Query Results ::::::::::::::::::::::::::::::::: '+accWithFieldSetList);


        //Dynamic SOQL using Database.queryWithBinds
        //Param 1 : Query string
        //Param 2: Map of bind variable name and it's value
        //Param 3: AccessLevel - USER_MODE or SYSTEM_MODE
        Map<String, Object> accountBinds = new Map<String, Object>{'accountName' => 'GenePoint'};
        List<Sobject> sobjectList = Database.queryWithBinds('SELECT Id, Name FROM Account WHERE Name = :accountName',accountBinds,AccessLevel.USER_MODE);
        System.debug('Dynamic soql::' + sobjectList); 
    }

    //results can be ieterated but heap size limit and 50000 records per soql allowed
    //Efficient chunking with query and query more calls 
    //records are retrieved in chunks of 200 records
    //cannot specif a LIMIT clause easily when using SOQL for loops
    public static void soqlForLOOP()
    {
        for(Account acc : [SELECT Name, Type FROM Account])
        {
            System.debug('Account Name ::::::::::::::::::::::::::::::::::: '+acc.Name);
        }
    }

    //Traversing relationship queries
    public static void soqlwithInnerQueries()
    {
        //Use parenthesis for inner query
        //Accounts with related Opportunities with Closed Won Stage
        
         List<Account> accountsList = [SELECT Name,Type,AnnualRevenue,
                                        (SELECT Name, Amount, StageName FROM Opportunities WHERE StageName = 'Closed Won')
                                        FROM Account 
                                        WHERE Type IN ('Prospect','Customer - Direct') ];

        //Retreieve Accounts with Contacts
        //Nested query - Semi-Join
         Account[] accntsWithContacts = [SELECT Name FROM Account 
                                        WHERE Id IN (SELECT AccountId FROM Contact)];

        System.debug('Accounts with Closed Won Opps: '+accountsList);
        System.debug('Accounts with Contacts: '+accntsWithContacts);

        Account[] accntsWithRelatedContacts = [SELECT Name,Type, (SELECT Firstname,LastName FROM Contacts) 
                                                FROM Account
                                                WHERE Name = 'Apex Account'];
        System.debug('Account with related contacts: '+accntsWithRelatedContacts);

        //Get the contacts 
        Contact[] contactArray = accntsWithRelatedContacts[0].Contacts;
        System.debug('Contacts : '+contactArray);
        system.debug('Name of associated contact'+contactArray[0].FirstName +' ' +contactArray[0].LastName);
    }
}
