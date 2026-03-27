public class OpportunityShareHelper {

    public static void shareOnClosedWon(
        List<Opportunity> newList,
        Map<Id, Opportunity> oldMap
    ) {

        // 🔹 Fetch User-A
        User userA = [
            SELECT Id 
            FROM User 
            WHERE Username = 'usera@company.com'
            LIMIT 1
        ];

        List<OpportunityShare> shares = new List<OpportunityShare>();

        for (Opportunity opp : newList) {
            Opportunity oldOpp = oldMap.get(opp.Id);

            // Stage changed to Closed Won
            if (
                opp.StageName == 'Closed Won' &&
                oldOpp.StageName != 'Closed Won'
            ) {
                OpportunityShare os = new OpportunityShare();
                os.OpportunityId = opp.Id;
                os.UserOrGroupId = userA.Id;
                os.OpportunityAccessLevel = 'Read';
                os.RowCause = Schema.OpportunityShare.RowCause.Manual;

                shares.add(os);
            }
        }

        if (!shares.isEmpty()) {
            insert shares;
        }
    }
}
