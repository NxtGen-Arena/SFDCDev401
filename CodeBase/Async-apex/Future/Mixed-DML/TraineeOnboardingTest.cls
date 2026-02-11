@isTest
public class TraineeOnboardingTest {

    @isTest
    static void testOnboarding() {

        Contact c = new Contact(
            LastName = 'Student',
            Email = 'student@test.com'
        );

        Test.startTest();
        TraineeOnboardingService.onboardTrainee(c);
        Test.stopTest(); // Executes @future
    }
}
