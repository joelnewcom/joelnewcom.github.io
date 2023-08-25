---
layout: single
---

# Terraform

Terraform has 4 main commands;

* ```terraform init```
this will initialize terraform, retrieve the state file, download the providers, etc.
* ```terraform plan```
this will compare your state with the infrastructure and show you which changes will be done IF the plan is applied
* ```terraform apply```
this will apply the changes to your infrastructure
* ```terraform destroy```
this will destroy your infrastructure completely

# local setup
## Using tf with your personal 
just run ```az login``` before you do terraform stuff. Also check [here](/tools-frameworks/azure-cli)

## Using tf with a service principal
Access / Role assignments
A service principal needs to be generated using AZ CLI. [Azure provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli). Example:

az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/{subscription-id}" -n "Terraform-Service-Principal" --years 2
(Make sure that you have the necessary rights to do this)

The output of this command looks like this:

{
"appId": "{appId}",
"displayName": "Terraform-Service-Principal",
"password": "***",
"tenant": "{tenantId}"
}
These values need to be stored safely.
Once the service principal has been created, there are some extra role assignments needed
Storage blob data contributor
Storage blob data owner (modify/create stuff)

Locally the credentials can be stores in ~/.bashrc;

````shell

export ARM_CLIENT_ID="{appId}"
export ARM_CLIENT_SECRET="***"
export ARM_TENANT_ID="tenantId"
export ARM_SUBSCRIPTION_ID="{subscriptionId}"
````

## add tf alias to ~/.bashrc

* ```cd ~```
* ```vim .bashrc```
* press ```"o" to append a newline ```
* write ```alias tf="terraform.exe"```
* press ```esc``` and write ```:wq``` and press ```enter```


# run terraform

````cd```` into your folder with terraform script eg.: /environments/dev
Normally a terraform folder is structured like:

* terraform
  * module
  * environments
    * dev
      * module.tf
      * output.tf
      * provider.tf
    * sit
    * prod

run ```tf init ```



