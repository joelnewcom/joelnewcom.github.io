---
layout: single
---

The steps are similar to [rolling-restart](../rolling-restart.md)

0. Make a backup of the cluster
1. Stop indexing
2. Disable shard allocation (In this case persistent)
3. Perform synced flush
4. Shutdown all nodes
5. Start all dedicated master nodes
6. Start the other nodes
7. Wait for yellow
8. Reenable shard-allocation

## Step 0 Make a backup
Is described [here](../backup-restore.md)  

## Step 1 Disable indexing
Best would be stopping the application which uses this cluster.

## Step 2 Disable shard allocation
```
PUT _cluster/settings
    {
    "persistent": {
        "cluster.routing.allocation.enable" : "none"
    }
}
```
## Step 3 Snyced flush
```
    POST _flush/synced
```

## Step 4 Stop all nodes
Stop the node. Reconfigure or update the node. 
This starts obviously the downtime of the cluster.

## Step 5 Start the dedicated master nodes
Start the node and wait for it to join the cluster again.
```
GET _cat/nodes
```

## Step 6 Start the other nodes
Reenable shard allocation.

## Step 7 Wait for yellow
``` 
GET _cat/health
``` 

## Step 8 Reenable shard-allocation
```
PUT _cluster/settings
{
    "transient": {
        "cluster.routing.allocation.enable" : "all"
    }
}
``` 
Wait until the cluster is green again: 
``` 
GET _cat/health
``` 