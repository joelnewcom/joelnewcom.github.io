---
layout: single
title:  "Hexagonal architecture"
date:   2023-09-01 00:00:00 +0200
categories: Architecture
---
# general idea
![Hexagonal](/assets/images/software-engineering/architecture/hexagonal/hexagonal-project.png)

You define your application structure like this:

* Core
  * DrivingPorts
  * DrivenPorts
  * Features (Business logic)
* Adapter
  * DrivingAdapters
  * DrivenAdapters

Where DrivingPorts and DrivenPorts are only interfaces (with core domain language).
And Adapter are the implementations of these ports. 

# Advantages
You can define the interfaces how to talk with the business logic on the core of the application. 
So the ports still "talks" in business logic language. 
Compared to 3 tier architecture, you never know where the boundary of your business logic is and which components 
translate from business-logic language to other domain language. 

For example: You define a model "Customer" on your business layer and define a @service, @controller and @repository classes for it.
Which class shall now translate from "Customer" to "CustomerDto" used by @Controller? The Controller itself, or shall the Service already return
the type CustomerDto?

[3tier](/assets/images/software-engineering/architecture/3tier/software-architecture.PNG)

