---
layout: single
title:  "Which PaaS is the right one for me?"
date:   2024-06-19 00:00:00 +0200
categories: azure
---

https://learn.microsoft.com/en-us/azure/container-apps/compare-options

Often it is not clear which PaaS to use. Here is a comparison of the different options:

![PaaS](/assets/images/azure/azure-compute-services.png)

# Container apps
Container apps is actually opinionated AKS.
Container environment = AKS Namespace
Container apps is built for microservices
Offers Revisions (Last 100 states). Set an old revision to active

# App service
Offers Slots. Blue/green deployments
This is the most simple solution to run an app, though it is not as flexible as AKS or container apps.

# AKS
Full control. You need to manage everything.
