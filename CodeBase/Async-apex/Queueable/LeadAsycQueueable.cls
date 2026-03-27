public class LeadAsycQueueable implements Queueable
{
    private List<Lead> leadsToUpdate;
    
    public LeadAsycQueueable(List<Lead> updatedLeadsList)
    {
        this.leadsToUpdate = updatedLeadsList;  //assign the param to the local collection variable declared
    }
    
	public void execute(QueueableContext context)
    {
        system.debug('Upating the leads using execute in Queuable :' + leadsToUpdate.size());
       
        for(Lead leadRec : leadsToUpdate)
        {
            leadRec.leadSource = 'Web';
        }
        if(!leadsToUpdate.isEmpty())
        {
        	update leadsToUpdate;
        }
        
        //chain the second process to execute
        System.enqueueJob(new AsynLoggerWithTask(leadsToUpdate));
    }
}
