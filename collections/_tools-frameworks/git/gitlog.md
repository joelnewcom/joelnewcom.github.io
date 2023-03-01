---
layout: single
---

## Shows git stats
```
git log --numstat --since 01-01-2019
```

## show amount of commits of all authors
```
git shortlog -sne --since="01 Jan 2017" --before="31 Dez 2020"
```

-n option to sort by the number of commits per author.
-s Suppress commit description and provide a commit count summary only.
-e Show the email address of each author.

## show changes of a certain author
```
git log --no-merges --author="joel.neukom*" --name-only --pretty=format:"" | sort -u > changes-joel.txt
```

## Count lines of all java files  
```wc -l $(git ls-files | grep '.*\.java')```

## Count all files and all lines
```
git diff --shortstat `git hash-object -t tree /dev/null` 
```
 
## Count all commits with "fix" in comment.
```
{% raw  %}
git log --all -i --grep='fix' --pretty=format:"{%H}" | wc -l
{% endraw %}
```