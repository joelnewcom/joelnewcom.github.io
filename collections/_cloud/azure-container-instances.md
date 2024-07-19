---
title: "Azure container instances"
layout: single
date: 2022-07-22
tags:
  - Azure
categories:
  - azure
header:
  teaser: "/assets/images/cloud-teaser.JPG"
---

#  Azure container instances
Top-level resource is a container group. This is similar to a kubernetes pod.
It is a collection of containers on the same host-machine. They share the same lifecycle, resources, storage volumes, network etc.

The benefit: Containerization guarantees the containerized software will always run the same. 
It doesn't matter, if the code is run locally on Windows, Linux or in the cloud (as its always the same container).

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

