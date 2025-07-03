public with sharing class EnrollmentController 
{
   @AuraEnabled
   public static List<Enrollment__c> getEnrollmentsByTraineeId(Id traineeId){
    try {
        return [
            SELECT Id, Course__r.Name, Status__c, Trainee__c,Trainee__r.Name
            FROM Enrollment__c
            WHERE Trainee__c = :traineeId
        ];
    } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
    }
   }
}