---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 02/14/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/remove-item?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Remove-Item
---

# Remove-Item

## SYNOPSIS
Deletes the specified items.

## SYNTAX

### Path (Default) - FileSystem provider

```
Remove-Item [-Path] <String[]> [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>]
 [-Recurse] [-Force] [-Credential <PSCredential>] [-WhatIf] [-Confirm] [-Stream <String[]>]
 [<CommonParameters>]
```

### LiteralPath - FileSystem provider

```
Remove-Item -LiteralPath <String[]> [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>]
 [-Recurse] [-Force] [-Credential <PSCredential>] [-WhatIf] [-Confirm] [-Stream <String[]>]
 [<CommonParameters>]
```

### Path (Default) - Certificate provider

```
Remove-Item [-Path] <String[]> [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>]
 [-Recurse] [-Force] [-Credential <PSCredential>] [-WhatIf] [-Confirm] [-DeleteKey]
 [<CommonParameters>]
```

### LiteralPath - Certificate provider

```
Remove-Item -LiteralPath <String[]> [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>]
 [-Recurse] [-Force] [-Credential <PSCredential>] [-WhatIf] [-Confirm] [-DeleteKey]
 [<CommonParameters>]
```

### Path (Default) - All providers

```
Remove-Item [-Path] <string[]> [-Filter <string>] [-Include <string[]>] [-Exclude <string[]>]
 [-Recurse] [-Force] [-Credential <pscredential>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### LiteralPath - All providers

```
Remove-Item -LiteralPath <string[]> [-Filter <string>] [-Include <string[]>] [-Exclude <string[]>]
 [-Recurse] [-Force] [-Credential <pscredential>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Remove-Item` cmdlet deletes one or more items. Because it's supported by many providers, it
can delete many different types of items, including files, folders, registry keys, variables,
aliases, and functions.

## EXAMPLES

### Example 1: Delete files that have any file extension

This example deletes all files with names that include a dot (`.`) from the `C:\Test` folder.
Because the command specifies a dot, the command doesn't delete folders or files that have no
file extension.

```powershell
Remove-Item C:\Test\*.*
```

### Example 2: Delete document files in a folder

This example deletes from the current folder all files that have a `.doc` file extension and a
name that doesn't include `*1*`.

```powershell
Remove-Item * -Include *.doc -Exclude *1*
```

It uses the wildcard character (`*`) to specify the contents of the current folder. It uses the
**Include** and **Exclude** parameters to specify the files to delete.

### Example 3: Delete hidden, read-only files

This command deletes a file that's both _hidden_ and _read-only_.

```powershell
Remove-Item -Path C:\Test\hidden-RO-file.txt -Force
```

It uses the **Path** parameter to specify the file. It uses the **Force**
parameter to delete it. Without **Force**, you can't delete _read-only_ or
_hidden_ files.

### Example 4: Delete files in subfolders recursively

This command deletes all the CSV files in the current folder and all subfolders recursively.

Because the **Recurse** parameter in `Remove-Item` has a known issue, the command in this example
uses `Get-ChildItem` to get the desired files, and then uses the pipeline operator to pass them to
`Remove-Item`.

```powershell
Get-ChildItem * -Include *.csv -Recurse | Remove-Item
```

In the `Get-ChildItem` command, **Path** has a value of (`*`), which represents the contents of the
current folder. It uses **Include** to specify the CSV file type, and it uses **Recurse** to make
the retrieval recursive. If you try to specify the file type in the path, such as `-Path *.csv`, the
cmdlet interprets the subject of the search to be a file that has no child items, and **Recurse**
fails.

> [!NOTE]
> This behavior was fixed in Windows versions 1909 and up.

### Example 5: Delete subkeys recursively

This command deletes the "OldApp" registry key and all its subkeys and values. It uses `Remove-Item`
to remove the key. The path is specified, but the optional parameter name (**Path**) is omitted.

The **Recurse** parameter deletes all of the contents of the "OldApp" key recursively. If the key
contains subkeys and you omit the **Recurse** parameter, you are prompted to confirm that you want
to delete the contents of the key.

```powershell
Remove-Item HKLM:\Software\MyCompany\OldApp -Recurse
```

### Example 6: Deleting files with special characters

The following example shows how to delete files that contain special characters like brackets or
parentheses.

```powershell
Get-ChildItem
```

```Output
    Directory: C:\temp\Downloads

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a---          6/1/2018  12:19 PM           1362 myFile.txt
-a---          6/1/2018  12:30 PM           1132 myFile[1].txt
-a---          6/1/2018  12:19 PM           1283 myFile[2].txt
-a---          6/1/2018  12:19 PM           1432 myFile[3].txt

```

```powershell
Get-ChildItem | Where-Object Name -Like '*`[*'
```

```Output
    Directory: C:\temp\Downloads

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a---          6/1/2018  12:30 PM           1132 myFile[1].txt
-a---          6/1/2018  12:19 PM           1283 myFile[2].txt
-a---          6/1/2018  12:19 PM           1432 myFile[3].txt

```

```powershell
Get-ChildItem | Where-Object Name -Like '*`[*' | ForEach-Object { Remove-Item -LiteralPath $_.Name }
Get-ChildItem
```

```Output
    Directory: C:\temp\Downloads

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a---          6/1/2018  12:19 PM           1362 myFile.txt
```

### Example 7: Remove an alternate data stream

This example shows how to use the **Stream** dynamic parameter of the `Remove-Item` cmdlet to delete
an alternate data stream. The stream parameter is introduced in Windows PowerShell 3.0.

```powershell
Get-Item C:\Test\Copy-Script.ps1 -Stream Zone.Identifier
```

```Output
   FileName: \\C:\Test\Copy-Script.ps1

Stream                   Length
------                   ------
Zone.Identifier              26

```

```powershell
Remove-Item C:\Test\Copy-Script.ps1 -Stream Zone.Identifier
Get-Item C:\Test\Copy-Script.ps1 -Stream Zone.Identifier
```

```Output
Get-Item : Could not open alternate data stream 'Zone.Identifier' of file 'C:\Test\Copy-Script.ps1'.
```

The **Stream** parameter `Get-Item` gets the `Zone.Identifier` stream of the `Copy-Script.ps1`
file. `Remove-Item` uses the **Stream** parameter to remove the `Zone.Identifier` stream of the
file. Finally, the `Get-Item` cmdlet shows that the `Zone.Identifier` stream was deleted.

## PARAMETERS

### -Credential

> [!NOTE]
> This parameter isn't supported by any providers installed with PowerShell.
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

### -DeleteKey

This is a dynamic parameter made available by the **Certificate** provider. The **Certificate**
provider and this parameter are only available on Windows platforms.

When provided, the cmdlet deletes the private key when the certificate is deleted.

For more information, see
[about_Certificate_Provider](../Microsoft.PowerShell.Security/About/about_Certificate_Provider.md).

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

### -Exclude

Specifies, as a string array, an item or items that this cmdlet excludes in the operation. The value
of this parameter qualifies the **Path** parameter. Enter a path element or pattern, such as
`*.txt`. Wildcard characters are permitted. The **Exclude** parameter is effective only when the
command includes the contents of an item, such as `C:\Windows\*`, where the wildcard character
specifies the contents of the `C:\Windows` directory.

When using **Recurse** with **Exclude**, **Exclude** only filters results of the current directory.
If there are files that match the **Exclude** pattern in subfolders, those files are removed along
with its parent directory.

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

Specifies a filter to qualify the **Path** parameter. The
[FileSystem](../Microsoft.PowerShell.Core/About/about_FileSystem_Provider.md) provider is the only
installed PowerShell provider that supports the use of filters. You can find the syntax for the
**FileSystem** filter language in
[about_Wildcards](../Microsoft.PowerShell.Core/About/about_Wildcards.md). Filters are more efficient
than other parameters, because the provider applies them when the cmdlet gets the objects rather
than having PowerShell filter the objects after they're retrieved.

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

Forces the cmdlet to remove items that can't otherwise be changed, such as hidden or read-only
files or read-only aliases or variables. The cmdlet can't remove constant aliases or variables.
Implementation varies from provider to provider. For more information, see
[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md). Even using the **Force**
parameter, the cmdlet can't override security restrictions.

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

Specifies a path to one or more locations. The value of **LiteralPath** is used exactly as it's
typed. No characters are interpreted as wildcards. If the path includes escape characters, enclose
it in single quotation marks. Single quotation marks tell PowerShell not to interpret any characters
as escape sequences.

For more information, see
[about_Quoting_Rules](../Microsoft.Powershell.Core/About/about_Quoting_Rules.md).

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

### -Path

Specifies a path of the items being removed.
Wildcard characters are permitted.

```yaml
Type: System.String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -Recurse

Indicates that this cmdlet deletes the items in the specified locations and in all child items of
the locations.

The **Recurse** parameter might not delete all subfolders or all child items. This is a known issue.

> [!NOTE]
> This behavior was fixed in Windows versions 1909 and newer.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Stream

This is a dynamic parameter made available by the **FileSystem** provider. This parameter is only
available on Windows. This parameter can't be used in combination with the **Recurse** parameter.

You can use `Remove-Item` to delete an alternative data stream, such as `Zone.Identifier`.
However, it isn't the recommended way to eliminate security checks that block files that are
downloaded from the Internet. If you verify that a downloaded file is safe, use the `Unblock-File`
cmdlet.

This parameter was introduced in Windows PowerShell 3.0. As of Windows PowerShell 7.2, `Remove-Item`
can remove alternative data streams from directories as well as files.

For more information, see
[about_FileSystem_Provider](../Microsoft.PowerShell.Core/About/about_FileSystem_Provider.md).

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

### -Confirm

Prompts you for confirmation before running the cmdlet. For more information, see the following
articles:

- [about_Preference_Variables](../microsoft.powershell.core/about/about_preference_variables.md#confirmpreference)
- [about_Functions_CmdletBindingAttribute](../microsoft.powershell.core/about/about_functions_cmdletbindingattribute.md?#confirmimpact)

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

Shows what would happen if the cmdlet runs. The cmdlet isn't run.

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
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string that contains a path, but not a literal path, to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

PowerShell includes the following aliases for `Remove-Item`:

- All platforms:
  - `del`
  - `erase`
  - `rd`
  - `ri`
- Windows:
  - `rm`
  - `rmdir`

The `Remove-Item` cmdlet is designed to work with the data exposed by any provider. To list the
providers available in your session, type `Get-PsProvider`. For more information, see
[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

When you try to delete a folder that contains items without using the **Recurse** parameter, the
cmdlet prompts for confirmation. Using `-Confirm:$false` doesn't suppress the prompt. This is by
design.

## RELATED LINKS

[Clear-Item](Clear-Item.md)

[Copy-Item](Copy-Item.md)

[Get-Item](Get-Item.md)

[Invoke-Item](Invoke-Item.md)

[Move-Item](Move-Item.md)

[New-Item](New-Item.md)

[Remove-ItemProperty](Remove-ItemProperty.md)

[Rename-Item](Rename-Item.md)

[Set-Item](Set-Item.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)

[about_Preference_Variables](../microsoft.powershell.core/about/about_preference_variables.md#confirmpreference)

[about_Functions_CmdletBindingAttribute](../microsoft.powershell.core/about/about_functions_cmdletbindingattribute.md?#confirmimpact)
