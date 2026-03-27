/**
 * Class Name : OpportunityTriggerHandler
 * Purpose    : Maintain Min & Max Opportunity Dates on Account
 */
public class OpportunityTriggerHandler {

    /**
     * Updates Account Min & Max Opportunity Close Dates
     */
    public static void updateAccountMinMaxDates(Set<Id> accountIds) {

        if (accountIds.isEmpty()) return;

        // Aggregate Min & Max CloseDate from Opportunities
        Map<Id, AggregateResult> accountToDatesMap = new Map<Id, AggregateResult>();

        for (AggregateResult ar : [
            SELECT AccountId accId,
                   MIN(CloseDate) minDate,
                   MAX(CloseDate) maxDate
            FROM Opportunity
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ]) {
            accountToDatesMap.put(
                (Id) ar.get('accId'),
                ar
            );
        }

        // Prepare Accounts for update
        List<Account> accountsToUpdate = new List<Account>();

        for (Id accId : accountIds) {
            Account acc = new Account(Id = accId);

            if (accountToDatesMap.containsKey(accId)) {
                AggregateResult ar = accountToDatesMap.get(accId);
                acc.Min_Opportunity_Date__c = (Date) ar.get('minDate');
                acc.Max_Opportunity_Date__c = (Date) ar.get('maxDate');
            } else {
                // No Opportunities left → clear fields
                acc.Min_Opportunity_Date__c = null;
                acc.Max_Opportunity_Date__c = null;
            }

            accountsToUpdate.add(acc);
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}
