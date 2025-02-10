# Flow Resources

## Variables in Flow

* Variable helps store data within flow. Everything is resource in flow.
* Variables can be made accessible outside Flow by declaring them as - Available for Input and/or Output.
* Variable can be of data type - Text, Number, Currency, Boolean, Date, Date/Time, Picklist, Multi-Picklist.
* They can also store collecctions.

## Choice 

* Choices are used as options that users can select from within radio buttons or multi-select picklist components.
* composed of both a label and a value, which are often confused – the label is displayed to end users, while the value is what is stored behind the scenes and used by the Flow.
* Allows to create single picklist choice at a time.
* Values are stored as individual choice items. But can be used in any Picklist field.
* Make sure to use the correct naming for the choice field APIs.

<img width="244" alt="image" src="https://github.com/user-attachments/assets/7d558f7e-5092-42ce-82de-846788fca4b3" />

***Types of Choices***
|Type|Description|
|-----|----------|
|Collection Choice Set|group of options made up of existing Collection Variables used in your Flow. can only reference Collections that already exist, unlike Record Choice Sets and Picklist Choice Sets that are constructed when they are configured.
|Record Choice Set|While the Record Choice Set behaves similarly to the Collection Choice Set, it is populated using a query built into the set itself, whereas a Collection Choice Set uses a collection that already exists within the Flow.
|Picklist Choice Set|Picklist Choice Sets use Picklist fields that are configured on objects to provide options within radio buttons or multi-select picklist Screen components.

***How to Create Choices***

If we select the “Display text input”, on selection of the picklist choice the new input text is added. This input field can be marked as required.Validate can also enforce data validation on the field.

<img width="848" alt="image" src="https://github.com/user-attachments/assets/cee4ec0f-d502-4fd4-98ef-093414e75ca6" />


## Collection Choice Set

Use an existing collection of records or external data to generate a set of choices. Collection choice sets are useful when a flow reuses the same dataset over multiple screens. 

<img width="819" alt="image" src="https://github.com/user-attachments/assets/b68fd949-a600-492d-8def-de668219e822" />

## Lookup Component

The Lookup flow screen component isn’t compatible with mobile devices or standalone Aura apps.Dependent lookup filters aren’t supported.
If the Maximum Selections value is 1 and the Record ID Collection and Record ID are both changed, the Record ID takes precedence. The Record ID Collection is ignored.Field API Name and Object API Name are case-sensitive.The Lookup flow screen component doesn’t support filtering by the source object record type.

### 1. Use Lookup field from Object

Drag and drop the lookup component on the screen. Use for Searching records from Salesforce or collection within flow.

**API Name:** Component API Name <br/>
**Field API Name:** The API name of a lookup field on the source object referenced in Object API Name. The lookup field referenced in Field API Name must be a field on the object referenced in Object API Name.<br/>
**Label:** The text displayed at the top of the component<br/>
**Object API Name:** The API name of the source object that has the lookup field referenced in Field API Name.The source object can be any object that has the type of lookup field that you want to use.The lookup field referenced in Field API Name must be a field on the object referenced in Object AI Name.<br/>
**Record Id:** Default record to be displayed in selection

<img width="453" alt="image" src="https://github.com/user-attachments/assets/c1b38982-3394-452d-8f04-59f3f087f9da" />

### 2. Use Lookup field from Record Variable

Create a record variable with desired sObject. Object field directly dragged based on the “Record Variable”. Properties are not editable. User can set the Field Visibility. Visibility,editability is carried from the Object level and field level security of object for logged in user.

<img width="677" alt="image" src="https://github.com/user-attachments/assets/2785f2a4-5141-4e1f-960a-b1c6d2d284b4" />

## Other Resource Types

* Constant: Variable with static data value. Value of constants cannot be changed in flow.
* Formulas: Like field formulas use the functions and use them as merge fields. recalculated every time they’re accessed. A flow formula can contain up to 3,900 characters.
* Text Templates: store a larger block of text, or maybe you need that text to be formatted in a specific way.Use a text template to store the body of an email or a chunk of formatted text to reuse on multiple screens. Like formulas, text templates can also use variables and screen components as merge fields.













