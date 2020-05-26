```df -h```
lists all disks any their usages. Give a great overview about your used diskspace

```du ./* -s -h```
Lists the items and their disk-usages within the folder you have opened. 

## Run process in background and forward output to file
nohup ./program > Output.log 2>&1 & 
echo $! > save_pid.txt