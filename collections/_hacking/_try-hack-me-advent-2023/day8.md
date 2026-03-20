---
layout: single
title: "[Day 8] Disk forensics Have a Holly, Jolly Byte!"
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

# Day8
Is about analyse a malicious USB drive with FTK imager.

## Theory FTK Imager
FTK Imager is a forensics tool that perform analysis without affecting the original evidence, preserving its authenticity, integrity, and validity for presentation during a trial in a court of law.

It can recover deleted files.


# Challenge
- peek into deleted files
- extract deleted .zip file
- Find the flag within .png file
- Compare SHA1 hashes of forensic image and actual usb drive


![Memory buffer](/assets/images/tryhackme/hackvent2023/day8/ftk-imager.PNG)