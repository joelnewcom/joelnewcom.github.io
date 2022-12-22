---
title: "Azure ARM"
date: 2022-07-22
layout: single
tags:
  - Azure 
categories:
  - azure
header:
  teaser: "/assets/images/cloud-teaser.JPG"
---


ARM templates:
written in Json.

Normally an arm template (especially the quick templates) consist of 3 files:
„README.md“ describes what we want to achieve
„azuredeploy.json“ defines the resources
„azuredeploy.parameters.json“ provides some values for the azuredeploy.json


Templates written in Bicep will be transpiled to arm json by ARM .


## Parameters
Vorlagenparameter mit secureString- oder secureObject-Typen können nach der Bereitstellung der Ressource nicht mehr gelesen oder abgerufen werden.

They can be passed directly:

PowerShell:
```
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="addSkuParameter-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile `
  -storageName {your-unique-name} `
  -storageSKU Standard_GRS
 ```