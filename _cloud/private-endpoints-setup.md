---
---

## Used quickstart: 
https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.web/private-webapp-with-app-gateway-and-apim


## Commands to create deploy storage
az storage account create -n deploystorageaccount -g ch-daw-sbx-pocjoel-rg -l westeurope
az storage container create -n deploystoragecontainer --account-name deploystorageaccount
az storage blob upload -f default.zip --account-name deploystorageaccount -c deploystoragecontainer -n deploystorageaccount
az storage blob generate-sas --full-uri --permissions r --account-name deploystorageaccount -c deploystoragecontainer -n deploystorageaccount

-> https://deploystorageaccount.blob.core.windows.net/deploystoragecontainer/deploystorageaccount?sp=r&sv=2021-06-08&sr=b&sig=UdUloOnlairT7RXNT4v5V1TzDYyu3AxfIf4ER4QpSCo%3D

### AZ command to deploy an app:
az webapp deploy --name web-u4ojl5tpyinng --resource-group ch-daw-sbx-pocjoel-rg --type zip --src-url "https://deploystorageaccount.blob.core.windows.net/deploystoragecontainer/deploystorageaccount?sp=r&st=2022-07-13T13:19:55Z&se=2022-07-13T21:19:55Z&spr=https&sv=2021-06-08&sr=b&sig=J5ZnJNdiS6u8bSOXG28fiOuIRSi6eBl0vLO7uoen3Z4%3D" --async false



## Deploy app to appservice with private endpoints 
https://azure.github.io/AppService/2021/03/01/deploying-to-network-secured-sites-2.html
https://azure.github.io/AppService/2021/04/22/Site-with-secure-backend-communication.html

# WIP

This worked with private endpoints disabled:
https://web-u4ojl5tpyinng-staging.azurewebsites.net/weatherforecast


