global class CountryBatchScheduler
implements Schedulable {

    global void execute(
        SchedulableContext sc
    ) {

        Database.executeBatch(
            new CountryAPICalloutBatch(),
            50
        );
    }
}
