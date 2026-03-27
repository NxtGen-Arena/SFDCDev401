public class AccountHandler {

    public static void updateTotalOpportunityAmount(Set<Id> accountIds) {

        if (accountIds == null || accountIds.isEmpty()) return;

        // Map to store AccountId → Total Opportunity Amount
        Map<Id, Decimal> accountTotals = new Map<Id, Decimal>();

        // Aggregate Opportunities
        for (AggregateResult ar : [
            SELECT AccountId accId, SUM(Amount) totalAmount
            FROM Opportunity
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ]) {
            accountTotals.put(
                (Id) ar.get('accId'),
                (Decimal) ar.get('totalAmount')
            );
        }

        // Prepare Account updates
        List<Account> accountsToUpdate = new List<Account>();

        for (Id accId : accountIds) {
            accountsToUpdate.add(new Account(
                Id = accId,
                Total_Opportunity_Amount__c =
                    accountTotals.containsKey(accId)
                        ? accountTotals.get(accId)
                        : 0
            ));
        }

        update accountsToUpdate;
    }
}
