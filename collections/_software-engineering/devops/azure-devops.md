---
layout: single
---

# Pipeline runs: 
pull requests can require (via branch policy: Build Validation) builds to happen before they can be merged.

Normal runs are happening after something is merged into a branch. 

# variables
## secret variables

You need to map the secret variables first to get its content.
For example:
````yaml
  - script: jmeter -n -t $(Build.SourcesDirectory)/.azure/load-test-preference-service.jmx -l reports/results.jtl -e -o reports
    env:
      CND_CUSTOMER_PREFERENCE_SERVICE_HOST: $(LOAD_TEST_HOST)
      LOAD_TEST_PASSWORD: $(LOAD_TEST_PASSWORD)
      LOAD_TEST_SYSTEM_OF_RECORD_ID : $(LOAD_TEST_SYSTEM_OF_RECORD_ID)
````

## predefined variables
### Build.Reason
* IndividualCI -> Triggered when a branch is updated 
* PullRequest -> Triggered by a branch policy
* Manual -> Triggered manually


# Create PR comments with Powershell

Make a conditional task within a pipeline 
````yaml
- task: PowerShell@2
  condition: eq(variables['Build.Reason'], 'PullRequest')
  displayName: Post Message to PR
  env:
    SYSTEM_ACCESSTOKEN: $(System.AccessToken)  
  inputs:
      targetType: filePath
      filePath: PostToPR.ps1
````

# Trigger Pipeline run on Pull request

## Option 1 - Via Build Validation policy
![azure-devops-build-validation](/assets/images/cicd/azure-devops-build-validation.png)

## Option 2 - Via yml pipeline file

