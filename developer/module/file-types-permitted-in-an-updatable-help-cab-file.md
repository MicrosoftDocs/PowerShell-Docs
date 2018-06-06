---
title: "File Types Permitted in an Updatable Help CAB File | Microsoft Docs"
ms.custom: ""
ms.date: "03/22/2012"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
applies_to:
  - "Windows PowerShell 3.0"
ms.assetid: acabdb93-c41a-4b8d-acbe-45cdab91e198
caps.latest.revision: 10
---
# File Types Permitted in an Updatable Help CAB File

This topics lists and describes the content requirements for Updatable Help CAB files.

## Updatable Help CAB File Requirements

- XML-based help topics for cmdlets.

- XML-based help topics for scripts and functions.

- XML-based help topics for Windows PowerShell providers.

- Text-based help topics, such as About topics.

 The [Update-Help](/powershell/module/Microsoft.PowerShell.Core/Update-Help) verifies the CAB contents when it unpacks the CAB. If `Update-Help` finds non-compliant file types in an Updatable Help CAB file, it generates a terminating error and stops the operation. It does not install any help files from the CAB, even those of compliant file types.
 The [Update-Help](/powershell/module/Microsoft.PowerShell.Core/Update-Help) verifies the CAB contents when it unpacks the CAB. If `Update-Help` finds non-compliant file types in an Updatable Help CAB file, it generates a terminating error and stops the operation. It does not install any help files from the CAB, even those of compliant file types.