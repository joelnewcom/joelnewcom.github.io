---
layout: single
title:  "Azure insights workshop"
date:   2023-06-06 00:00:00 +0200
categories: azure
---

# Training

It is a three days long course led by Microsoft.

* First day was theory about Azure Insights.
* Second day was a lab with PartsUnlimited webshop where Azure Insights is used to track usage of a webshop. After the
  lab we could show our own cases and Microsoft supported on all questions.
* Third day was about our internal solutions and Microsoft helped where possible.

# Purpose

Azure insights shall be used for performance measurement and log analytics of an application, but is not designed for
beeing an audit log.

# data types

## Metrics

* Performance data
* Free of charge
* lightweight
* Near realtime
* Can be used for autoscale
* Not analysable be default, but can be sent to Logs for detailed analyse

## Logs

* Needs to be opt in, costs money
* Rich verbose logs
* Can be analyzed

# Cloud role name

you should name the cloud role of your app. This helps a lot on the Application map.

# Availability test

Can be used to do TLS certificate validity check to warn you when a certificate is about to expire.

# Workbooks

There is a SLA Report pre-defined workbook which is a great start for measuring SLAs.

# Smart detection recipients

The one with role:

* Monitor Reader
* Monitor Contributor

on subscription, resource group or even azure insights resource will receive the smart detection alerts.

# UnlimitedParts Lab

## dotnet versions

.Net5 core and VisualStudio 2019 was required to run the application. I struggled a lot to set this up.

Normal dotnet installation folder is: C:\Program Files\dotnet

Under ```C:\Program Files\dotnet\shared``` we see the runtimes and there are different ones:
Microsoft.AspNetCore.App
Microsoft.NETCore.App
Microsoft.WindowsDesktop.App

And only the [dotnet-install.ps1](https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script) could
install a specific one.

```
dotnet --list-sdks
dotnet --list-runtimes

// this will install the specified version into: Microsoft.NETCore.App
./dotnet-install.ps1 -Architecture x64 -InstallDir "C:\Program Files\dotnet\" -Runtime dotnet -Version 6.0.16

./dotnet-install.ps1 -Architecture x64 -InstallDir "C:\Program Files\dotnet\" -Runtime dotnet -Version 5.0.17
```

## Enable Azure insights for dotnetcore application

There is a wizard on VisualStudio to setup AzureInsights. In my case it didn't work because I got logged out of my
account in VS all the time, so I did it manually following this:
follow this [manual](https://learn.microsoft.com/en-us/azure/azure-monitor/app/asp-net-core?tabs=netcorenew%2Cnetcore6#enable-application-insights-server-side-telemetry-no-visual-studio)

* Install the Microsoft.ApplicationInsights.AspNetCore Nuget package
* Add builder.Services.AddApplicationInsightsTelemetry(); on Pragram.cs
* Add ApplicationInsights.ConnectionString to appsettings.json

## Kusto Detective agent

To learn Kusto language: https://detective.kusto.io/

# Questions

## How many AzureInsights instances should we create

If possible: Only one. https://learn.microsoft.com/en-us/azure/azure-monitor/app/separate-resources
and https://learn.microsoft.com/en-us/azure/azure-monitor/logs/workspace-design#design-strategy

## Why we don't see exceptions on azure insights for our app

### Configuration order
[order of config](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/configuration/?view=aspnetcore-7.0#default-application-configuration-sources)

## Startup.cs
### ConfigureServices method
Configure services: Order of methods called doesn't matter

### Configure method
Configure method is actually a pipeline where the order of the methods calls matter.  