---
layout: single
---

# Question / Answers
## Q: What are the key responsibilities of a devops engineer?

A:
* Continuous Integration
* Continuous Delivery
* Microservices
* Infrastructure as Code
* Monitoring and Logging
* Communication and Collaboration

## Q: What is a VCS?
A: Version control systems are a kind of software tool which reports the changes in the code and integrates these changes with the existing code. As the developer makes changes in the code frequently, these types of tools are helpful in integrating the new code smoothly without disturbing the work of other team members. Along with integration, it will test the new code so that we can avoid the code leading to bugs)

## Q: What is a branching strategy in devops?
A: Branching is a technique employed for code isolation. In simple terms, it makes a copy of the source code to create two versions that are developed separately. There are various types of branching available. Therefore, the DevOps team must make a choice depending on application requirements. This choice is called a branching strategy.

## Q: What is the main purpose of Continous Integration?
A: Continuous integration is a development practice of automating the integration of code changes from several contributors to a single software project. By regularly integrating, you can detect errors quickly and locate them easily. The source code version control is the crux of the CI process.
The major benefits of Continuous Integration are listed below:

* Faster development cycles
* Smarter risk mitigation
* Stable codes
* Team Communication
* Reduced Overhead
* Flexibility
* Consistency of Build Process

## Q: What’s the difference between Continous Delivery and Continous Deployment?
A: 
* Continuous Delivery: It is a process in which continuous integration, automated testing, and automated deployment capabilities develop, build, test, and release high-quality software rapidly and reliably with minimal manual overhead.
* Continuous Deployment: It is a process in which qualified changes in the architecture or software code are deployed automatically to production as soon as they are ready and without human intervention.

## Q: What is Infrastructure as a code and why is it important?
A:
* Infrastructure as code (IaC) is a method to manage and provision IT infrastructure (networks, databases, connection topology, etc.) through source code, rather than manual process or interactive configuration tools.
* It helps you to automate the infrastructure deployment process easily, consistently, and reliably.


## Q: How does your perfect infrastrucutre looks like? (Everybody is striving for something/ a specific goal (Like zero downtime deployment))
A: There is no right/wrong

# DevOps Kata - Networking

## Given
Present an infrastructure diagram about some azure web apps, or container apps, some API gateway, databases, keyvaults etc. 
The application shall be used only internal. 

## Task

### Q: Which component would you use to achieve the same as shown in the diagram, but in the cloud?

A:
First, there shall be questions come back at you about the diagram. What are the: 
* Requirements overall?
  * Requirements by the company or the cloud team.
  * What does already exists?
* Availability
* Performance?
* Scalability?
* How much load, clients?
* What kind of data is processed
* Security?

Some components which can be the answer, depending on the shown diagram:
API management service (ev. Application Gateway), Webapp oder container app, Managed SQL instance.
Service endpoints or  private endpoints, vnets und NSG (network security rules).

### Q: How would you setup the infrastructure?

A:
Infrastructure as code
Using Pipelines

Run at least two instances of a microservice (scalability)
Backups are considering RTO (recovery time objective) and RPO (Recovery point objective)

### Q: What pipelines would you create?
A: Distinguish between
* Build (CI) Pipelines
* Release (CD) Pipelines

### Q: How would you deploy a webapp? 

A: Zip deployment

### Q: How would you deploy an iOS App?
A: 
Via MDM or via official appstore
Inject secrets from a secure place 


### Q: How would you monitor the infrastructure setup?
A: 
App logs to Azure insights. 
Turn on Smart alerts
Create own alerts
Create dashboards