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
```docker run -it --entrypoint /bin/bash <image>```

## Exec into a running container
```docker exec -it <container> bash```

```-i``` for interactive 
```-t``` for allocate a pseudo terminal 
```bash``` as command for new process in container  

