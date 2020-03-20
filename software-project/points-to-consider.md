## New project
*// 20.03.2020*
[Go back](/)

As RegWay started in a hurry, we forgot (or skipped by purpose) a lot of things, which got afterwards very important, but hard to change and improve.
Those things are hitting us now really bad and by now you cannot just fix them, as other system and customers already depend on it. 
In this document I want to describe those mistakes, so I don’t do these mistakes twice.

### Architecture
You can implement code right away. But as soon as you realize you have multiple domains, multiple business processes and so on, you need to be very sure how you want to connect your components. 
Because it needs to make sense on a business perspective. The easiest way is, that every component or every process-step will produce its own persisted artifact, so the components loosely dependent on each other. In most cases this artifact will just be a file. 
You need to have a really good argumentation if you connect components synchronous. This will make one component out of two. As we did it with server and dataintake.

### Data flow
It is not an easy task and get along with architecture and log trace. You need an overview of your dataflow. This flow needs to be represented by your logging. 
Nevertheless you need a picture which shows every kind of data format and where the data flows to. Such things needs to be defined before you implement something. 

### Database IDs
It is neat if you can define your primarykeys directly as businesskeys. If you do that, you need to be really sure that this will change. This needs to be rock solid. If you are not sure, better make some technical primary keys. This gives you a lot more freedom.

### Log format
The log format needs to be defined. If the company standard is not good enough, define another standard. If you don’t have this, the modules of your project will log in different formats and it is really hard to monitor different logformat.

### Traceability
The log format needs to support an unique ID for every request or business process. There needs to be a tool which shows a (business)-request through the whole system. If you don’t have this, you will lose a huge amount of time, investigating what happened when and where.

### Business Layer
You need a business-layer in any case. 
As soon as the DAO layer merges, manipulates or verifies input, it is something wrong! The business layer handles logic like dependencies between entities, orphans, mappings, checks etc.
For example: It’s better to fetch the entity from the business layer for existence check, rather than doing this in the DAO layer (by throwing exception if it exists or the opposite way around). The DAO layer should be as neutral as possible. You never know what the needs in the future are!

### REST endpoints
Start with internal endpoints which returns almost the raw content of your database. Then make some business endpoints which transform the output in a way the user can use it. 

### Configuration
You need to configure your application somehow, but never exaggerate it. If you don’t know if it needs to be configurable, don’t make it configurable. YAGNI should be considered strongly.
 
### API definition
The API definition needs to be tested against your business-object.
You need a logic (tool, test, process) which will make sure your definitions are aligned. The best would be, if such definitions will be generated (out of your business object). 
This will make sure that your API is equal to your application. If you forget to change of them, you will get an error before you even committed your change.

### Monitoring
Before you ever run your application the first time, its needs to be clear how you want to monitor. What happens when you log on ERROR level? 
When you log error, it will trigger a ticket and shows dark red on your monitor screen.
When you log warn, it will also trigger tickets, but yellow ones. 
Those needs to be identified and categorized in errorcodes (warncodes). 
You need define KPIs for your application as soon as possible.

### Code review and analysis
You need to have a sense about code review in your team. Reviewing and decline a PR is something good!
Right at the beginning you need static code analysis. The application needs to have a certain level which you can hold.

### CI/CD
You cannot invest enough time for that, before your first line of code. It is essential, if your project successes or not.
