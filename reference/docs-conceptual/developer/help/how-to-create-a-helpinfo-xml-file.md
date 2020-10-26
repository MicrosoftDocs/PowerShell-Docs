---
ms.date: 09/13/2016
ms.topic: reference
title: How to Create a HelpInfo XML File
description: How to Create a HelpInfo XML File
---
# How to Create a HelpInfo XML File

This topics in this section explains how to create and populate a help information file, commonly
known as a "HelpInfo XML file," for the PowerShell Updatable Help feature.

## HelpInfo XML File Overview

The HelpInfo XML file is the primary source of information about Updatable Help for the module. It
includes the location of the help files for the modules, the supported UI cultures, and the version
numbers that Updatable Help uses to determine whether the user has the newest help files.

Each module has just one HelpInfo XML file, even if the module includes multiple help files for
multiple UI cultures. The module author creates the HelpInfo XML file and places it in the internet
location that is specified by the **HelpInfoUri** key in the module manifest. When the module help
files are updated and uploaded, the module author updates the HelpInfo XML file and replaces the
original HelpInfo XML file with the new version.

It is critical that the HelpInfo XML file is carefully maintained. If you upload new files, but
forget to increment the version numbers, Updatable Help will not download the new files to users'
computers. if you add help files for a new UI culture, but don't update the HelpInfo XML file or
place it in the correct location, Updatable Help will not download the new files.

## In this section

This section includes the following topics.

- [HelpInfo XML Schema](./helpinfo-xml-schema.md)

- [HelpInfo XML Sample File](./helpinfo-xml-sample-file.md)

- [How to Name a HelpInfo XML File](./how-to-name-a-helpinfo-xml-file.md)

- [How to Set HelpInfo XML Version Numbers](./how-to-set-helpinfo-xml-version-numbers.md)

## See Also

[Supporting Updatable Help](./supporting-updatable-help.md)
