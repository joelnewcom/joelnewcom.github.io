---
title: "Azure computer"
date: 2022-07-22
layout: single
tags:
  - Azure 
categories:
  - azure 
header:
  teaser: "/assets/images/cloud-teaser.JPG"
---

# Costs

There are compute and storage costs. 

## Compute costs
Compute costs are billed on minute basis and depends on the size and also the OS you select (Linux has no os license)
If the vm is deallocated, there are no compute costs charged.

There are two options to choose:

Consumption based:
Pay for compute capacity be seconds. This is good for short-term or unpredictable workloads.

Reserved VM instances:
You purchase a VM for one or 3 years. As its an upfront commitememnt its about 72% cheaper than pay-as-you-go.
You can pay early termination fee if you don't need it anymore. 

This option is good if you need a VM running all the time.

## Storage costs
The status of the VM has no relationship to storage costs.

# Connect to VMs
Normally you setup an azure bastion service in the same vnet as your vms. 
Azure bastion allows SSH and RDP connection without having your VMs exposed to the internet its also available via Azure portal.

# virtual machine extensions
They are small applications to do post-deployment automation tasks like software installations and update configuration.

There are two main different extensions: 
## Custom Script Extension (CSE) 
to run your custome script

## Desired State configuration (DSE) 
This is only about configuration. You define a powershell script with declarative content how the setup should look like.