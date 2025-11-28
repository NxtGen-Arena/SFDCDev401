# Payment Processing System

<p>

- StayEase Hotel accepts multiple modes of payment:Credit Card,UPI, PayPal,Corporate Voucher etc
- Each payment type:
- ** has its own integration,
- ** has different validations,
- ** but must follow common steps (validate → process → update booking).

This leads to code duplication, inconsistency, and tight coupling.
So we introduce a clean architectural pattern using Abstract Classes.

<img width="800" height="400" alt="image" src="https://github.com/user-attachments/assets/fde06610-ac95-453c-99c3-f1803802d282" />



</p>

<h2>WITHOUT ABSTRACT CLASS</h2>

❗Issues:

* Duplicated logic;Any change must be replicated in all payment classes
* Different naming conventions
* No common structure, method names are different for same implementation logic
* Hard to maintain
* New payment type = more copy-paste

✅ IMPROVED REAL-TIME ARCHITECTURE USING ABSTRACT CLASS

<b>Architectural Pattern Used: Template Method Pattern</b>

<p> We create:

1. Abstract Payment Processor - 
   * Defines the common workflow
   * Child classes must implement validations and processing

2. Concrete Payment Classes
   * Override only what is different
   * Follow the same parent contract
  
3. UI Level Classes - App Layer
   * Hides Core logic while enabling front end to access the business function

</p>

<p>List of Classes</p>

|Class Name| Purpose|
|----------|--------|
|PaymentProcessingEngine|Abstrct classs implementing Core business functions. contains concrete and abstrct methods|
|CreditCardPayment| extends Abstrct class PaymentProcessingEngine, provides implementation for abstract methods|
|PaymentController| Class to be used as a controller to access and expose data to UI layer.|
