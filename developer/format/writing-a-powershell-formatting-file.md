---
title: "Writing a PowerShell Formatting File | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 39acce45-5144-43ba-894d-a4ce782fa67d
caps.latest.revision: 13
---
# Writing a PowerShell Formatting File

"Writing a PowerShell Formatting File" is for command developers who are writing cmdlets or functions that output objects to the command line. Formatting files define how PowerShell displays those objects at the command line. This documentation provides an overview of formatting files, an explanation of the concepts that you should understand when writing these files, examples of XML used in these files, and a reference section for the XML elements.

## In This Section

[Formatting File Overview](./formatting-file-overview.md)
Describes what a format file is and the general components of a formatting file, including common features that can be defined in the file, the different types of format views that can be defined for .NET objects, and a simplified example of the XML used to define a table view.

[Formatting File Concepts](./formatting-file-concepts.md)
Includes information that you might need to know when creating your own formatting files, such as the different types of views that you can define and special components of those views.

[Examples of Formatting Files](./examples-of-formatting-files.md)
Provides XML examples of several formatting files, including examples of a table view, a list view, and a wide view, as well as examples that show how to define features such as selection sets, selection conditions, and common controls.

[Format XML Reference](./format-schema-xml-reference.md)
Includes reference topics for the XML elements used in a formatting file.
