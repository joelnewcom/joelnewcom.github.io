---
date: 2022-07-22
tags:
  - Azure
categories:
  - azure
header:
  teaser: "/assets/images/cloud-teaser.JPG"
---

### Connectivity
Azure resources communicate over one of these channels: VNets, VNet service endpoints and VNet peering.

### vNet
You can create a vNet to segment your application landscape. Within a vNet each component can see each other, but they don't have connectivity to the outside of the vNet.

### Subnet 
Within a vNet you can create subnets. A subnet can have zero or one NSG. 

### NSG
Network security group: Can be assigned to a subnet or a NIC (network interface controller) 