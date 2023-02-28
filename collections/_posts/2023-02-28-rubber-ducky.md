---
layout: single
title:  "Rubber Ducky"
date:   2023-01-28 00:00:00 +0200
categories: Hacking
---

I bought a rubberducky from hak5 and this is what I learned:

# Unboxing 
The rubberducky has a button and a sd card. But to access these two things you need to open the USB stick following this [tutorial](https://docs.hak5.org/hak5-usb-rubber-ducky/unboxing-quack-start-guide)

# Arm the rubber ducky
You need to put the rubber ducky into "arming mode" by pressing the button on the inserted stick. 
Then you go to: [Hak5 payloads](https://hak5.org/blogs/payloads/tagged/usb-rubber-ducky+prank).

You take one of these and copy the content of payload.txt into the [payload studio](https://payloadstudio.hak5.org/pro/).

Make sure you selected the correct language on payload studio:
![language](/assets/images/rubberducky/language.PNG)

Then press "Generate Payload" and download the *.bin file and maybe also the other needed files from git if there are any. 
Put the *.bin file into the DUCKY flashdrive:

![flashdrive](/assets/images/rubberducky/ducky-flashdrive.PNG)

# Run it
when you plug the rubberducky out its armed and when plugin it into an usb port its going to run its code. 