@isTest
public with sharing class TestDataFactory 
{
   public static List<Account> createTestAccounts(Integer numAccounts,Boolean insertRecords)
   {
      List<Account> accounts = new List<Account>();
      for(Integer i=0;i< numAccounts;i++)
      {
         Account acc = new Account();
         acc.Name ='TestAccount'+i;
         acc.Industry = 'Technology';
         acc.Active__c = 'Yes';
         accounts.add(acc);
      }

        if(insertRecords)
        {
            insert accounts;
        }
        return accounts;
    }

    public static List<Contact> createTestContacts(Integer numContacts,Id AccountId,Boolean insertRecords)
    {
        List<Contact> contacts = new List<Contact>();
        for(Integer i=0;i<numContacts;i++)
        {
            Contact con = new Contact();
            con.LastName = 'TestContact'+i;
            con.AccountId = AccountId;
            contacts.add(con);
        }

        if(insertRecords)
        {
            insert contacts;
        }
        return contacts;
    }

    public static List<Opportunity> createTestOpportunities(Integer numOpportunities,Boolean insertRecords)
    {
        List<Opportunity> opportunities = new List<Opportunity>();
        for(Integer i=0;i< numOpportunities;i++)
        {
            Opportunity opp = new Opportunity();
            opp.Name = 'Test Opportunity'+i;
            opp.StageName = 'Qualification';
            opp.CloseDate = Date.today().addDays(60);
            opportunities.add(opp);
        }

        if(insertRecords)
        {
            insert opportunities;
        }
        return opportunities;
    }

    public static List<User> createUsers(Integer numUsers,String profileName,Boolean insertRecords,String firstName,String lastName,String email)
    {
        List<User> users = new List<User>();
        Profile userProfile = [SELECT ID FROM Profile WHERE Name =: profileName LIMIT 1];
        for(Integer i=0;i<numUsers;i++)
        {
            User testUser = new User();
            testUser.FirstName = firstName;
            testUser.LastName = lastName;
            testUser.Email = email;
            testUser.ProfileId = userProfile.Id;
            testUser.Alias = 'Tcode';
            testUser.Username = firstName+lastname+i+'@test.com';
            testUser.CommunityNickname = 'testUser'+i;
            testUser.LocaleSidKey = 'en_US';
            testUser.TimeZoneSidKey = 'GMT';
            testUser.EmailEncodingKey = 'UTF-8';
            testUser.LanguageLocaleKey = 'en_US';
            users.add(testUser);
        }
        if(insertRecords)
        {
            insert users;
        }
        return users;
    }
}
