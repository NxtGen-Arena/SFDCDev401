public with sharing class InstituteController {

    // Fetch all institutes
    @AuraEnabled(cacheable=true)
    public static List<Account> getInstitutes() {
        return [
            SELECT Id, Name, BillingCity
            FROM Account
            WHERE Type = 'Institute'
            ORDER BY Name
        ];
    }

    // Fetch institutes by city
    @AuraEnabled(cacheable=true)
    public static List<Account> searchInstitutes(String city) {

        return [
            SELECT Id, Name, BillingCity
            FROM Account
            WHERE Type = 'Institute'
            AND BillingCity = :city
            ORDER BY Name
        ];
    }
}
