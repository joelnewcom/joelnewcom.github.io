---
layout: single
---

## Runnable
Represents a task to run on a thread. It is a functional interface with one ```void run()``` method.
Can be run with ```Thread``` class or ```ExecutorService```.

## Callable
Kinda the successor of Runnable. It is an interface with ```V call()``` method.
Can be run with ```ExecutorService```. The return value of the call method can be retrieved with ```Future<V>```.

## Future
https://www.baeldung.com/java-future
Represents a result of an asynchronous computation. This is around since Java 1.5 and is the old way to do async programming in Java. It has some limitations compared to the CompletableFuture.

### Interrupting a Future
A great advantage is still that when calling future.cancel(true) the underlying thread to compute the result will be interrupted.

## CompletableFuture
https://www.baeldung.com/java-completablefuture
This came with Java 8 and is the common way to do async programming in Java. You can chain multiple operations and handle exceptions in a more readable way than with the old Future interface.

### Interrupting a CompletableFuture
When you call completableFuture.cancel(true) the thread(s) computing the results will not be interrupted. But the CompletableFuture itself will be cancelled.
https://stackoverflow.com/questions/29013831/how-to-interrupt-underlying-execution-of-completablefuture

