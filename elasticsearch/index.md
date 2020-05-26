## Scaling
One of the purpose of elasticsearch is to make lucene scalable. The environment where you run elasticsearch should naturally be scalable. Never let you convince that you run elasticsearch on super-duper fast machines which cannot be afford later on, when you actually need to scale.  

## Making re-indexing faster
Set replication to zero on the index you want to index into. After the re-indexing is done you can set it to the desired number.

## 
