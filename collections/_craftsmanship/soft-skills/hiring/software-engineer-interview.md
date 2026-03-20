---
layout: single
---

# Question / Answer
## What is your intrinsic motivation to write software?
No correct/wrong answer

## Do you know SOLID principles?

- Single Responsibility principle (name the class and let it do this thing)
- Open closed principle (open for extension, closed to change)
- Liksov substitution principle (what?)
- Interface segregation (define the smalles possible interface)
- Dependency inversion principle (Make interfaces and use the interface to communicate with others)

## What does clean code means to you? 
Should have at least an opinion about it

### What do you think about linter? 
Do you know better than the authors of a programming language? Or can you adhere to some principals?

## For what are you looking when perform a code review?
- Understandable? Readable?
- Tested?
- Simple?
- Does it fit into existing?
- Does it what the user story describes? 
- SOLID, yagni, design patterns?

## Do you have any pet projects?
No correct/wrong answer

## Tell something about properties (C# specific)
Acting as data fields, but offers the benefits of methods
Compiler creates a private field (called a "backing store")

Properties should not trigger long computations. 

## Tell something about immutability
Immutable object can not be changed once created. If you want to change it, you have to create a new instance. 
This is great because you only have to validate it once. 

## What is a side effects code smell?
A method doing some changes the caller would not expect. 

## Tell something about checked/unchecked exceptions? (Java specific)
* Checked exceptions (Compiler checks them)
* Unchecked exceptions (Compiler doesn't check them)
* Should have an opinion about it

## Do you know about cruft?
internal versus external quality. What does it cost to change?

Internal quality signs:

* Module structure
* Software architecture (MVVN, 3 tier, MVC, Hexagonal)
* Software design (SOLID, yagni etc.)
* Tests

External quality
* What the customer currently sees and feels

## Who is your idol regarding software engineering?
No correct/wrong answer
Books, key figures, blogs to follow etc.

## What is important to you regarding code?
* Software craftsmanship 
* Testing
* Patterns
* ...
 
# C# Kata - Checkout
[Source](https://github.com/asierba/Katas.CSharp)

Following code can be run in [DotNet fiddle](https://dotnetfiddle.net/) if there is no IDE at hand. 

* [Empty](/Kata-Empty.cs)
* [Solution](/Kata-Solution.cs)
