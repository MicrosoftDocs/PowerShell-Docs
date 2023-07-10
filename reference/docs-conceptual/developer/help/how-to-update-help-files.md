---
description: How to update help files
ms.date: 07/10/2023
ms.topic: reference
title: How to update help files
---
# How to update help files

[!INCLUDE [use-platyps](../../../includes/use-platyps.md)]

There are many reasons to update help files, such as correcting errors, clarifying a concept,
answering a frequently asked question, adding new files, or adding new and better examples.

To update a help file:

1. Change the files.
1. Translate the files into other UI cultures.
1. Collect all help files (new, changed, and unchanged) for the module in each UI culture.
1. Validate the files against the XML schema.
1. Rebuild the CAB files for each UI culture.
1. In the HelpInfo XML file, increment the version numbers of the CAB file for each UI culture.
1. Upload the new CAB files to the location that's specified by the value of the **HelpContentUri**
   element in the HelpInfo XML file. Replace the older CAB files with the new CAB files.
1. Upload the updated HelpInfo XML file to the location that's specified by the **HelpInfoUri** key
   in the module manifest. Replace the older HelpInfo XML file with the new file.
