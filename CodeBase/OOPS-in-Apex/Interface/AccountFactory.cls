public with sharing class AccountFactory implements IDataFactory
{
    public sObject createRecord(){
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        return acc;
    }

    public sObject getRecord(){
        //return new Account(name = 'My Account');
        return [SELECT Id, Name from Account WHERE Name = 'Test Account' limit 1];
    }
}
