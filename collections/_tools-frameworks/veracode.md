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