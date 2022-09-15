---
layout: single
title:  "Deploy into Web-app with private endpoint enabled"
date:   2022-07-26 10:00:00 +0200
categories: azure
---

# Default way
The normal approach would be to call the azure cli command: ```az webapp deploy --src-url```. Also the standard ADO pipeline task just wraps this call.
This should work on a we-app with private endpoint enabled because ARM calls are still allowed. 

![arm api](/assets/images/azure/arm-api-layers.png)

## deploy with azure storage and sas link
az storage account create -n deploystorageaccount -g ${resource-group} -l westeurope
az storage container create -n deploystoragecontainer --account-name deploystorageaccount
az storage blob upload -f default.zip --account-name deploystorageaccount -c deploystoragecontainer -n deploystorageaccount
az storage blob generate-sas --full-uri --permissions r --account-name deploystorageaccount -c deploystoragecontainer -n deploystorageaccount

az webapp deploy --name ${web-app} --resource-group ${resource-group} --type zip --src-url "${SAS-rul}" --async false

# Call ARM directly instead
But when the wep-app has private endpoints enabled, you will experience that this deployment won't work, and you will get a 403 error-response from your web-app.
There is a problem with "az webapp deploy --src-url": It actually doesn't go via ARM API, but directly to the scm endpoint of the web-app (which is blocked due to private endpoints).
![arm api](/assets/images/azure/arm-api-wrong.png)

There is a bug reported for this: https://github.com/Azure/azure-cli/issues/21168

The solution in the meantime is not to use Azure cli command "az webapp deploy", but to call the ARM API directly. In your case it is something like this:

    az rest --method PUT --uri https://management.azure.com/subscriptions/${SUBSCRIPTIONID}/resourceGroups/${RESOURCEGROUP}/providers/Microsoft.Web/sites/${WEBAPP}/extensions/onedeploy?api-version=2022-03-01 --body '{"properties": {"type": "zip", "packageUri": ${ARTIFACTURL} }}'

![arm api](/assets/images/azure/arm-api-using-restclient.png)
This call will go via ARM proxy and won't be blocked by your private endpoint setup. 
