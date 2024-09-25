---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 09/25/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/convert-path?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Convert-Path
---
# Convert-Path

## SYNOPSIS
Converts a path from a PowerShell path to a PowerShell provider path.

## SYNTAX

### Path (Default)

```
Convert-Path [-Path] <String[]> [<CommonParameters>]
```

### LiteralPath

```
Convert-Path -LiteralPath <String[]> [<CommonParameters>]
```

## DESCRIPTION

The `Convert-Path` cmdlet converts a path from a PowerShell path to a PowerShell provider path.

## EXAMPLES

### Example 1: Convert the working directory to a standard file system path

This example converts the current working directory, which is represented by a dot (`.`), to a
standard FileSystem path.

```
PS C:\> Convert-Path .
C:\
```

### Example 2: Convert a provider path to a standard registry path

This example converts the PowerShell provider path to a standard registry path.

```powershell
PS C:\> Convert-Path HKLM:\Software\Microsoft
HKEY_LOCAL_MACHINE\Software\Microsoft
```

### Example 3: Convert a path to a string

This example converts the path to the home directory of the current provider, which is the
FileSystem provider, to a string.

```powershell
PS C:\> Convert-Path ~
C:\Users\User01
```

### Example 4: Convert paths for hidden items

By default, `Convert-Path` does not return hidden items. This example uses the **Force** parameter
to find hidden items. The `Get-Item` command confirms that the `.git` folder is hidden. Using
`Convert-Path` without the **Force** parameter returns only the visible items. Adding the **Force**
parameter returns all items, including hidden items.

```powershell
PS> Get-Item .git -Force

    Directory: D:\Git\PS-Docs\PowerShell-Docs

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d--h-           9/25/2024  4:46 PM                .git

PS> Convert-Path .git*
D:\Git\PS-Docs\PowerShell-Docs\.github
D:\Git\PS-Docs\PowerShell-Docs\.gitattributes
D:\Git\PS-Docs\PowerShell-Docs\.gitignore

PS> Convert-Path .git* -Force
D:\Git\PS-Docs\PowerShell-Docs\.git
D:\Git\PS-Docs\PowerShell-Docs\.github
D:\Git\PS-Docs\PowerShell-Docs\.gitattributes
D:\Git\PS-Docs\PowerShell-Docs\.gitignore
```

## PARAMETERS

### -Force

Allows the cmdlet to get items that otherwise can't be accessed by the user, such as hidden or
system files. The **Force** parameter doesn't override security restrictions. Implementation varies
among providers. For more information, see
[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

This parameter was added in PowerShell 7.5-preview.5.

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

### -LiteralPath

Specifies, as a string array, the path to be converted. The value of the **LiteralPath** parameter
is used exactly as it's typed. No characters are interpreted as wildcards. If the path includes
escape characters, enclose it in single quotation marks. Single quotation marks tell PowerShell not
to interpret any characters as escape sequences.

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

Specifies the PowerShell path to be converted.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a path, but not a literal path, to this cmdlet.

## OUTPUTS

### System.String

This cmdlet returns a string that contains the converted path.

## NOTES

PowerShell includes the following aliases for `Convert-Path`:

- All platforms:
  - `cvpa`

The cmdlets that contain the Path noun manipulate path names and return the names in a concise
format that all PowerShell providers can interpret. They're designed for use in programs and
scripts where you want to display all or part of a path in a particular format. Use them like you
would use **Dirname**, **Normpath**, **Realpath**, **Join**, or other path manipulators.

You can use the path cmdlets with several providers, including the **FileSystem**, **Registry**,
and **Certificate** providers.

This cmdlet is designed to work with the data exposed by any provider. To list the providers
available in your session, type `Get-PSProvider`. For more information, see
[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

`Convert-Path` only converts existing paths. It can't be used to convert a location that doesn't
exist yet.

## RELATED LINKS

[Join-Path](Join-Path.md)

[Resolve-Path](Resolve-Path.md)

[Split-Path](Split-Path.md)

[Test-Path](Test-Path.md)

[Get-PSProvider](Get-PSProvider.md)
