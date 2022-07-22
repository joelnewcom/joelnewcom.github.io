---
layout: single
title:  "Managing a softdeleted keyvault"
date:   2022-07-22 20:41:53 +0200
categories: azure
---

Further infos: https://docs.microsoft.com/en-us/azure/api-management/soft-delete

# List all soft-deleted instances for a given subscription
```
az rest --method GET --uri "https://management.azure.com/subscriptions/{subscriptionId}/providers/Microsoft.ApiManagement/deletedservices?api-version=2021-08-01"
```

# Recover
```
az rest --method PUT --uri https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.ApiManagement/service/{apimServiceName}?api-version=2021-08-01 --body '{"properties": {"restore": true}, "location":"West Europe"}'
```

# Purge
```
az rest --method DELETE --uri "https://management.azure.com/subscriptions/{subscriptionId}/providers/Microsoft.ApiManagement/locations/{location}/deletedservices/{serviceName}?api-version=2021-08-01"
```

