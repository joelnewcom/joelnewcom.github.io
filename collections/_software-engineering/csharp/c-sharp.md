---
layout: single
---

# DotNet SDK
The even version-numbers are the LTS(long term support) versions. For big projects its good to stick to the latest 
even .Net version. Only opt for a preview or STS (Standard term version) if you depend on a new feature of this sdk. 

[SDK version policy](https://dotnet.microsoft.com/en-us/platform/support/policy)

## Download the right dotnet version
[Download dotnet](https://dotnet.microsoft.com/en-us/download/visual-studio-sdks)

# Building steps

## dotnet restore

Uses NuGet to restore dependencies and project specific tools.
```dotnet restore``` is run automatically in other dotnet commands
like, ```new, build, build-server, run, test, publish and pack```

## dotnet publish

Will create an artifact which can be deployed (Depending on the parameters and configuration)

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

This method might become asynchronous when reaching the await operator. This method might run on another thread then the
main thread and main thread can go on with its work.
Once the Task is done, C# will make sure the code proceeds as you would expect.

Its best practice that an async method always returns a Task. If it doesn't it will be hard to test the method.

# Fields and Property

Field is a private instance variable which is set via constructor.
Property is a public instance variable which is normally defined like this:

```
struct Person
{
    public String Name {get; set; }
}
```

This can be used like this:

```
var p = new Person() { Name = "jonson"};
```

# Naming conventions

Use PascalCase for public properties

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

Changes made to the appsettings.json and appsettings.Environment.json file after the app starts are read by the JSON
configuration provider.

## Launch setting

To set environment variable, you can edit the ```launchSettings.json```
Normally this file is placed under ```src/application/Properties/launchSettings.json```

## user secrets

```Cd``` into where your appsettings.json file is. Its normally under ```src/application//appsettings.json```
To add the setting "ServicePrincipal:ClientSecret":
run ```dotnet user-secrets set ServicePrincipal:ClientSecret {secret value}```

Though this is only for development. If you want to run sit, uat or prod application setup locally you would need
to pass this secrets via environment variable in launchSettings.json.

# Start from scratch

```dotnet new console```  will create a new console project.

## New Unit test project

```dotnet new mstest -o MyClassTest```

# int/float division

integer / integer returns an integer even when the result has decimals. To get a float as result, at least one of the
numbers needs to be a float: integer / (float)integer

# Common exceptions

| Exception Class | Cause of Exception                                                   |
|------------------------------ |----------------------------------------------------------------------|
| SystemException               | A failed run time check; used as a base class for other exceptions . |
| AccessException               | Failure to access a type member , such as a method or field.         |
| ArgumentException             | An argument to a method was invalid.                                 |
| ArgumentNullException         | A null argument was passed to a method that does not accept it.      |
| ArgumentOutOfRangeException   | Argument value is out of range.                                      |
| ArithmeticException           | Arithmetic over or underflow has occurred.                           |
| ArrayTypeMismatchException    | Attempt to store the wrong type of object in an array.               |
| BadImageFormatException       | Image is in wrong format                                             |
| CoreException                 | Base class for exceptions thrown by the runtime.                     |
| DevideByZeroException         | An attempt was made to divide by Zero.                               |
| FormatException               | The format of an argument is wrong.                                  |
| IndexOutofRangeException      | An Array index is out of range                                       |
| InvalidCastException          | An attempt was made to cast to an invalid class.                     |
| InvalidOperationException     | A method was called at an invalid time                               |
| MissingmemberException        | An invalid version of a DLL was accessed                             |
| NotFiniteException            | A number is not valid                                                |
| NotSupportedException         | Indicates that a method is not implemented by a class                |
| NullReferenceException        | Attempt to use an unassigned reference                               |
| OutofmemoryException          | Not enough memory to continue execution                              |
| StackOverFlowException        | A Stack has overflowed                                               |

# json deserialization
Default in standard deserializer of [System.Text.Json](https://learn.microsoft.com/en-us/dotnet/standard/serialization/system-text-json/deserialization?pivots=dotnet-7-0#deserialization-behavior)
* Case sensitive
* Enums must be their int values 

The more intuitive defaults are set in the [web defaults option](https://learn.microsoft.com/en-us/dotnet/standard/serialization/system-text-json/configure-options?pivots=dotnet-7-0#web-defaults-for-jsonserializeroptions): 
* Case in-sensitive
* Enums can also be their string representations. 