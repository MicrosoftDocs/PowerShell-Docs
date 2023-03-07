---
description: Loading and Exporting Formatting Data
ms.date: 08/23/2021
ms.topic: reference
title: Loading and Exporting Formatting Data
---
# Loading and Exporting Formatting Data

Once you've created your formatting file, you need to update the format data of the session by
loading your files into the current session. PowerShell loads a predefined set of formats. Once the
format data of the current session is updated, PowerShell uses that data to display the .NET objects
associated with the views defined in the loaded formats. There's no limit to the number of formats
that you can load into the current session. You can also export the format data in the current
session back to a formatting file.

## Loading format data

Formatting files can be loaded into the current session using the following methods:

- You can import the formatting file into the current session from the command line. Use the
  [Update-FormatData][06] cmdlet as described in the following procedure.

- You can create a module manifest that references your formatting file. Modules allow you to
  package your formatting files for distribution. Use the [New-ModuleManifest][03] cmdlet to create
  the manifest, and the [Import-Module][02] cmdlet to load the module into the current session. For
  more information about modules, see [Writing a Windows PowerShell Module][01].

- You can create a snap-in that references your formatting file. Use the
  [System.Management.Automation.PSSnapIn.Formats][07] to reference your formatting files. However,
  best practice recommendation is to use modules to package cmdlets and associated formatting and
  types files.

- If you're invoking commands programmatically, you can add formatting files to the initial session
  state of the runspace where the commands are run. For more information, see the
  [System.Management.Automation.Runspaces.SessionStateFormatEntry][08] class.

When a formatting file is loaded, it's added to an internal list that PowerShell uses to choose the
view used when displaying objects in the host. You can prepend your formatting file to the beginning
of the list, or you can append it to the end of the list.

Knowing where your formatting file is added to this list is important.

- If you're loading a formatting file that defines the only view for an object, you can use any of
  the methods described previously.

- If you're loading a formatting file that defines a view for an object that has an existing view
  defined, it must be added to the beginning of the list. You must use the [Update-FormatData][06]
  cmdlet and prepend your file to the beginning of the list.

## Storing Your Formatting File

You can store formatting files anywhere on disk. However, it's recommended that you store them in
the same folder as your profile script.

Use the following command to determine the location of your profile script.

```powershell
Split-Path -Path $PROFILE -Parent
```

### Loading a format file

1. Store your formatting file to disk.

1. Run the [Update-FormatData][06] cmdlet using one of the following commands.

   If you're changing how an object is displayed, use the following command to add your formatting
   file to the front of the list.

   ```powershell
   Update-FormatData -PrependPath PathToFormattingFile
   ```

   Use the following command to add your formatting file to the end of the list.

   ```powershell
   Update-FormatData -AppendPath PathToFormattingFile
   ```

   > [!NOTE]
   > Once format data has been loaded in a session it can't be removed. You must open a new session
   > without the format data loaded.

## Exporting format data

PowerShell includes format definitions for many .NET types. You can use the [Get-FormatData][05]
cmdlet to view the format data that's loaded in the current session. You can export the format data
for a type to a file using the [Export-FormatData][04] cmdlet.

The following commands export the format data for the `System.Guid` type to a file named
`System.Guid.format.ps1xml` in the current directory.

```powershell
Get-FormatData System.Guid | Export-FormatData -Path ./System.Guid.format.ps1xml
Get-Content ./System.Guid.format.ps1xml
```

```Output
<?xml version="1.0" encoding="utf-8"?>
<Configuration>
  <ViewDefinitions>
    <View>
      <Name>System.Guid</Name>
      <ViewSelectedBy>
        <TypeName>System.Guid</TypeName>
      </ViewSelectedBy>
      <TableControl>
        <TableHeaders />
        <TableRowEntries>
          <TableRowEntry>
            <TableColumnItems>
              <TableColumnItem>
                <PropertyName>Guid</PropertyName>
              </TableColumnItem>
            </TableColumnItems>
          </TableRowEntry>
        </TableRowEntries>
      </TableControl>
    </View>
  </ViewDefinitions>
</Configuration>
```

You can edit the exported file create a custom format definition for that type.

<!-- link references -->
[01]: ../module/writing-a-windows-powershell-module.md
[02]: xref:Microsoft.PowerShell.Core.Import-Module
[03]: xref:Microsoft.PowerShell.Core.New-ModuleManifest
[04]: xref:Microsoft.PowerShell.Utility.Export-FormatData
[05]: xref:Microsoft.PowerShell.Utility.Get-FormatData
[06]: xref:Microsoft.PowerShell.Utility.Update-FormatData
[07]: xref:System.Management.Automation.PSSnapIn.Formats
[08]: xref:System.Management.Automation.Runspaces.SessionStateFormatEntry
