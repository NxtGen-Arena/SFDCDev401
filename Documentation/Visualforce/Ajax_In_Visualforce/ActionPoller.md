# ActionPoller in Visualforce for polling

✅ Definition of apex:actionPoller in Salesforce
The <apex:actionPoller> is a Visualforce component that repeatedly calls a controller method at specified intervals (in milliseconds). It enables you to refresh parts of the page automatically, without requiring user interaction (like button clicks).

🧠 Purpose

* To refresh part of a page based on real-time or time-based changes (e.g., status updates, queue checks).
* Helps implement auto-refresh behavior in Visualforce pages, useful for dashboards or progress tracking.

🔧 Syntax
```
<apex:actionPoller interval="seconds" action="{!methodName}" rerender="componentId" />
```

- interval: How often to poll (in seconds).
- action: The method in the Apex controller to invoke.
- rerender: The ID of the component to update.

✅ Simple Example: Refresh Order Status Every 5 Seconds: OrderStatusPolling



🎯 Common Use Cases

|Use Case|	Description|
|---------|------------|
|Live dashboard updates	|Auto-refresh key metrics (e.g., sales, cases, tasks)
|Status monitoring	|Update order, case, or job status in near real-time
|Queue or job completion notification	|Poll a backend job until it completes
|Real-time chat or notification area	|Poll for new messages or alerts

✅ Pros

|Advantage|	Benefit|
|--------|-------|
|Auto-refresh UX	|Users don’t have to manually refresh for updates
|Simple to implement	|Just add a tag and controller method
|Works without JavaScript	|Fully supported in Visualforce with no need for custom JS
|Partial page refresh|	Efficient: only re-renders specific components

❌ Cons

|Limitation|	Issue|
|---------|------|
|Server Load	|Frequent polling can increase server requests and governor limit usage
|Not real-time	|It’s still a pull mechanism (not push/streaming)
|Limited control	|Less flexible than Lightning Components or JavaScript push methods
|Battery impact on mobile	|Can drain battery with high-frequency polling


📌 Best Practices

- Keep polling intervals reasonable (5–60 seconds depending on use case).
- Avoid frequent rerenders of large components.
- For real-time push, consider Platform Events or Lightning + Streaming API.
- Disable <apex:actionPoller> when data is final (e.g., use a flag when a job completes).
