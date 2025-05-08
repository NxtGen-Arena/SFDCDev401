# Standard Controllers in Visualforce

<h2>What is Standard Controller</h2>
<p> It is automatically provided by the Force.com engine, and available at design and runtime for most standard and all custom sObjects. It is tightly integrated with sObject metadata, configurable for each sObject, and it drives the runtime page materialization, record management and action processing of most of the built-in user interface. This includes search layouts, record detail page layouts, record list views and the associated actions and behavior.

</p>

In the MVC pattern, 
- Views know how to present their data and accept input from the user, butknow nothing about how to actually fetch that data or process it.
- Data Models know how to perform various operations such as Save, Delete or Merge, but need to be told when to operate, and need to be provided with the data to operate on.
- Controller’s job is to marshal both data and action selection, as initiated by the user from within the View, to the Model. Controllers are also responsible for responding accordingly with navigation redirection based on the results of any particular action.

_In the Salesforce MVC paradigm, the standard controller facilitates the ability of users to access and interact with the structured business data contained in records and displayed in the materialized user interface._

<h3>Controlling Data</h3>

One of the key tasks of the standard controller is to provide that data, and to facilitate binding a view’s controls to the record’s fields, for either display or input.

1. Binding controller to Page:
   we can associate a standard controller with a Visualforce page by use of the _standardController_ attribute on the component. Identify the
   standard or custom sObject for the controller as follows. Once bound, the page associates within the context of the specified sObject

2. Specifyng Record Id:
   The standard controller requires record context that can be provided by including a URL parameter named "id" and assigned with a valid 15- or
   18-digit record ID. The record specified by the ID must match the sObject type associated with the StandardController on the page, or an
   error will be thrown when the page attempts to render.

   ```
   <base_url> /apex/AccountEngine?id=001A0000005HjZL
   ```
   
4. Access Fields Data:
   - The standard controller will provide the data from an associated record and allow the record’s fields to be bound to the page’s various
   components using merge expression syntax.
   - DOT notation allows to access any related fields data similar to how we access within the formulas.
   - Lists of records from child sObjects can be referenced and bound to components that render collections. Note that the value of the list
     attribute is the literal name of the field representing the child relationship

```
<apex:page standardController ="Account" >
  <apex:inputField value="{!Account.name}" />
  <apex:inputField value="{!Account.Owner.Firstname}" />
  <apex:relatedList list=”Contacts” />
</apex:page>

```

<h2>Referencing List of Records</h2>

The standard controller instruction set also manages lists of records, such as in standard list view pages where users can configure both the fields displayed in columns, as well as filters on the records displayed. The StandardController as bound to a Visualforce page is also capable of fetching a list of records and managing paging through the list. 

Its behavior as a set controller is activated by adding an additional parameter named recordSetVar on the apex:page component.
```
<apex:page standardController=”Account” recordSetVar=”accounts” >
```

Leveraging this mechanism allows your page to operate on a collection of the specified sObject bound to the controller.
The _recordsSetVar_ specified becomes a reference to a List of the sObjects, and the controller will now have the following additional actions available to be directly bound to command controls, (in addition to the primary set of actions available on a bound StandardController
managing only one sObject):
•	 first displays the first page of records in the set.
•	 last displays the last page of records in the set.
•	 next displays the next page of records in the set.
•	 previous displays the previous page of records in the set.

You also have access to two new attributes, filterId and listViewOptions for managing list view selection and applying filters.
