# Governor Limits in Apex

Salesforce enforces Governor Limits to ensure efficient resource usage in a multi-tenant architecture. These limits prevent a single tenant (organization) from monopolizing shared resources such as CPU time, database queries, and memory.
If a governor limit is exceeded, the system throws a runtime exception, and the execution is halted.

<h2> Governor Limits and Transactions </h2>

* Governor Limits ensure that one customer does not monopolize shared resources in a multi-tenant environment
  * Example Limits: CPU time, memory used, how long a query can run, how many records are returned from a query
  * Performance: Limits are monitored per transaction and per customer over a defined time period to ensure that performance in one org is not       impacted bby another

* Transactions are also know as execution contexts
  * Transactions are defined as a set of operations that is executed and evaluated as a single unit
  * Each event that occurs in a single transaction is bound by their associated governor limits
  * Can be initiated from various sources in the Salesforce platform: Apex triggers, class methods, anonymous code, web service, Visualforce page, custom Lightning component, process, Flow, etc
  
![image](https://github.com/user-attachments/assets/4a3a7b32-11c6-4301-a38b-874d737c9fc8)

Exceeding Governor Limits resuls in:
* Terminated: current transaction is immediately terminated and unrecoverable
* Limit Excelption: the System.LimitException is thrown - this exception cannot be handled
* Roll Back: entire transaction is rolled back and no data is committed to the database

<h3> How They Work & Are Calculated </h3>

  Governor limits are calculated based on:

  * Per Transaction (e.g., SOQL queries, DML operations)
  * Per Execution Context (e.g., CPU time, heap size)
  * Per Org-Wide Limit (e.g., API calls, data storage)

<h3> How They Are Assigned </h3>

  Governor limits vary based on:

  * Edition (e.g., Enterprise, Unlimited, Developer)
  * User License Type
  * Execution Context (e.g., synchronous vs. asynchronous transactions)

<h3> Different Governor Limits & Categories </h3>

|Category	|Limit Type	| Example Limits|
|--------|-----------|--------|
|SOQL & DML Limits|	Max SOQL Queries|	100 per transaction
||Max DML Statements	|150 per transaction
| | Max Records in SOQL Query	|50,000 per transaction
| Heap & CPU Limits|	Max Heap Size	| 6MB (synchronous) / 12MB (async)
| | Max CPU Time	|10 sec (sync) / 60 sec (async)
|Batch & Future Limits|	Future Calls per Apex invocation	| 50
|Batch Apex| Job Queues	| 5 concurrent jobs
|Callout Limits|	HTTP Callouts per transaction	|100
| | Max Callout Time	| 120 seconds
| API Limits|	Daily API Request Limit|	Varies by edition
|Email Limits	|Emails Sent per Org|	5,000 per day

<h3> Ways to Overcome Governor Limits </h3>

1. Bulkification: Process records in bulk instead of single transactions.
2. Use Asynchronous Processing: Leverage @future, Queueable, and Batch Apex.
3. SOQL & DML Best Practices:
  * Avoid SOQL inside loops
  * Use selective filters and indexed fields
  * Use Database.insert/upsert for better control
4. Optimize Collections: Use Maps and Sets instead of Lists for better performance.
5. Use Platform Caching: Store frequently accessed data in the cache.
6. Use Limits Apex Class: Monitor resource usage in real time.
7. Reduce Callouts in Loops: Consolidate external API calls.


