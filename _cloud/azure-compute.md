# Costs

There are compute and storage costs. 

## Compute
Compute costs are billed on minute basis and depends on the size and also the OS you select (Linux has no os license)
If the vm is deallocated, there are no compute costs charged.

There are two options to choose:

Consumption based:
Pay for compute capacity be seconds. This is good for short-term or unpredictable workloads.

Reserved VM instances:
You purchase a VM for one or 3 years. As its an upfront commitememnt its about 72% cheaper than pay-as-you-go.
You can pay early termination fee if you don't need it anymore. 

This option is good if you need a VM running all the time.

## Storage
The status of the VM has no relationship to storage costs.

## Connect to VMs
Normally you setup an azure bastion service in the same vnet as your vms. 
Azure bastion allows SSH and RDP connection without having your VMs exposed to the internet its also available via Azure portal.

