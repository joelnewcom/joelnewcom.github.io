---
layout: single
---

# Clean architecture
![Clean architecture](/assets/images/software-engineering/architecture/clean-architecture.PNG)

The architecture should support to keep the core of the app as clean as possible.

The outer layers (low-level modules) shall depend on the inner layer (high-level module). 
This is achieved by Dependency inversion principle. 

# 3 tier pattern
You can split your application into 3 layers:

* Controllers
* Service
* Repository

[3tier](/assets/images/software-engineering/architecture/3tier/software-architecture.PNG)

I would keep your business code in a project called Services, your DAL code in a project called Repositories, and your interfaces and business objects(or entities) in a project called Core.
Your REST project should reference only Core (and Services for resolving dependencies).
You program exclusively to interfaces.
Your Services and Repositories should each only depend on Core. These concrete implementations need only implement Core interfaces and act on Core entities.
[Source](https://stackoverflow.com/a/26908990/4132067)