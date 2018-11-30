---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  Using Import-DSCResource
---

# Using Import-DSCResource

When you write [Configurations](configurations.md), you will need to import resources in order to use them. If you do not import a resource used in your Configuration you will see an error.

```powershell

```

```output

```

Import resources into your Configurations using the [Import-DSCResource]() function.

PowerShell development environments will highlight any resource blocks where you have not explicitly imported the resource.

[Intellisense](.\media\import-resource-intellisense.png)

You can use the out-of-the-box resources (Registry, File, etc.) without explicitly importing them, but you will see a warning.

```powershell

```

```output

```
