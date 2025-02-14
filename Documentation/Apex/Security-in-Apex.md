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




