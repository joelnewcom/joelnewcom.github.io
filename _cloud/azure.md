---
title: "Azure"
date: 2022-07-22
tags:
  - Azure
categories:
  - azure
header:
  teaser: "/assets/images/cloud-teaser.JPG"
---


## connectivity troubleshooting
There are two major causes if you cannot reach a host:
* If you have a firewall in the way, you hit the TCP timeout. The TCP timeout is 21 seconds in this case. Use the ```tcpping``` tool to test connectivity.
* DNS isn't accessible. The DNS timeout is 3 seconds per DNS server. If you have two DNS servers, the timeout is 6 seconds. Use ```nameresolver``` to see if DNS is working. 
You can't use nslookup, because that doesn't use the DNS your virtual network is configured with. If inaccessible, you could have a firewall or NSG blocking access to DNS or it could be down.

## Blob Storage

is ideal for
Serving images or documents directly to a browser.
Storing files for distributed access.
Streaming video and audio.
Storing data for backup and restore, disaster recovery, and archiving.
Storing data for analysis by an on-premises or Azure-hosted service.
Storing up to 8 TB of data for virtual machines.

Three resource level are needed to manage blobs.
![](blob1.png)

Types of storage accounts:
* General-purpose v2: For most scenarios. Can store blobs, files, queues and tables
* Block blob: For Block blobs. Recommended for high transaction scenarios on small objects. Low transaction latency
* Page blob: For Page blobs only.

Types of blobs:
* Block blobs store text and binary data and each block of data can be managed individually.
* Append blobs are made up of blocks like block blobs, but are optimized for append operations. Ideal for logging data.
* Page blobs store random access files up to 8 TiB in size. Page blobs store virtual hard drive (VHD) files and serve as disks for Azure virtual machines.

## Azure app service
The app service plan defines in which azure region your app will run. 

in price tier Free and Shared your app gets CPU minutes on a shared VM instance. 

On the other pricing tiers you have your own VM resources. 
If you scale out the app service plan, all apps running on that plan will be scaled out. 

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

## Appsettings
The Azure app service app settings overrides the ```Web.config``` and ```appsettings.json``` values. 
App settings are encrypted at rest.

If "Deployment slot setting" is enabled, the setting is only for the actual slot and will not be shared with other slots.

For linux containers you need to defined embedded json object like this: ```ApplicationInsights__InstrumentationKe```, so the ":" becomes "__"

## Automatic Scaling rules
Automatic scaling rule first aggregates all values of all instances on the metric specific "AggregationIntervall". Most of metrics have this set to 1min.
After that the custom settings of duration and aggregationmethod (min, max, av) will be applied on the previous metric aggregation.


## Cosmos DB
RU = Request unit. Its a measure based on CPU, IOPS and Ram needed to perform DB requests.
1 RU = Resources needed to read 1KB Element by ID and partitionkey. 

### Partitionkey
Cosmos distributes partitions on its physic partitions. The key to group the data is set by the user in form of a partitionkey.
The partitionkey should devide the data into equal pieces. Unique ElementIds are good choice for partitionkey.

## Azure VMs
Usecases:
* Is good for developing and testing.
* Run application in cloud
* extend your datacenter

It is cool because you can shutdown your VM and don't pay anymore. When you manage VM's yourself you still pay for the underlying infrastructure.

### VM scaling group
You can define a group of VMs which share all the same settings.

### Availabilitygroup
You can group your VMs into groups and Azure will make sure that VMs in the groups
are distributed over different failuredomains.

#### Failure-Domain
Group depending on same infrastructure as electricity, switch, rack etc.

#### Update-Domain
Group of Hardware/Software which can be updated at the same time

## Load balancer
To make sure, traffic only goes to VMs which are running, you need to place an Azure Load Balancer in front of them.



# Azure infrastructure 

## Regions
Stands for an area on the planet which contains at least on azure datacenter. 
### Region pairs
If you want to go full resilience you make usage of region pairs. If a whole region goes down, your resource would fail over to the region pair.

### Sovereign Regions
These are some seperated azure regions for US and China goverment. 

## Availability zones
Availabilityzone is one of minimum three physically separate datacenter in an azure region (Not every azure region support availability zones)



## API Gateway
Azure API Gateway can mock api and can do retry logic.
Its good practice to use a subscription key for your api. You can define access policies for each subscription key.
API Gateway also supports a variety of policies to apply on the incoming traffic. 

## Event grid
Webhooks can be used to get synchronous notification from the event grid.

## Bastion
Lets you dp rdp to your VMs. 

## organizing azure resources
* Azure management groups: Lets you group subscriptions (Composition of multiple management groups are possible). Enables to define access for multiple subscriptions and to apply policies to multiple subscriptions. 
* Subscriptions: Second tier. Where the billing happens. You can also define access on this level. You cannot put a subscription into another subscription.
* Resource Group: To group resources
* Resource