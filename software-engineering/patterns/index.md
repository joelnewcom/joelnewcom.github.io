[Home](/)

[Back](../index.md)

## Builder
If you want to instantiate a specific class with a lot of constructor parameters, or the class should be immutable, 
the builder pattern encapsulates this logic into another class. You will have the possibility to work with the builder class until you have all information to actually build the real class.

[Example in Java](../java/builder-pattern.md)   

## Factory
The Factory take care the right implementation of the abstract class will be instantiated. Factory makes sense when you use different implementations depending on the parameter sent to the factory.
    