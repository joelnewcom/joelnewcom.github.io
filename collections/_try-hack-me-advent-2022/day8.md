---
layout: single
title: "[Day 8] Smart Contracts Last Christmas I gave you my ETH"
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

## Blockchain
Simple explanation of a blockchain:  database to store information in a specified format and is shared among members of a network with no one entity in control.

# Smart Contracts
Are a lot of the time the backbone of DeFi (Decentralized Financial apps) to support cryptocurrency on a blockchain. 
A smart contract is a program stored on a blockchain that runs when pre-determined conditions are met.

## The Re-entrancy Attack
When smartcontracts are not perfectly written and exceptions are not properly handled or allowing fallback functions while executing the main withdrawal function. 

We load the two provided smartcontracts into Remix IDE.

One contract acts as normal wallet. You can call deposit, withdraw, get balance. 
The other contract implements a re-entrancy attack on a given wallet address. 

[exploitable contract](/assets/images/tryhackme/day8/EtherStore.sol)
[exploit](/assets/images/tryhackme/day8/Attack.sol)