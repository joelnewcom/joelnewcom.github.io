---
layout: single
title: "[Day 20] Firmware Binwalkin’ around the Christmas tree "
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

# Firware reverse engineering
1. After obtaining the firmare (normally a binary file)
2. Find out if its a bare metal or OS based.
3. Check if its encrypted or packed (Encrypted binaries are obviously much harder to cope with)

## Static Analysis
Examination of the binary file without running it.

* BinWalk: Tries to extract the code and file system of the binary
* Firware ModKit (FMK): Using binwalk and you can change code and repack the into binary.
* FirmWalker: Checks for strings and directories.

## Dynamic analysis
Typical tools:
* Qemu: Cross platform emulator for binary files. 
* Gnu DeBugger (GDB): Emulator for binaries and inspection tool of memory and registers.

 
# Task
We are going to reverse engineer a firmware binary file using Firmware modkit. 

File entropy analysis to check if its encrypted:
Using this command: ```binwalk -E -N firmwarev2.2-encrypted.gpg```
![Check entropy of binary](/assets/images/tryhackme/day20/binwalk-e-n-entropy.PNG)
The "Rising entropy edge" means its most probably encrypted and includes a lot of randomness.

We are given an older version of the firmware which is not encrypted. We might find encryption keys there to decrypt the newest version.
Using this command: ```extract-firmware.sh firmwarev1.0-unsigned```
![Check entropy of binary](/assets/images/tryhackme/day20/fmk-extract-firmware.PNG)
This will extract the binary into a folder called "fmk" 

In this folder we will ```grep -ir key``` and ```grep -ir paraphrase``` (i = case insensitive, r = recursive)

Now we have a private-key, a public-key and a passphrase.
We can now import the two keys into a keychain:  

```gpg --import fmk/rootfs/gpg/private.key``` -> Its asks for a passphrase.
```gpg --import fmk/rootfs/gpg/public.key```

```gpg --list-secret-keys```

go to the encrypted binary and do ```gpg firmarev2.2-encrypted.gpg```, this will ask again for the passphrase.

Now using FMK to extract the binary: ```extract-firmware.sh firmwarev2.2-encrypted```

