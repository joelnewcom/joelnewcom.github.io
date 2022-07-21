---
---

## Project DAW
*// 01.06.2020*

Project DAW (digital agents workplace) equips every swiss Zurich agent with an iPad and develops an iOS app called MyCustomer. The project also manages thirdparty iOS apps like Fluix.

### MyCustomer iOS app
It is a native app written in Swift. From XCode the code goes into Azure Devops Repository and will be built and tested via Azure Devops Pipelines.
At runtime, MyCustomer app connects via REST with its own backend (Azure Webapp).
The app has a sophisticated retry mechanism, because of its offline requirements. 
Every failed REST request will be retried several times and if it still fails, it will be put onto a stack of failed requests, which can be retried at anytime. This way the agent can to actions on data he loaded while there was still internet connection.

### Backend
It is azure app written in C# on .Net Core. From Visual Studio or Visual Studio Code, the code goes into Azure Devops Repository and will be built and tested via Azure Devops Pipelines.
The initial idea of putting an own backend in place (We could have also just integrate zurichs existing systems directly with the iOS app) was to support different countries with the same iOS app. 
The backend would abstract all the country specifics, so the iOS doesn't need to care about it.
In our case this means we just implement the switzerland layer and map everything into DTOs the iOS app understands.    

The backend (switzerland) connects to the centralized API Gateway and consumes multiple APIs from it.
Main supplier of data is the Zurich CRM software (MS Dynamics 365).

### Challenges
## Dependencies
A challenge I had to cope with, is the unbalanced team sizes compared to other teams within the company. The reason for this is the way how zurich spreads budget to teams and project. 
If you convince the right persons, that your project brings the most value, your project gets more money than others. If the success of the project actually depends on the other projects will be ignored.
What the people don't consider is that a project can only as fast as its dependency systems.

## Quality assurance
Joining an existing project and expecting good code from developers is very challenging. Especially if you did not master the language yourself (swift and C#).
Also I did not succeed to spread security awareness to the devops guys, if you don't know yourself how to achieve better security on a hands-on level you will have a hard time.

## Knowhow of internal (legacy) systems
Because of my role I was forced to understand the systems within the whole company not just the one of the projects. The developers on the other hand weren't interested at all what was going on in the company tech landscape.
They just wanted their API to integrate and once they had their data, they fulfilled their story.  
It was up to me to give them the understanding why things are not possible (Like why is specific data update action asynchronous? Because there is only nightly dataload to an involved legacy system).
