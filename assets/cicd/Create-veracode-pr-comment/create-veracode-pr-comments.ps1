# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 
# This script parses the filtered_results.json from VeraCode-Pipeline-Scan and check if findings matches the files changed in the PullRequest. If so, it makes a new PR comment.
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 

param(
    [ValidateNotNullOrEmpty()][string]$orgUrl,             # e.g. "https://dev.azure.com/{org}/{project}"
    [ValidateNotNullOrEmpty()][string]$repo,               # e.g. "{repo-name}"
    [ValidateNotNullOrEmpty()][string]$prId,               # e.g. "92040"
    [ValidateNotNullOrEmpty()][string]$pathToResultJson,   # e.g. "C:\_work\DevOps local\results.json"
    [ValidateNotNullOrEmpty()][string]$accessToken
)

function Get-PR-Comment ($finding, $fileName)
{
    Write-Host "DEBUG: Get-PR-Comment file: $($fileName) , line: $($finding.files.source_file.line) , severity $($finding.severity) issue_type $($finding.issue_type) flaw_details_link $($finding.flaw_details_link)" -ForegroundColor Green
    $content = "# :warning: VeraCode finding \n- $($finding.issue_type)) (Severity: $($finding.severity)) \n- Found in File **$($fileName)** in Line **$($finding.files.source_file.line)**\n[How-To Fix]($($finding.flaw_details_link))"
    Write-Host "DEBUG: Get-PR-Comment $($Content)" -ForegroundColor Green
    return $content
}

function Check-For-Existing-Comment($orgUrl, $repo, $header, $prId, $content)
{

    $url= "$($orgUrl)/_apis/git/repositories/$($repo)/pullRequests/$($prId)/threads?api-version=7.1-preview"
    Write-Host DEBUG: Check-For-Existing-Comment: URL: $url -ForegroundColor Green
    $threads = Invoke-RestMethod -Uri $url -Method Get -Header $header
    $contents = $threads.value | Where-Object -Property status -eq "active"  | Select-Object -ExpandProperty comments | Where-Object -Property content -eq $content | Select-Object -ExpandProperty content

    if ($contents)
    {
        return $true
    }

    return $false
}

function Get-Body-For-Comment-For-File($fileName, $line, $content) 
{
    $body = @"
    {
      "comments": [
        {
          "parentCommentId": 0,
          "content": "$content",
          "commentType": 1
        }
      ],
      "status": 1,
      "threadContext": {
        "filePath": "$($fileName)",
        "leftFileEnd": null,
        "leftFileStart": null,
        "rightFileEnd": {
          "line": $($line),
          "offset": 100
        },
        "rightFileStart": {
          "line": $($line),
          "offset": 1
        }
      }      
    }
"@

    Write-Host DEBUG: Get-PR-Comment body: $body -ForegroundColor Green
    return $body
}

# https://learn.microsoft.com/en-us/rest/api/azure/devops/git/pull-request-threads?view=azure-devops-rest-7.0
function Create-Comment ($orgUrl, $repo, $header, $prId, $fileName, $finding)
{

    $content = Get-PR-Comment $finding $fileName

    # check for existing comment
    $foundExistingComment = Check-For-Existing-Comment $orgUrl $repo $header $prId $content
    if ($foundExistingComment)
    {
        Write-Host "DEBUG: Create-Comment Nothing to do - comment already exists: $content" -ForegroundColor Green
    }
    else
    {
        $body = Get-Body-For-Comment-For-File $fileName $finding.files.source_file.line $content
        $url = "$orgUrl/_apis/git/repositories/$repo/pullRequests/$prId/threads?api-version=7.1-preview.1"
        $result = Invoke-RestMethod -Uri $url -Method POST -Headers $header -Body $body -ContentType "application/json"
        Write-Host "DEBUG: Create-Comment Result API-Call: $result" -ForegroundColor Green
    }
}

