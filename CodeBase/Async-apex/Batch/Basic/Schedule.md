
## Schedule via UI

1. Go to Setup > Apex Classes
2. Click Schedule Apex
3. Job Name: UpdateAccountsJob
4. Apex Class: ScheduleAccountBatch
5. Set frequency and time
6. Click Save

## You can also schedule programmatically:

```
String cron = '0 0 1 * * ?'; // 1 AM daily
System.schedule('DailyAccountBatch', cron, new ScheduleAccountBatch());

```
