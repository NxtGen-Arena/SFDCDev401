# Create a new Salesforce project in Visual Studio Code (VS Code)

## Create Project with Manifest and Authorize an Org

1. Open the command ctrl + shift + p (windows) or cmd + shift + p(macOS)
2. type **SFDX:Create Project with Manifest**
3. Select Standard and type the name of the Project
4. Run **SFDX:Authroize an Org** and select login url (production for developer env)
5. Provide a user friendly org alias > new window to login to salesforce will open
6. In your borwser, select the credential for org to be used and Allow

## Retrieve the Source Code from connected Org

1. WIthin your project structure > navigate to "package.xml" inside manifest.
2. Validate the components to be retrieved.
3. Right click and execute **SFDX: retrieve this source from Org**. **NOTE**: If your org has too much customization, number of components may slow down the retrieval. Unders these circumstances you can selectively retrieve.
4. check the folders for the components.


## Depoy the code from VS to Saelsforce Org

1. Save the changes within VS Code using cmd + s (macOS) or ctrl +s (windows)
2. Right click and execute **SFDX:Deploy this source to org**
3. Validate the changes in Salesforce

Best Practice: 
- Before starting to make changes in any components, first perform "SFDX:Retrieve this source from org" to override any changes made by other developers.
