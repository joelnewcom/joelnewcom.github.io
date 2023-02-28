---
layout: single
---

# TLS facts
Even if you don't understand how it really works, you can assume following points are true:

1. Any message encrypted with Bob's public key can only be decrypted with Bob's private key.
2. Anyone with access to Bob's public key can verify that a message (by its signature) could only have been created by someone with access to Bob's private key. 

# HTTPS Inspection
Other names: including SSL inspection, TLS inspection, TLS break and inspect, and HTTPS interception.
This is close to the Man-in-the-middle attack (MITM) on a TLS connection or "on-path" attack.

The browser will still tell you that the connection is secure because its configured to trust the self-signed certificate by your company.

![TLS inspection](/assets/images/software-engineering/https/outbound_tls_inspection.png)

## How to detect HTTPS inspection
When certificate doesn't come from official CA but is self-signed by your company. 

## Applications other than browsers
A lot of other Applications uses TLS connection and you need to configure them to use the windows trust store otherwise they tell you that a non-trusted certificate is in the chain. 

### Java
```java -Djavax.net.ssl.trustStoreType=WINDOWS-ROOT -jar C:\MyApps\whatever.jar```