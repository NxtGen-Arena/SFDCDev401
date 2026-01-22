/**
 * FUTURE class to avoid Mixed DML
 */
public class TrainerPermissionFuture {

    @future
    public static void assignPermissionAsync(Set<Id> userIds) {

        PermissionSet ps = [
            SELECT Id FROM PermissionSet
            WHERE Name = 'Trainer_Permission'
            LIMIT 1
        ];

        List<PermissionSetAssignment> assignments = new List<PermissionSetAssignment>();

        for(Id userId : userIds) {
            assignments.add(new PermissionSetAssignment(
                AssigneeId = userId,
                PermissionSetId = ps.Id
            ));
        }

        insert assignments; // SETUP DML runs safely
    }
}
