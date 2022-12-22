---
title: "Azure App service"
date: 2022-07-22
layout: single
tags:
  - Azure 
categories:
  - azure
header:
  teaser: "/assets/images/cloud-teaser.JPG"
---

# App service plan
If multiple apps are in the same App Service plan, they all share the same VM instances. 
If you have multiple deployment slots for an app, all deployment slots also run on the same VM instances. 
If you enable diagnostic logs, perform backups, or run WebJobs, they also use CPU cycles and memory on these VM instances.

## Azure app service
The app service plan defines in which azure region your app will run.

In price tier "Free" and" Shared", your app gets CPU minutes on a shared VM instance.
On the other pricing tiers you have your own VM resources.
If you scale out the app service plan, all apps running on that plan will be scaled out.

## Considerations
Think about this points to determine if you need a new app service plan or re-use one:
* The app is resource-intensive.
* You want to scale the app independently from the other apps in the existing plan.
* The app needs resource in a different geographical region.

### ways to deploy your app
An app is by default deployed to: D:\home\site\wwwroot

Git: App Service-Web-Apps verfügen über eine Git-URL, die Sie als Remoterepository hinzufügen können. Durch Push an das Remoterepository wird Ihre App bereitgestellt.
CLI:webapp up ist ein Feature der az-Befehlszeilenschnittstelle, mit der Apps gepackt und bereitgestellt werden können. Im Gegensatz zu anderen Bereitstellungsmethoden kann mit az webapp up eine neue App Service-Web-App für Sie erstellt werden, sofern Sie dies nicht bereits erledigt haben.
ZIP-Bereitstellung: Verwenden Sie curl oder ein ähnliches HTTP-Hilfsprogramm, um eine ZIP-Datei Ihrer Anwendungsdateien an App Service zu senden.
FTP/S: FTP oder FTPS ist eine herkömmliche Methode, Ihren Code per Push in beliebige Hostingumgebungen wie App Service zu übertragen.


### Slots
When swapping slots, all instances of the source slot will be restarted (because they get the slot specific config of the target slot)

## Authentication and authorization via app service
If enabled, the http traffic goes first to the auth modul of azure app service (which runs in the samesandbox as your app)

Microsoft Identitätsplattform	/.auth/login/aad	Microsoft Identitätsplattform-App-Service-Anmeldung
Facebook	/.auth/login/facebook	App Service Facebook-Anmeldung
Google	/.auth/login/google	Google-Anmeldung App Service
Twitter	/.auth/login/twitter	App Service Twitter-Anmeldung
Ein beliebiger OpenID Connect-Anbieter	/.auth/login/<providerName>	App Service OpenID Connect-Anmeldung

You can decide if the auth modul should let unauthorized traffic through or not.

## App settings
The Azure app service app settings overrides the ```Web.config``` and ```appsettings.json``` values.
App settings are encrypted at rest.

If "Deployment slot setting" is enabled, the setting is only for the actual slot and will not be shared with other slots.

For linux containers you need to defined embedded json object like this: ```ApplicationInsights__InstrumentationKe```, so the ":" becomes "__"

## Scaling
You can either scale up/down, which means changing the app service plan, eg. making the machine(s) bigger.
Or scale out/in, which means add more instances of your current app service plan machine.  

## Automatic Scaling rules
Can be matric-based or time-based. 

Automatic scaling rule first aggregates all values of all instances on the metric specific "AggregationIntervall". Most of metrics have this set to 1min.
After that, the custom settings of duration and aggregationmethod (min, max, av) will be applied on the previous metric aggregation.
