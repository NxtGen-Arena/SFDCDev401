# Modularize your Flows

## What are Auto-Launched Flows?

* Runs in the background and doesn’t require user interaction. This type of flow doesn’t support screens and local actions.
* Scheduled triggered flow, record-triggered flow, platform event-triggered flow, or subflow are all Auto-Launched Flows
* Sub flows and Auto-Launched are different. There can be an Auto-Launched flow that is not a Sub-Flow.
* Unlike Record-Triggered Flows, Autolaunched Flows do not have entry criteria and do not have to be designated to a specific object.
  
<img width="803" alt="image" src="https://github.com/user-attachments/assets/dcc62cb7-34b3-4ffb-a2b6-0d8ab30e13ad" />


## What are Sub Flows?

* A subflow is an autolaunched flow (no trigger) or a screen flow, which is referenced by another flow (called the parent flow) and calls the subflow at its runtime.
* Use the subflow’s input and output assignments to pass data between the parent flow and the subflow.
* identify repetitive automation steps, make them into their own flow and use the subflow element in the parent flow to reference it.
* Chunking out your flow into smaller flows, where it makes sense, versus building one massive ginormous flow, makes your automation more manageable in the long run. It also enables debugging more efficiently.
* Use the subflow’s input and output assignments to pass data between the parent flow and the subflow. 


## How the sub-flows are invoked

Sub-Flows are invoked from other processes - Apex, Process Builders, Flows

<img width="356" alt="image" src="https://github.com/user-attachments/assets/e9207cc0-5da3-45f8-8560-7d3a28afb797" />


## Resources for Further Reading:

* [How to call Subflows from Record-Triggered Flows](https://help.salesforce.com/s/articleView?id=000396957&type=1)
