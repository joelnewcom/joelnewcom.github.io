---
layout: single
title:  "Code smells"
date:   2024-07-15 00:00:00 +0200
categories: dev
---

# MagicNumbers/string
Refactoring: Introduce constant with a meaningful name.
But don't over do it. If the constant is only used once, it might be better to leave it as is.

# Redundant comments
Refactoring: Remove comments that are not adding value.

# Complex conditionals
Refactoring: Extract complex conditionals into a method with a meaningful name.

# Deeply nested code
When ifs are nested: 
Refactor: Guard causes (Clause to return early)

# Long methods
If a method is too long, it is hard to understand.
Refactor: Extract method

# Side effects
When a method does more than one thing, it is hard to understand.
Refactor: Duplicate and Reduce
1. Identify use-cases which part of the method is used by which caller
2. Duplicate the complicated method for each use-case
3. Reduce each method to its use-case
4. Extract shared code into a new method

# Temporary field
When a field is only used in a small part of the class.
Refactor: Form the field to a parameter and use it as a local variable.

# Error codes
When a method returns an error code, it is hard to understand.
Refactor: Throw an exception

# Output parameter
When a method has an output parameter, it is hard to understand.
Refactor: Return just one thing.

# deep inheritance hierarchy or Lazy class
When a class is inherited by many classes, it is hard to understand.
When a class is not doing much.

Refactor: Push members down, safe delete.

# Speculative Generality
When someone is adding a feature/code that is not needed yet.
Refactor: Safe delete it

# Refused Bequest
When you inherit from a class, but only use a subpart of if (eg. throw exceptions when some method gets called).
Violates the liskov substitution principle. (If you inherit from a class, you should be able to use it as is)

Refactor: 
1. Create a new field of type parent
2. Generate (Alt + ins) -> Delegating members and select the used method
3. Delete the inheritance

# Flag parameter
When a method has a boolean parameter which is used to switch between two different behaviors.
Refactor: 
1. Extract a method for each branch made by the parameter
2. Rewrite the if to ternary operator
3. Inline the whole method into the caller

# Primitive obsession
When an array is used instead of a list
Refactor:
1. Create new structure
2. Duplicate each write access to the new structure
3. Change read access to the new structure
4. Remove the write access to the old structure
5. Remove the old structure

# Inappropriate Intimacy
When two classes are too close to each other.
Refactor: Remove public fields

# Long parameter list
When a method has too many parameters.
Refactor:  

# Data clumps
When a group of parameters is always passed together.
Refactor: Refactor the parameters into a class (Like: method(int x, int y) into a method(Point point))

# Data class
When a class is only used to store data.
Refactor: Put the fields into the class that uses them.

# Feature envy
When a method is more interested in a different class than in itself. (eg. uses a lot of properties from another class)

1. Extract method
2. Move method

# Dead code
When a method is not used anymore.
Refactor: Safe delete