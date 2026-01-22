/**
 * Handler class to keep trigger clean
 */
public class UserTriggerHandler {

    public static void handleAfterInsert(List<User> newUsers) {

        List<User> trainerUsers = new List<User>();

        for(User u : newUsers) {
            // Example condition: Trainer users only
            if(u.Profile.Name == 'Standard User') {
                trainerUsers.add(u);
            }
        }

        if(!trainerUsers.isEmpty()) {
            TrainerOnboardingService.processTrainers(trainerUsers);
        }
    }
}
