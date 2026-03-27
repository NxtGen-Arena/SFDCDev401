public class EnrollmentFutureHandler {

    @future
    public static void sendNotifications(Set<Id> enrollmentIds) {

        List<Batch_Enrollment__c> enrollments = [
            SELECT Id,
                   Trainee__r.Email,
                   Trainee__r.Name,
                   Batch__r.Name
            FROM Batch_Enrollment__c
            WHERE Id IN :enrollmentIds
        ];

        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for (Batch_Enrollment__c be : enrollments) {

            // Trainee Email
            Messaging.SingleEmailMessage traineeMail =
                new Messaging.SingleEmailMessage();

            traineeMail.setToAddresses(
                new String[] { be.Trainee__r.Email }
            );
            traineeMail.setSubject('Welcome to ' + be.Batch__r.Name);
            traineeMail.setPlainTextBody(
                'Hello ' + be.Trainee__r.Name +
                ',\n\nYou have been successfully enrolled in batch: ' +
                be.Batch__r.Name +
                '.\n\nRegards,\nFutureTech Training Institute'
            );

            emails.add(traineeMail);
        }

        // Send all emails asynchronously
        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }
}
