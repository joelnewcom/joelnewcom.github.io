---
layout: single
---

# Create Subset of object
[Source](https://gomakethings.com/how-to-create-a-new-object-with-only-a-subject-of-properties-using-vanilla-js/)

Helper method to create a subset of an existing object. 
```
var partyObject = pick(fullObject, ['gender', 'language', 'directCustomer', 'employee','agentCustomer']);

function pick (obj, props) {
    if (!obj || !props) return;
    var picked = {};
    props.forEach(function(prop) {
        picked[prop] = obj[prop];
    });
    return picked;
};
```