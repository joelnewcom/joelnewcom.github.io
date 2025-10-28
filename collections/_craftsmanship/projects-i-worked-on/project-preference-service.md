---
title: Project Preference service
layout: archive
classes: wide
categories:
  - craftsmanship
header:
    teaser: "/assets/images/efile/preference-service.png"
---

*// 01.01.2024*

![preference-service](/assets/images/efile/preference-service.png)

## Project Preference Service
Preference-service is a microservice written in Java with Spring Boot. It is a part of the eFile platform of Zürich insurance.
The app is running on Azure kubernetes service (AKS).
The preference service stores the communication preferences of customers.

## Requirements
This app has only one client. It is the output management system (OMS) which is responsible to generate documents and send them to the customers.
OMS works on a party by party process and needs to know the preferences of each customer one by one. No bulk operations are supported.

The preference service needs to be able to response as fast as possible, otherwise OMS will be slowed down.

## Challenges
preference service got started as a tiny PoC to prove that we can store customer preferences in a central place and provide it fast enough to OMS.
As the PoC was successful, we decided to go into production with it. 
The app gets a lot of data from DB queries and external REST services to build up a data structure purely in memory to be able to response fast enough.

### High availability
The app doesn't have its own database and needs to load its in-memory data after startup.
Meaning after every restart/reschedule of a pod, the app needs to load all data again.

It is not easy to run multiple replicas of this app, as one instance needs a lot of memory (about 8GB) and we cannot guarantee that the instances
responses with the same data all the time, as the data source might change between two reloads.

### Data analytics
The final data lives only in memory. There is no good way to analyze the data, like you would do it in a database.

### Audit / History
The result of a data load is volatile, once the app is restarted, the data is gone, and we cannot reproduce what data was there before.

## Solutions
To cope with these challenges, we introduced a database for this app.
