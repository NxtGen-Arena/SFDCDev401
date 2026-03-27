trigger CreateTaskForHighValueOpp on Opportunity (after insert) {
    List<Task> tasksToCreate = new List<Task>();

    for (Opportunity opp : Trigger.new) {
        if (opp.Amount > 100000) {
            Task task = new Task();
            task.Subject = 'Follow up on high-value opportunity';
            task.WhatId = opp.Id;
            task.OwnerId = opp.Account.OwnerId;
            task.Status = 'Not Started';
            tasksToCreate.add(task);
        }
    }

    if (tasksToCreate.size() > 0) {
        insert tasksToCreate;
    }
}
