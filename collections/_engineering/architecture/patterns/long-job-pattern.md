---
layout: single
---

![long running jobs](/assets/images/software-engineering/architecture/async-long-tasks-pattern.png)

To support long running tasks, you should create a separate table to store the state of these jobs.
The ```start controller``` will add rows to this table with the needed information to complete the task. It returns the id of the newly created job.
The ```worker``` would be start by a scheduled task and read from this table. As soon as there is an open task it would grab it and set the status to ```running```. 
When completed it will update the status again and might also add some information. 

The ```client``` who also triggered the start can retrieve the status of every job anytime.