# How Can Salesforce be customized?

When Standard OOTB features cannot be completely used for implementing Business Function, customize the Salesforce platform to extend the capabilities.

**Declarative customizations** are important tools that make programmatic solutions simpler and more efficient.
> [!Tip] Don't reinvent the wheels, config should b e your first choice.



![image](https://github.com/user-attachments/assets/e44bfc39-9fa1-4240-a258-95c619e6b3e0)

<Details>
  <summary> Customizing Data Model </summary>

  ## Standard Object
  
  - Object predefined by force.com platform. OOTB functionality provided by Salesforce.
  - Can be customized upto certain extent.
  - New fields can be created, new picklist values can be adde to existing fields, add lookup filters on relationship fields.
  - Standard Fields cannot be deleted. They can be removed from page layouts with few exceptions.

  ### Few Standard Objects:
  1. Account - A company with which we do business
  2. Contact - An individual associated with Company or business accounts
  3. Opportunity - A propsective Sales Deal
  4. Case - Customer issue or complaint

## Custom Object
  
  - Created by a developer to capture and manage additional data based on specific business requirements.
  - API Names for Custom object and fields are suffixed with "__c"
  - Fully customizable for fields creation and deletion.
  - Grant access to custom objects and fields post creation.  Object permission determine whether users can view,create,edit or delete records       in an object.

</Details>
