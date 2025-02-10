# Where can we write code?

You can write Apex code using multiple tools:

1. Developer Console - Salesforce native platform tool. Not so efficient since it does not proivde any versioning or recovery of code.
2. CLI - Command Line interface allowing to write code and create component using command line interface.
3. Visual Studio - Based on CLI. Provided User interface for Salesforce development and deployment. Efficient and provides many extensions for produtivity improvements. Install locally and retrieve the code from Salesforce. Helps parallel development and enables to retain changes locally.
4. Code Builder - Browser based Visual Studio tool. Can be enabled for sandboxes from setup > code builder. No need to locally install visual studio.
5. Third Party 

<h1>Developer Console</h1>
<p>
  
Developer Console allows to perform operations such as:
* Code writing and compilation of code: create an apex class, trigger, lightning component or visualforce page, etc using the source code editor and as soon as you save your code it will automatically be compiled on the force.com server. Use “Execute Anonymous Window” from Debug menu to create executing apex code.
* Explore the Components:**  Explore  Salesforce components like – Aura, Apex Class, Objects, Triggers from Console directly. 
* Debugging: Using the Developer Console and the debug logs, you can debug Apex code, set checkpoints to make debugging easier.
* Testing: build and execute test cases for a specific apex class and inspect the code coverage.
* SOQL/SOSL  queries: perform both SOQL and SOSL queries.
* Color coding and autocomplete: In addition to auto-completion for class and method names, the editor uses a color scheme to make code elements easier to read.
</p>

<h1>Code Builder</h1>
<p>

* Provides a modern developer experience and work from anywhere with web-based Visual Studio Code IDE that connects seamlessly to your Salesforce org.
* VS Code is a powerful IDE but it requires you to install the app and related tools on your computer. Code Builder enables you to use VS Code in your browser without the need to install anything.
* Code Builder is installed as a managed package, and it comes with everything you need: VS Code, Salesforce extensions, and Salesforce CLI.
* No matter whether you’re using VS Code on your desktop or Code Builder from a browser, the Salesforce extensions you access are the same.
* Code builder is managed package which needs to be installed from setup > Search > code builder > install
* Based on User Licenses and The number of Code Builder licenses available depends on the Salesforce edition.

### Enabling Code Builder

1. Click the Setup icon (gear icon in the upper right corner), and click Setup.
2. In Quick Find, search for Code Builder, and select Code Builder.
3. Dismiss the error message. This is due to the pre-installation of Code Builder.
4. Click the Enable Code Builder toggle to enable Code Builder. Review and accept the license agreement.
5. Click the App Launcher icon (waffle icon in the upper left corner), and select the Code Builder app.
6. In the Code Builder Dashboard, click the Launch button.
7. Open the command palette (Press CMD+SHIFT+P on Mac or CTRL+SHIFT+P on PC).
8. Search for Authorize an Org. If it is not yet available, wait Code Builder to fully initialize.
9. Select SFDX: Authorize an Org. > Project Default
10. Enter the org alias and press Return.
11. Connect and you are set to create your first project.

![image](https://github.com/user-attachments/assets/6ffbe1c0-912c-4f6c-9ef2-f146c8f1a75f)

</p>

<h1>Visual Studio Code</h1>
<p>

* Allows developers to code locally and synchronize with the salesforce org you are using.
* Depend heavily on two runtime environments behind the scenes: Node.js and Java.
* Node is a JavaScript runtime environment that’s used for the Salesforce CLI, Lightning Web Components, and the overall structure of your Salesforce project.
* Java is used for the Apex language server.
* Apex is used to interact with the Salesforce database and backend.
* The Apex language server helps write code faster by providing the Visual Studio Code extension with useful code-editing features, such as code completion.
* Install additional extensions to enable more streamlined and faster development. E.g: Prettier – Code Formatter, Agentforce for Developers, Apex, Apex PMD, Apex Replay Debugger, Aura Components,Lightning Web Component, ESLint 

![image](https://github.com/user-attachments/assets/c0242b7b-3d3d-4bb1-8172-035e6626669f)

  
</p>

<Details> 
  <Summary><h2>Create a new Salesforce project in Visual Studio Code (VS Code)</h2></Summary>

<h3>Setup your VS Code for Development</h3>

1. Create a new Salesforce Developer org for this training  - [Sign up](https://developer.salesforce.com/signup) and reset your password
2. Install VS code and CLI aloong with the extensions mentioned in the next step. Follow steps - [Quick Start: Visual Studio Code for Salesforce Development](https://trailhead.salesforce.com/content/learn/projects/quickstart-vscode-salesforce?trail_id=set-up-your-workspace-and-install-developer-tools)
3. Enable the Extensions given below:
   - Apex
   - Apex PMD
   - Aura Components & Lightning Web Components
   - Prettier - Code Formatter
   - Salesforce Code Analyzer
   - SOQL
   - Visualforce
4. Create a new Apex Class - "HelloWorld" using developer console

## **Additional references:**

- [How to Setup Visual Studio Code for Salesforce](https://www.apexhours.com/how-to-setup-visual-studio-code-for-salesforce/) 

<h3>Create Project with Manifest and Authorize an Org</h3>

1. Open the command ctrl + shift + p (windows) or cmd + shift + p(macOS)
2. type **SFDX:Create Project with Manifest**
3. Select Standard and type the name of the Project
4. Run **SFDX:Authroize an Org** and select login url (production for developer env)
5. Provide a user friendly org alias > new window to login to salesforce will open
6. In your borwser, select the credential for org to be used and Allow

<h3>Retrieve the Source Code from connected Org</h3>

1. Within your project structure > navigate to "package.xml" inside manifest.
2. Validate the components to be retrieved.
3. Right click and execute **SFDX: retrieve this source from Org**. **NOTE**: If your org has too much customization, number of components may slow down the retrieval. Unders these circumstances you can selectively retrieve.
4. check the folders for the components.

<h3>Deploy the code from VS to Salesforce Org</h3>

1. Save the changes within VS Code using cmd + s (macOS) or ctrl +s (windows)
2. Right click and execute **SFDX:Deploy this source to org**
3. Validate the changes in Salesforce

</details>

Best Practice: 
- Before starting to make changes in any components, first perform "SFDX:Retrieve this source from org" to override any changes made by other developers.
