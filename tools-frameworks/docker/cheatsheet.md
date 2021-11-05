[Home](/)

[Back](../index.md)

## Advantages
The big advantage of containers is the non existing virtualisation layer. The running application within a docker container actually runs directly on the physical machine as process.
If you don't need to configure the hardware, you better use container instead of VW. 

## docker usages
```Usage:  docker run [OPTIONS] IMAGE [COMMAND] [ARG...]```
```Usage:  docker exec [OPTIONS] CONTAINER COMMAND [ARG...]```

## Run an interactive container

##### Simple
```docker run --rm -it <image> bash```

```-i``` for interactive 
```-t``` for allocate a pseudo terminal
```--rm``` to remove container when exited 
```bash``` as command for new process in container 

##### Run a privileged container with mounted volume
```docker run -it -v /var/opt/directory:/mounted --privileged --rm rhel7 bash```

##### Override defined entrypoint
This can be used to explore an exited container.
```docker run -it --entrypoint /bin/bash <image>```

## Exec into a running container
```docker exec -it <container> bash```

```-i``` for interactive 
```-t``` for allocate a pseudo terminal 
```bash``` as command for new process in container  


## Show docker stats
```docker stats --format "table {{.Container}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"```

```docker stats --format "table {{.Container}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}"```

```docker ps --format "table {{.Status}}\t{{.Names}}\t{{.Image}}\t{{.ID}}"```
