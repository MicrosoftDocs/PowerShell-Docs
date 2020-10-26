---
ms.date: 03/22/2012
ms.topic: reference
title: File Types Permitted in an Updatable Help CAB File
description: File Types Permitted in an Updatable Help CAB File
---
# File Types Permitted in an Updatable Help CAB File

Uncompressed CAB file content is limited to 1 GB by default. To bypass this limit, users have to use
the **Force** parameter of the
[Update-Help](/powershell/module/Microsoft.PowerShell.Core/Update-Help) and
[Save-Help](/powershell/module/Microsoft.PowerShell.Core/Save-Help) cmdlets.

To assure the security of help files that are downloaded from the internet, an Updatable Help CAB
file can include only the file types listed below. The
[Update-Help](/powershell/module/Microsoft.PowerShell.Core/Update-Help) cmdlet validates all files
against the help topic schemas. If the `Update-Help` cmdlet encounters a file that is invalid or is
not a permitted type, it does not install the invalid file and stops installing files from the CAB
on the user's computer.

- XML-based help topics for cmdlets.
- XML-based help topics for scripts and functions.
- XML-based help topics for PowerShell providers.
- Text-based help topics, such as About topics.

The [Update-Help](/powershell/module/Microsoft.PowerShell.Core/Update-Help) verifies the CAB
contents when it unpacks the CAB. If `Update-Help` finds non-compliant file types in an Updatable
Help CAB file, it generates a terminating error and stops the operation. It does not install any
help files from the CAB, even those of compliant file types.
