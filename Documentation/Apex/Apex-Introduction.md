# Introduction to Apex

## What is programming Language
Programming languages are the foundation of software development. They are used to write instructions that computers can understand and execute. Programming languages are important because they allow developers to create software that can solve complex problems, automate tasks, and improve efficiency.
Programming Languages

## What is Apex? 

Salesforce Apex is a powerful programming language developed specifically for the Salesforce.com platform. It's an **object oriented** server side programming language. It's not required to have prior knowledge of JAVA, c++ to learn Apex. Apex runs on server side and helps developers build the customization which can be invoked based on user interation like button click, through Low Code tools like Flows, or through API's.

* Apex is Salesforce's cloud-based, object-oriented programming language specifically designed for customizing and extending apps on the force.com platform.
* Apex is interpreted, executed, and controlled entirely by the Lightning Platform.Apex has well defined data types and structure to simplify 
  writing code. Apex is **cases insensitive**.
* Tailored for data access and manipulation and Designed to work effectively and efficiently in a multi-tenant environment.
* Successfully compiled code is saved as metadata to the force.com database. The Apex runtime engine retrieves the compiled code when it is needed.
* Hosted: saved, compiled, executed on Lightning Platform servers
* Object oriented: supports classes, interfaces, and inheritance
* Strongly typed: validates references to objects at compile time
* Multitenant aware: guards closely against runaway code by enforcing limits, preventing code from monopolizing shared resources
* Integrated with the database: straightforward to access and manipulate records. Provides direct access to records and fields, and gives
  statements and query languages to manipulate those records.
* Data focused: provides transactional access to the database, which allows you to roll back operations
* Easy to test: provides build-in support for unit test creation, execution, and code coverage. Ensures that all custom Apex code works as          expected by executing all unit tests before platform upgrades.
* Versioning of custom code which means you can save your code against different versions of the API. Versioning enables to leverage bug fixes and new enahncements to Apex with each release.
* Case-insensitive
  
Use Apex when you need advanced business logic and complex calculations to support business functions. Apex is primarily used for transactions. It's tailored for data access and data manipulation on the platform, and it enables to add custom business logic to system events. 

## Understanding Apex
Salesforce platform native functionality provides powerful tools and features to build applications faster and with Low Code automations. 

### Model
Objects - Standard and Custom Objects

### View
* Page Layouts & Lightning Pages 
* Flows, LWC, Visualforce

### Controller
* Standard CRUD and Flow automations
* Apex


![image](https://github.com/user-attachments/assets/21bddbec-3c56-4c81-88be-86b273e720b7)



## When to use Apex
* Implement  complex business processes not supported by Low Code or Native features
* Custom logic for backend implementations involving APIs and other integration with native or non native functions
* Complex validations to be performed against record data
* Creating APIs, Web Services, Email services
* Complex User interfaces cutting across multiple objects and processes and can be supported with Lightning Components, Visualforce etc

# How Apex Works
Apex is compiled, stored and runs natively on Lightning Platform.  Apex can be invoked then from Buttons, actions, other processes and user interface. Everytime you write a code, it's compiled and converted into instructions for Apex Runtime interpreter and then these instructions are saved as **metadata**

![image](https://github.com/user-attachments/assets/d32c9049-4777-4521-b10e-424d4b391709)

All Apex code runs on the Lightning Platform, which is a **shared resource** used by all other organizations. To enable consistent performance and scalability and prevent resource monopolisation, the execution of Apex is bound by governor limits that ensure no single Apex execution impacts the overall service of Salesforce. This means all Apex code is limited by the number of operations (such as DML or SOQL) that it can perform within one transaction or process.

# Apex development process
1. Choose an Org for building application 
2. Select your Coding Environment and tool and integrate with 
3. Write your apex code
4. Test apex code
5. Deploy code using DevOps processes
   
