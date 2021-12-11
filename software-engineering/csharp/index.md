[Home](/)

[Back](../index.md)

# async and await
In C# you can make usage of the keywords async and await like this:
```
public sealed class SystemUnderTest
{
  public static async Task SimpleAsync()
  {
    await Task.Delay(10);
    // throw new Exception("Should fail.");
  }
}
```

This method might become asynchronous when reaching the await operator. This method might run on another thread then the main thread and main thread can go on with its work. 
Once the Task is done, C# will make sure the code proceeds as you would expect. 

Its best practice that an async method always returns a Task. If it doesn't it will be hard to test the method. 

# Dependency injection

## Scope
scoped = Will be newly instantiated for every request context
singleton = Will be created only once

Only a smaller scope can reference a larger scoped object. A singleton cannot hold reference to a scoped instance.  

### Use scoped instance from singleton
Use IServiceScopeFactory to instantiate a new scoped object in a singleton scoped class. 

# Settings
Order of settings (A higher number overrides the lower)

1. appsettings.json
2. appsettings.<Environment>.json
3. user secrets
4. environment variable 

Changes made to the appsettings.json and appsettings.Environment.json file after the app starts are read by the JSON configuration provider.

# NuGet packages
## Licensing
A NuGet package available on nuget.org can have any license.
There is no restriction on whether the NuGet package is free, open source or commercially licensed.
You should review the license that each NuGet package has. 
Typically a NuGet package that does not have an open source license will require you to accept the license agreement before installing it but you should still review the license even if you are not prompted to accept one.