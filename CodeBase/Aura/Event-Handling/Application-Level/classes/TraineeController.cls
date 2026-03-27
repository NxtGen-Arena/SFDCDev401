public with sharing class TraineeController 
{
    @AuraEnabled
    public static contact getTraineeById(Id TraineeId) {
        return [
            SELECT Id, Name, Email FROM Contact WHERE Id = :TraineeId];
    }

    @AuraEnabled(cacheable = true)
    public static List<contact> getTrainees(Id accountId)
    {
        return [
            SELECT Id, Name, Email 
            FROM Contact 
            WHERE AccountId = :accountId
            Limit 10
        ];
    }
}
