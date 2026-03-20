---
layout: single
---

# SSL Inspection
SSL inspection (Man in the middle) is a technique used to intercept and analyze encrypted SSL/TLS traffic between a client and a server. 
This is often done for security purposes, such as monitoring for malicious activity or enforcing corporate policies.

# Download the certificate
Just open any website with SSL inspection enabled and download/export the certificate.

## Maven
Set JAVA_HOME to the correct version
```
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
```

Create a new keystore based on the default ca certs

```
mkdir -p ~/dev/security
cp "$JAVA_HOME/lib/security/cacerts" ~/dev/security/corp-cacerts
```

Import the certificate into the newly created keystore
```
keytool -importcert \
  -alias corp-root \
  -file corporate-root.pem \
  -keystore ~/dev/security/corp-cacerts \
  -storepass changeit \
  -noprompt
```

Create or edit the ~/.mavenrc file and add the following line:
```
echo 'export MAVEN_OPTS="-Djavax.net.ssl.trustStore=$HOME/dev/security/corp-cacerts -Djavax.net.ssl.trustStorePassword=changeit"' >> ~/.mavenrc
```
