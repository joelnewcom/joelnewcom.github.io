---
layout: single
---

# VeraCode static scan
1. Order a veracode profile and some credentials to access it
2. Build a pipeline to build your app and send it to veracode
3. Trigger a first scan
3. Before the whole process can be automated, you need to configure these things on veracode UI
   3. Module selection: Select the entrypoint of your app
   4. Set auto-scan to on

After that, the pipeline can run automatically, though the previous scan needs to be finished before the next one can start.
That is why, it is better to schedule the pipeline to run for example all weeks and not trigger the pipeline on every PR.  

# VeraCode pipeline scan

[VeraCode documentation about pipeline scan](https://docs.veracode.com/r/c_about_pipeline_scan)

## Doing it locally in powershell:

### Package the .net app
[VeraCode documentation to pack .Net app](https://docs.veracode.com/r/compilation_net)

Run: ```dotnet publish .\myproject.csproj -o myPublishedApp -c Debug```

### Reduce it to the min
```
$dest = "C:\Git\myproject\myPublishedApp-reduced"
$source = "C:\Git\myproject\myPublishedApp"
Copy-Item -Path $source -Filter "MyNameSpace*" -Destination $dest –Recurse
```

### zip it
```
Compress-Archive -Path C:\Git\myproject\myPublishedApp-reduced -DestinationPath C:\Git\myproject\myPublishedApp-reduced
```

### Download VeraCode pipeline scan client
```
$extractFolder = "C:/MyApps/veracode-pipeline-scan/latest"
        if(!(Test-Path -Path $extractFolder/pipeline-scan.jar -PathType Leaf)){
            Invoke-WebRequest https://downloads.veracode.com/securityscan/pipeline-scan-LATEST.zip -OutFile pipeline-scan.zip  
            Expand-Archive pipeline-scan.zip -DestinationPath $extractFolder
        }
```

### Run the pipeline scan

```
java -jar C:\MyApps\veracode-pipeline-scan\latest\pipeline-scan.jar `
-vid "{veraCode ID}" `
-vkey "{veracode token}" `
-f "C:\Git\myproject/myPublishedApp-reduced.zip" `
--veracode_profile "{veracode profile}" `
--summary_display "true" `
--summary_output "true" `
--development_stage "Development"
```

Additionally add this parameter if you want to ignore all flaws found in a previous scan
``` 
--baseline_file "C:\MyApps\veracode-pipeline-scan\latest\api-baseline\results.json" `
```

You will see this output:
![Files involved](/assets/images/cicd/veracode-pipelinescan.PNG)

```filtered_results.json``` includes all delta findings compared to baseline, ```results.json``` including all findings regardless of baseline, ```results.txt``` summarizes the scan.


# Veracode in Azure Devops pipeline for java app

```
variables:
- group: SOME-LIBARY
- name: system.debug
  value: true

trigger: none

pool:
  name: Azure Pipelines
  vmImage: 'ubuntu-latest'

stages:
  - stage: Code
    displayName: "Source Code"
    jobs:
      - job: BuildTest
        displayName: "Build and Test"
        steps:
          - task: MavenAuthenticate@0
            displayName: Maven Authenticate Artifacts
            inputs:
              artifactsFeeds: 'artfeed'
          - task: JavaToolInstaller@0
            inputs:
              versionSpec: '11'
              jdkArchitectureOption: 'x64'
              jdkSourceOption: 'PreInstalled'
          - script: |
              chmod +x ./mvnw
              ./mvnw clean package -DskipTests
            displayName: "Build and Package"
          - script: mkdir veracode;
            displayName: 'Create veracode upload folder'
          - script: find . -wholename .*/target/*.jar -exec mv {} veracode/ \;
            displayName: 'Move JAR artifacts to veracode upload folder'
          - task: Veracode@3
            inputs:
              ConnectionDetailsSelection: Credentials
              apiId: '$(VERACODE_API_CREDENTIALS_ID)'
              apiKey: '$(VERACODE_API_CREDENTIALS_SECRET)'
              veracodeAppProfile: 'My Profile' # Veracode application profile to scan
              version: '$(build.buildNumber)' # name of the scan to run
              filepath: '$(System.DefaultWorkingDirectory)/veracode' # filepath or folderpath of files to upload to Veracode
              createSandBox: false # true to scan of new development sandbox
              createProfile: false # false to enforce using existing profiles
              failBuildIfUploadAndScanBuildStepFails: true # true to fail build if Upload and Scan task fails to start
              importResults: true # required to view Veracode results in Azure DevOps
              failBuildOnPolicyFail: false # true to fail the build if application fails policy
              maximumWaitTime: '360' # wait time, in minutes, to fail the build if no scan results available
              # According to https://docs.veracode.com/r/r_uploadandscan, optargs supports any uploadandscan parameters
              optargs: '-include myApp.jar' # set CustomerPortal dll as entrypoint and delete a scan with incomplete status
```

# Veracode in Azure Devops pipeline for C# app

````yaml
# This pipeline will run every month on the main branch. This will produce the official Veracode score. This pipeine can be triggered manually any time.
parameters:
- name: runInSandbox
  type: boolean
  default: false

variables:
- group: SOME-LIBARY

trigger: none

schedules:
- cron: '0 0 1 * *' # check: https://learn.microsoft.com/en-us/azure/devops/pipelines/process/scheduled-triggers?view=azure-devops&tabs=yaml#cron-syntax
  displayName: Every first day of a month
  branches:
  include:
    - main

pool:
vmImage: 'windows-latest'

stages:
- stage: Veracode
  displayName: "Run VeraCode static scan"
  jobs:
    - job: Build
      displayName: "Build and start Veracode scan"
      steps:
        - task: NuGetToolInstaller@1

        - task: DotNetCoreCLI@2
          displayName: 'Restore Nuget packages'
          inputs:
          command: restore
          projects:  '**/Application.csproj'
          feedsToUse: select

      # According to https://docs.veracode.com/r/compilation_net#preparing-applications-based-on-net-core-net-5-net-6-and-net-7
        - task: DotNetCoreCLI@2
          displayName: 'Publish solution'
          inputs:
          command: publish
          projects: '**/Application.csproj'
          publishWebProjects: False
          arguments: '-c Debug -o $(Build.ArtifactStagingDirectory)/publish_output -p:UseAppHost=false'
          zipAfterPublish: true

        - task: PublishBuildArtifacts@1
          inputs:
          PathtoPublish: '$(Build.ArtifactStagingDirectory)/publish_output'
          ArtifactName: 'publish_output'
          publishLocation: 'Container'

        - task: CmdLine@2
          displayName: 'tree command in $(Build.ArtifactStagingDirectory)'
          inputs:
          workingDirectory: $(Build.ArtifactStagingDirectory)
          script: 'tree /F'

      # According to https://docs.veracode.com/r/Use_YAML_to_Add_Veracode_Analysis_to_Azure_DevOps_Pipelines
        - task: Veracode@3
          displayName: 'Upload to VeraCode and run static scan'
          inputs:
          ConnectionDetailsSelection: Credentials
          apiId: '$(veracode-api-credentials-id)'
          apiKey: '$(veracode-api-credentials-secret)'
          veracodeAppProfile: 'my-profile' # Veracode application profile to scan
          version: '$(build.buildNumber)-$(Build.BuildId)' # name of the scan to run
          filepath: '$(Build.ArtifactStagingDirectory)/publish_output' # filepath or folder path of files to upload to Veracode
          ${{ if parameters.runInSandbox }}:
          createSandBox: true # true to scan of new development sandbox
          sandboxName: 'Sandbox'
          createProfile: false # false to enforce using existing profiles
          failBuildIfUploadAndScanBuildStepFails: true # true to fail build if Upload and Scan task fails to start
          importResults: true # required to view Veracode results in Azure DevOps
          failBuildOnPolicyFail: true # true to fail the build if application fails policy
          maximumWaitTime: '360' # wait time, in minutes, to fail the build if no scan results available
          # According to https://docs.veracode.com/r/r_uploadandscan, optargs supports any uploadandscan parameters
          optargs: '-include MyApp.dll' # set CustomerPortal dll as entrypoint and delete a scan with incomplete status

````