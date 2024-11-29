# Introduction to Apex

## What is programming Language
Programming languages are the foundation of software development. They are used to write instructions that computers can understand and execute. Programming languages are important because they allow developers to create software that can solve complex problems, automate tasks, and improve efficiency.
Programming Languages


## What is Apex?
Salesforce Apex is a powerful programming language developed specifically for the Salesforce.com platform. It's an **object oriented** server side programming language. It's not required to have prior knowledge of JAVA, c++ to learn Apex. Apex runs on server side and helps developers build the customization which can be invoked based on user interation like button click, through Low Code tools like Flows, or through API's.

Apex has well defined data types and structure to simplify writing code. Apex is **cases insensitive**. 

## Understanding Apex
Salesforce platform native functionality provides powerful tools and features to build applications faster and with Low Code automations. 

### Model
Objects - Standard and Custom Objects

### View
* Page Layouts & Lightning Pages 
* Flows

### Controller
* Standard CRUD and Flow automations

Use Apex when you need advanced business logic and complex calculations to support business functions. Apex is primarily used for transactions. It's tailored for data access and data manipulation on the platform, and it enables to add custom business logic to system events. 


Some of the distinct features of Apex are - 
- Direct access to Data Model using SOQL
- Use DML's (insert,update,delete)
- Apex is interpreted, executed, and controlled entirely by the Lightning Platform.
- Provides built-in support for unit test making it easier for developers to confirm the behaviour
- Versioned which means you can save your code against different versions of the API. Versioning enables to leverage bug fixes and new enahncements to Apex with each release.

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
   
