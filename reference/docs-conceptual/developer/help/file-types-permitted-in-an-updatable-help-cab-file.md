---
description: File Types Permitted in an Updatable Help CAB File
ms.date: 07/10/2023
ms.topic: reference
title: File Types Permitted in an Updatable Help CAB File
---
# File Types Permitted in an Updatable Help CAB File

Uncompressed CAB file content is limited to 1 GB by default. To bypass this limit, users have to use
the **Force** parameter of the [Update-Help][02] and [Save-Help][01] cmdlets.

To assure the security of help files that are downloaded from the internet, an Updatable Help CAB
file can include only the file types listed below. The [Update-Help][02] cmdlet validates all files
against the help topic schemas. If the `Update-Help` cmdlet encounters a file that's invalid or is
not a permitted type, it doesn't install the invalid file and stops installing files from the CAB on
the user's computer.

- XML-based help topics for cmdlets.
- XML-based help topics for scripts and functions.
- XML-based help topics for PowerShell providers.
- Text-based help topics, such as About topics.

The [Update-Help][02] verifies the CAB contents when it unpacks the CAB. If `Update-Help` finds
non-compliant file types in an Updatable Help CAB file, it generates a terminating error and stops
the operation. It doesn't install any help files from the CAB, even those of compliant file types.

[!INCLUDE [use-platyps](../../../includes/use-platyps.md)]

<!-- link references -->
[01]: /powershell/module/Microsoft.PowerShell.Core/Save-Help
[02]: /powershell/module/Microsoft.PowerShell.Core/Update-Help
