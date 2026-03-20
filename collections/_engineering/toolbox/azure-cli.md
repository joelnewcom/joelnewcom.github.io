---
layout: single
---

## Use az in a company with SSL inspection
If you see this: ![Self signed cert in chain](/assets/images/tools/azure-cli/az-login-self-signed.PNG)

on powershell you can run: ````ls cert:\currentuser\root````

Put all certs into one .pem file and set the environment variable ````REQUESTS_CA_BUNDLE```` to point to it.

````shell
export REQUESTS_CA_BUNDLE="C:\certificates\chain_cert.pem"
````

## azure cli
run ````az login````


## add alias to ~/.bashrc

* ```cd ~```
* ```vim .bashrc```
* press ```"o" to append a newline ```
* write ```export REQUESTS_CA_BUNDLE="C:\certificates\chain_cert.pem"```
* press ```esc``` and write ```:wq``` and press ```enter```
