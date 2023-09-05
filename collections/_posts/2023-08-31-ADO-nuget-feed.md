---
layout: single
title:  "Use ADO Feed inside docker"
date:   2023-08-31 00:00:00 +0200
categories: DevOps
---

# Normal case
When you use ADO Nuget feed from a pipeline you do something like this:
1. Create feed on ADO or use existing
2. Add the feed into your Nuget.Config file
3. run this on an ADO pipeline
````yaml
 steps:
    - task: NuGetAuthenticate@0
      inputs:
        nuGetServiceConnections: 'MyGet feed'

    - task: NuGetToolInstaller@1

    - task: NuGetCommand@2
      inputs:
        restoreSolution: '$(solution)'
        feedsToUse: 'config'
        nugetConfigPath: 'Deployment/NuGet.config'
        externalFeedCredentials: 'MyGet feed'
````

Either you use a specific ServiceConnection or the "Project Collection Build Service" will have access to the feed 
and the build agent will be able to download the packages.

# Docker case
In case of you run nuget client within a docker, there is no pre-installed credentials provider. This needs to be installed
first. 
[Source](https://github.com/dotnet/dotnet-docker/blob/main/documentation/scenarios/nuget-credentials.md#using-the-azure-artifact-credential-provider)
[Source2](https://github.com/microsoft/artifacts-credprovider#unattended-build-agents)

You can do this by run the .sh or .ps1 [installcredprovider](https://github.com/microsoft/artifacts-credprovider/tree/master/helpers)
Either download the file or do something like: ```RUN curl -L https://raw.githubusercontent.com/Microsoft/artifacts-credprovider/master/helpers/installcredprovider.sh  | sh```

After this you need to set the "VSS_NUGET_EXTERNAL_FEED_ENDPOINTS" environment variable. 
Where the ${FEED_ACCESSTOKEN} is your PAT token with Packaging Read access (depends on what you want to do)

````docker
ARG FEED_ACCESSTOKEN
ENV VSS_NUGET_EXTERNAL_FEED_ENDPOINTS="{\"endpointCredentials\": [{\"endpoint\":\"https://fabrikam.pkgs.visualstudio.com/_packaging/MyGreatFeed/nuget/v3/index.json\", \"username\":\"docker\", \"password\":\"${FEED_ACCESSTOKEN}\"}]}"
RUN dotnet restore
````
In my case the username was an email address.


## Do it locally
To test this locally you might need to set the environmentvariable "NUGET_CREDENTIALPROVIDER_SESSIONTOKENCACHE_ENABLED" to false. 
This forces the credentials provider not to save the secrets to disk. Otherwise you might just use your existing secrets. 
