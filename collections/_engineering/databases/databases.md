---
layout: single
---



# ACID

## Atomicity
A transaction represents a unit which needs to be applied as a whole or not at all.

## Consitency
A transaction can only put data from a valid state to another valid state.

## Isolation
Between parallel transactions there should be no conflict. 

## Durability
A commit needs to persist even when database shuts down. 

# Technologies
## MySQL
Opensource Relational database (Part of LAMP stack -> Linux Apache, MySQL, PHP)

## MariaDB
Is a fork of MySQL (Relational database)

## PostgreSQL
Is a hybrid database which supports tables enriched with non-sql datatypes. 

## Cosmos DB
Is a non-relational database with APIs supporting Json documents, key-value pairs, column familiy and diagrams. 

## Azure Storage
See [Azure storage](/collections/cloud/azure-storage.md)

## Azure Data Factory
Azure Data Factory is a cloud-based ETL (Transform and Load) and data integration service

## Azure Synapse analytics
Azure synapse is a data-analysis solution which uses:
* Azure data factory pipelines
* SQL for data warehousing
* Apache spark
* Azure Synapse-data explorer

## Azure Databricks
Azure wrapper for Databricks. Databricks uses Apache Spark platform with SQL semantik to analyse data. 

## Azure HDInsight
Azure service which hosts different open source Big data technolgies from Apache like: 
* Apache Spark
* Apache Hadoop
* Apache HBase
* Apache Kafka
* Apache Storm

