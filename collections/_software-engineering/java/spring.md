---
layout: single
---

# Tell java compiler and IDE not warn about Spring dependency injection
Annotate a method or classes with: ```@SuppressWarnings("unused")```

````java
    @GetMapping("/csv")
    @SuppressWarnings("unused")
    public String index() {
        return "csv";
    }
````
