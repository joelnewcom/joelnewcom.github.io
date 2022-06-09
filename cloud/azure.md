[Home](/)

[Back](index.md)

## connectivity troubleshooting
There are two major causes if you cannot reach a host:
* If you have a firewall in the way, you hit the TCP timeout. The TCP timeout is 21 seconds in this case. Use the ```tcpping``` tool to test connectivity.
* DNS isn't accessible. The DNS timeout is 3 seconds per DNS server. If you have two DNS servers, the timeout is 6 seconds. Use ```nameresolver``` to see if DNS is working. 
You can't use nslookup, because that doesn't use the DNS your virtual network is configured with. If inaccessible, you could have a firewall or NSG blocking access to DNS or it could be down.

## Blob Storage

is ideal for
Serving images or documents directly to a browser.
Storing files for distributed access.
Streaming video and audio.
Storing data for backup and restore, disaster recovery, and archiving.
Storing data for analysis by an on-premises or Azure-hosted service.
Storing up to 8 TB of data for virtual machines.

