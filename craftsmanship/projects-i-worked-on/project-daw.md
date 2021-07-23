[Home](/)

## Project DAW
*// 01.06.2020*

Project DAW (digital agents workplace) equips every swiss Zurich agent with an iPad. The project develops an iOS app called MyCustomer and manages thirdparty apps like Fluix too.
MyCustomer app connects via REST with its own backend (Azure Webapp). 

### Backend
The initial idea of putting a backend in place was to support different countries with the same iOS app. The backend would abstract all the country specifics, so the iOS doesn't need to care about it.
In our case this means we just implement the switzerland layer and map everything into DAW domains.   

The backend connects to the API Gateway of Business unit switzerland and consumes different REST APIs from it.  
Main supplier of data is the Zurich CRM software (MS Dynamics 365).


