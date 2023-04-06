---
layout: single
---

## add tag locally
git tag v1.0.1

## push a specific tag to remote
git push origin v1.0.1

## delete a tag locally
git -d v1.0.1

## delete a tag remote
git push --delete origin v1.0.1

## Reset all local changes
git reset --hard HEAD

## git diff
```git diff branch1...branch2```
Using “git diff” with three dots compares the top of the right branch (the HEAD) with the common ancestor of the two branches.

## git fetch
```git fetch origin master:master```
Will update master branch without switching to master. (Works only if the merge is a fast-forward)
