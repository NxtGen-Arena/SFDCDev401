public class TraineeOnboardingService {

    public static void onboardTrainee(Contact trainee) {

        insert trainee; // ✅ Non-setup object

        // Call future method for setup objects
        TraineeUserFuture.createUserAsync(trainee.Id);
    }
}
