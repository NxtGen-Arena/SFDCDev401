global class ScheduleAccountBatch implements Schedulable {
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new UpdateAccountIndustryBatch(), 200);
    }
}
