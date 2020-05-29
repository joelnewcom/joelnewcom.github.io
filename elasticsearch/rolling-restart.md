[Home](/)

0. Make a backup of the cluster
1. stop non-essential indexing (if possible)
2. disable shard allocation
3. stop and update one node
4. start the node
5. re-enable shard allocation and wait
6. GOTO step 2 (until all nodes are updated)

## Step 0 Make a backup
Is described [here](../backup-restore.md)  

## Step 1 Disable indexing
Best would be stopping the application which uses this cluster.

## Step 2 Disable shard allocation
```
PUT _cluster/settings
    {
    "transient": {
        "cluster.routing.allocation.enable" : "none"
    }
}
```
```
    POST _flush/synced
```

## Step 3 Stop node
Stop the node. Reconfigure or update the node. 

## Step 4 Start node
Start the node and wait for it to join the cluster again.

```
GET _cat/nodes
```

## Step 5
Reenable shard allocation.

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

## Step 6
Repeat Step 2-5 for each node.