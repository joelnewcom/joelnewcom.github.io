[Home](/)

### table of content
[Backup & Restore](backup-restore.md)
[Full cluster restart](full-cluster-restart.md)
[Rolling restart](rolling-restart.md)
[Scrolling on Index](scrolling-on-es.md)

## Scaling
One of the purpose of elasticsearch is to make lucene scalable. The environment where you run elasticsearch should naturally be scalable. 
Never let you convince that you run elasticsearch on super-duper fast machines which cannot be afford later on, when you actually need to scale up.
That doesn't mean bear-metal should be avoided. It just means, the environment needs to allow adding new servers or virtual machines when you need them. 

## Making re-indexing faster
Set replication to zero on the index you want to index into. After the re-indexing is done you can set it to the desired number.