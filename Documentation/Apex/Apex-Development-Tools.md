# Where can write code?

You can write Apex code using multiple tools:

1. Developer Console - Salesforce native platform tool. Not so efficient since it does not proivde any versioning or recovery of code.
2. CLI - Command Line interface allowing to write code and create component using command line interface.
3. Visual Studio - Based on CLI. Provided User interface for Salesforce development and deployment. Efficient and provides many extensions for produtivity improvements. Install locally and retrieve the code from Salesforce. Helps parallel development and enables to retain changes locally.
4. Code Builder - Browser based Visual Studio tool. Can be enabled for sandboxes from setup > code builder. No need to locally install visual studio.
5. Third Party 

We are focused on understanding Visual Studio Code and extensions we can use.

<Details> 
  <Summary><h2>Create a new Salesforce project in Visual Studio Code (VS Code)</h2></Summary>

###  Installing VS Code Locally
[Setup VS Code with Extensions](Homework/Preparing-for-Development/Setup-VSCode.md)

### Create Project with Manifest and Authorize an Org

1. Open the command ctrl + shift + p (windows) or cmd + shift + p(macOS)
2. type **SFDX:Create Project with Manifest**
3. Select Standard and type the name of the Project
4. Run **SFDX:Authroize an Org** and select login url (production for developer env)
5. Provide a user friendly org alias > new window to login to salesforce will open
6. In your borwser, select the credential for org to be used and Allow

### Retrieve the Source Code from connected Org

1. WIthin your project structure > navigate to "package.xml" inside manifest.
2. Validate the components to be retrieved.
3. Right click and execute **SFDX: retrieve this source from Org**. **NOTE**: If your org has too much customization, number of components may slow down the retrieval. Unders these circumstances you can selectively retrieve.
4. check the folders for the components.

### Deploy the code from VS to Salesforce Org

1. Save the changes within VS Code using cmd + s (macOS) or ctrl +s (windows)
2. Right click and execute **SFDX:Deploy this source to org**
3. Validate the changes in Salesforce

</details>

Best Practice: 
- Before starting to make changes in any components, first perform "SFDX:Retrieve this source from org" to override any changes made by other developers.
