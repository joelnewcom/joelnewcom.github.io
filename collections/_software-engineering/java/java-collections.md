---
layout: single
---

# Map

## compute
If the function returns null, the mapping is removed (or remains absent if initially absent).
There are also variants of compute() method like computeIfPresent() and computeIfAbsent(), which computes the new value only if an existing value is present or absent.

````java
cache.forEach(party -> party.getAgreements().forEach(agreement -> countMap.compute(agreement.getSystemOfRecord(), (key, value) -> value == null ? 1 : value + 1)));
````

## putIfAbsent

Checks if key is absent. If it is, put the value into the map.
The return value is the OLD value in the map, before putting a new value into it. So when the key is absent, the return value will always be null.
``` 
cacheSlot.putIfAbsent(key, party);
```

Example with map inception: 

````java
// Map<SystemOfRecord, Map<String, Party>> outerMap = new ConcurrentHashMap<>();
Map<String, Party> innerMap = outerMap.get(agreement.getSystemOfRecord());
if (innerMap == null){
    ConcurrentHashMap<String, Party> innerMap = new ConcurrentHashMap<>();
    innerMap.put(agreement.getSystemOfRecordId(), party);
    outerMap.put(agreement.getSystemOfRecord(), innerMap);
}else{
    innerMap.put(agreement.getSystemOfRecordId(), party);
    outerMap.put(agreement.getSystemOfRecord(), innerMap);
}
````

This can be simplified with:

````java
// Map<SystemOfRecord, Map<String, Party>> outerMap = new ConcurrentHashMap<>();
Map<String, Party> innerMap = outerMap.computeIfAbsent(agreement.getSystemOfRecord(), k-> new ConcurrentHashMap<>());
innerMap.put(agreement.getSystemOfRecordId(), party);
````

## computeIfAbsent
This is great if you want to work with the value right away.

## merge
merge(){
    computeIfAbsent(...)
    computeIfPresent(...)
}

