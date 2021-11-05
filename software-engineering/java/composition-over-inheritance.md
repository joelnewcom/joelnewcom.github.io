[Home](/)

[Back](index.md)

I learned in 2007 in computer science class to use inheritance to achieve polymorphism-like behaviour. You just need to build a good inheritance tree to abstract the real world objects. 
Like these examples: Giraffe inherits Animal and Lion also inherits Animal. But Lion actually inherits first from Carnivore and Carnivore inherits from Animal...

Problem with this is: Java doesn't allow multiple inheritance and you also will violate the Interface segregation rule quite fast.
 

    