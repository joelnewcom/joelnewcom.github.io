---
title: Project CEP
layout: archive
classes: wide
categories:
  - craftsmanship
header:
    teaser: "/assets/images/cep/CEP.PNG"
---

*// 03.03.2023*

This project is responsible to provide APIs and CIAM functionality for a customer portal.

You can edit your profile: 
![get-profile](/assets/images/cep/get-profile.PNG)

You can check your policies with Zurich:
![get-policies](/assets/images/cep/CEP-web.PNG)

# Start small
It started with helping a friend with some Java coding on a short-term solution to enable paperless communication with customer and ended up in contributing to a C# API application for the customer portal.

# MVP approach
First version display profile data of a customer and its policies. Basically this comes down to two endpoints: 

* get-profile
* get-policies

# API application
The application is a .net core application running on AKS. 

# Terraform
The needed infrastructure (besides AKS infrastructure, which is delivered by shared services team) 

* Keyvaults
* Azure DBs
* Networking (VNets, Subnets, Private endpoints)
* Blobstorages
* Service principals
* RBAC assignments

are all defined by the team in Terraform.