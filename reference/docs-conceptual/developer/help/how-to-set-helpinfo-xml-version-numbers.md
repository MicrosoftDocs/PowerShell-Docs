---
ms.date: 09/12/2016
ms.topic: reference
title: How to Set HelpInfo XML Version Numbers
description: How to Set HelpInfo XML Version Numbers
---
# How to Set HelpInfo XML Version Numbers

This topic explains how to set and increase the version numbers in an Updatable Help Information
file, commonly known as a "HelpInfo XML file."

## How to Set HelpInfo XML Version Numbers

The version numbers in a HelpInfo XML file are critical to the operation of Updatable Help. The
[Update-Help](/powershell/module/Microsoft.PowerShell.Core/Update-Help) and
[Save-Help](/powershell/module/Microsoft.PowerShell.Core/Save-Help) cmdlets download new help files
only when the version number for a UI culture in the remote HelpInfo XML file is greater than the
version number for that UI culture in the local HelpInfo XML, or there is no local HelpInfo XML
file.

The HelpInfo XML file uses the 4-part version number that is defined in the **System.Version** class
of the Microsoft .NET Framework. The format is `N1.N2.N3.N4`. Module authors can use any version
numbering scheme that is permitted by the **System.Version** class. Updatable Help requires only
that the version number for a UI culture increase when a new version of the CAB file for that UI
culture is uploaded to the location that is specified by the **HelpContentURI** element in the
HelpInfo XML file.

The following example shows the elements of the HelpInfo XML file for the German (de-DE) UI culture
when the version is 2.15.0.10.

```xml
<UICulture>
  <UICultureName>de-DE</UICultureName>
  <UICultureVersion>2.15.0.10</UICultureVersion>
</UICulture>
```

The version number for a UI culture reflects the version of the CAB file for that UI culture. The
version number applies to the entire CAB file. You cannot set different version numbers for
different files in the CAB file. The version number for each UI culture is evaluated independently
and need not be related to the version numbers for other UI cultures that the module supports.
