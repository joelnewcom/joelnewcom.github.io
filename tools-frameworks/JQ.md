[Home](/)

[Back](index.md)

## Count elements with certain criteria
```
[ .result[] | .isParticipatingAsManufacturer = true ] | length
```
## Group by
```
group_by(.customerId) | length
```