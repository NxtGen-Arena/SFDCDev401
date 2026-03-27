## Below is a performance-optimized, Queueable-based version that:

- Offloads heavy recalculation to async
- Batches Account processing
- Still handles insert / update / delete / undelete
- Is enterprise-ready

**Why Queueable Improves Performance**

**Problem with synchronous approach**

- Aggregate queries + Account updates run in the same transaction
- Risk of CPU time / row limits during mass Opportunity deletes or data loads

**Queueable Benefits**

- Runs in a separate async transaction
- Higher limits (CPU, heap)
- Better user experience
- Easy to chain if needed later
