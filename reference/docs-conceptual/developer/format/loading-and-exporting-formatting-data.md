---
ms.date: 09/13/2016
ms.topic: reference
title: Loading and Exporting Formatting Data
description: Loading and Exporting Formatting Data
---
# Loading and Exporting Formatting Data

Once you have created your formatting file, you need to update the format data of the session by loading your files into the current session. (The formatting files provided by Windows PowerShell are loaded by snap-ins that are registered when the current session is opened.) Once the format data of the current session is updated, Windows PowerShell uses that data to display the .NET objects associated with the views defined in the loaded formatting files. There is no limit to the number of formatting files that you can load into the current session. In addition to updating the formatting data, you can export the format data in the current session back to a formatting file.

## Loading format data

Formatting files can be loaded into the current session using the following methods:

- You can import the formatting file into the current session from the command line. Use the [Update-FormatData](/powershell/module/Microsoft.PowerShell.Utility/Update-FormatData) cmdlet as described in the following procedure.

- You can create a module manifest that references your formatting file. Modules allow you to package you formatting files for distribution. Use the [New-ModuleManifest](/powershell/module/Microsoft.PowerShell.Core/New-ModuleManifest) cmdlet to create the manifest, and the [Import-Module](/powershell/module/Microsoft.PowerShell.Core/Import-Module) cmdlet to load the module into the current session. For more information about modules, see [Writing a Windows PowerShell Module](../module/writing-a-windows-powershell-module.md).

- You can create a snap-in that references your formatting file. Use the [System.Management.Automation.PSSnapIn.Formats](/dotnet/api/System.Management.Automation.PSSnapIn.Formats) to reference your formatting files. It is strongly encouraged to use modules to package cmdlets, and any associated formatting and types files for distribution. For more information about modules, see [Writing a Windows PowerShell Module](../module/writing-a-windows-powershell-module.md).

- If you are invoking commands programmatically, you can add a formatting file entry to the initial session state of the runspace where the commands are run. For more information about .NET type used to add the formatting file, see the [System.Management.Automation.Runspaces.Sessionstateformatentry?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Runspaces.SessionStateFormatEntry) class.

When a formatting file is loaded, it is added to an internal list that Windows PowerShell uses to determine which view to use when displaying objects at the command line. You can prepend your formatting file to the beginning of the list, or you can append it to the end of the list. Knowing where your formatting file is added to this list is important if you are loading formatting file that defines a view for an object that has an existing view defined, such as when you want to change how an object that is returned by a Windows PowerShell core cmdlet is displayed. If you are loading a formatting file that defines the only view for an object, you can use any of the methods described previously.  If you are loading a formatting file that defines another view for an object, you must use the [Update-FormatData](/powershell/module/Microsoft.PowerShell.Utility/Update-FormatData) cmdlet and prepend your file to the beginning of the list.

## Storing Your Formatting File

There is no requirement for where your formatting files are stored on disk. However, it is strongly suggested that you store them in the following folder: `user\documents\windowspowershell\`

#### Loading a format file using Import-FormatData

1. Store your formatting file to disk.

2. Run the [Update-FormatData](/powershell/module/Microsoft.PowerShell.Utility/Update-FormatData) cmdlet using one of the following commands.

   To add your formatting file to the front of the list use this command. Use this command if you are changing how an object is displayed.

   ```powershell
   Update-FormatData -PrependPath PathToFormattingFile
   ```

   To add your formatting file to the end of the list use this command.

   ```powershell
   Update-FormatData -AppendPath PathToFormattingFile
   ```

   Once you have added a file using the [Update-FormatData](/powershell/module/Microsoft.PowerShell.Utility/Update-FormatData) cmdlet, you cannot remove the file from the list while the session is open. You must close the session to remove the formatting file from the list.

## Exporting format data

Insert section body here.
