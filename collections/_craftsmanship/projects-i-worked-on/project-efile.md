---
title: Project EFile
layout: archive
classes: wide
categories:
  - craftsmanship
header:
    teaser: "/assets/images/efile/ingest-efile.png"
---

*// 01.01.2025*

![preference-service](/assets/images/efile/functions.png)

# Project eFile
EFile is a platform we developed from scratch to send out emails instead of paper letters to customers of Zürich insurance.

OMS (output management system) is responsible to generate documents and send them to the customers.
At some point in the process, OMS decides if the communication shall go out physical or digitally. 
In case of digitally, OMS publishes an event to an event hub, which is then processed by eFile solution.

# Caching documents
To be able to send out documents fast enough, we introduced an azure premium blobstorage as a caching layer for the documents.
After a certain time, the documents are deleted from this blobstorage and the efile platform will fetch the document from an archive system.

# Serverless
A lot of components within efile are serverless functions. This allows us to scale depending on the load from OMS system.