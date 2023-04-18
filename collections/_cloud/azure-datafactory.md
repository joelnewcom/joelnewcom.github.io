---
title: "Azure data factory"
layout: single
date: 2023-03-03
tags:
    - Azure
categories:
    - azure
header:
teaser: "/assets/images/cloud-teaser.JPG"
---

# What is it
Azure Data Factory is a cloud-based ETL (Transform and Load) and data integration service

## Components
### pipelines
Groups of activities acting as a work-unit. 

### activities
On working step. Three types: 
* Data movement
* Data transformation
* Control

### data sets
Represents datastructure on your store

### connected services
Defines the connections informations to connect to external resources. 

### Data flows
To implement data transformation logic without code. Dataflows are run as activities in pipelines.

### integration runtimes
Are the compute resources on which compute activities run. 

![azure data factory concepts](/assets/images/azure/azure-data-factory-concepts.png)

