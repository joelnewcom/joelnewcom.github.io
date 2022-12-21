---
layout: single
---

# Building steps
## dotnet restore
Uses NuGet to restore dependencies and project specific tools.
```dotnet restore``` is run automatically in other dotnet commands like, ```new, build, build-server, run, test, publish and pack```

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

# NuGet packages

## Licensing

A NuGet package available on nuget.org can have any license.
There is no restriction on whether the NuGet package is free, open source or commercially licensed.
You should review the license that each NuGet package has.
Typically a NuGet package that does not have an open source license will require you to accept the license agreement
before installing it but you should still review the license even if you are not prompted to accept one.

# Start from scratch

```dotnet new console```  will create a new console project.

## New Unit test project

```dotnet new mstest -o MyClassTest```

# int/float division

integer / integer returns an integer even when the result has decimals. To get a float as result, at least one of the
numbers needs to be a float: integer / (float)integer

# Common exceptions

| Exception Class |    Cause of Exception |
|------------------------------ | ---------------------- |
| SystemException               |    A failed run time check; used as a base class for other exceptions . |
| AccessException               |    Failure to access a type member , such as a method or field. |
| ArgumentException             |    An argument to a method was invalid. |
| ArgumentNullException         |    A null argument was passed to a method that does not accept it. |
| ArgumentOutOfRangeException   |    Argument value is out of range. |
| ArithmeticException           |    Arithmetic over or underflow has occurred. |
| ArrayTypeMismatchException    |    Attempt to store the wrong type of object in an array. |
| BadImageFormatException       |    Image is in wrong format |
| CoreException                 |    Base class for exceptions thrown by the runtime. |
| DevideByZeroException         |    An attempt was made to divide by Zero. |
| FormatException               |    The format of an argument is wrong. |
| IndexOutofRangeException      | An Array index is out of range |
| InvalidCastException          |    An attempt was made to cast to an invalid class. |
| InvalidOperationException     |    A method was called at an invalid time |
| MissingmemberException        |    An invalid version of a DLL was accessed |
| NotFiniteException            |    A number is not valid |
| NotSupportedException         |    Indicates that a method is not implemented by a class |
| NullReferenceException        |    Attempt to use an unassigned reference |
| OutofmemoryException          |    Not enough memory to continue execution |
| StackOverFlowException        |    A Stack has overflowed |