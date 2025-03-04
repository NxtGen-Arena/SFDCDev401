/**
 * Search your org for specific information
 * writing [] with your query
 * SOQL - Salesforce Object Query Language
 */
public with sharing class SOQLDemo {

    public static void simpleQuery() {
        /**
         * SELECT - Select fields to return. API names ofr fields
         * FROM - Name of the object you want to select, object API Name
         * WHERE - Additional conditions to return only specific records
         * @Returns: sObject or sObjects - Collection of sObjects with fields you specified in SELECT
         * @Syntax:SELECT fields_API FROM objectAPIName WHERE condition
         * @Use Cases: 
         * 1. Retrieve data from sObject or sObjects
         * 2. COunt or perform math operation (aggregation) - COUNT, MIN, MAX, AVG, SUM, COUNT_DISTINCT
         * 3. Sort the results and tretieve the data
         */ 

         //Limit - restricts the number of records returned
         sObject accountRec = [SELECT Id,Name, Type FROM Account LIMIT 1];

         System.debug('Account Record ::::::::::::: '+accountRec);

         //use collection to store multiple records. All records from system
         List<Account> accountList = [SELECT Id,Name, Type 
                                      FROM Account
                                      LIMIT 5];

         System.debug('Account List ::::::::::::: '+accountList);

         /**
          * Purpose: selct fields easily w/o writing allt he fieldslist
          ** @Keyswords:
          ** Fields(ALL) - retreieve all standard and custom fields from sObject
          ** Fields (STANDARD) - retreive all standard fields from sObject
          ** Fields (CUSTOM) - retreive all custom fields from sObject
          */

        /*  accountList.clear();
          //Retrieve all the fields from Account object
          //Fields(ALl) - considered as unbounded so it may return your not all the fields.
          //If you get all the fields, it might be slow and may cause problem.
          accountList = [SELECT FIELDS(ALL) FROM Account LIMIT 1];

          System.debug('Account List with all fields::::::::::::: '+accountList);

          accountList.clear();
          accountList = [SELECT FIELDS(STANDARD) FROM Account LIMIT 2];
          
          System.debug('Account List with standard fields::::::::::::: '+accountList);
          
          accountList.clear();

          //Bounded queries - well-defined feilds
          //unbounded - set of fields which cannot be predetermined
          accountList = [SELECT FIELDS(CUSTOM) FROM Account LIMIT 1];
        
          System.debug('Account List with custom fields::::::::::::: '+accountList);*/

    }

    /**
     * @Description: Queries to return filetered data - Selective queries
     * @return: void
     * @param: NA
     */
    public static void selectiveQueries() {

        //Retrieve all the accounts with Type = 'Other'
        List<Account> accList = [SELECT Id,Name,Type 
                                FROM Account 
                                WHERE Type = 'Other' 
                                LIMIT 2];

        System.debug('Account List::::::::::::: '+accList);

        //Retrieve all the accounts with Type = 'Other' and Industry = 'Chemicals'
         List<Account> accList2 = [SELECT Id,Name,Type 
                                FROM Account 
                                WHERE Type = 'Other' 
                                AND Industry = 'Chemicals'
                                LIMIT 2];
        
        //Reteive the Accounts where name starts with United
        accList.clear();
        accList = [SELECT Id,Name,Type 
                                FROM Account 
                                WHERE Name Like 'United%'];

        System.debug('Account List with united starts::::::::::::: '+accList);

        //Account name ends with
        accList.clear();
        accList = [SELECT Id,Name,Type 
                                FROM Account 
                                WHERE Name Like '%United'];

        System.debug('Account ends with united starts::::::::::::: '+accList);

        //Account name COntains
        accList.clear();
        accList = [SELECT Id,Name,Type 
                                FROM Account 
                                WHERE Name Like '%United%'
                                LIMIT 2];

        System.debug('Account ends with united starts::::::::::::: '+accList);

        //Account state - California, New York
         accList.clear();
        accList = [SELECT Id,Name,Type 
                                FROM Account 
                                WHERE BillingState = 'California'   
                                OR BillingState = 'New York'
                                LIMIT 2];
         
   
        accList = [ SELECT Id,Name,Type 
                     FROM Account 
                     WHERE BillingState NOT IN ('California','New York')
                    LIMIT 2];
    }

    /**
     * @Description: Queries with multipicklist field needs a little different approach
     * @return: void
     * @param: NA
     */
    public static void multipicklistQueries() 
    {
        //multi-picklists are stored as ; separated values in database
        //Includes or excludes

        //includes
        List<Account> accList = [SELECT Id,Name,Type 
                    FROM Account 
                    WHERE Supported_Regions__c INCLUDES ('EMEA')];
        
        System.debug('Accounts including EMEA:::::::::::: '+accList.size());

         //includes
        accList.clear();
        accList = [SELECT Id,Name,Type 
                    FROM Account 
                    WHERE Supported_Regions__c = 'EMEA'];
        
        System.debug('Accounts equals EMEA:::::::::::: '+accList.size());

        //search for null values
        accList.clear();
        accList = [SELECT Id,Name,Type 
                    FROM Account 
                    WHERE BillingState = null];
        
        System.debug('BillingStates is null:::::::::::: '+accList.size());

        //ALL ROWS - includes deleted records also
        accList.clear();
        accList = [SELECT Id,Name,Type 
                    FROM Account 
                    WHERE BillingState = 'California' 
                    OR BillingState = 'New York'
                    ALL ROWS];
    }

    /**
     * @Description: Traversing relationship queries 
     * @return: void
     * @param: NA
     */
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

    /**
     * @Description: Use the Date lieterals in SOQL Queries
     * @return: void
     * @Param:NA
     */
    public static void queryWithDateLiterals()
    {
        //Queries with date literals
        //Literal	Description
        //YESTERDAY	The date before yesterday.
        List<Account> accList = [SELECT Id,Name,Type 
                                FROM Account 
                                WHERE CreatedDate = YESTERDAY];
        //TODAY	The date today.

        List<Account> accList2 = [SELECT Id,Name,Type 
                                FROM Account 
                                WHERE CreatedDate = TODAY];
        
        accList2 = [SELECT Id,Name,Type 
                                FROM Account 
                                WHERE CreatedDate < THIS_WEEK];
        
        accList2 = [SELECT Id,Name,Type 
                                FROM Account 
                                WHERE CreatedDate < LAST_90_DAYS];

        accList2 = [SELECT Id,Name,Type 
                                FROM Account 
                                WHERE CreatedDate < LAST_N_DAYS:90];
    }

    /**
     * @Description: Update a record locked for update in another session by using FOR UPDATE
     * @return: void
     * @param: NA
     */
    public static void forUpdateQuery()
    {
        //Queries a record at a time based on query
        List<Account> accList = new List<Account> ();
        accList = [SELECT Id,Name,Type 
                    FROM Account 
                    WHERE Type = 'Prospect'
                    LIMIT 5
                    FOR Update];

        for(Account acc: accList)
        {
            acc.Type = 'Other'; 
        }

        //Update the account records
        Database.update(accList);
    }

    /**
     * @Description:FieldSets allow you to gather a set of fields that belong to a particular object into a single place.
     ** @return: void
     * @param: NA
     */
    public static void fieldsetBasedQuery()
    {
        //Retrive fields from field set
        //Get all the fields in a string
        //String fieldName = 'Id';
        List<Schema.FieldSetMember> memberFieldlist = SObjectType.Account.FieldSets.EMEA.getFields();
        System.debug('No. of fields retrieved ::::::::::::::::::::::::::::::::::: '+memberFieldlist.size());

        //Create a string to store the fields
        String fieldNames = '';

        //Iterate the fields and append the fields to the string
        //Ternary operator: (Condition) ? True-value : False-value;
        //First Field: Account Name - fieldName == '' then the fieldName = Name
        //Secind onwards: source - fieldsName = Name then fieldName = Name,Source
        for(Schema.FieldSetMember field : memberFieldlist) 
        {
            fieldNames += fieldNames==''? field.getFieldPath() : ',' + field.getFieldPath();
        }
         System.debug('fieldNames retrieved ::::::::::::::::::::::::::::::::::: '+fieldNames);

        //forming the query correctly, else you may run into Malformed query error
        String soqlQuery = 'SELECT ' + fieldNames + ' FROM Account LIMIT 1';

        system.debug('soqlQuery>>>>'+ soqlQuery);
        //Database.query method can also be used to execute a dynamic query
        List<Account> accWithFieldSetList = Database.query(soqlQuery);
        System.debug('accWithFieldSetList SOQL Query Results ::::::::::::::::::::::::::::::::: '+accWithFieldSetList); 
    }

    /**
     * @Description: Use bind variable to prevent SOQL injection.
     * Database.Query takes a string as a parameter to dynamically construct the SOQL query.
     * @return: void
     * @param: NA
     */
    public static void bindVariableQueries()
    {
        //
        List<Account> lstAccnts = [SELECT Id,Name 
                                   FROM Account
                                   WHERE Type = 'Prospect'];

        //Use bind variables to prevent SOQL injection
        String accType = 'Prospect';

        String soqlQuery = 'SELECT Id, Name, Type, Phone, Industry FROM Account WHERE Type = :accType';
        List<Account> accList = Database.query(soqlQuery);

        //list of contacts to be retrieved 
        List<Contact> lstContacts = [SELECT Id, FirstName, LastName, Phone, Email, AccountId
                                    FROM Contact
                                    WHERE AccountId IN :accList];

        
        //Dynamic SOQL using Database.queryWithBinds
        //Param 1 : Query string
        //Param 2: Map of bind variable name and it's value
        //Param 3: AccessLevel - USER_MODE or SYSTEM_MODE
        Map<String, Object> accountBinds = new Map<String, Object>{'accountName' => 'GenePoint'};
        List<Sobject> sobjectList = Database.queryWithBinds('SELECT Id, Name FROM Account WHERE Name = :accountName',accountBinds,AccessLevel.USER_MODE);
        System.debug('Dynamic soql::' + sobjectList);
    }
    /**
     * @Description
     * dynamically retrieve information about all available objects in your Salesforce org, 
     * allowing you to construct SOQL queries based on object names and field details that are determined at runtime, 
     * rather than being hardcoded in your code. 
     * @return: void
     * @param: NA
     */
    public static void describeGlobalQueries()
    {
        // Get a map of all objects and their metadata
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe(); 
        // Get the 'Account' object type
        Schema.SObjectType accountType = globalDescribe.get('Account'); 

        // Access field information for the 'Account' object 
        Schema.DescribeSObjectResult accountDescribe = accountType.getDescribe(); 

        // Build a SOQL query dynamically based on the retrieved information using global describe
       String soqlQuery = 'SELECT ' + accountDescribe.fields.getMap().keySet() + ' FROM Account LIMIT 1';

        // Execute the query
        List<sObject> accounts = Database.query(soqlQuery);
    }

    /**
     * @Description: Aggregate queries help you to get the summary level information about the data
     * @return: void
     * @param: NA
     */
    public static void aggregateQueries()
    {
        List<Opportunity> lstOpps = [SELECT Amount
                                    FROM Opportunity
                                    WHERE StageName != 'Closed Won'
                                    ORDER BY CloseDate ASC NULLS LAST];

        //Query to group by Lead Source
        //Aggregate Result - Group By
        //Alias works only in apex. if you execute this query in developer console or workbench may not not work.
        List<AggregateResult> agrAccountList = [SELECT Type, COUNT(Id) totalCount
                                                FROM Account
                                                GROUP BY Type
                                                LIMIT 15];

         
        //query to group the sum of opportunities bsaed on the Stage and Account Type
        //total ampunt is the alias for SUM(Amount)
       List<AggregateResult> agrOppList = [SELECT SUM(Amount) totalAmount, Type, StageName
                                            FROM Opportunity
                                            GROUP BY Type, StageName];

        //ieterate over aggregate result
        for(AggregateResult agr : agrOppList)
        {
            System.debug('agrOppList::::::::::::::::::::::::::::::::::::::::::::::::::'+agr);
            System.debug('agrOppList:::totalAmount::::::::::::::::::::::::::::::::::::'+agr.get('totalAmount'));
            System.debug('agrOppList:::Type:::::::::::::::::::::::::::::::::::'+agr.get('Type'));
            System.debug('agrOppList:::StageName:::::::::::::::::::::::::::::::::::'+agr.get('StageName'));
        }

        //List of all the opportunities with specific stages
        List<Opportunity> oppList = [SELECT Id, Name, Amount, StageName
                                    FROM Opportunity];

        Integer iCount = 0;
        Map<String,Integer> mapOppStageCount = new Map<String,Integer>();
        for(Opportunity opp : oppList)
        {
            if(opp.StageName == 'Closed Won')
            {
                iCount++;

                if(mapOppStageCount.containsKey(opp.StageName))
                {
                    Integer iCountStage = mapOppStageCount.get(opp.StageName);
                    iCountStage++;
                    mapOppStageCount.put(opp.StageName,iCountStage);
                }else{
                    mapOppStageCount.put(opp.StageName,iCount);
                }
                System.debug('mapOppStageCount:::::::::::::::::::::::::::::::::::'+mapOppStageCount);       
            }
        }
    }
}
