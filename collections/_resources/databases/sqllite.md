---
layout: single
---

#### Persist data
Its is normal for a small project to start with an in-memory storage. The next evolution-step would be persist the data.    
But instead of using fopen() and store data in files on your own, its in every case better to use SQLite instead.  
It will handle all your problems of file handling and inconsistent data and makes it easier to migrate to a database server. 

As soon you want to serve concurrent users, it is time to switch to a database server which supports multiple connections.