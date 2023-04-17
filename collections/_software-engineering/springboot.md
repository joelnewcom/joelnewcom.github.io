---
layout: single
---

# Setup a local env via spring property file
1. Create a file ```src/main/resources/application-local.properties```
2. Define following variables within the new properties file. They will override the ones in ```src/main/resources/application.properties```:
   ```    
   servicename.config.environment=xxx
   servicename.config.configname=xxx 
   ```
3. Add new Run Configuration with Environment variables equals ```--spring.profiles.active=local```

![getting started - local env](/assets/images/software-engineering/java/getting-started-run-config.PNG)

# ### Setup a local env via environment variables

Add new Run configuration and define each attribute as Environment variable:
```
   ENVNAME=value;ENVNAME2=value;
```

![getting started - local env](/assets/images/software-engineering/java/getting-started-run-config-env-variables.PNG)

### Generate a new BCrypted password
Follow this [instructions](https://docs.spring.io/spring-security/reference/servlet/authentication/passwords/in-memory.html)
