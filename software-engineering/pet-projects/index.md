[Home](/)

[Back](../index.md)

### Learnings

#### Persist data
Its is normal for a small project to start with an in-memory storage. The next evolution-step would be persist the data.    
But instead of using fopen() and store data in files on your own, its in every case better to use SQLite instead.  
It will handle all your problems of file handling and inconsistent data and makes it easier to migrate to a database server. 

As soon you want to serve concurrent users, it is time to switch to a database server which supports multiple connections.

#### Data access object
Every project will have some kind of data access object. At some point you need to decide a pattern how you want to return data from your database to the business-logic layer.
One case which will always happen: The dataAccessObject did not find the object in the store. I see five options:

##### Return a dataNotFoundException
I prefer not communicating via Exceptions. Exceptions should only be used when something happens, which shouldn't. The code will be bloated with a lot of try catches.
* Return a NoDataFound object which inherits the same interface as the actual entity you looked for?

```When returning an interface type, every caller needs to check the real type and cast the object, this will also be cumbersome.```
* Return a custom wrapper object which has a method to ask for errors and to retrieve the result.
* Return Optional<T> in Java 
* Return null



 

### AutoTrader 
Is an application which utilizes Lykke cryptocurrency exchange to automatically trade assets.
 
[More info](autotrader.md)
