---
layout: single
title: "Use a MS SQL DB for development"
date: 2023-04-19 00:00:00 +0200
categories: Engineering
tags: [database, mssql, docker, development]
---

Following this tutorial: [link](https://learn.microsoft.com/en-us/azure/azure-sql/database/local-dev-experience-set-up-dev-environment?view=azuresql&tabs=vscode)

1. Install and Run Docker Desktop
2. Install VsCode [ms-mssql.mssql extension](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql)
3. Create a new Database Project in VsCode
4. Build and publish a new table -> The publish step will ask if you want to create a new db, click yes

This will create a new docker container with a ms sql database in it.
![sql server in docker](/assets/images/mssql/sql-server-in-docker.PNG)

You can connect to it with Azure data studio:
![azure data studio](/assets/images/mssql/azure-data-studio.PNG)



