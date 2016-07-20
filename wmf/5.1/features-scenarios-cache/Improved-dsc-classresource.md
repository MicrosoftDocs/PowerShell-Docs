---
title: DSC Class Resource Improvements
author:  jaimeo
contributor: amitsara
---

## DSC Class Resource Improvements

In this release, we have fixed following know issues from WMF 5.0:
* Get-DscConfiguration may return empty values (null) or errors if a complex/hashtable type is returned by Get() function of a class based DSC resource.
* Get-DscConfiguration returns error if RunAs credential is used in DSC Configuration.
* Class based resource cannot be used in a Composite Configuration.
* Start-DscConfiguration hangs if Class based resource has a property of its own type.
* Class based resource cannot be used as an exclusive resource.
