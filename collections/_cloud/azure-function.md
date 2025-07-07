---
title: "Azure computer"
date: 2025-03-20
layout: single
tags:
  - Azure 
categories:
  - azure 
header:
  teaser: "/assets/images/cloud-teaser.JPG"
---

# Chose the right hosting plan

* Consumption plan
  * Doesn't support VNET integration
  * Is the predecessor of Flex Consumption plan 
* Flex Consumption plan
  * Supports VNET integration
  * Dont support Slot deployment
  * Only run one function app
* Premium plan
  * Supports VNET integration
  * Supports Slot deployment
  * Runs up to 100 different function apps
* Dedicated (App Service) plan

[Source](https://learn.microsoft.com/en-us/azure/azure-functions/functions-best-practices?tabs=csharp#choose-the-correct-hosting-plan)

Here is a great overview of the different plans: [Overview](https://learn.microsoft.com/en-us/azure/azure-functions/functions-scale#overview-of-plans)

# Deployments
Depending on the type of your function app, it can be deployed in different ways.
![Deployment Matrix](/assets/images/azure/azure-functions-deployment-types-matrix.png)
[Source](https://learn.microsoft.com/en-us/azure/azure-functions/functions-deployment-technologies?tabs=linux#deployment-technology-availability)


# Ilogger and ILoggerFactory
If typed Ilogger (Ilogger<Classname>) is injected, the logs are not sent to Application Insights nor host. 
You first need to enable the namespace via host file: 
https://learn.microsoft.com/en-us/azure/azure-functions/functions-dotnet-dependency-injection#iloggert-and-iloggerfactory

