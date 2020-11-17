---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/update-formatdata?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Update-FormatData
---

# Update-FormatData

## SYNOPSIS
Updates the formatting data in the current session.

## SYNTAX

```
Update-FormatData [[-AppendPath] <String[]>] [-PrependPath <String[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Update-FormatData` cmdlet reloads the formatting data from formatting files into the current
session. This cmdlet lets you update the formatting data without restarting PowerShell.

Without parameters, `Update-FormatData` reloads the formatting files that it loaded previously.
You can use the parameters of `Update-FormatData` to add new formatting files to the session.

Formatting files are text files in XML format with the `format.ps1xml` file name extension. The
formatting data in the files defines the display of Microsoft .NET Framework objects in the session.

When PowerShell starts, it loads the format data from the PowerShell source code. However, you can
create custom format.ps1xml files to update formatting in the current session. You can use
`Update-FormatData` to reload the formatting data into the current session without restarting
PowerShell. This is useful when you have added or changed a formatting file, but do not want to
interrupt the session.

For more information about formatting files in PowerShell, see [about_Format.ps1xml](../Microsoft.PowerShell.Core/About/about_Format.ps1xml.md).

## EXAMPLES

### Example 1: Reload previously loaded formatting files

```powershell
Update-FormatData
```

This command reloads the formatting files that it loaded previously.

### Example 2: Reload formatting files and trace and log formatting files

```powershell
Update-FormatData -AppendPath "trace.format.ps1xml, log.format.ps1xml"
```

This command reloads the formatting files into the session, including two new files,
Trace.format.ps1xml and Log.format.ps1xml.

Because the command uses the **AppendPath** parameter, the formatting data in the new files is loaded
after the formatting data from the built-in files.

The **AppendPath** parameter is used because the new files contain formatting data for objects that
are not referenced in the built-in files.

### Example 3: Edit a formatting file and reload it

```powershell
Update-FormatData -PrependPath "c:\test\NewFiles.format.ps1xml"

# Edit the NewFiles.format.ps1 file.

Update-FormatData
```

This example shows how to reload a formatting file after you have edited it.

The first command adds the NewFiles.format.ps1xml file to the session. It uses the **PrependPath**
parameter because the file contains formatting data for objects that are referenced in the built-in
files.

After adding the NewFiles.format.ps1xml file and testing it in these sessions, the author edits the
file.

The second command uses the `Update-FormatData` cmdlet to reload the formatting files. Because the
NewFiles.format.ps1xml file was previously loaded, `Update-FormatData` automatically reloads it
without using parameters.

## PARAMETERS

### -AppendPath

Specifies formatting files that this cmdlet adds to the session. The files are loaded after
PowerShell loads the built-in formatting files.

When formatting .NET objects, PowerShell uses the first formatting definition that it finds for each
.NET type. If you use the **AppendPath** parameter, PowerShell searches the data from the built-in
files before it encounters the formatting data that you are adding.

Use this parameter to add a file that formats a .NET object that is not referenced in the built-in
formatting files.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: PSPath, Path

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -PrependPath

Specifies formatting files that this cmdlet adds to the session. The files are loaded before
PowerShell loads the built-in formatting files.

When formatting .NET objects, PowerShell uses the first formatting definition that it finds for each
.NET type. If you use the **PrependPath** parameter, PowerShell searches the data from the files that
you are adding before it encounters the formatting data from the built-in files.

Use this parameter to add a file that formats a .NET object that is also referenced in the built-in
formatting files.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string that contains the append path to `Update-FormatData`.

## OUTPUTS

### None

The cmdlet does not return any output.

## NOTES

- `Update-FormatData` also updates the formatting data for commands in the session that were
  imported from modules. If the formatting file for a module changes, you can run an
  `Update-FormatData` command to update the formatting data for imported commands. You do not need
  to import the module again.

## RELATED LINKS

[Get-FormatData](Get-FormatData.md)

[Export-FormatData](Export-FormatData.md)
