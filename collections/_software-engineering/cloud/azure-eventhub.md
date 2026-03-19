---
title: "Azure Eventhub"
date: 2025-04-07
layout: single
tags:
  - Azure 
categories:
  - azure 
header:
  teaser: "/assets/images/cloud-teaser.JPG"
---

# Overview
Azure eventhub is used to stream events from publishers to consumers.

# Checkpoints

## Delete
You can delete checkpoints of each consumer group and partition to force the consumer within a consumer group to read all events of a specific partition  again.
![delete checkpoints](/assets/images/azure/eventhub/delete-checkpoints.png)