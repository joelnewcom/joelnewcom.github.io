---
layout: single
title:  "Introduce SonarQube"
date:   2023-05-08 00:00:00 +0200
categories: DevOps
---

# Create a new SonarQube project
In my case you would need to order this internally via devops self-service. 

# Create ADO pipeline to run SonarQube
SonarQube advices to run the prepare step before you build the application. In this case for a java application, this was not necessary, though for some .net application this might be mandatory. 

````yaml
      - job: SonarQubeAnalysis
        workspace:
          clean: resources
        displayName: "SonarQube Analysis"
        dependsOn: BuildTest
        steps:
          - task: DownloadPipelineArtifact@2
            displayName: 'Download Pipeline Artifact'
            inputs:
              artifact: artifactForSQ
              targetPath: '$(Pipeline.Workspace)/s'
          - task: SonarQubePrepare@5
            displayName: 'Prepare SonarQube'
            inputs:
              SonarQube: 'service-connection'
              scannerMode: 'CLI'
              configMode: 'manual'
              cliProjectKey: sonarQubeprojectkey
              extraProperties: |
                sonar.coverage.exclusions=**/test/**
                sonar.java.binaries=target/
                sonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml
                sonar.exclusions=src/main/resources/sql/**
          - task: SonarQubeAnalyze@5
            displayName: 'Analyze SonarQube'
          - task: SonarQubePublish@5
            displayName: 'Publish SonarQube'
            inputs:
              pollingTimeoutSec: '300'
````

# Setup sonarQube to decorate PR with comments
![azure-devops-build-validation](/assets/images/azure-devops/qualitygateToADO.PNG)

# Define the this pipeline as Build Validation step
After the first run (SonarQube needs to report back to ADO first) you should be able to set a Status Check on SonarQube quality gate:
![azure-devops-build-validation](/assets/images/azure-devops/StatusCheck-SonarQube.PNG)
This will make sure that the PRs need to pass the qualitygate defined on sonarQube. You can also define this BuildValidation is optional. 