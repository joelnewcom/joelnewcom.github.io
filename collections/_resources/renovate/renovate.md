---
layout: single
---


# Run renovate locally
cd into the directory where config.js is located and run: 
```

$env:RENOVATE_USE_BASE_BRANCH_CONFIG = 'merge'
$env:RENOVATE_BASE_BRANCHES = '["main", "/^renovate\\/.*/"]'
$env:LOG_LEVEL = 'debug'
npx renovate
```

# Run against specific branch
https://github.com/renovatebot/renovate/discussions/16108


For this we would need to first set useBaseBranchConfig to "merge" and then define 
some baseBranches. 

https://docs.renovatebot.com/configuration-options/#usebasebranchconfig
https://docs.renovatebot.com/configuration-options/#basebranches
