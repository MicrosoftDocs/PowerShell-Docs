---
ms.date:  08/23/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821624
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Resolve-Path
---
# Resolve-Path

## SYNOPSIS
Resolves the wildcard characters in a path, and displays the path contents.

## SYNTAX

### Path (Default)

```
Resolve-Path [-Path] <String[]> [-Relative] [-Credential <PSCredential>] [-UseTransaction] [<CommonParameters>]
```

### LiteralPath

```
Resolve-Path -LiteralPath <String[]> [-Relative] [-Credential <PSCredential>] [-UseTransaction]
 [<CommonParameters>]
```

## DESCRIPTION

The `Resolve-Path` cmdlet displays the items and containers that match the wildcard pattern at the
location specified. The match can include files, folders, registry keys, or any other object
accessible from a PSDrive provider.

## EXAMPLES

### Example 1: Resolve the home folder path

The tilde character (~) is shorthand notation for the current user's home folder. This example
shows `Resolve-Path` returning the fully qualified path value.

```powershell
PS C:\> Resolve-Path ~
```

```Output
Path
----
C:\Users\User01
```

### Example 2: Resolve the path of the Windows folder

```powershell
PS C:\> Resolve-Path -Path "windows"
```

```Output
Path
----
C:\Windows
```

When run from the root of the C: drive, this command returns the path of the Windows folder in the
C: drive.

### Example 3: Get all paths in the Windows folder

```powershell
PS C:\> "C:\windows\*" | Resolve-Path
```

This command returns all of the folders in the C:\Windows folder. The command uses a pipeline
operator (|) to send a path string to `Resolve-Path`.

### Example 4: Resolve a UNC path

```powershell
PS C:\> Resolve-Path -Path "\\Server01\public"
```

This command resolves a Universal Naming Convention (UNC) path and returns the shares in the path.

### Example 5: Get relative paths

```powershell
PS C:\> Resolve-Path -Path "c:\prog*" -Relative
```

```Output
.\Program Files
.\Program Files (x86)
.\programs.txt
```

This command returns relative paths for the directories at the root of the C: drive.

### Example 6: Resolve a path containing brackets

This example uses the **LiteralPath** parameter to resolve the path of the Test\[xml\] subfolder.
Using **LiteralPath** causes the brackets to be treated as normal characters rather than a regular
expression.

```powershell
PS C:\> Resolve-Path -LiteralPath 'test[xml]'
```

## PARAMETERS

### -Credential

Specifies a user account that has permission to perform this action.
The default is the current user.

Type a user name, such as User01 or Domain01\User01, or pass a **PSCredential** object. You can
create a **PSCredential** object using the `Get-Credential` cmdlet. If you type a user name, this
cmdlet prompts you for a password.

This parameter is not supported by any providers installed with PowerShell.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LiteralPath

Specifies the path to be resolved.
The value of the **LiteralPath** parameter is used exactly as typed.
No characters are interpreted as wildcard characters.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell PowerShell not to interpret any characters as escape sequences.

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

Specifies the PowerShell path to resolve.
This parameter is required.
You can also pipe a path string to `Resolve-Path`.

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

### -Relative

Indicates that this cmdlet returns a relative path.

```yaml
Type: SwitchParameter
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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string that contains a path to this cmdlet.

## OUTPUTS

### System.Management.Automation.PathInfo, System.String

Returns a **PathInfo** object. Returns a string value for the resolved path if you specify the
*Relative* parameter.

## NOTES

- The `*-Path` cmdlets work with the FileSystem, Registry, and Certificate providers.
- `Resolve-Path` is designed to work with any provider. To list the providers available in your
  session, type `Get-PSProvider`. For more information, see
  [about_providers](../microsoft.powershell.core/about/about_providers.md).

## RELATED LINKS

[Convert-Path](Convert-Path.md)

[Join-Path](Join-Path.md)

[Split-Path](Split-Path.md)

[Test-Path](Test-Path.md)