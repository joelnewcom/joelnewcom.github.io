---
layout: single
---

# variables
```
STR="Hello World!"
echo $STR
echo ${STR}
```

# check if a tool is installed
```shell
# Check if jq is installed
if command -v jq &> /dev/null; then
    echo "jq is installed"
    # Extract the value of "medianResTime" from "Get Policies"
    else
    echo "An error occurred. Exiting..."
    exit 1
fi
```