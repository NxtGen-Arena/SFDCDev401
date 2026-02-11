## Desining for LDV of Accounts (50+)

### Limitations
- Queueable can process only 50k records per transaction
- Aggregate SOQL + DML must stay under CPU & row limits

### Solution

✔ Split Account Ids into chunks (e.g. 200–500 per job)
✔ Chain Queueables until all chunks are processed
✔ Each Queueable handles one chunk only

| Feature                     | Benefit                         |
| --------------------------- | ------------------------------- |
| Chunked processing          | Prevents CPU & row limit issues |
| Queueable chaining          | Unlimited scale                 |
| Aggregate SOQL              | Fast & selective                |
| Small DML batches           | Stable performance              |
| Trigger does almost nothing | Excellent UX                    |
