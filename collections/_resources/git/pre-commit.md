---
layout: single
---

# How to install
Either run ```pip install pre-commit```
Or download pyz file from https://github.com/pre-commit/pre-commit/releases
and run: 
```python %homedrive%%homepath%/Downloads/pre-commit-3.3.3.pyz install```

# How to uninstall
Cd into your local git repo folder and run: 
```python %homedrive%%homepath%/Downloads/pre-commit-3.3.3.pyz uninstall```

# How to use
Create a file named ´´´-pre-commit-config.yaml´´´ in the root folder of your project: 

Content: 

````yaml
repos:
- repo: https://github.com/python-jsonschema/check-jsonschema
  rev: 0.24.0
  hooks:
    - id: check-azure-pipelines
- repo: local
  hooks:
  #Use dotnet format already installed on your machine
    - id: dotnet-format
      name: dotnet-format
      language: system
      entry: dotnet format --include
      types_or: ["c#", "vb"]
- repo: https://github.com/antonbabenko/pre-commit-terraform
  rev: v1.81.2
  hooks:
    - id: terraform_fmt
````
