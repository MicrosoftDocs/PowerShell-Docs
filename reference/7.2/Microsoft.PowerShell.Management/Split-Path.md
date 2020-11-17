---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/split-path?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Split-Path
---
# Split-Path

## SYNOPSIS
Returns the specified part of a path.

## SYNTAX

### ParentSet (Default)

```
Split-Path [-Path] <String[]> [-Parent] [-Resolve] [-Credential <PSCredential>]
 [<CommonParameters>]
```

### LeafSet

```
Split-Path [-Path] <String[]> -Leaf [-Resolve] [-Credential <PSCredential>] [<CommonParameters>]
```

### LeafBaseSet

```
Split-Path [-Path] <String[]> -LeafBase [-Resolve] [-Credential <PSCredential>]
 [<CommonParameters>]
```

### ExtensionSet

```
Split-Path [-Path] <String[]> -Extension [-Resolve] [-Credential <PSCredential>]
 [<CommonParameters>]
```

### QualifierSet

```
Split-Path [-Path] <String[]> -Qualifier [-Resolve] [-Credential <PSCredential>]
 [<CommonParameters>]
```

### NoQualifierSet

```
Split-Path [-Path] <String[]> -NoQualifier [-Resolve] [-Credential <PSCredential>]
 [<CommonParameters>]
```

### IsAbsoluteSet

```
Split-Path [-Path] <String[]> [-Resolve] -IsAbsolute [-Credential <PSCredential>]
 [<CommonParameters>]
```

### LiteralPathSet

```
Split-Path -LiteralPath <String[]> [-Resolve] [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION

The `Split-Path` cmdlet returns only the specified part of a path, such as the parent folder, a
subfolder, or a file name. It can also get items that are referenced by the split path and tell
whether the path is relative or absolute.

You can use this cmdlet to get or submit only a selected part of a path.

## EXAMPLES

### Example 1: Get the qualifier of a path

```powershell
Split-Path -Path "HKCU:\Software\Microsoft" -Qualifier
```

```Output
HKCU:
```

This command returns only the qualifier of the path. The qualifier is the drive.

### Example 2: Display file names

```powershell
Split-Path -Path "C:\Test\Logs\*.log" -Leaf -Resolve
```

```Output
Pass1.log
Pass2.log
...
```

This command displays the files that are referenced by the split path. Because this path is split to
the last item, also known as the leaf, the command displays only the file names.

The **Resolve** parameter tells `Split-Path` to display the items that the split path references,
instead of displaying the split path.

Like all `Split-Path` commands, this command returns strings. It does not return **FileInfo**
objects that represent the files.

### Example 3: Get the parent container

```powershell
Split-Path -Path "C:\WINDOWS\system32\WindowsPowerShell\V1.0\about_*.txt"
```

```Output
C:\WINDOWS\system32\WindowsPowerShell\V1.0
```

This command returns only the parent containers of the path. Because it does not include any
parameters to specify the split, `Split-Path` uses the split location default, which is **Parent**.

### Example 4: Determines whether a path is absolute

```powershell
Split-Path -Path ".\My Pictures\*.jpg" -IsAbsolute
```

```Output
False
```

This command determines whether the path is relative or absolute. In this case, because the path is
relative to the current folder, which is represented by a dot (`.`), it returns `$False`.

### Example 5: Change location to a specified path

```powershell
PS C:\> Set-Location (Split-Path -Path $profile)
PS C:\Documents and Settings\User01\My Documents\WindowsPowerShell>
```

This command changes your location to the folder that contains the PowerShell profile.

The command in parentheses uses `Split-Path` to return only the parent of the path stored in the
built-in `$Profile` variable. The **Parent** parameter is the default split location parameter.
Therefore, you can omit it from the command. The parentheses direct PowerShell to run the command
first. This is a useful way to move to a folder that has a long path name.

### Example 6: Split a path by using the pipeline

```powershell
'C:\Documents and Settings\User01\My Documents\My Pictures' | Split-Path
```

```Output
C:\Documents and Settings\User01\My Documents
```

This command uses a pipeline operator (`|`) to send a path to `Split-Path`. The path is enclosed in
quotation marks to indicate that it is a single token.

## PARAMETERS

### -Credential

> [!NOTE]
> This parameter is not supported by any providers installed with PowerShell. To impersonate another
> user, or elevate your credentials when running this cmdlet, use [Invoke-Command](../Microsoft.PowerShell.Core/Invoke-Command.md).

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Extension

Indicates that this cmdlet returns only the extension of the leaf. For example, in the path
`C:\Test\Logs\Pass1.log`, it returns only `.log`.

This parameter was introduced in PowerShell 6.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: ExtensionSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IsAbsolute

Indicates that this cmdlet returns $True if the path is absolute and $False if it is relative. An
absolute path has a length greater than zero and does not use a dot (`.`) to indicate the current
path.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: IsAbsoluteSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Leaf

Indicates that this cmdlet returns only the last item or container in the path. For example, in the
path `C:\Test\Logs\Pass1.log`, it returns only Pass1.log.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: LeafSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LeafBase

Indicates that this cmdlet returns only base name of the leaf. For example, in the path
`C:\Test\Logs\Pass1.log`, it returns only `Pass1`.

This parameter was introduced in PowerShell 6.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: LeafBaseSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LiteralPath

Specifies the paths to be split. Unlike **Path**, the value of **LiteralPath** is used exactly as it is
typed. No characters are interpreted as wildcard characters. If the path includes escape characters,
enclose it in single quotation marks. Single quotation marks tell PowerShell not to interpret any
characters as escape sequences.

```yaml
Type: System.String[]
Parameter Sets: LiteralPathSet
Aliases: PSPath, LP

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NoQualifier

