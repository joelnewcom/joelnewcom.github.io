[Home](/)

[Back](index.md)

## New project
*// 20.03.2020*

As RegWay started in a hurry, we forgot (or skipped by purpose) a lot of things, which got afterwards very important, but hard to change and improve.
Those things are hitting us now really bad and by now you cannot just fix them, as other system and customers already depend on it. 
In this document I want to describe those mistakes, so I don’t do them again.

*//22.12.2021 Ha! It happened again!*
[For future reference](https://martinfowler.com/articles/is-quality-worth-cost.html)

### Splitting things apart
As soon as the application gets bigger an complexer the team wants to separate things. There will be multiple domains, multiple business processes and multiple parts will have different purposes to change. 
Don't just separate them because it feels right to do it. Think more about it. Think about reasons, try to apply known best practices like SOLID to your decision. 
Think from the beginning what will happen when another component does not work. This question didn't appear before because everything was in one place anyway. If you end up with two components which both don't work with each other, what did win?
The easiest way is, that every component or every process-step will produce its own persisted artifact which can be taken by another component. In most cases this artifact will just be a file or an event in a queue. 
You need to have a really good argumentation if you connect components synchronously. This will make the dependency even closer.

### Data flow
It is not an easy task to do and it gets along with architecture and traceability. You need an overview of the flow of data within your business cases.
You need a picture which shows every kind of data format and where the data flows to. 
Such things needs to be defined before you implement something. Because the implementation will only be done if you can represent the flow somehow as you draw it on paper.
Assuming you read a 30GB file and every row represents a unit of work for the next component. Even the next component doesn't care about the group of all units it needs to hold an identifier which will be part of the logging. 
You always will have this kind of meta information above your unit of work. You should be able to trace your little attribute in the database back to where it came from the customer by FTP or REST or whatever.

### Database IDs
It could have advantages if you can define your primarykeys by your businesskeys. In our case it was the worst we could do. Business told us their well defined business keys will be unique forever. After 2 years they weren't as the world rotated further.  
If you are not sure (And actually you will never be), better make some technical primary keys. This gives you a lot more freedom.

### Log format
The log format needs to be defined. If the company standard is not good enough, define another standard. 
If you don’t have this, the components of your project will log in different formats and monitoring will be pain in the ass.

### Traceability
The log format needs to support an unique ID for every request or business process.
We were not able to build such a component which shows every business-request through the whole system.
If you don’t have this, you will lose a huge amount of time, everytime you investigate a problem in your system.

### Business Layer
You need a business-layer in any case. 
As soon as the DAO layer merges businessobjects, manipulates or verifies input, it is something wrong! The business layer handles logic like dependencies between entities, orphans, mappings, checks etc.
For example: It’s better to fetch the entity from the business layer for existence-check, rather than doing this in the DAO layer (even it feels better, as the DAO layer is closer to the database)
The DAO layer should be as simple and neutral as possible. You never know what the needs in the future are!

### APIs
APIs are contracts. Once you have a client, its hard to change this contract. Even to remove unused fields brakes the contract by definition. 
That is why the "Interface Segregation" of SOLID makes sense. Always start with the bare minimum. Don't just return the raw database entry, but transform it into a minimalistic, but well defined business DTO (or client data model)    

### Configuration
You need to configure your application somehow, but don't exaggerate it. 
If you don’t know if it needs to be configurable, don’t make it configurable. YAGNI should be considered strongly.
 
### Define a CDM
Separate your internal business object and the clients business object. These will be almost the same when the project start, but they will diverge in the future.
Your internal business-object will hold your primarykey, internal timestamp, record version, metainfo etc. Your client data model will remain the same as long your API doesn't change. 
The API definition needs to be tested against the client data model, if they are not generated from the same source.
The best would be when such definitions will be generated.

### Monitoring
Before you ever run your application the first time, its needs to be clear how you want to monitor it. What happens when you log on ERROR level? Do you want that people fix it asap, or do you want people to ignore it, as errors are the normal case anyway?
Error codes are always a good idea. Define KPIs for your application in an early stage.

### Code review and analysis
You need to have a common sense about code review in your team. Reviewing and decline a PR is something good!
Right at the beginning you need static code analysis. The application needs to have a certain level of maturity which you can hold. Otherwise it will take you months to implement such a mindset in your team.

### CI/CD
You cannot invest enough time for that, do it before your first line of code. 
It is essential, if your project successes or not.
