---
layout: single
---

# Git branching strategies

I know three types of branching model for git. 

* [Git flow](https://nvie.com/posts/a-successful-git-branching-model/)
* [Trunk based](https://paulhammant.com/2013/04/05/what-is-trunk-based-development/)
* [Environment Branching](https://sairamkrish.medium.com/git-branching-strategy-for-true-continuous-delivery-eade4435b57e)

[Good comparison between the strategies](https://www.toptal.com/software/trunk-based-development-git-flow)

# Git merge
Git merge goes like this:

```
# Do a reverse-merge to update your local branch 
git fetch 
git checkout feature-branch 
git merge origin/master
# Open a PR and let your git server merge your changes back to main.
```

## Git merge logic

```
# 1. Step: find the common commit, called the merge base
git merge-base master feature 

# 2. Step: 2 diffs from merge base to first branch and from merge base to second branch. 
git diff feature...master (green)
git diff master...feature (blue)

# 3. Step: Apply both diffs to the merge base. 
git commit

```

![git merge logic](/assets/images/git/git-merge-logic.PNG)

## Git merge ff options
```
git merge --ff # does a fast-forward if possible, otherwise create a merge-commit
git merge --no-ff # Always creat a merge-commit
git merge --ff-only # Only proceed if fast-forward is possible (basically a git push) 
```

![git merge ff options](/assets/images/git/git-merge-ff.PNG)

# Git cherry-pick

```
# Applies a specific or multiple commits at the tip of your current branch. 
git checkout feature-branch
git cherry-pick <sha>
```

Git creates a new commit on the branch you are on. The involved branches are the current and the other up to the cherry-picked commit. 
The merge base is the parent of the commit you are cherry-picking.

# git revert
```
# Create a new commit at the tip of your current branch to undo a specific commit 
git checkout feature-branch
git revert <sha>
```

Git performs a backwards-facing cherry-pick. The involved branches are the current one and the parent of the commit you are reverting. 
The merge base is the commit you are reverting.

# git pull
You are on a branch and want to get the latest changes from remote git. 
```
git fetch
git merge origin/x
```

# Git rebase

You are on a branch and want to get the latest changes from remote git, but you don't want to create a merge-commit.
Git rebase takes the latest origin/x as basis and cherry-picks each of your local commits on top of it.  

On a tree it looks like git shifts your commits in front of the branch you rebased on (though technically these are new commits created by git)

```
git fetch
git checkout feature-branch
git rebase origin/master
```

After you rebased on a branch, it is easy to merge --ff-only your changes into this branch.
![git rebase](/assets/images/git/git-rebase.PNG)

# Git squash merge
This will put all new commits into one new commit 

```
git fetch
git checkout master
git merge --squash feature-branch
```

![git merge --squash](/assets/images/git/git-squash-merge.PNG)

# Git rebase and merge --no-ff
This is a merge strategy on Azure Devops to create semi-linear history
![git semi linear](/assets/images/git/git-semi-linear.PNG)

# Keep your local branch up to date
There are two option to keep your local branch up to date with a long-living branch.
![git keep up to date](/assets/images/git/git-keep-up-to-date.PNG)


# Use .gitignore locally
You can add this line to ```~/.gitconfig```
```
[core]
    excludesfile = ~/.gitignore
```
And add a ```.gitignore``` file in your ```~/``` folder with this content: 

```
# PhpStorm
.idea

# VSCode
.vscode
```

This is useful if you don't want to change projects .gitignore as you are the only one working on a specific IDE.

# Use different email for work and private repos
[manual](https://blog.hao.dev/how-to-use-different-git-emails-for-personal-and-work-repositories-on-the-same-machine)

# undo, revert commit
revert commit = New commit to undo all changes
Undo commit = drop commit and get the changes back locally
drop commit = Lose the changes completely

# Get branch from fork
Nur einmal: ```git remote add upstream https://mycompany@dev.azure.com/mycompany/Project/_git/repo```

```
git fetch upstream
git checkout -b feature-branch upstream/feature-branch
git push origin feature-branch
```