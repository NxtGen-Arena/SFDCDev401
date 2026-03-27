public with sharing class ContactInitDemo_cont 
{
    @AuraEnabled
    public static Contact getContactDetails(Id contactId){
        try {
            return [
                SELECT FirstName,LastName,Email,Phone
                FROM Contact
                WHERE Id = :contactId
                LIMIT 1
            ];
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching contact:'+ e.getMessage());
        }
    }
}
