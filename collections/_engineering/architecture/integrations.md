---
layout: single
---

# REST
Should be used when you want an anwer of success or failure right away. 
It is a synchronous call and the client waits for the answer.

# Queue
Should be used when you don't want to lose a message. If a message cannot be processed, it can be retried and after all
can be moved to a dead letter queue for further actions. 

* Azure Service Bus
* RabbitMQ

# Eventstore
Should be used if there is a huge a amount of small messages and they need to be processed fast. Though if you 
lose a message, it is not huge a problem. Its not intended to store the event for a long time.

* Azure Eventhub
* Kafka