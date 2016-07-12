---
title: DSC Resource Debugging Improvements
author:  jaimeo
contributor: amitsara
---


## DSC Resource Debugging Improvements

In WMF 5.0, PowerShell debugger didn’t use to stop at Class Resource method (Get/Set/Test) directly.
We have fixed this issue, now debugger will stop at Class Resource method same as mof based resources methods.
