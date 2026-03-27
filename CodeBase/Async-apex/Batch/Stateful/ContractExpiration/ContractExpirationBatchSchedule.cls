global class ContractExpirationBatchSchedule implements Schedulable
{
	global void execute(SchedulableContext context)
    {
        Database.executeBatch(new ContractExpirationEngineBatch(),5);
    }
}
