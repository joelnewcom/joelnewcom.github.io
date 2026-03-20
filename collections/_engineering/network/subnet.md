---
---

# General

An IP address is composed of two parts: the network prefix in the high-order bits and the remaining bits called the host identifier.

IP v4 gives you 32bit address space.
IP v6 ives you 128bit address space. 

201.1.1.0 -> Having a 255.255.255.0 address-space (class C /24) how many hosts can you have?
-> 256 -2 = 254 (Because .0 and .1 are reserved)

# CIDR (classless Inter-Domain Routing)
Going away from hardcoded A,B,C classes CIDR introduces the /x notation to determine the subnet mask.

192.0.2.0/24 means that the first 24 bits are reserved for networking.

The IPv4 block 198.51.100.0/22 represents the 1024 IPv4 addresses from 198.51.100.0 to 198.51.103.255.