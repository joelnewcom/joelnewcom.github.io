---
layout: single
---

## Count elements with certain criteria
```
.result 
| map({customerTypeID: .customerTypeID})  
| group_by(.customerTypeID)  
| map({customerTypeID: .[0].customerTypeID, Count: length}) 
| .[]
 
```
## Group by
```
group_by(.customerId) | length
```