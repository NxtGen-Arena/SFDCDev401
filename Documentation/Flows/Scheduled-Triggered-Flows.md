# Scheduled Triggered Flows

## What are Scheduled Trigeered flows
Many a times we need operations to be executed in the background at a specified time and at a repeated frequency - daily, weekly, once. These operations are performed on the bulk records and do not need immediate execution. They can be delayed and performed later in the time. This approach helps to save time and minimize manual data upldate by automation. By scheduling actions we can also avoid conflicts with users daily operations and avoiding potential risks like record locking.

## Key Pointers
- Scheduled triggered flows are a low-code version of a scheduled batch apex which needs pro-code skills.
- Unlike Batch apex, upto 50000 records can be processed.
- The maximum number of schedule-triggered flow interviews per 24 hours is 250,000, or the number of user licenses in your org multiplied by 200, whichever is greater.
- One interview is created for each record retrieved by the schedule-triggered flow’s query.
- The maximum batch size for schedule-triggered flows is 200.
- Testing and debugging schedule-triggered flows is fairly limited. Unlike a record-triggered flow or autolaunched flow where you can specify the record to use to debug, if you debug the schedule- triggered flow, it will automatically take the oldest matching record.


## Things to look out for
- The Automated Process user mentioned under "Process Automation Settings" runs schedule-triggered flows
- Scheduled jobs run in background so make sure to add error handling mechanism to process the final results. Use fault paths to send email notififcations or log the final results in custom object for better tracking.



## Resources for Further Reading:
* Trailhead: [Autolaunched and Scheduled Flows](https://trailhead.salesforce.com/content/learn/modules/autolaunched-scheduled-flows?_ga=2.160143101.1953172342.1737939633-1209282457.1736952360)
* Salesforce Help: [Schedule-Triggered Flow Considerations](https://help.salesforce.com/s/articleView?id=sf.flow_considerations_trigger_schedule.htm&type=5&_ga=2.160143101.1953172342.1737939633-1209282457.1736952360)
