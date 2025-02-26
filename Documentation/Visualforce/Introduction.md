# What is Visualforce

Visualforce is a markup language used by Salesforce developers for designing custom user interfaces in their CRM platform. It provides a set of tags, components, and controllers, allowing developers to create customized pages integrating with Salesforce's back-end database. Visualforce offers a wide range of design capabilities focusing on delivering a highly interactive UX.

Visualforce is nothing but one of the framework of Force.com which is component-based user interface. A tag based language more similar to HTML is used by visualforce.  Each tag corresponds to user interface component. It also has 100 built-in components with custom build component development support.

## How Visualforce is used in Salesforce

Visualforce allows developers to create page layouts using HTML, CSS, and JavaScript, which can be rendered dynamically based on user input and other factors. This means that developers can develop custom pages with a high degree of flexibility, enabling them to tailor the user experience to the specific needs of their application.

Visualforce pages can be tested using standard Salesforce testing tools, which ensures that the code is robust and functional. The pages can be composed of reusable components, which makes development easier and more efficient. These components can be shared across multiple pages, which reduces development time and improves code reuse.

Developers can use Visualforce’s variety of standard and custom components, such as input fields, lists, and buttons, or utilize standard styling and layout options, as well as custom CSS and JavaScript, to create rich and interactive user interfaces.


<h3> Salesforce MVC Architecture </h3>

The Model-View-Controller (MVC) architecture is a widely used design pattern that separates an application into three core components:

1. Model – Represents the data and business logic (e.g., Standard and Custom Objects in Salesforce).
2. View – Handles the user interface and presentation (e.g., Visualforce Pages).
3. Controller – Manages user interactions and business logic execution (e.g., Apex Controllers).

<h3> Visualforce and MVC Implementation </h3>

Salesforce supports the MVC pattern through Visualforce, which enables developers to build applications efficiently in the cloud.Visualforce executes on server side.

* Model: Standard and Custom Objects store and manage data.
* View: Visualforce pages provide the front-end interface, similar to JSP or ASP pages, and enable dynamic UI rendering based on user needs.
* Controller: Apex Controllers (Standard, Custom, or Extension Controllers) handle user interactions and business logic execution.

### Key Features of MVC in Visualforce

* Supports Standard and Custom Objects for data management.
* Uses Apex to write custom controllers or extend standard controllers.
* Leverages Standard AJAX Components for dynamic UI interactions.
* Incorporates Formula Expressions for binding data and actions to UI components.
* Provides Auto-Generated Controllers to simplify database interactions.

### Salesforce-Specific MVC Enhancements

Salesforce also introduces three specialized components to enhance MVC implementation:

1. Visualforce Pages – Define the UI structure and presentation.
2. Visualforce Components – Reusable UI elements for modular development.
3. Controllers – Apex-based logic handlers that control application behavior.

By following the MVC pattern in Salesforce, developers can build scalable, maintainable, and efficient applications that align with industry best practices.

![image](https://github.com/user-attachments/assets/78e191f2-ea02-4c52-9cf4-662db13df591)

<h2> Designing Visualforce Pages</h2>

Visualforce pages are created by composing components, HTML, and optional styling elements available in Force.com platform. To make animation or rich user interface, visualforce can integrate with any standard web technology like JavaScript.

### Creating Visualforce Pages

You can create Visualforce pages using -
1. Developer Console
2. Setup>Visualforce Pages
3. Visual Studio IDE
