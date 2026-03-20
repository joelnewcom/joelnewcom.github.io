---
layout: single
---

## Switch kubernetes context
```kubectl config get-contexts```

gives you this: 
```
$ kubectl config get-contexts
CURRENT   NAME                         CLUSTER                      AUTHINFO                                                           NAMESPACE
*         aks-ports-and-adapter-demo   aks-ports-and-adapter-demo   clusterUser_ports-and-adapter-demo-rg_aks-ports-and-adapter-demo   demo
          rancher-desktop              rancher-desktop              rancher-desktop
```

```
kubectl config use-context rancher-desktop
```
