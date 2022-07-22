---
layout: single
title:  "Managing a soft-deleted apim resource"
date:   2022-07-22 18:20:53 +0200
categories: azure
---

When a keyvault is deleted via azure portal it is actually only soft-deleted. The reason for this is to protect the user from deleting their secrets.
After a keyvault is deleted you can either restore it or hard-delete it.

Further infos: https://docs.microsoft.com/en-us/azure/key-vault/general/key-vault-recovery?tabs=azure-portal

# List the soft-deleted keyvaults
```
az keyvault list-deleted --subscription {SUBSCRIPTION ID} --resource-type vault
```

# Recover a soft-deleted key-vault
```
az keyvault recover --subscription {SUBSCRIPTION ID} -n {VAULT NAME}
```

# Purge a soft-deleted key-vault
```
az keyvault purge --subscription {SUBSCRIPTION ID} -n {VAULT NAME}
```

