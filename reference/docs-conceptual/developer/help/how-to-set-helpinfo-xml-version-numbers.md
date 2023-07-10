---
description: How to set HelpInfo XML version numbers
ms.date: 07/10/2023
ms.topic: reference
title: How to set HelpInfo XML version numbers
---
# How to set HelpInfo XML version numbers

[!INCLUDE [use-platyps](../../../includes/use-platyps.md)]

The version numbers in a HelpInfo XML file are critical to the operation of Updatable Help. The
[Update-Help][02] and [Save-Help][01] cmdlets download new help files only when the version number
for a UI culture in the remote HelpInfo XML file is greater than the version number for that UI
culture in the local HelpInfo XML, or there is no local HelpInfo XML file.

The HelpInfo XML file uses the 4-part version number that's defined in the **System.Version** class
of the Microsoft .NET Framework. The format is `N1.N2.N3.N4`. Module authors can use any version
numbering scheme that's permitted by the **System.Version** class. Updatable Help requires only that
the version number for a UI culture increase when a new version of the CAB file for that UI culture
is uploaded to the location that's specified by the **HelpContentURI** element in the HelpInfo XML
file.

The following example shows the elements of the HelpInfo XML file for the German (de-DE) UI culture
when the version is 2.15.0.10.

```xml
<UICulture>
  <UICultureName>de-DE</UICultureName>
  <UICultureVersion>2.15.0.10</UICultureVersion>
</UICulture>
```

The version number for a UI culture reflects the version of the CAB file for that UI culture. The
version number applies to the entire CAB file. You can't set different version numbers for different
files in the CAB file. The version number for each UI culture is evaluated independently and need
not be related to the version numbers for other UI cultures that the module supports.

<!-- link references -->
[01]: /powershell/module/Microsoft.PowerShell.Core/Save-Help
[02]: /powershell/module/Microsoft.PowerShell.Core/Update-Help
