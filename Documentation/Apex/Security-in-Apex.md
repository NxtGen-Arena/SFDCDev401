# Enforcing Security in Apex classes

Salesforce’s Apex language empowers developers to perform sophisticated business logic and automate complex processes within the platform. Ensuring that this code adheres to the security and sharing models of Salesforce is crucial to maintaining data integrity and privacy. 

Security isn't just a feature; it's a necessity. As developers, understanding the intricate details of Apex security is paramount. Apex, Salesforce's powerful programming language, offers robust mechanisms to control and enforce data access, crucial for building secure applications. 

Apex classes code executes in system mode and has the ability to read and update all data within an organization. Therefore, you must enforce sharing rules, set object and field permissions, and protect against CRUD and FLS violations. You will need to determine which code should be run as system mode—that is, with access privileges to many resources—and which code should be run as user mode, in which the permissions, field-level security, and sharing rules of the current user are enforced.

<h2> Execution Context</h2>

The Configuration and Customization runs either in – System or User Context. The Context determines data visibility and operations allowed. Exposure of sensitive data may result in compromising Data Security and Privacy.

![image](https://github.com/user-attachments/assets/82e05740-762d-4119-b4e8-75acc4c9a5b9)

<h2> How Security is enforced for Apex </h2>

Enforcing security in apex ensures adherence to platform security guidelines, protecting data and unauthorized use of the functions built.Salesforce allows to enforce different layers of security on apex code. Starting with Class level > Object and field level checks > SOQl and DML validations to prevent unauthorized usage.

![image](https://github.com/user-attachments/assets/9b72e843-a36e-4636-98b6-68bf779fbea7)

<h2> 1. Granting Class Level Access </h2>

Salesforce allows to control the access to the Apex classes from Profiles. Enable the Apex Class access for profiles and permission sets before deploying code to production.

<h2> 2. Enforcing Sharing Rules </h2>

Apex generally runs in system context; that is, the current user's permissions and field-level security aren’t taken into account during code execution. Sharing rules, however, are not always bypassed: the class must be declared with the without sharing keyword in order to ensure that sharing rules are not enforced.

>[!Note]
>Apex code that is executed with the executeAnonymous call and Connect in Apex always execute using the sharing rules of the current user.

<h3> Sharing Keywords in Apex </h3>

|Sharing mode| Description|
|-------------|-----------|
|With Sharing| Enforces the sharing rules of the current user. The class respects the user’s sharing settings and limits access to data accordingly.
|Without Sharing| Ignores the sharing rules, allowing the code to run with system privileges. This can access all records, regardless of the user’s sharing rules.
|Inherited Sharing|Inherits the sharing rules from the class that called it, providing flexibility and ensuring consistency in security enforcement. 

<h2> 3. Enforcing Object and Field Level Security in Apex </h2>

Use the Schema.DescribeSObjectResult to check if a user has access to read, create, update, or delete the object. 

```
public void checkObjectPermissions() {
    if (!Schema.sObjectType.Contact.isCreateable()) {
        throw new AuthorizationException('Insufficient permissions to create Contact records.');
    }
    Contact newContact = new Contact(LastName='Smith');
    insert newContact;
}

public void checkFieldPermissions() {
    if (!Schema.sObjectType.Contact.fields.Email.isAccessible()) {
        throw new AuthorizationException('Insufficient permissions to access Contact Email field.');
    }
    Contact contact = [SELECT Email FROM Contact LIMIT 1];
    System.debug(contact.Email);
}
```

<h2> 4. Security-Enforced Queries </h2>

Apex code runs in system mode by default, which means that it runs with substantially elevated permissions over the user running the code. To enhance the security context of Apex, you can specify user-mode access for database operations. Field-level security (FLS) and object permissions of the running user are respected in user mode, unlike in system mode.

**USER_MODE in SOQL:** USER_MODE is a security feature that enforces user permissions and sharing rules directly in SOQL queries.
**WITH SECURITY_ENFORCED:** Automatically enforces field and object permissions in SOQL queries.

```
List<Account> accounts = [SELECT Id, Name FROM Account USING USER_MODE];
public List<Account> getSecuredAccounts() {
    return [SELECT Id, Name FROM Account WITH SECURITY_ENFORCED];
}
```

In Salesforce, prioritizing Field-Level Security (FLS) enforcement with WITH USER_MODE over WITH SECURITY_ENFORCED offers distinct advantages:

* User mode meticulously handles polymorphic fields like Owner and Task.WhatId, processing all SOQL clauses, including the where clause.
* It also identifies SOQL query errors effectively using the getInaccessibleFields() method on Query Exception.
* The AccessLevel class enables user mode enforcement in key database methods including Database.query, Database.getQueryLocator, Database.countQuery, Search.query, and Database DML methods.

<h2> 5. DML Security Enforced</h2>

When Database DML methods are run with AccessLevel.USER_MODE, you can access errors via SaveResult.getErrors().getFields(). With insert as user, you can use the DMLException method getFieldNames() to obtain the fields with FLS errors.

```
Database.SaveResult[] results = Database.insert(records, AccessLevel.USER_MODE);
```

<h2>6. Enforce Security with stripInaccessbile Method</h2>

Use the stripInaccessible method to enforce field-level and object-level data protection. This method can be used to strip the fields and relationship fields from query and subquery results that the user can’t access. The method can also be used to remove inaccessible sObject fields before DML operations to avoid exceptions and to sanitize sObjects that have been deserialized from an untrusted source.

```
List<Account> accountsWithContacts =
	[SELECT Id, Name, Phone,
	    (SELECT Id, LastName, Phone FROM Account.Contacts)
	FROM Account];
  
   // Strip fields that are not readable
   SObjectAccessDecision decision = Security.stripInaccessible(
	                                   AccessType.READABLE,
	                                   accountsWithContacts);
 
// Print stripped records
   for (Integer i = 0; i < accountsWithContacts.size(); i++) 
  {
      System.debug('Insecure record access: '+accountsWithContacts[i]);
      System.debug('Secure record access: '+decision.getRecords()[i]);
   }
 
// Print modified indexes
   System.debug('Records modified by stripInaccessible: '+decision.getModifiedIndexes());
 
// Print removed fields
   System.debug('Fields removed by stripInaccessible: '+decision.getRemovedFields());
```
