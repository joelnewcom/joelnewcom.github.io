---
title: "Azure storage"
layout: single
date: 2022-07-22
tags:
  - Azure 
categories:
  - azure
header:
  teaser: "/assets/images/cloud-teaser.JPG"
---


## Azure storage
Locally redundant storage (LRS) replicates your data three times within a single data center in the primary region. LRS provides at least 11 nines of durability (99.999999999%) of objects over a given year.
For Availability Zone-enabled Regions, zone-redundant storage (ZRS) replicates your Azure Storage data synchronously across three Azure availability zones in the primary region. ZRS offers durability for Azure Storage data objects of at least 12 nines (99.9999999999%) over a given year.


Azure Blobs: A massively scalable object store for text and binary data. Also includes support for big data analytics through Data Lake Storage Gen2.
Azure Files: Managed file shares for cloud or on-premises deployments.
Azure Queues: A messaging store for reliable messaging between application components.
Azure Disks: Block-level storage volumes for Azure VMs.


### Blob Storage

is ideal for
Serving images or documents directly to a browser.
Storing files for distributed access.
Streaming video and audio.
Storing data for backup and restore, disaster recovery, and archiving.
Storing data for analysis by an on-premises or Azure-hosted service.
Storing up to 8 TB of data for virtual machines.

Three resource level are needed to manage blobs.
![](blob1.png)

Types of storage accounts:
* General-purpose v2: For most scenarios. Can store blobs, files, queues and tables
* Block blob: For Block blobs. Recommended for high transaction scenarios on small objects. Low transaction latency
* Page blob: For Page blobs only.

Types of blobs:
* "Block blobs" store text and binary data and each block of data can be managed individually.
* "Append blobs" are made up of blocks like block blobs, but are optimized for append operations. Ideal for logging data.
* "Page blobs" store random access files up to 8 TiB in size. Page blobs store virtual hard drive (VHD) files and serve as disks for Azure virtual machines.
# Storage tier
Hot, Cold, archive is set on storageAccount level

# Encryption
StorageSerice encryption is default and cannot be disabled. It uses 256-Bit-AES encryption