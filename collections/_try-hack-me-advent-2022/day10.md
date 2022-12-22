---
layout: single
title: "[Day 10] Hack a game You're a mean one, Mr. Yeti"
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

Changing data in memory at runtime. 
Cetus is a simple browser plugin that works for Firefox and Chrome, allowing you to explore the memory space of Web Assembly games that run in your browser.

Its downloadable from here: https://github.com/Qwokka/Cetus/releases/download/v1.03.1/Cetus_v1.03.1.zip

On firefox you can put ```about:debugging``` ->  ```This Firefox``` -> ```Load Temporary Add-on``` and select downloaded .zip file.
 
The game lets you guess a number between 0 and 99999999  
![guess numbers](/assets/images/tryhackme/day10/number-guessing.PNG)

First I guessed and it was obviously wrong, but the guard tells you what it would have been: 81070266

This number can be found with Cetus. The memory address can be bookmarked:
![search in memory](/assets/images/tryhackme/day10/searched-bookmarked.PNG)

We just try again and we see how the value changed in the bookmarked memory address:
![read from bookmark](/assets/images/tryhackme/day10/read-from-bookmark.PNG)

Next challenge is to cross some obstacles. 
We can search the whole addressspace once. This will return 458753 results. 
When we walk into the obstacle which will decrease our livepoints we search again for all values which decreased since last time.
We repeat this until we see an address which could fit. We set this value to a high value and become imortal. 
![imortal](/assets/images/tryhackme/day10/set-livepoint.PNG)