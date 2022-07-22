---
layout: single
title:  "Exceptions"
date:   2022-07-20 20:41:53 +0200
categories: java
header:
  teaser: "/assets/images/java-teaser-500x300.JPG"
---

# Exceptions
In Java, you can to a lot with exceptions. You should use and handle exceptions the same way in your project. The mess starts when you mix different patterns.

There is the BaseClass Throwable, and it has two children: Exception and Error.
Error is like an earthquake. If the JVM raises an Error, something is wrong in the JVM or even the physical machine. 

There are two main types of Exceptions.
* Checked exceptions (Compiler checks them)
* Unchecked exceptions (Compiler doesn't check them)

The class Exception has a child called RunTimeException. All classes extending/inheriting the RunTimeException are called unchecked exceptions.

## Handling patterns
Checked exceptions are forced to be handled. This is a good thing right? Depending on how your project is structured, you might handle the exception after it passes a lot of methods.
Every of these methods are forced to declare the checked exception on their method header. This is pain and doesn't really help.

## Dont's
Don't handle an exception just to throw another. Only case you do this, is to use unchecked exception instead of checked one. And if you do so, don't forget to pass the stacktrace and message to the new one.

Don't use exceptions to pass information to the caller if you can pass it properly via a dedicated object. Like 
```
public Entity searchEntityBadExample(String id){
    Entity entity = dbao.getById(id);
    if (entity == null){
        throw EntityNotFoundException("Entity not found with id: " + id");
    }
    return entity;
}
```

This is a better example: EmptyEntity is of type Entity. It can be handled via polymorphism in the caller method. 
```
public Entity searchEntityGoodExample(String id){
    Entity entity = dbao.getById(id);
    if (entity == null){
        return new EmptyEntity(id, "Not existent");
    }
    return entity;
}
```

