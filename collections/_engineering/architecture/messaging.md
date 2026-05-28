---
layout: single
---

# Messaging — Queues, Event Brokers & Webhooks

## Decision Matrix

| Technology | Model | Ordering | Replay | Throughput | Best for |
|---|---|---|---|---|---|
| Azure Service Bus | Queue / Pub-Sub | Per-session | DLQ only | Medium | Reliable business messages |
| Azure Event Hub | Event stream | Per-partition | Yes (days) | Very high | Telemetry, ingestion pipelines |
| Azure Storage Queue | Queue | Best-effort | No | Low–medium | Simple decoupling, low cost |
| Apache Kafka | Event stream | Per-partition | Yes (indefinite) | Extremely high | Event sourcing, audit logs |
| RabbitMQ | Queue / Pub-Sub | Per-queue | No | High | Complex routing, microservices |
| ActiveMQ | Queue / Pub-Sub | Per-queue | No | Medium | Java/JEE, legacy JMS |
| Amazon SQS/SNS | Queue / Pub-Sub | FIFO optional | No | Very high | Serverless on AWS |
| Google Pub/Sub | Pub-Sub | Per-key | 7 days | Very high | GCP pipelines |
| NATS JetStream | Queue / Stream | Per-stream | Yes | Extremely high | Low-latency, IoT, edge |
| Redis Streams | Event stream | Per-stream | Yes | High | Lightweight streaming |
| Apache Pulsar | Queue + Stream | Per-partition | Yes (indefinite) | Very high | Multi-tenant, geo-replicated |
| Webhook | HTTP push | None | No | Sender-dependent | Third-party SaaS integrations |

---

## Technologies

### Azure Service Bus
Enterprise broker with **DLQ, sessions, transactions, and topic filters**. Every message must be processed — designed for reliability over throughput.
- Use for: order processing, approval workflows, microservice command bus.
- Avoid for: high-throughput telemetry, event sourcing.

### Azure Event Hub
Partitioned event stream with **consumer groups and short-term replay**. Kafka-compatible endpoint available.
- Use for: IoT telemetry, log ingestion, real-time analytics pipelines.
- Avoid for: transactional messages needing DLQ or retries.

### Azure Storage Queue
Cheapest Azure queue. 64 KB limit, 7-day TTL, at-least-once, no ordering.
- Use for: simple background jobs, Azure Function triggers, low-cost decoupling.
- Avoid for: ordered processing, messages > 64 KB.

### Apache Kafka
Immutable, partitioned log with **indefinite retention and exactly-once semantics**. Industry standard for event streaming.
- Use for: event sourcing, CDC (Debezium), audit logs, high-throughput pipelines.
- Avoid for: simple task queues (operational overhead too high), request-reply.

### RabbitMQ
Mature AMQP broker with **flexible exchange routing** (direct, fanout, topic, headers). Quorum queues for HA.
- Use for: complex routing rules, work queues, MQTT/STOMP support, microservices.
- Avoid for: millions-of-events/sec telemetry, indefinite replay.

### ActiveMQ
**JMS-compliant** broker for Java/Spring stacks. Use Artemis (next-gen) over Classic for new deployments.
- Use for: legacy JEE apps, Spring JMS, on-premise where cloud brokers are unavailable.
- Avoid for: greenfield projects — prefer RabbitMQ or Kafka.

### Amazon SQS & SNS
SQS = queue (Standard or FIFO). SNS = pure fan-out to SQS, Lambda, HTTP, email.
**SNS → SQS** is the standard AWS reliable fan-out pattern.
- Use for: AWS serverless architectures, Lambda triggers, multi-subscriber fan-out.

### NATS JetStream
Ultra-lightweight broker (single binary). Core NATS = ephemeral pub-sub. JetStream adds persistence.
- Use for: Kubernetes service mesh, IoT/edge, latency-critical internal comms.

### Redis Streams
Kafka-like log inside Redis. Lives in RAM — suitable for moderate volume.
- Use for: simple streaming when Redis is already in the stack.
- Avoid for: large volumes or long retention (memory cost).

### Apache Pulsar
Separates broker (compute) from BookKeeper (storage). Supports queue + stream semantics on the same topic.
- Use for: multi-tenant SaaS, geo-replicated streaming, independent storage scaling.

---

## Webhook Pattern

An HTTP callback — a remote system POSTs to your endpoint when an event occurs. Not a broker, just a pattern.

```
[External System] ──POST /webhooks/payment──▶ [Your API]
```

**Key rules:**
1. Respond `200 OK` immediately — push work to a queue, never process inline.
2. Verify the HMAC-SHA256 signature on every request.
3. Design handlers to be **idempotent** — duplicates happen.

| | Webhook | Polling |
|---|---|---|
| Latency | Near real-time | Interval-bound |
| Sender load | Low | High |
| Reliability | Sender retry policy | Receiver-controlled |
| Requires public endpoint | Yes | No |

- Use for: Stripe, GitHub, Twilio, PagerDuty integrations.
- Avoid for: high-volume streams, guaranteed ordering, audit replay.

---

## Choosing the Right Technology

| Need | Pick |
|---|---|
| Must not lose a message, retry on failure | Service Bus, RabbitMQ, SQS FIFO |
| High-throughput telemetry ingestion | Kafka, Event Hub, Kinesis |
| Event sourcing / indefinite replay | Kafka, Pulsar |
| Simple background task queue | Storage Queue, SQS Standard |
| Complex routing between microservices | RabbitMQ, Service Bus topics |
| JMS / Java EE legacy | ActiveMQ Artemis |
| Third-party SaaS integration | Webhook |
| Ultra-low latency internal comms | NATS JetStream |

---

## Common Mistakes

| Mistake | Why it's wrong |
|---|---|
| Kafka for simple task queues | Operational overhead far exceeds the benefit |
| Storage Queue for ordered processing | No ordering guarantee — use Service Bus sessions |
| Slow work in a webhook handler | Causes timeouts → sender retries → duplicates |
| Skipping webhook signature verification | Any actor can forge events |
| Event Hub for transactional messages | No DLQ, no sessions, no per-message retry |
| Service Bus for telemetry at scale | Not designed for millions of small events/sec |


