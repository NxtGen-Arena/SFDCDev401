public class AsynLoggerWithTask implements Queueable
{
	private List<Lead> leadsToProcess;
    
    public AsynLoggerWithTask(List<Lead> leadsRecords)
    {
        this.leadsToProcess = leadsRecords;
    }
    
    public void execute(QueueableContext context)
    {
        system.debug('Inside chained job');
        
        List<Task> lstTasks = new List<Task>();
        for(Lead leadRec : leadsToProcess)
        {
            Task newTask = new Task();
            newTask.Subject = 'Follow up and Update correct LeadSource.';
            newTask.WhoId = leadRec.Id;
            newTask.Status = 'Not Started';
            newTask.Priority = 'High';
            
            lstTasks.add(newTask);
        }
        if(!lstTasks.isEmpty())
        {
            insert lstTasks;
        }
        
        Id jobId = context.getJobId();
        system.debug('Current Job Id is >>>' + jobId);
    }
}
