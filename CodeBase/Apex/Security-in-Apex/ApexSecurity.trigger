/**
* Triggers run in system mode. So inherited sharing is enforced on the next level.
*
**/
trigger ApexSecutiy on Account (before insert,Before update) {

   SharingRulesApex.enforceSharingRules(Trigger.new);
}
