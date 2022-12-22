---
title: "Private endpoint setup"
layout: single
date: 2022-07-26
tags:
  - Azure 
categories:
  - azure
header:
  teaser: "/assets/images/cloud-teaser.JPG"
---

# Used references
## Used quickstart bicep template: 
https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.web/private-webapp-with-app-gateway-and-apim

## Networking with private endpoints
https://docs.microsoft.com/en-us/azure/app-service/networking/private-endpoint

## Deploy app to app-service with private endpoints
https://azure.github.io/AppService/2021/03/01/deploying-to-network-secured-sites-2.html
https://azure.github.io/AppService/2021/04/22/Site-with-secure-backend-communication.html

## DNS Resolving
# Standard when using webapp:
| Name                                  | Type  | Value                                 |
|---------------------------------------|-------|---------------------------------------|
| mywebapp.azurewebsites.net            | CNAME | clustername.azurewebsites.windows.net |
| clustername.azurewebsites.windows.net | CNAME | cloudservicename.cloudapp.net         |
| cloudservicename.cloudapp.net         | A     | 40.122.110.154                        |


# When using webapp with private endpoint:
| Name                                         | Type  | Value                                  | Remark                                                                                                              |
|----------------------------------------------|-------|----------------------------------------|---------------------------------------------------------------------------------------------------------------------|
| mywebapp.azurewebsites.net                   | CNAME | mywebapp.privatelink.azurewebsites.net | Azure creates this entry in Azure Public DNS to point the app service to the privatelink and this is managed by us  |
| mywebapp.privatelink.azurewebsites.net       | A     | 10.10.10.8                             | You manage this entry in your DNS system to point to your Private Endpoint IP address                               |




# WIP

This worked with private endpoints disabled:
https://web-u4ojl5tpyinng-staging.azurewebsites.net/weatherforecast


