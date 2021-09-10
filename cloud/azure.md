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

## Azure data logs Kusto syntax
I once had the problem that the request logs couldn't be retrieved because the url value contained characters which lead to malformed json (request where from vulnerability scan).
So I created a query which displays all columns expect the url one. Fortunately the url also appears in the name and operation_name column anyway.
```
let start=datetime("2021-09-09T05:11:00.000Z");
let end=datetime("2021-09-09T06:37:00.000Z");
requests
    | where timestamp > start and timestamp < end
    | where client_Type != "Browser"
    | project timestamp, id, source, name, success, resultCode, duration, performanceBucket, itemType, customDimensions, customMeasurements, operation_Name, operation_Id, operation_ParentId, operation_SyntheticSource, session_Id, user_Id,user_AuthenticatedId, user_AccountId, application_Version, client_Type, client_Model, client_OS, client_IP, client_City, client_StateOrProvince, client_CountryOrRegion, client_Browser, cloud_RoleName, cloud_RoleInstance, appId, appName, iKey,sdkVersion, itemId, itemCount
```