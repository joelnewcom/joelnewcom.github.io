---
layout: single
title: "Exception versus ResultWrapper"
date:   2025-07-03 00:00:00 +0200
categories: dev
---

# null versus ResultWrapper
## Example DataAccessObject
Every project will have some kind of data access object.
At some point you need to decide a pattern how you want to return data from your database to the business-logic layer.
A case which will always happen: The db client did not find the object in the store. How to return this?

* Return a dataNotFoundException

I prefer not to communicate via Exceptions. Exceptions should only be used when something unexpected happens.
The code will be bloated with a lot of try catches.

* Return a NoDataFound object which inherits the same interface as the actual entity you looked for.

When returning an interface type, every caller needs to check the real type and cast the object, this will also be cumbersome.
* Return a custom wrapper object which has a method to ask for errors and to retrieve the result.

Many libraries do it like this.
* Return Optional<T> in Java
  Same outcome, as returning null, but saver for NullpointerExceptions.

* Return null
  There will be a lot of null checks.

### Lists
It is a different story, if you return multiple items. Then you can just return an empty list. 

# Error cases
What is an error? 
* Is it an error when you expect getting data for a specific id, but the data is not there?
* Is it an error when an API known to be unavailable sometimes is unavailable?
* Is it an error when a value doesn't match a specific format, but you know its possible to get a value in this format?

## Unexpected errors
According to MS .Net best practices, you need to know how often such an error can happen and if it is a common condition or not.
[Source](https://learn.microsoft.com/en-us/dotnet/standard/exceptions/best-practices-for-exceptions#handle-common-conditions-to-avoid-exceptions)

If it is a common condition, you should not throw an exception, but return a ResultWrapper or similar.
If it is an uncommon condition, you should throw an exception.

## ErrorResults versus Exceptions

[Source](https://learn.microsoft.com/en-us/dotnet/standard/exceptions/best-practices-for-exceptions#design-classes-so-that-exceptions-can-be-avoided)

For value types, consider whether to use Nullable<T> or default as the error indicator for your app. 
By using Nullable<Guid>, default becomes null instead of Guid.Empty. Sometimes, adding Nullable<T> can make it clearer when a value is present or absent. Other times, adding Nullable<T> can create extra cases to check that aren't necessary and only serve to create potential sources of errors.

This is a philosophical discussion, if a null value should indicate an error or not. 
It depends on the caller, does the flow differs when an error happened or is it the same flow as when the value is not found?  

### Examples
#### nullable
```public User? GetUserById(String id)```

#### ResultWrapper
```public ResultWrapper<User> GetUserById(String id)```

#### Nullable hides error

Callee: 
```
public User? GetUserById(String id)
{
    try
    {
        var User = dbClient.getUser(id);
    }
    catch (DataNotFoundException | DbNotAvailableException e)
    {
        logger.warn("User with id {} not found", id);
        return null; // hides the error
    }
    
}
```

Caller: 
```
var User = GetUserById("id");
if (User != null)
{
    // normalflow    
}
else
{
    // Errorcase or just not found
}
```

#### ResultWrapper returns error
Callee:
```
public ResultWrapper<User> GetUserById(String id)
{
    try
    {
        var User = dbClient.getUser(id);
    }
    catch (DataNotFoundException | DbNotAvailableException e)
    {
        return ResultWrapper.Fail("User with id {} not found", id);
    }
}
```

Caller:
```
var User = GetUserById(id);
if (User.IsSuccess)
{
    if (User.Value != null)
    {
        // normalflow
    }
    else
    {
        // User not found, but no error
    }    
}
else
{
    // Errorcase
    logger.warn("User with id {} not found", id);
}
```





