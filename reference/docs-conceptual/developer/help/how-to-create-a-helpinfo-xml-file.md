---
description: How to create a HelpInfo XML file
ms.date: 07/10/2023
ms.topic: reference
title: How to create a HelpInfo XML file
---
# How to create a HelpInfo XML file

[!INCLUDE [use-platyps](../../../includes/use-platyps.md)]

This topics in this section explains how to create and populate a help information file, commonly
known as a "HelpInfo XML file," for the PowerShell Updatable Help feature.

## HelpInfo XML file overview

The HelpInfo XML file is the primary source of information about Updatable Help for the module. It
includes the location of the help files for the modules, the supported UI cultures, and the version
numbers that Updatable Help uses to determine whether the user has the newest help files.

Each module has just one HelpInfo XML file, even if the module includes multiple help files for
multiple UI cultures. The module author creates the HelpInfo XML file and places it in the internet
location that's specified by the **HelpInfoUri** key in the module manifest. When the module help
files are updated and uploaded, the module author updates the HelpInfo XML file and replaces the
original HelpInfo XML file with the new version.

It's critical that the HelpInfo XML file is carefully maintained. If you upload new files, but
forget to increment the version numbers, Updatable Help will not download the new files to users'
computers. if you add help files for a new UI culture, but don't update the HelpInfo XML file or
place it in the correct location, Updatable Help will not download the new files.

## In this section

This section includes the following topics.

- [HelpInfo XML Schema][02]
- [HelpInfo XML Sample File][01]
- [How to Name a HelpInfo XML File][03]
- [How to Set HelpInfo XML Version Numbers][04]

## See also

[Supporting Updatable Help][05]

<!-- link references -->
[01]: ./helpinfo-xml-sample-file.md
[02]: ./helpinfo-xml-schema.md
[03]: ./how-to-name-a-helpinfo-xml-file.md
[04]: ./how-to-set-helpinfo-xml-version-numbers.md
[05]: ./supporting-updatable-help.md