Indicates that this cmdlet returns the path without the qualifier. For the FileSystem or registry
providers, the qualifier is the drive of the provider path, such as `C:` or `HKCU:`. For example, in the
path `C:\Test\Logs\Pass1.log`, it returns only `\Test\Logs\Pass1.log`.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: NoQualifierSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Parent

Indicates that this cmdlet returns only the parent containers of the item or of the container
specified by the path. For example, in the path `C:\Test\Logs\Pass1.log`, it returns `C:\Test\Logs`.
The **Parent** parameter is the default split location parameter.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: ParentSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path

Specifies the paths to be split. Wildcard characters are permitted. If the path includes spaces,
enclose it in quotation marks. You can also pipe a path to this cmdlet.

```yaml
Type: System.String[]
Parameter Sets: ParentSet, LeafSet, LeafBaseSet, ExtensionSet, QualifierSet, NoQualifierSet, IsAbsoluteSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -Qualifier

Indicates that this cmdlet returns only the qualifier of the specified path. For the FileSystem or
registry providers, the qualifier is the drive of the provider path, such as `C:` or `HKCU:`.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: QualifierSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Resolve

Indicates that this cmdlet displays the items that are referenced by the resulting split path
instead of displaying the path elements.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string that contains a path to this cmdlet.

## OUTPUTS

### System.String, System.Boolean

`Split-Path` returns text strings. When you specify the **Resolve** parameter, `Split-Path` returns a
string that describes the location of the items; it does not return objects that represent the
items, such as a **FileInfo** or **RegistryKey** object.

When you specify the **IsAbsolute** parameter, `Split-Path` returns a **Boolean** value.

## NOTES

- The split location parameters (**Qualifier**, **Parent**, **Extension**, **Leaf**, **LeafBase**,
  and **NoQualifier**) are exclusive. You can use only one in each command.

- The cmdlets that contain the **Path** noun (the **Path** cmdlets) work with path names and return
  the names in a concise format that all PowerShell providers can interpret. They are designed for
  use in programs and scripts where you want to display all or part of a path name in a particular
  format. Use them in the way that you would use **Dirname**, **Normpath**, **Realpath**, **Join**,
  or other path manipulators.

- You can use the **Path** cmdlets together with several providers. These include the FileSystem,
  Registry, and Certificate providers.

- `Split-Path` is designed to work with the data exposed by any provider. To list the providers
  available in your session, type `Get-PSProvider`. For more information, see about_Providers.

## RELATED LINKS

[Convert-Path](Convert-Path.md)

[Join-Path](Join-Path.md)

[Resolve-Path](Resolve-Path.md)

[Test-Path](Test-Path.md)