function Get-Files-From-Commit($orgUrl, $repo, $header, $prId)
{
    
    $commits = Get-Commits $orgUrl $repo $header $prId

    $allFilesInCommit = @()

    foreach ($commit in $commits.value) {

        $url= "$($orgUrl)/_apis/git/repositories/$($repo)/commits/$($commit.commitId)/changes?api-version=7.1-preview"
        Write-Host DEBUG: Get-Files-From-Commit: URL: $url -ForegroundColor Green
        $changes = Invoke-RestMethod -Uri $url -Method Get -Header $header
        $paths = $changes.changes | Select-Object -ExpandProperty item | Where-Object -Property isFolder -NE -Value $true | Select-Object -ExpandProperty path
        foreach ($path in $paths)
        {
            Write-Host DEBUG: Get-Files-From-Commit: found commit-path: $path -ForegroundColor Green
            if (!($allFilesInCommit.Contains($path)))
            {
                # Adding with case sensitive, as it matters latter for filePath attribute on PR comment thread request
                $allFilesInCommit += $path 
                Write-Host DEBUG: Get-Files-From-Commit: added commit-path: $path -ForegroundColor Green
            }
        }
    }

    return $allFilesInCommit
}

function Get-Header($accessToken)
{
    Write-Host "DEBUG: Get-Header: Initialize authentication context" -ForegroundColor Yellow
    $token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($accessToken)"))
    $header = @{authorization = "Basic $token" }

    return $header 
}

function Get-Commits($orgUrl, $repo, $header, $prId) 
{
    $getRepoUrl = "$orgUrl/_apis/git/repositories?api-version=6.0"

    $url = "$orgUrl/_apis/git/repositories/$repo/pullRequests/$prId/commits?api-version=7.1-preview.1"
    Write-Host DEBUG: Get-Commits: URL: $url -ForegroundColor Green

    $commits = Invoke-RestMethod -Uri $url -Method Get -Header $header

    return $commits
}



# Check if the filepath with veracode finding contains one of the changed files within the PR
# Filename in veracode findings looks like this: a/1/s/allora.httprestrequestshandler/httphandler.cs
# Filename in commits looks like this: allora.httprestrequestshandler/httphandler.cs
function Get-File-Name-If-Commited
{
    param ( 
        [Parameter(Mandatory=$True)]
        [string]$fileNameInVeraCodeFinding,
 
        [Parameter(Mandatory=$True)]
        [array]$allFilesInCommit
    )
 
    foreach($fileNameInCommit in $allFilesInCommit) {
        if($fileNameInVeraCodeFinding -like "*$($fileNameInCommit.ToLower())") {
            return $fileNameInCommit;
        }
    }
 
    return "";
}

## -------------------  main ------------------------------------------------------------------

Write-Host "DEBUG: Entered create-pullrequest-comments: orgUrl: $($orgUrl) repo: $($repo) prId: $($prId)" -ForegroundColor Green

$header = Get-Header $accessToken

$allFilesInCommit = Get-Files-From-Commit $orgUrl $repo $header $prId

if (!$allFilesInCommit){
    Write-Host "DEBUG: not files in commit found therefore exiting" -ForegroundColor Red
    return
}

$vercodeResultJson = Get-Content -Raw $pathToResultJson | ConvertFrom-Json

Write-Host "DEBUG: scan_status: $($vercodeResultJson.scan_status) findingsCount: $($vercodeResultJson.findings.Count)" -ForegroundColor Green

foreach ($finding in $vercodeResultJson.findings )
{
    Write-Host "DEBUG: found findings in File: $($finding.files.source_file.file) " -ForegroundColor Green

    $fileName = $finding.files.source_file.file.ToLower()
    $fileNameCommitted = Get-File-Name-If-Commited $fileName $allFilesInCommit

    if ($fileNameCommitted)
    {
        Write-Host "DEBUG: Add PR-Comment for findings in File: $($fileNameCommitted) " -ForegroundColor Green
        Create-Comment $orgUrl $repo $header $prId $fileNameCommitted $finding
    }
    else
    {
        Write-Host "DEBUG: nothing to do, File is not part of the PR: $($fileName) " -ForegroundColor Green
    }
}