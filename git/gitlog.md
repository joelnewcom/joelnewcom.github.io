## Shows git stats
git log --numstat --since 01-01-2019

## show changes of a certain author
git log --no-merges --author="joel.neukom*" --name-only --pretty=format:"" | sort -u > changes-joel.txt