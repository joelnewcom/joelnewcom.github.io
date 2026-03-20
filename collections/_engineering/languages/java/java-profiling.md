---
layout: single
---

# VisualVM
1. Download VisualVM (doesn't need to be installed) and run it.
2. Run the java application
3. In VisualVM, you should see started application under "Local" and you can already monitor CPU and memory usage. 
4. Go to "Profiler" tab and click on "Profile: CPU"
5. If it doesn't work, you might need to add ```-Xverify:none``` as JVM argument and restart your application
6. You should see opened threads and method calls according to you ```Profile classes``` filter. 
7. If you want to profile springframework classes, add ```org.springframework.**``` to ```Profile classes``` filter.

# Profiling with IntelliJ
This is a IntelliJ Ultimate feature. Don't even try it with community edition. 