````yaml
# trigger this pipeline if there's a PR to any of these branches
pr:
- master
- main
- staging
- releases/*
````

# Scheduled trigger
By default every pipeline is enabled for IndividualCI trigger. As soon as there are changes to the branch, the pipeline would run. Thats why you need to disable this.
You can also define schedules via ADO ui and it will override whats defined in the yaml definition. 

````yaml
trigger: none

schedules:
- cron: '0 0 1 * *' # check: https://learn.microsoft.com/en-us/azure/devops/pipelines/process/scheduled-triggers?view=azure-devops&tabs=yaml#cron-syntax
  displayName: Every first day of a month
  branches:
  include:
    - main
````



# Using PAT basic authorization
Generate a new personal access token on Azure Devops. 
You can use the token in the Basic Authorization header. Just keep the username empty and the PAT token is the password.
```--header 'Authorization: Basic {toBase64(:$PAT-token)}'```

[Infos here](https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?toc=%2Fazure%2Fdevops%2Forganizations%2Ftoc.json&view=azure-devops&tabs=Windows)

# Create PR comments

Make this REST call according to the [MS docu](https://learn.microsoft.com/en-us/rest/api/azure/devops/git/pull-request-threads/create?view=azure-devops-rest-7.0&tabs=HTTP), but omit the ```pullRequestThreadContext``` attribute, as ADO would then ignore the filePath attribute.  

````shell
curl --location --request POST 'https://dev.azure.com/{org}/{project}/_apis/git/repositories/{repo-name}/pullRequests/95973/threads?api-version=7.0' \
--header 'Authorization: Basic {PAT}' \
--header 'Content-Type: application/json' \
--data-raw ' {
      "comments": [
        {
          "parentCommentId": 0,
          "content": "Thats my comment",
          "commentType": 1
        }
      ],
      "status": 1,
      "threadContext": {
        "filePath": "/Allora.Core/Services/BlobStorageService.cs",
        "leftFileEnd": null,
        "leftFileStart": null,
        "rightFileEnd": {
          "line": 92,
          "offset": 100
        },
        "rightFileStart": {
          "line": 92,
          "offset": 1
        }
      }
    }'
````

[Checkout the sample pipeline](/assets/cicd/Create-veracode-pr-comment/get_veracode_feedback.yml)

[And its powershell script](/assets/cicd/Create-veracode-pr-comment/create-veracode-pr-comments.ps1)


# Use emojis
[Emoji in Azure Devops()]https://learn.microsoft.com/en-us/azure/devops/project/wiki/markdown-guidance?view=azure-devops#emoji)

# SonarQube integration

Create a sonarQube project and configure it to integrate with your ADO repository. Only with this setting, SonarQube will be able to publish a state back to the PR. 
![azure-devops-build-validation](/assets/images/azure-devops/qualitygateToADO.PNG)

Then you need to create a pipeline with these steps in it: 

````yaml
  - job: SonarQubeAnalysis
    displayName: "SonarQube Analysis"
    dependsOn: BuildTest
    steps:
      - task: DownloadPipelineArtifact@2
        displayName: 'Download Pipeline Artifact'
        inputs:
          artifact: artifactForSQ
          path: target/
      - task: SonarQubePrepare@5
        displayName: 'Prepare SonarQube'
        inputs:
          SonarQube: 'service-connection'
          scannerMode: 'CLI'
          configMode: 'manual'
          cliProjectKey: SonarQubeprojectKey
          extraProperties: |
            sonar.coverage.exclusions=**/test/**
            sonar.java.binaries=target/
            sonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml
            sonar.exclusions=src/main/resources/sql/**, src/main/resources/templates/**
      - task: SonarQubeAnalyze@5
        displayName: 'Analyze SonarQube'
      - task: SonarQubePublish@5
        displayName: 'Publish SonarQube'
        inputs:
          pollingTimeoutSec: '300'
````

Then define this pipeline as Build Validation step.

After the first run you should be able to set a Status Check on SonarQube quality gate:
![azure-devops-build-validation](/assets/images/azure-devops/StatusCheck-SonarQube.PNG)

# Paths on ADO pipeline

$(Pipeline.Workspace) equals to $(Agent.BuildDirectory) 

-> $(Build.SourcesDirectory) -> $(Pipeline.Workspace)/s

# Debug on Pipelines

````yaml
    steps:
      - task: DownloadPipelineArtifact@2
        displayName: 'Download Pipeline Artifact'
        inputs:
          artifact: artifactForSQ
          targetPath: '$(Pipeline.Workspace)/s'
      - script: |
          echo "ls $(System.DefaultWorkingDirectory)/"
          ls $(System.DefaultWorkingDirectory)/
          
          echo "ls $(Pipeline.Workspace)"
          ls $(Pipeline.Workspace)
          
          echo "ls $(Pipeline.Workspace)/s"
          ls $(Pipeline.Workspace)/s
````

# Tree
This will output the content of the defined workingDirectory in a nice tree. Its including folder and files
````yaml
- task: CmdLine@2
  displayName: 'tree command in $(Build.ArtifactStagingDirectory)'
  inputs:
    workingDirectory: $(Build.ArtifactStagingDirectory)
    script: 'tree /F'
````

# If else

Following example show how to use ```createSandBox``` and ```sanboxName``` attributes only if the if-condition is met.    
```yaml
  - task: Veracode@3
    displayName: 'Upload to VeraCode and run static scan'
    inputs:
      ConnectionDetailsSelection: Credentials
      apiId: '$(veracode-api-id)'
      apiKey: '$(veracode-api-secret)'
      veracodeAppProfile: 'blalba' # Veracode application profile to scan
      version: '$(build.buildNumber)-$(Build.BuildId)' # name of the scan to run
      filepath: '$(Build.ArtifactStagingDirectory)/publish_output' # filepath or folderpath of files to upload to Veracode
      ${{ if parameters.isPr }}:
        createSandBox: true # true to scan of new development sandbox
        sandboxName: 'PullRequest-Sandbox'
      createProfile: false # false to enforce using existing profiles
      failBuildIfUploadAndScanBuildStepFails: true # true to fail build if Upload and Scan task fails to start
      importResults: true # required to view Veracode results in Azure DevOps
      failBuildOnPolicyFail: true # true to fail the build if application fails policy
      maximumWaitTime: '360' # wait time, in minutes, to fail the build if no scan results available
```