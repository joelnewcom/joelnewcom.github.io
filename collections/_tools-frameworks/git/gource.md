---
layout: single
---

[gource](https://gource.io/) is a nice tool to visualize git history. 

# Move faster

Normally a project is taking years and you don't want to watch too long. 


```
gource --seconds-per-day 1 --auto-skip-seconds 1 --file-idle-time 0 --max-file-lag 0.1 --key --title "ZOA Application"
```

```
--seconds-per-day 1 (How long to spend on one day. Default is 10 seconds)
--auto-skip-seconds 1 (How long to wait until jump to next log enty. Default is 3 seconds) 
--file-idle-time 0 (How long to keep files not touched. Default is 60 seconds)
--max-file-lag 0.1 (How long the animation takes until a file is present. Default is 5 seconds) 
--key (Make a list of colors and file endings)
--title "ZOA Application" (Title at the left bottom of the screen)
```
