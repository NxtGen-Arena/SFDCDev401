# Triggers Homework

<Details>
  <Summary>Account Address Sync </Summary>
  
  **Business Challenge**:
  
  Customer Service reps from GreenTech Inc are often finding the contact addresses not in sync with their parent accounts. This delays the communication and also adds additional clicks before finally 
  finding the address. Manually navigating and updating addresses on related contacts has been biggest challenge for them.

 **What is Expected**: 
 
 Business wants to automate the overall process. When the Shipping Address on Account is updated they need the related Contacts addresses to be updated. but there are certain contacts where the addresses 
 should not be copied from Account and reps should be able to mark such contacts. Also, CAL (Customer Account Lead) on account should be notified about the changes to Address on Account. This should be also 
 logged under Account activity. 

 **Additional Business Requirements**
 * The sync should be controlled and should be able to be triggered based on the Account flag "Enable Address Sync".
 * This function should work only for the Active Accounts.
 * Business also wants to capture when was the last address change triggered.

</Details>
