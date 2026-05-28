---
layout: single
---

# Integration Patterns

How to connect cloud applications and services. Choose the right method based on latency needs, coupling tolerance, and data volume.

---

## Quick Decision Guide

| Need | Method |
|---|---|
| Immediate response required | REST, GraphQL, gRPC |
| Don't need to wait for result | Queue, Event broker |
| Real-time bidirectional | WebSocket |
| Third-party SaaS pushes to you | Webhook |
| Batch data movement | ETL/ELT, File transfer |
| Expose to external clients | API Gateway |
| Internal service communication at scale | Service mesh (gRPC/mTLS) |
| Multiple systems reading same event | Pub-Sub (Kafka, Event Hub, SNS) |

---

## Synchronous APIs

Use when the **caller needs an answer before continuing**.

### REST (HTTP/JSON)
Standard. Stateless, cacheable, widely supported. Slow/unavailable downstream = caller is blocked.
- Use for: CRUD operations, public APIs, simple request-reply.
- Avoid for: long-running operations, high-throughput streaming.

### GraphQL
Client specifies exactly what data it needs. Reduces over/under-fetching. One endpoint for all queries.
- Use for: frontend-driven APIs with complex, nested data requirements.
- Avoid for: simple CRUD, server-to-server integrations.

### gRPC (Protobuf over HTTP/2)
Binary protocol, strongly typed contracts, bidirectional streaming. Much faster than REST for internal services.
- Use for: internal microservice communication, polyglot environments, low-latency calls.
- Avoid for: browser clients (limited support without a proxy), external/public APIs.

### WebSocket
Persistent bidirectional connection. Both sides can push at any time.
- Use for: live dashboards, chat, real-time notifications, collaborative tools.
- Avoid for: fire-and-forget, batch, or infrequent communication (polling is simpler).

---

## Asynchronous — Queues & Events

Use when the **caller does not need to wait** for the result, or when the receiver may be temporarily unavailable.

### Queue (point-to-point)
Message is consumed by exactly one receiver. Guarantees delivery, supports retry and DLQ.
- Examples: Azure Service Bus, RabbitMQ, Amazon SQS
- Use for: work distribution, background jobs, business process steps that must not be lost.

### Event streaming (pub-sub / log)
Multiple consumers read the same stream independently. Events are retained and replayable.
- Examples: Kafka, Azure Event Hub, Google Pub/Sub
- Use for: telemetry, audit logs, event sourcing, feeding multiple downstream systems.

### Webhook (inbound push)
External system calls your HTTP endpoint on event. You don't control retry or ordering.
- Use for: receiving events from third-party SaaS (Stripe, GitHub, Twilio).
- Always verify signatures and respond fast (queue the work, don't process inline).

> **Key difference — sync vs async:**
> Sync = tight coupling, immediate feedback, caller blocked.
> Async = loose coupling, no immediate feedback, higher resilience.

---

## Batch & File-Based Integration

Use when **latency is not critical** and data volume is large or integration partner doesn't support APIs.

### ETL / ELT
Extract → Transform → Load. Move and reshape data between systems on a schedule.
- Examples: Azure Data Factory, Apache Airflow, AWS Glue
- Use for: data warehouse ingestion, nightly reporting, cross-system data sync.

### File transfer (SFTP, Blob Storage)
Drop a file, partner picks it up. Simple and reliable for legacy systems.
- Use for: EDI, billing exports, partner data exchanges, legacy ERP integrations.
- Avoid for: real-time data needs.

### CDC (Change Data Capture)
Stream database row changes as events without modifying the application.
- Examples: Debezium → Kafka, Azure SQL CDC → Event Hub
- Use for: replicating data across services, keeping read models in sync.

---

## Infrastructure Patterns

### API Gateway
Single entry point for all external clients. Handles auth, rate limiting, routing, SSL termination.
- Examples: Azure API Management, AWS API Gateway, Kong, Nginx
- Use for: exposing microservices to external consumers, enforcing security policies centrally.

### Service Mesh
Handles mTLS, retries, circuit breaking, and observability between internal services — without changing app code.
- Examples: Istio, Linkerd, Consul Connect
- Use for: Kubernetes microservice environments needing fine-grained traffic control and zero-trust networking.

### BFF (Backend for Frontend)
A dedicated API layer per client type (mobile, web, partner). Aggregates and shapes data for each consumer.
- Use for: when mobile and web clients have very different data needs, avoiding over-fetching.

---

## Sync vs Async — When Each Fails

| Scenario | Why sync breaks | Fix |
|---|---|---|
| Downstream is slow or down | Caller is blocked / times out | Use a queue in between |
| Processing takes > a few seconds | Client timeout, bad UX | Accept async, return job ID, poll or webhook back |
| Burst of traffic | Overwhelms receiver | Queue buffers the load |
| Fan-out to many consumers | N synchronous calls | Pub-Sub event |

| Scenario | Why async breaks | Fix |
|---|---|---|
| Caller needs immediate result | No response to act on | Use REST / gRPC |
| Strict ordering matters | Queues may reorder | Use partitioned stream or sessions |
| Simple CRUD with no side effects | Added complexity for no gain | Stay with REST |
