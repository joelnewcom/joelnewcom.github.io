---
layout: single
---

[VeraCode documentation about pipeline scan](https://docs.veracode.com/r/c_about_pipeline_scan)

# Doing it locally in powershell:

## Package the .net app
[VeraCode documentation to pack .Net app](https://docs.veracode.com/r/compilation_net)

Run: ```dotnet publish .\Allora.API\Allora.API.csproj -o myPublishedApp -c Debug```

## Reduce it to the min
```
$dest = "C:\Git\Allora.Azure\myPublishedApp-reduced"
$source = "C:\Git\Allora.Azure\myPublishedApp"
Copy-Item -Path $source -Filter "Allora*" -Destination $dest –Recurse
```

## zip it
```
Compress-Archive -Path C:\Git\Allora.Azure\myPublishedApp-reduced -DestinationPath C:\Git\Allora.Azure\myPublishedApp-reduced
```

## Download VeraCode pipeline scan client
```
$extractFolder = "C:\MyApps/veracode-pipeline-scan/latest"
        if(!(Test-Path -Path $extractFolder/pipeline-scan.jar -PathType Leaf)){
            Invoke-WebRequest https://downloads.veracode.com/securityscan/pipeline-scan-LATEST.zip -OutFile pipeline-scan.zip  
            Expand-Archive pipeline-scan.zip -DestinationPath $extractFolder
        }
```

## Run the pipeline scan

```
java -jar C:\MyApps\veracode-pipeline-scan\latest\pipeline-scan.jar `
-vid "{veraCode ID}" `
-vkey "{veracode token}" `
-f "C:\Git\Allora.Azure/myPublishedApp-reduced.zip" `
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


# Veracode ADO

```
variables:
- group: CND-ADIS-GENESYS-CONTACTS-SERVICE-DEV
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
              artifactsFeeds: 'galapagos'
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
              # Once access to the adis genesys veracode profile is given to veracode-middleware, we should use following two lines:
              # ConnectionDetailsSelection: 'Endpoint' # access Veracode with service connection or Veracode API credentials
              # AnalysisService: 'veracode-middleware' # service connection name for accessing Veracode
              veracodeAppProfile: 'EMEA_SwitzerlandGI_Addressbook Sync ADIS - Genesys' # Veracode application profile to scan
              version: '$(build.buildNumber)' # name of the scan to run
              filepath: '$(System.DefaultWorkingDirectory)/veracode' # filepath or folderpath of files to upload to Veracode
              createSandBox: false # true to scan of new development sandbox
              createProfile: false # false to enforce using existing profiles
              failBuildIfUploadAndScanBuildStepFails: true # true to fail build if Upload and Scan task fails to start
              importResults: true # required to view Veracode results in Azure DevOps
              failBuildOnPolicyFail: false # true to fail the build if application fails policy
              maximumWaitTime: '360' # wait time, in minutes, to fail the build if no scan results available

```