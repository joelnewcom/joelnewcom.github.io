[Home](/)

## Project DAW
*// 01.06.2020*

Project DAW (digital agents workplace) equips every swiss Zurich agent with an iPad. The project develops an iOS app called MyCustomer and manages thirdparty apps like Fluix too.
MyCustomer app connects via REST with its own backend (Azure Webapp). 

### Backend
The initial idea of putting an own backend in place (We could have also just integrate zurichs existing systems directly with the iOS app) was to support different countries with the same iOS app. 
The backend would abstract all the country specifics, so the iOS doesn't need to care about it.
In our case this means we just implement the switzerland layer and map everything into a domain the iOS app understands.    

The backend connects to the centralized API Gateway and consumes multiple APIs from it.  
Main supplier of data is the Zurich CRM software (MS Dynamics 365).

### Challenges
A challenge I had to cope with, is the unbalanced team sizes. The reason for this is the way how zurich spreads budget to teams and project. If you convince the right persons that your project brings the most value, your project gets more money than others.
What the people don't consider is that a project can only as fast as its dependency systems.  
