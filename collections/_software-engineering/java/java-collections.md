---
layout: single
---

# List
## Create and init List 
```List<String> ids = List.of("Id1","Id2");```

# Map

## Create and init Map
```Map.of("Id", content);```

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

These lines lead to the same result:
```
Map<String, List<Party>> partiesByEmail;

// via computeIfAbsent 
List<Party> partiesWithSameEmail = partiesByEmail.computeIfAbsent(email, k -> new ArrayList<>());
partiesWithSameEmail.add(party);

// via getOrDefault, you still need to put the value into the map
List<Party> partiesWithSameEmail = partiesByEmail.getOrDefault(email, new ArrayList<>());
partiesWithSameEmail.add(party);
partiesByEmail.put(email, partiesWithSameEmail);
```


## merge
merge(){
    computeIfAbsent(...)
    computeIfPresent(...)
}


## flatMap
```
Map<String, List<Party>> partiesByEmail = new HashMap<>();
partiesByEmail.values().stream()
    .filter(partiesWithSameEmail -> partiesWithSameEmail.size() > 1)
    .flatMap(Collection::stream)
    .forEach(item -> item.do());
```

```
Before flattening 	: [[1, 2, 3], [4, 5], [6, 7, 8]]

After flattening 	: [1, 2, 3, 4, 5, 6, 7, 8]
```