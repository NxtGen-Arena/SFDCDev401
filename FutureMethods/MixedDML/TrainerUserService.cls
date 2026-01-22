/**
 * Class Name  : TrainerUserService
 * Purpose     : Demonstrates resolving Mixed DML issue using @future
 * Scenario    : Training Institute – Trainer Onboarding
 */
public class TrainerUserService {

    /**
     * Main method called after Trainer User creation
     * Performs NON-SETUP object DML
     */
    public static void onboardTrainer(User trainerUser) {

        // 1️⃣ Create Trainer Profile (Custom Object → NON-SETUP)
        Trainer_Profile__c profile = new Trainer_Profile__c(
            Name = trainerUser.Name,
            Trainer_User__c = trainerUser.Id
        );
        insert profile;

        // 2️⃣ Assign Permission Set asynchronously
        assignPermissionSetAsync(trainerUser.Id);
    }

    /**
     * FUTURE method to perform SETUP object DML
     * This avoids Mixed DML exception
     */
    @future
    public static void assignPermissionSetAsync(Id userId) {

        // Fetch Permission Set
        PermissionSet ps = [
            SELECT Id FROM PermissionSet
            WHERE Name = 'Trainer_Permission'
            LIMIT 1
        ];

        // Assign Permission Set to User
        PermissionSetAssignment psa = new PermissionSetAssignment(
            AssigneeId = userId,
            PermissionSetId = ps.Id
        );

        insert psa;
    }
}
