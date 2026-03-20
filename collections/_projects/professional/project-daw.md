---
title: Project DAW
layout: archive
classes: wide
categories:
  - craftsmanship
header:
    teaser: "/assets/images/daw/risk-cards.PNG"
---

*// 01.06.2020*

Project DAW (digital agents workplace) equips every swiss Zurich agent with an iPad and develops an iOS app called MyCustomer and its backend applications. 
The project also manages thirdparty iOS apps like Fluix.
I am working as solution architect. Searching for ways to achieve business needs.

Within a meeting with a customer, the app would look like this: 
![risk-cards](/assets/images/daw/risk-cards.PNG)

When the agents looks for his client, the app would look like this: 
![clients profile](/assets/images/daw/clients-profile.PNG)

# MyCustomer iOS app
It is a native app written in Swift. At runtime, MyCustomer app connects via REST with its own backend (Azure Webapp).
The app has a sophisticated retry mechanism, because of its offline requirements. 
Every failed REST request will be retried several times and if it still fails, it will be put onto a stack of failed requests, which can be manually retried again at anytime. 
This allows the agent to do updates on already downloaded data while there is no internet connection.

Furthermore, the app keeps, almost everything it gets from its backend, locally in a sqlite database and on the app's file storage.   

# Backend
It is an azure app written in C# on .Net Core.
The initial idea of putting an own backend in place (We could have also just integrate Zurichs existing systems directly with the iOS app) was to support different countries with the same iOS app. 
The backend would abstract all the country specifics, so the iOS doesn't need to care about it.
In our case this means we only implemented the switzerland layer by mapping into DTOs the iOS app understands.

The backend connects to a centralized API Gateway and consumes multiple APIs from there.
Main supplier of data is the Zurich CRM software (MS Dynamics 365).

# Challenges
## Dependencies
A challenge I had to cope with, is the unbalanced team sizes compared to other teams within the company. The reason for this is the way how zurich calls budget to platform-teams and project-teams. 
If you convince the right people, that your project brings the most value to his/her domain, your project gets funded to achieve the defined goal. 
If the success of the project depends on other systems and shared services, things will get complicated.
What people don't consider, is that a project can only be as fast as its dependencies. Basically when you ramp up a huge team to build something exciting, you also need to make sure you increase resources on your dependencies (Shared services, Backend systems etc.)

## Quality assurance
Joining an existing project and expecting good code from developers is very challenging. Especially if you did not master the language yourself (swift and C#).
I had also a hard time to spread security awareness to the devops guys, if you don't know yourself how to achieve better security on a hands-on level you will have a hard time.

## Lack of know-how of internal (legacy) systems
Because of my role I had to learn about other systems within the company. The external developers on the other hand weren't interested at all what was going on in the company landscape.
They only wanted to know how the API to integrate looks like to fulfill their story.  
It was up to me to give them the understanding why things are not possible, even the API might look like it is. (For example: Just because there is a REST API, it doesn't mean every action is synchronous. You might just trigger an asynchronous action with your synchronous API call and the data gets updated on the next data load).