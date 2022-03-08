---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 05/14/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/move-item?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Move-Item
---
# Move-Item

## SYNOPSIS
Moves an item from one location to another.

## SYNTAX

### Path (Default)

```
Move-Item [-Path] <String[]> [[-Destination] <String>] [-Force] [-Filter <String>] [-Include <String[]>]
 [-Exclude <String[]>] [-PassThru] [-Credential <PSCredential>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### LiteralPath

```
Move-Item -LiteralPath <String[]> [[-Destination] <String>] [-Force] [-Filter <String>] [-Include <String[]>]
 [-Exclude <String[]>] [-PassThru] [-Credential <PSCredential>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Move-Item` cmdlet moves an item, including its properties, contents, and child items, from one
location to another location. The locations must be supported by the same provider.
For example, it can move a file or subdirectory from one directory to another or move a registry
subkey from one key to another.
When you move an item, it is added to the new location and deleted from its original location.

## EXAMPLES

### Example 1: Move a file to another directory and rename it

This command moves the `Test.txt` file from the `C:` drive to the `E:\Temp` directory and renames it
from `test.txt` to `tst.txt`.

```powershell
Move-Item -Path C:\test.txt -Destination E:\Temp\tst.txt
```

### Example 2: Move a directory and its contents to another directory

This command moves the `C:\Temp` directory and its contents to the `C:\Logs` directory.
The "Temp" directory, and all of its subdirectories and files, then appear in the "Logs" directory.

```powershell
Move-Item -Path C:\Temp -Destination C:\Logs
```

### Example 3: Move all files of a specified extension from the current directory to another directory

This command moves all of the text files (`*.txt`) in the current directory (represented by a dot
(`.`)) to the `C:\Logs` directory.

```powershell
Move-Item -Path .\*.txt -Destination C:\Logs
```

### Example 4: Recursively move all files of a specified extension from the current directory to another directory

This command moves all of the text files from the current directory and all subdirectories,
recursively, to the "C:\TextFiles" directory.

```powershell
Get-ChildItem -Path ".\*.txt" -Recurse | Move-Item -Destination "C:\TextFiles"
```

The command uses the `Get-ChildItem` cmdlet to get all of the child items in the current directory
(represented by the dot \[.\]) and its subdirectories that have a "*.txt" file name extension.
It uses the **Recurse** parameter to make the retrieval recursive and the Include parameter to limit
the retrieval to "*.txt" files.

The pipeline operator (`|`) sends the results of this command to `Move-Item`, which moves the text
files to the "TextFiles" directory.

If files that are to be moved to "C:\Textfiles" have the same name, `Move-Item` displays an error
and continues, but it moves only one file with each name to "C:\Textfiles".
The other files remain in their original directories.

If the "Textfiles" directory (or any other element of the destination path) does not exist, the
command fails.
The missing directory is not created for you, even if you use the **Force** parameter.
`Move-Item` moves the first item to a file called "Textfiles" and then displays an error explaining
that the file already exists.

Also, by default, `Get-ChildItem` does not move hidden files.
To move hidden files, use the **Force** parameter with `Get-ChildItem`.

> [!NOTE]
> In Windows PowerShell 2.0, when using the **Recurse** parameter of the `Get-ChildItem` cmdlet, the
> value of the **Path** parameter must be a container.
> Use the **Include** parameter to specify the .txt file name extension filter
> (`Get-ChildItem -Path .\* -Include *.txt -Recurse | Move-Item -Destination C:\TextFiles`).

### Example 5: Move registry keys and values to another key

This command moves the registry keys and values within the "MyCompany" registry key in
`HKLM\Software` to the "MyNewCompany" key.
The wildcard character (`*`) indicates that the contents of the "MyCompany" key should be moved, not
the key itself.
In this command, the optional **Path** and **Destination** parameter names are omitted.

```powershell
Move-Item "HKLM:\software\mycompany\*" "HKLM:\software\mynewcompany"
```

### Example 6: Move a directory and its contents to a subdirectory of the specified directory

This command moves the "Logs\[Sept\`06\]" directory (and its contents) into the "Logs\[2006\]"
directory.

```powershell
Move-Item -LiteralPath 'Logs[Sept`06]' -Destination 'Logs[2006]'
```

The **LiteralPath** parameter is used instead of **Path**, because the original directory name
includes left bracket and right bracket characters ("\[" and "\]").
The path is also enclosed in single quotation marks (' '), so that the backtick symbol (\`) is not
misinterpreted.

The **Destination** parameter does not require a literal path, because the Destination variable also
must be enclosed in single quotation marks, because it includes brackets that can be misinterpreted.

## PARAMETERS

### -Credential

> [!NOTE]
> This parameter is not supported by any providers installed with PowerShell.
> To impersonate another user, or elevate your credentials when running this cmdlet,
> use [Invoke-Command](../Microsoft.PowerShell.Core/Invoke-Command.md).

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Current user
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Destination

Specifies the path to the location where the items are being moved.
The default is the current directory.
Wildcards are permitted, but the result must specify a single location.

To rename the item being moved, specify a new name in the value of the **Destination** parameter.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Current directory
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Exclude

Specifies, as a string array, an item or items that this cmdlet excludes in the operation. The value
of this parameter qualifies the **Path** parameter. Enter a path element or pattern, such as
`*.txt`. Wildcard characters are permitted. The **Exclude** parameter is effective only when the
command includes the contents of an item, such as `C:\Windows\*`, where the wildcard character
specifies the contents of the `C:\Windows` directory.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Filter

Specifies a filter to qualify the **Path** parameter. The [FileSystem](../Microsoft.PowerShell.Core/About/about_FileSystem_Provider.md)
provider is the only installed PowerShell provider that supports the use of filters. You can find
the syntax for the **FileSystem** filter language in [about_Wildcards](../Microsoft.PowerShell.Core/About/about_Wildcards.md).
Filters are more efficient than other parameters, because the provider applies them when the cmdlet
gets the objects rather than having PowerShell filter the objects after they are retrieved.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Force

Forces the command to run without asking for user confirmation.
Implementation varies from provider to provider.
For more information, see [about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Include

Specifies, as a string array, an item or items that this cmdlet includes in the operation. The value
of this parameter qualifies the **Path** parameter. Enter a path element or pattern, such as
`"*.txt"`. Wildcard characters are permitted. The **Include** parameter is effective only when the
command includes the contents of an item, such as `C:\Windows\*`, where the wildcard character
specifies the contents of the `C:\Windows` directory.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -LiteralPath

Specifies a path to one or more locations. The value of **LiteralPath** is used exactly as it is
typed. No characters are interpreted as wildcards. If the path includes escape characters, enclose
it in single quotation marks. Single quotation marks tell PowerShell not to interpret any characters
as escape sequences.

For more information, see [about_Quoting_Rules](../Microsoft.Powershell.Core/About/about_Quoting_Rules.md).

```yaml
Type: System.String[]
Parameter Sets: LiteralPath
Aliases: PSPath, LP

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru

Returns an object representing the item with which you are working.
By default, this cmdlet does not generate any output.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the path to the current location of the items.
The default is the current directory.
Wildcard characters are permitted.

```yaml
Type: System.String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 0
Default value: Current directory
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`,
`-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`,
`-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.String

You can pipe a string that contains a path to this cmdlet.

## OUTPUTS

### None or an object representing the moved item

When you use the *PassThru* parameter, this cmdlet generates an object representing the moved item.
Otherwise, this cmdlet does not generate any output.

## NOTES

- This cmdlet will move files between drives that are supported by the same provider, but it will move
  directories only within the same drive.
- Because a `Move-Item` command moves the properties, contents, and child items of an item, all moves
  are recursive by default.
- This cmdlet is designed to work with the data exposed by any provider.
  To list the providers available in your session, type `Get-PSProvider`.
  For more information, see [about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

## RELATED LINKS

[Clear-Item](Clear-Item.md)

[Copy-Item](Copy-Item.md)

[Get-Item](Get-Item.md)

[Invoke-Item](Invoke-Item.md)

[New-Item](New-Item.md)

[Remove-Item](Remove-Item.md)

[Rename-Item](Rename-Item.md)

[Set-Item](Set-Item.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)

