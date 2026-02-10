/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class OpprtunityHandlerTest {

    @TestSetup
    static void makeData(){
        TestDataFactory.createTestOpportunities(5, true);
    }

    @isTest
    static void testOpportunityAmountPositive() {
        List<Opportunity> ops = [SELECT Id, Amount FROM Opportunity WHERE Name = 'Test Opportunity0'];
        Decimal oppAmount = 100.0;
        Boolean isSuccess = OpportunityHandler.setAmount(ops[0].Id, oppAmount);
        System.assertEquals(true,isSuccess,'Update should have been successful');

        Opportunity afterUpdateOpp = [SELECT Amount FROM Opportunity WHERE Id =:ops[0].Id];
        System.assertEquals(oppAmount,afterUpdateOpp.Amount,'Amount should have been set to 100.0');

        system.assertEquals(3,Limits.getQueries(),'COunted queries before test start end end');

        //test resets the governor limits back to 0. Any code that executes after call to startTest and vefore stopTest is assigned with a new set of governor limits
        Test.startTest();
           List<Opportunity> oppBulk = TestDataFactory.createTestOpportunities(50, true);

            for(Opportunity oppRec : oppBulk){
                Opportunity opp = [SELECT Id,Name FROM Opportunity WHERE Id =:oppRec.Id];
                opp.Amount = 500.0;
                Boolean bSuccess = OpportunityHandler.setAmount(opp.Id,opp.Amount);
            }
            system.assertEquals(50,Limits.getQueries(),'COunted queries within test start end end');
        Test.stopTest();
        //test resets the governor limits back to 0
    }
    
    @isTest
    static void testOpportunityAmountNegative() {
        List<Opportunity> ops = [SELECT Id, Amount FROM Opportunity WHERE Name = 'Test Opportunity0'];
        Decimal oppAmount = -100.0;
        Boolean isSuccess = OpportunityHandler.setAmount(ops[0].Id, oppAmount);
        System.assertEquals(false,isSuccess,'Update should have failed');

        Opportunity afterUpdateOpp = [SELECT Amount FROM Opportunity WHERE Id =:ops[0].Id];
        system.assertEquals(null,afterUpdateOpp.Amount,'Amount should have not been set');
    }



    @isTest
    static void testAsOtherUser(){
        List<User> customSalesusers = TestDataFactory.createUsers(1,'Custom: Sales Profile',true,'Adam','Santos','adam.santos@technie.com');

        List<Opportunity> adminOps = [SELECT Id, Amount FROM Opportunity];
        System.assertEquals(5,adminOps.Size(),'All opps should be inserted');

        //Opportunity OWD = Private. WE inserted opps as Admin, so sales user should not be able to see the records
        System.runAs(customSalesusers[0]){
           List<Opportunity> salesUserOpps = [SELECT Id, Amount FROM Opportunity];
            System.assertEquals(0,salesUserOpps.size(),'Sales User Opps should not be accessible');

            //insert opp as sales user
            Opportunity opp = new Opportunity();
            opp.Name = 'Test Opportunity Sales';
            opp.StageName = 'Qualification';
            opp.CloseDate = Date.today().addDays(60);
            insert opp;

            try {
                Decimal oppAmount = -100.0;
                Boolean isSuccess = OpportunityHandler.setAmount(opp.Id, oppAmount);
            } catch (Exception ex) {
                System.assertEquals('InvalidAmountException', ex.getMessage());
            }
        }
    }
}
