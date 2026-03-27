@isTest
public class EnrollmentFutureHandlerTest {

    @isTest
    static void testFutureEmailNotification() {

        // Test Data
        Contact trainee = new Contact(
            LastName = 'Student',
            Email = 'student@futuretech.com'
        );
        insert trainee;

        Batch__c batch = new Batch__c(
            Name = 'Salesforce Developer Feb'
        );
        insert batch;

        Batch_Enrollment__c enrollment = new Batch_Enrollment__c(
            Trainee__c = trainee.Id,
            Batch__c = batch.Id
        );

        Test.startTest();
        insert enrollment;   // Trigger fires → Future runs
        Test.stopTest();

        System.assertEquals(1,
            [SELECT Count() FROM Batch_Enrollment__c],
            'Enrollment should be created successfully'
        );
    }
}
