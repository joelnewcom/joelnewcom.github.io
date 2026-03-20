---
layout: single
---

# Check content of .pfx cert file

```certutil -dump cert.pfx```

# Add a cert to jvm
[source](https://connect2id.com/blog/importing-ca-root-cert-into-jvm-trust-store)

certmgr.msc

-Djavax.net.ssl.trustStore=zurichTrustStoreFile -Djavax.net.ssl.trustStorePassword=nevertrustme