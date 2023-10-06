---
layout: single
---

## Builder
If you want to instantiate a specific class with a lot of constructor parameters, or the class should be immutable, 
the builder pattern encapsulates this logic into another class. You will have the possibility to work with the builder class until you have all information to actually build the real class.

[Example in Java](../patterns/builder-pattern-java.md)   

## Factory
The Factory take care the right implementation of the abstract class will be instantiated. Factory makes sense when you use different implementations depending on the parameter sent to the factory.

## Data access object
Every project will have some kind of data access object. At some point you need to decide a pattern how you want to return data from your database to the business-logic layer.
One case which will always happen: The dataAccessObject did not find the object in the store. I see five options:

* Return a dataNotFoundException

I prefer not communicating via Exceptions. Exceptions should only be used when something happens, which shouldn't. The code will be bloated with a lot of try catches.
* Return a NoDataFound object which inherits the same interface as the actual entity you looked for.

When returning an interface type, every caller needs to check the real type and cast the object, this will also be cumbersome.
* Return a custom wrapper object which has a method to ask for errors and to retrieve the result.

Many libraries do it like this.
* Return Optional<T> in Java 

* Return null

## State pattern
State pattern is the underlying pattern for State machine. Depending on the state of the machine it will do something different.
[Example in C#](../patterns/statemachine-pattern-csharp.md)

## Pipeline pattern
[Example in java](../patterns/pipeline-pattern-java.md)

## Rule engine pattern
[Example in java](../patterns/rule-engine-pattern-java.md)