---
layout: single
---

# Create PR comments with Powershell

Make a conditional task within a pipeline 
```
- task: PowerShell@2
  condition: eq(variables['Build.Reason'], 'PullRequest')
  displayName: Post Message to PR
  env:
    SYSTEM_ACCESSTOKEN: $(System.AccessToken)  
  inputs:
      targetType: filePath
      filePath: PostToPR.ps1
```

# Trigger Pipeline run on Pull request

## Option 1 - Via Build Validation policy
![azure-devops-build-validation](/assets/images/cicd/azure-devops-build-validation.png)

## Option 2 - Via yml pipeline file

```
# trigger this pipeline if there's a PR to any of these branches
pr:
- master
- main
- staging
- releases/*
```

# Using PAT basic authorization
Generate a new personal access token on Azure Devops. 
You can use the token in the Basic Authorization header. Just keep the username empty and the PAT token is the password.
```--header 'Authorization: Basic {toBase64(:$PAT-token)}'```

[Infos here](https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?toc=%2Fazure%2Fdevops%2Forganizations%2Ftoc.json&view=azure-devops&tabs=Windows)

# Create PR comments

Make this REST call according to the [MS docu](https://learn.microsoft.com/en-us/rest/api/azure/devops/git/pull-request-threads/create?view=azure-devops-rest-7.0&tabs=HTTP), but omit the ```pullRequestThreadContext``` attribute, as ADO would then ignore the filePath attribute.  

```
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
```

[Checkout the sample pipeline](/assets/cicd/Create-veracode-pr-comment/get_veracode_feedback.yml)

[And its powershell script](/assets/cicd/Create-veracode-pr-comment/create-veracode-pr-comments.ps1)