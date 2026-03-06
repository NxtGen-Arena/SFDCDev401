global class ScheduleContactUpdatesBatch implements Schedulable
{
	global void execute(SchedulableContext sc)
    {
		Database.executeBatch(new DeactivateContactsBatch(),10);
    }
}
