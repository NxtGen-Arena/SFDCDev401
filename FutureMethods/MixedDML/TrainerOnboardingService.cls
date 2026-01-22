/**
 * Service Class handling NON-SETUP object DML
 */
public class TrainerOnboardingService {

    public static void processTrainers(List<User> users) {

        List<Trainer_Profile__c> profiles = new List<Trainer_Profile__c>();
        Set<Id> userIds = new Set<Id>();

        for(User u : users) {
            profiles.add(new Trainer_Profile__c(
                Name = u.Name,
                Trainer_User__c = u.Id
            ));
            userIds.add(u.Id);
        }

        // NON-SETUP DML
        insert profiles;

        // SETUP DML moved to @future
        TrainerPermissionFuture.assignPermissionAsync(userIds);
    }
}
