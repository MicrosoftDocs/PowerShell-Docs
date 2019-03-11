---
title: "How Updatable Help Works | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 7674636e-a0f2-4587-bfc5-dd3e6ce5489e
caps.latest.revision: 6
---
# How Updatable Help Works

This topic explains how Updatable Help processes the HelpInfo XML file and CAB files for each module, and installs updated help for users.

## The Update-Help Process

The following list describes the actions of the [Update-Help](/powershell/module/Microsoft.PowerShell.Core/Update-Help) cmdlet when a user runs a command to update the help files for a module in a particular UI culture.

1. `Update-Help` gets the remote HelpInfo XML file from the location specified by the value of the **HelpInfoURI** key in the module manifest and validates the file against the schema. (To view the schema, see [HelpInfo XML Schema](./helpinfo-xml-schema.md).) Then `Update-Help` looks for a local HelpInfo XML file for the module in the module directory on the user's computer.

2. `Update-Help` compares the version number of the help files for the specified UI culture in the remote and local HelpInfo XML files for the module. If the version number on the remote file is greater than version number on the local file, or if the there is no local HelpInfo XML file for the module, `Update-Help` prepares to download new help files.

3. `Update-Help` selects the CAB file for the module from the location specified by the **HelpContentUri** element in the remote HelpInfo XML file. It uses the module name, module GUID, and UI culture to identify the CAB file.

4. `Update-Help` downloads the CAB file, unpacks it, validates the help content files, and saves the help content files in the language-specific subdirectory of the module directory on the user's computer.

5. `Update-Help` creates a local HelpInfo XML file by copying the remote HelpInfo XML file. It edits the local HelpInfo XML file so that it includes elements only for the CAB file that it installed. Then it saves the local HelpInfo XML file in the module directory and concludes the update.

## The Save-Help Process

The following list describes the actions of the [Save-Help](/powershell/module/Microsoft.PowerShell.Core/Save-Help) and [Update-Help](/powershell/module/Microsoft.PowerShell.Core/Update-Help) cmdlets when a user runs commands to update the help files in a file share, and then use those files to update the help files on the user's computer.

The `Save-Help` cmdlet performs the following actions in response to a command to save the help files for a module in a file share that is specified by the **DestinationPath** parameter.

1. `Save-Help` gets  the remote HelpInfo XML file from the location specified by the value of the **HelpInfoURI** key in the module manifest and validates the file against the schema. (To view the schema, see [HelpInfo XML Schema](./helpinfo-xml-schema.md).) Then `Save-Help` looks for a local HelpInfo XML file in the directory that is specified by the **DestinationPath** parameter in the `Save-Help` command.

2. `Save-Help` compares the version number of the help files for the specified UI culture in the remote and local HelpInfo XML files for the module. If the version number on the remote file is greater than version number on the local file, or if the there is no local HelpInfo XML file for the module in the **DestinationPath** directory, `Save-Help` prepares to download new help files.

3. `Save-Help` selects the CAB file for the module from the location specified by the **HelpContentUri** element in the remote HelpInfo XML file. It uses the module name, module GUID, and UI culture to identify the CAB file.

4. `Save-Help` downloads the CAB file and saves it in the **DestinationPath** directory. (It does not create any language-specific subdirectories.)

5. `Save-Help` creates a local HelpInfo XML file by copying the remote HelpInfo XML file. It edits the local HelpInfo XML file so that it includes elements only for the CAB file that it saved. Then it saves the local HelpInfo XML file in the  **DestinationPath** directory and concludes the update.

   The `Update-Help` cmdlet performs the following actions in response to a command to update the help files on a user's computer from the files in a file share that is specified by the **SourcePath** parameter.

1. `Update-Help` gets the remote HelpInfo XML file from the **SourcePath** directory. Then it looks for a local HelpInfo XML file in the module directory on the user's computer.

2. `Update-Help` compares the version number of the help files for the specified UI culture in the remote and local HelpInfo XML files for the module. If the version number on the remote file is greater than version number on the local file, or if the there is no local HelpInfo XML file, `Update-Help` prepares to install new help files.

3. `Update-Help` selects the CAB file for the module from **SourcePath** directory. It uses the module name, module GUID, and UI culture to identify the CAB file.

4. `Update-Help` unpacks the CAB file, validates the help content files, and saves the help content files in the language-specific subdirectory of the module directory on the user's computer.

5. `Update-Help` creates a local HelpInfo XML file by copying the remote HelpInfo XML file. It edits the local HelpInfo XML file so that it includes elements only for the CAB file that it installed. Then it saves the local HelpInfo XML file in the module directory and concludes the update.