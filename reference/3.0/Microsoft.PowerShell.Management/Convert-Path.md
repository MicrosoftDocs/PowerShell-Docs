---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=113289
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Convert-Path
---

# Convert-Path
## SYNOPSIS
Converts a path from a Windows PowerShell path to a Windows PowerShell provider path.
## SYNTAX

### Path (Default)
```
Convert-Path [-Path] <String[]> [-UseTransaction] [<CommonParameters>]
```

### LiteralPath
```
Convert-Path -LiteralPath <String[]> [-UseTransaction] [<CommonParameters>]
```

## DESCRIPTION
The Convert-Path cmdlet converts a path from a Windows PowerShell path to a Windows PowerShell provider path.
## EXAMPLES

### Example 1
```
PS C:\> convert-path .
```

This command converts the current working directory, which is represented by a dot (.), to a standard file system path.
### Example 2
```
PS C:\> convert-path HKLM:\software\microsoft
```

This command converts the Windows PowerShell provider path to a standard registry path.
### Example 3
```
PS C:\> convert-path ~
C:\Users\User01
```

This command converts the path to the home directory of the current provider, which is the FileSystem provider, to a string.
## PARAMETERS

### -LiteralPath
Specifies the path to be converted.
The value of the LiteralPath parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: LiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
Specifies the Windows PowerShell path to be converted.

```yaml
Type: String[]
Parameter Sets: Path
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -UseTransaction
Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see about_transactions.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: usetx

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### System.String
You can pipe a path (but not a literal path) to Convert-Path.
## OUTPUTS

### System.String
Convert-Path returns a string that contains the converted path.
## NOTES
* The cmdlets that contain the Path noun (the Path cmdlets) manipulate path names and return the names in a concise format that all Windows PowerShell providers can interpret. They are designed for use in programs and scripts where you want to display all or part of a path name in a particular format. Use them like you would use Dirname, Normpath, Realpath, Join, or other path manipulators.

  You can use the path cmdlets with several providers, including the FileSystem, Registry, and Certificate providers.

  The Convert-Path cmdlet is designed to work with the data exposed by any provider.
To list the providers available in your session, type "Get-PSProvider".
For more information, see about_Providers.

*
## RELATED LINKS

[Join-Path](Join-Path.md)

[Resolve-Path](Resolve-Path.md)

[Split-Path](Split-Path.md)

[Test-Path](Test-Path.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)

