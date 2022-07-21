---
---

# login
```az login``` will open a browser to login

# accounts
```az accounts``` will list all subscriptions

# change subscription

Check what default subscription is on
```az account show --output table```

List all subscriptions
```az account list --output table```

Command to switch to one
```az account set --subscription "ch-app_8652_daw_my_customer-uatprod"```

# Manage resource-groups
```az group list --output table```

# Manage firewall rules on sql server
```az sql server firewall-rule list --resource-group rg_application_PROD --server sql-mycustomer-PROD```

```az sql server firewall-rule update --resource-group rg_application_PROD --server sql-mycustomer-PROD --name Joel_From_SkeyKey --start-ip-address 195.28.240.35 --end-ip-address 195.28.240.36```