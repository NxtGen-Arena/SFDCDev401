# Visualforce Controllers

Visualforce acts as "View" and in order to display the data we need to retrieve the data from "Model". So, controllers acts like mediators betweeb Model and View.

Controllers can be of:

1. **Standard Controllers:**

A Standard Controller provides built-in functionalities for standard and custom Salesforce objects without requiring custom Apex code. It allows CRUD (Create, Read, Update, Delete) operations and follows the security model automatically.

Salesforce provided used in standard lightning functionality. No need to write a single line of code. For Standard Controllers we need to pass Id as a "querystring paramater".

Use the standard controllers - When you need to display or manipulate records of a standard/custom object without writing custom logic.

```
<apex:page standardController="Account">
    <h1>Account Name: {!Account.Name}</h1>
</apex:page>
```
   
3. **Custom Controllers:**

A Custom Controller is an Apex class that provides custom business logic. Unlike a Standard Controller, it does not inherit any existing Salesforce behavior, so you must handle all CRUD operations manually.

Use Custom Controllers, When you need complete control over logic, data handling, and security.

### Apex Class

```
public class AccountController {
    public List<Account> accounts { get; set; }
    
    public AccountController() {
        accounts = [SELECT Id, Name FROM Account LIMIT 10];
    }
}

```
### Visualforce Page

```
<apex:page controller="AccountController">
    <apex:repeat value="{!accounts}" var="acc">
        <p>{!acc.Name}</p>
    </apex:repeat>
</apex:page>
```
5. **Controller Extensions:**
Leverage benfits from Standard as well as Custom Controllers. A Controller Extension allows adding or overriding functionality of a Standard or Custom Controller. It enhances the existing controller without replacing it.

When you need to extend a Standard Controller with additional logic, controller extensions are useful.

### Visualforce Page
```
<apex:page standardController="Account" extensions="AccountExtension">
    <h1>Account Name: {!Account.Name}</h1>
    <apex:form>
        <apex:commandButton value="Update Name" action="{!updateAccount}" />
    </apex:form>
</apex:page>
```
### Apex Class
```
public class AccountExtension {
    private final Account acc;

    public AccountExtension(ApexPages.StandardController stdController) {
        this.acc = (Account)stdController.getRecord();
    }

    public void updateAccount() {
        acc.Name = acc.Name + ' - Updated';
        update acc;
    }
}

```

<h2>Comparison</h2>

|Controller Type	|Purpose|	Security & CRUD Handling	|Use Case |
|-----------------|-------|----------------------------|---------|
|Standard Controller|	Uses built-in object functionalities	|Follows Salesforce security model automatically	|Simple record display and CRUD operations
|Custom Controller	|Implements custom logic and operations	|Requires explicit security and CRUD handling	|Complex business logic, API calls, and external system interactions
|Controller Extension	|Extends Standard/Custom Controller	|Follows security of the base controller	|Adding custom logic while still leveraging built-in functionalities
