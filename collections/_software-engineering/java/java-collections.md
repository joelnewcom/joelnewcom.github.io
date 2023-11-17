---
layout: single
---

# Map

## putIfAbsent

Checks if key is absent. If it is, put the value into the map.
The return value is the OLD value in the map, before putting a new value into it. So when the key is absent, the return value will always be null.
``` 
cacheSlot.putIfAbsent(key, party);
```

## computeIfAbsent
This is great if you want to work with the value right away.

