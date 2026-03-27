public with sharing class ActionPollerDemo 
{
    public String orderStatus {get;set;}
    public Boolean stopPolling {get;set;}

    public Integer unassignedCases {get;set;}

    public ActionPollerDemo() {
        this.orderStatus = 'Started';
        stopPolling = false;

    }

    public void checkStatus() {
        //poll the status change
        if(Math.random() > 0.5) {
            this.orderStatus = 'Processing';
        } else if(Math.random() > 0.7){
            this.orderStatus = 'Completed';
            this.stopPolling = true;
        }
    }

    public void refreshCaseQueue(){
        unassignedCases = [SELECT Count() FROM Case 
                           WHERE OwnerId =: UserInfo.getUserId() 
                           AND Status != 'Closed'];
    }
}
