/**
 * Class Name : OpportunityMinMaxChainedQueueable
 * Purpose    : Process Account Min/Max dates in chunks using chained queueables
 */
public class OpportunityMinMaxChainedQueueable implements Queueable {

    private List<Id> allAccountIds;
    private Integer startIndex;

    // Tune this safely (200–500 recommended)
    private static final Integer CHUNK_SIZE = 200;

    public OpportunityMinMaxChainedQueueable(
        List<Id> allAccountIds,
        Integer startIndex
    ) {
        this.allAccountIds = allAccountIds;
        this.startIndex = startIndex;
    }

    public void execute(QueueableContext context) {

        // Determine chunk range
        Integer endIndex = Math.min(
            startIndex + CHUNK_SIZE,
            allAccountIds.size()
        );

        List<Id> accountChunk =
            allAccountIds.subList(startIndex, endIndex);

        // ---------- BUSINESS LOGIC (Same as before) ----------
        Map<Id, AggregateResult> accountToDatesMap = new Map<Id, AggregateResult>();

        for (AggregateResult ar : [
            SELECT AccountId accId,
                   MIN(CloseDate) minDate,
                   MAX(CloseDate) maxDate
            FROM Opportunity
            WHERE AccountId IN :accountChunk
            GROUP BY AccountId
        ]) {
            accountToDatesMap.put(
                (Id) ar.get('accId'),
                ar
            );
        }

        List<Account> accountsToUpdate = new List<Account>();

        for (Id accId : accountChunk) {
            Account acc = new Account(Id = accId);

            if (accountToDatesMap.containsKey(accId)) {
                AggregateResult ar = accountToDatesMap.get(accId);
                acc.Min_Opportunity_Date__c = (Date) ar.get('minDate');
                acc.Max_Opportunity_Date__c = (Date) ar.get('maxDate');
            } else {
                acc.Min_Opportunity_Date__c = null;
                acc.Max_Opportunity_Date__c = null;
            }

            accountsToUpdate.add(acc);
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }

        // ---------- CHAIN NEXT QUEUEABLE ----------
        if (endIndex < allAccountIds.size()) {
            System.enqueueJob(
                new OpportunityMinMaxChainedQueueable(
                    allAccountIds,
                    endIndex
                )
            );
        }
    }
}
