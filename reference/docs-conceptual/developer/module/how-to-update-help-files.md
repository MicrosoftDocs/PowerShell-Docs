---
title: "How to Update Help Files | Microsoft Docs"
ms.custom: ""
ms.date: "09/12/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 495869a6-080e-4401-9ddc-16edd2f86857
caps.latest.revision: 6
---
# How to Update Help Files

This topic explains how to update help files for a module that supports Updatable Help.

## Updating Help Files

There are many reasons to update help files, such as correcting errors, clarifying a concept, answering a frequently-asked question, adding new files, or adding new and better examples.

To update a help file:

1. Change the files.

2. Translate the files into other UI cultures.

3. Collect all help files (new, changed, and unchanged) for the module in each UI culture.

4. Validate the files against the XML schema.

5. Rebuild the CAB files for each UI culture.

6. In the HelpInfo XML file, increment the version numbers of the CAB file for each UI culture.

7. Upload the new CAB files to the location that is specified by the value of the **HelpContentUri** element in the HelpInfo XML file. Replace the older CAB files with the new CAB files.

8. Upload the updated HelpInfo XML file to the location that is specified by the **HelpInfoUri** key in the module manifest. Replace the older HelpInfo XML file with the new file.
