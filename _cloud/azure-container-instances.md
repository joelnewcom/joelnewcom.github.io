---
date: 2022-07-22
tags:
  - Azure
categories:
  - azure
header:
  teaser: "/assets/images/cloud-teaser.JPG"
---

#  Azure container instances
Top-level resources is container group. This is similar to kubernetes pod.
Its a collection of containers on the same host machine. They share the same lifecycle, resources, sotrage volumes, network etc.

The key thing that Docker provides is the guarantee that the containerized software will always run the same. It doesn't matter if the code is run locally on Windows, Linux or in the cloud on Azure.

# Azure Kubernetes Service

![AKS](/assets/images/azure/azure-kubernetes.png)
 
* Pools are groups of nodes with identical configurations.
* Nodes are individual virtual machines running containerized applications.
* Pods are a single instance of an application. A pod can contain multiple containers.
* Container is a lightweight and portable executable image that contains software and all of its dependencies.
* Deployment has one or more identical pods managed by Kubernetes.
* Manifest is the YAML file describing a deployment.

# Storage
Azure Disks are mounted on one node.
Azure Files can be mounted on multiple nodes.

