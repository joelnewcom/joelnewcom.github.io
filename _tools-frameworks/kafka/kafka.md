---
layout: single
---

# what is kafka?
Is realtime event-streaming platform.

* Can be the event broker in a event driven architecture
* Can cope with high volume data
* Can cope with IoT events
* Can cope with CDC (Change Data Capture) events

# Kafka features
* permanent storage: You can replay the events

## How it works

* Brokers
    * Topics (can have multiple partitions)
        * Messages
            * Message-Types

# Event driven architecture
Synchronous APIs have some disadvantages: If a system is down, it usually means the client cannot work anymore.

# Kafka topics
## standard topics
Standard retention time is 7days. You need to define your retention time...

# Compacted topics
You can group by some keys. Only the latest snapshot of the data will be kept.

# Consumer groups
If you have multiple partitions and multiple consumers, the consumers need to agree which consumers read which partition.
Consumer groups are independent of another consumer group.

If you want to replay passed events, you would do this with another consumer-group.


Consumer group without activity will be deleted after 7 days.

# kafka users
