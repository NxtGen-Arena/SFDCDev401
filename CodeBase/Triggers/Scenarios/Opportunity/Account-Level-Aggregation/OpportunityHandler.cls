public class OpportunityHandler {

    public static void updateAccountTotal(
        List<Opportunity> newList,
        Map<Id, Opportunity> oldMap
    ) {
        Set<Id> accountIds = new Set<Id>();

        // Collect Account Ids from new records
        if (newList != null) {
            for (Opportunity opp : newList) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
        }

        // Collect Account Ids from old records (for delete & re-parenting)
        if (oldMap != null) {
            for (Opportunity oldOpp : oldMap.values()) {
                if (oldOpp.AccountId != null) {
                    accountIds.add(oldOpp.AccountId);
                }
            }
        }

        if (accountIds.isEmpty()) return;

        // Aggregate Opportunity Amounts
        Map<Id, Decimal> accountToTotal = new Map<Id, Decimal>();

        for (AggregateResult ar : [
            SELECT AccountId accId, SUM(Amount) total
            FROM Opportunity
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ]) {
            accountToTotal.put(
                (Id) ar.get('accId'),
                (Decimal) ar.get('total')
            );
        }

        // Prepare Account updates
        List<Account> accountsToUpdate = new List<Account>();

        for (Id accId : accountIds) {
            accountsToUpdate.add(new Account(
                Id = accId,
                Total_Opportunity_Amount__c =
                    accountToTotal.containsKey(accId)
                        ? accountToTotal.get(accId)
                        : 0
            ));
        }

        update accountsToUpdate;
    }
}
