---
layout: single
---

They have the ending .ps1

# Get-Help
If you want to know something about a command (For example Get-AzureADObjectByObjectId) you need to run: 
```
Get-Help Get-AzureADObjectByObjectId
```

# Run a ps1 file without signing it: 
run ```Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass``` before running the ps1 file. 

Or create a cmd file with: ```powershell -ExecutionPolicy Unrestricted -File ./read.ps1```

# Variables
```
$loc = "East US"
$iterations = 3
```

## set environment variable
$env:VSS_NUGET_EXTERNAL_FEED_ENDPOINTS = '{"some-quoted-string": "value"'

# Arrays
## Create an array
$MyArray = @()

## Adding items (Creates new array)
$MyArray += $entry