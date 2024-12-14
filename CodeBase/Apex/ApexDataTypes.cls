/*
Description: This class is used to demonstrate the various data types in Apex
Author: Sheetal Chougule
Version History:
    Modified by | Changes Made  | US #
    Sheetal Chougule | Updated the comments to reflect the changes made to the class. | WBS-1*/

public with sharing class ApexDataTypesDemo {

    public ApexDataTypesDemo() {

        //Variable Declaration and Assignment/initialization
        //Integer - A integer primitive variable type that contains 32-bit integer numbers w/o decimal

        //1. Primitive data types
        Integer iCount = 1;

        String strName = 'Customer Name';
        Decimal decValue = 123.45;
        Double piValue = 3.14159; //64 bit number with decimal point
        Long lngValue = 123465464L; // 64 it number wihtouth decimal point
        Boolean bIsActive = true; // values permissible = true, false, null
        Id accntId = '003000003566TYG'; //  Unique identifier assigned to each Salesforce object record.
        Date dtToday = Date.today(); // date primitive variable type that contains date with out time
        Datetime dtNow = Datetime.now(); // date time primitive variable type that contains date and time
        Time tmMorningTime = Time.newInstance(9,0,0,0); // time primitive variable type that contains time without date


        //Print the values of variables in system debug log.
        system.debug('Integer data type: ' + iCount);
        system.debug('Decimal data type: ' + decValue);
        system.debug('Double data type: ' + piValue);
        system.debug('Long data type: ' + lngValue);
        //system.debug('Boolean data type: ' + isActive); //This will throw compile time error becaise isActive is not a variable declared.
        system.debug('Boolean data type: ' + bisActive);
        system.debug('Date data type: ' + dtToday);
        system.debug('DateTime data type: ' + dtNow);
        system.debug('Time data type: ' + tmMorningTime);

        //Apex data types inherit from object
        Object obj = 'This is a string object';
        Object intData = 10;
        Object myBoolean = false;

        //SObject - A sObject is a generic Salesforce object that can contain a variety of data. Salesforce is tightly integrated with the database.
        //Use Case = When you need to perform dynamic queries that can return a mix of different Salesforce objects.
        //[NOTE]: Every recrod in Salesfoce is natively represented as sObject
        sObject acnt = new Account();
        acnt.put('Name', 'My Account Name'); //put - is used to add values to the object

        Account accntrec = new Account();  //creaitng an account object with name
        accntrec.Name = 'test Account for Apex data type';

        //sObject paymentInfo = new PaymentInfo__c(); // creating custom object instance. 

        //Blob stores the binary data  in a variable
        Blob blobTest = Blob.valueOf('Test data');
        system.debug('blobTest = ' + blobTest);
    }
    

    public static void constantVariables(){

        //Constant Variable
        final Integer iCount = 10;  //"final" keyword is used when the value of the variable will not be changed in future.
        iCount = 20;  //Run time Error: System.FinalException: Final variable has already been initialized

        system.debug('constant variable = ' + iCount);

        static final Integer iCountStatic = 10;  //"static" keyword is used when the value of the variable will be used across the entire application
        system.debug('constant variable = ' + iCountStatic);
    }

    public static void variableAssignmentsDemo(){
        Integer iCount = 10; //Assigning Value to a variable
        iCount = iCount + 10;//Assigning value to a variable through expression
        iCount += 10;//Assigning value to a variable through expression

        //Variable initialized with soql & SOSL
        Account accnt = [SELECT Id, Name FROM Account LIMIT 1];
        system.debug('Account record' + accnt);

        //instance of a class
        Account accnt = new Account();
        ApexDataTypesDemo demo = new ApexDataTypesDemo();
    }
}
