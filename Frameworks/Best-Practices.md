
1. Trigger should be bulkified
2. No hard coded Ids. Use Custom Metdata, Custom Settings instead.
3. No code inside the trigger directly
4. No SOQL, or DML inside for loops.
5. In Triggers do not process trigger.new[0]
