public class TraineeUserFuture {

    @future
    public static void createUserAsync(Id contactId) {

        Contact c = [
            SELECT Id, Email, LastName 
            FROM Contact 
            WHERE Id = :contactId
        ];

        User u = new User(
            Username = c.Email,
            Email = c.Email,
            LastName = c.LastName,
            Alias = c.LastName.substring(0, 4),
            TimeZoneSidKey = 'Asia/Kolkata',
            LocaleSidKey = 'en_IN',
            EmailEncodingKey = 'UTF-8',
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id,
            LanguageLocaleKey = 'en_US'
        );

        insert u; // ✅ Setup object in separate transaction
    }
}
