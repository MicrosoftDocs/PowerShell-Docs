---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 12/12/2022
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/resolve-path?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Resolve-Path
---

# Resolve-Path

## SYNOPSIS
Resolves the wildcard characters in a path, and displays the path contents.

## SYNTAX

### Path (Default)

```
Resolve-Path [-Path] <String[]> [-Relative] [-Credential <PSCredential>] [-UseTransaction]
 [<CommonParameters>]
```

### LiteralPath

```
Resolve-Path -LiteralPath <String[]> [-Relative] [-Credential <PSCredential>] [-UseTransaction]
 [<CommonParameters>]
```

## DESCRIPTION

The `Resolve-Path` cmdlet displays the items and containers that match the wildcard pattern at the
location specified. The match can include files, folders, registry keys, or any other object
accessible from a **PSDrive** provider.

## EXAMPLES

### Example 1: Resolve the home folder path

The tilde character (`~`) is shorthand notation for the current user's home folder. This example
shows `Resolve-Path` returning the fully qualified path value.

```powershell
Resolve-Path ~
```

```Output
Path
----
C:\Users\User01
```

### Example 2: Resolve the path of the Windows folder

```powershell
Resolve-Path -Path "windows"
```

```Output
Path
----
C:\Windows
```

When run from the root of the `C:` drive, this command returns the path of the `Windows` folder in
the `C:` drive.

### Example 3: Get all paths in the Windows folder

```powershell
"C:\windows\*" | Resolve-Path
```

This command returns all the files and folders in the `C:\Windows` folder. The command uses a
pipeline operator (`|`) to send a path string to `Resolve-Path`.

### Example 4: Resolve a UNC path

```powershell
Resolve-Path -Path "\\Server01\public"
```

This command resolves a Universal Naming Convention (UNC) path and returns the shares in the path.

### Example 5: Get relative paths

```powershell
Resolve-Path -Path "c:\prog*" -Relative
```

```Output
.\Program Files
.\Program Files (x86)
.\programs.txt
```

This command returns relative paths for the directories at the root of the `C:` drive.

### Example 6: Resolve a path containing brackets

This example uses the **LiteralPath** parameter to resolve the path of the `Test[xml]` subfolder.
Using **LiteralPath** causes the brackets to be treated as normal characters rather than a regular
expression.

```powershell
Resolve-Path -LiteralPath 'test[xml]'
```

## PARAMETERS

### -Credential

Specifies a user account that has permission to perform this action. The default is the current
user.

Type a user name, such as `User01` or `Domain01\User01`, or pass a **PSCredential** object. You can
create a **PSCredential** object using the `Get-Credential` cmdlet. If you type a user name, this
cmdlet prompts you for a password.

This parameter is not supported by any providers installed with PowerShell.

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

### -LiteralPath

Specifies the path to be resolved. The value of the **LiteralPath** parameter is used exactly as
typed. No characters are interpreted as wildcard characters. If the path includes escape characters,
enclose it in single quotation marks (`'`). Single quotation marks tell PowerShell not to interpret
any characters as escape sequences.

```yaml
Type: System.String[]
Parameter Sets: LiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path

Specifies the PowerShell path to resolve. This parameter is required. You can also pipe a path
string to `Resolve-Path`. Wildcard characters are permitted.

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

### -Relative

Indicates that this cmdlet returns a relative path.

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

### -UseTransaction
Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see [about_transactions](../Microsoft.PowerShell.Core/About/about_Transactions.md).

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: usetx

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
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.String

You can pipe a string that contains a path to this cmdlet.

## OUTPUTS

### System.Management.Automation.PathInfo

By default, this cmdlet returns a **PathInfo** object.

### System.String

If you specify the **Relative** parameter, this cmdlet returns a string value for the resolved path.

## NOTES

Windows PowerShell includes the following aliases for `Resolve-Path`:

- `rvpa`

The `*-Path` cmdlets work with the **FileSystem**, **Registry**, and **Certificate** providers.

`Resolve-Path` is designed to work with any provider. To list the providers available in your
session, type `Get-PSProvider`. For more information, see
[about_providers](../microsoft.powershell.core/about/about_providers.md).

`Resolve-Path` only resolves existing paths. It cannot be used to resolve a location that does not
exist yet.

## RELATED LINKS

[Convert-Path](Convert-Path.md)

[Join-Path](Join-Path.md)

[Split-Path](Split-Path.md)

[Test-Path](Test-Path.md)
