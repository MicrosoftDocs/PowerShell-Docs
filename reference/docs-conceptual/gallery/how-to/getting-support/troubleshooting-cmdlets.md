---
ms.date:  06/12/2017
title:  Troubleshooting cmdlets
description: This article provide information and steps for troubleshooting errors using the PowerShell Gallery
---
# Troubleshooting cmdlets

## How to resolve "WARNING: Package 'your package name' failed to download" issue

It is reported that `Install-Module` or `Update-Module` sometimes fails on some machines. Based on
our investigation, it is something to do with the networking connection. Recently we updated NuGet
provider so that it can reliably download packages. You can follow the instructions below to install
the latest build of NuGet provider and then install or update your module. Let's use 'Azure' module
as an example below.

```powershell
Install-PackageProvider NuGet -MinimumVersion 2.8.5.206 -Force
Launch new PowerShell Console
Update-Module Azure -Verbose
```

### Required network endpoints

The Install and Update cmdlets require internet access to connect to the network endpoints used by
by the PowerShell Gallery. Ensure that your network access policies allow you to connect to the
following endpoints.

- oneget.org
- go.microsoft.com
- az818661.vo.msecnd.net
- www.powershellgallery.com
- devopsgallerystorage.blob.core.windows.net
