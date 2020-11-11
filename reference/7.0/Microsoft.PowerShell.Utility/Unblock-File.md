---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/unblock-file?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Unblock-File
---
# Unblock-File

## SYNOPSIS
Unblocks files that were downloaded from the Internet.

## SYNTAX

### ByPath (Default)

```
Unblock-File [-Path] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByLiteralPath

```
Unblock-File -LiteralPath <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Unblock-File` cmdlet lets you open files that were downloaded from the Internet. It unblocks
PowerShell script files that were downloaded from the Internet so you can run them, even when the
PowerShell execution policy is **RemoteSigned**. By default, these files are blocked to protect the
computer from untrusted files.

Before using the `Unblock-File` cmdlet, review the file and its source and verify that it is safe to
open.

Internally, the `Unblock-File` cmdlet removes the Zone.Identifier alternate data stream, which has a
value of "3" to indicate that it was downloaded from the Internet.

For more information about PowerShell execution policies, see
[about_Execution_Policies](../Microsoft.PowerShell.Core/about/about_Execution_Policies.md).

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Unblock a file

This command unblocks the PowerShellTips.chm file.

```
PS C:\> Unblock-File -Path C:\Users\User01\Documents\Downloads\PowerShellTips.chm
```

### Example 2: Unblock multiple files

This command unblocks all of the files in the `C:\Downloads` directory whose names include
"PowerShell". Do not run a command like this one until you have verified that all files are safe.

```
PS C:\> dir C:\Downloads\*PowerShell* | Unblock-File
```

### Example 3: Find and unblock scripts

This command shows how to find and unblock PowerShell scripts.

The first command uses the **Stream** parameter of the *Get-Item* cmdlet get files with the
Zone.Identifier stream.

The second command shows what happens when you run a blocked script in a PowerShell session in which
the execution policy is **RemoteSigned**. The RemoteSigned policy prevents you from running scripts
that are downloaded from the Internet unless they are digitally signed.

The third command uses the `Unblock-File` cmdlet to unblock the script so it can run in the session.

```
PS C:\> Get-Item * -Stream "Zone.Identifier" -ErrorAction SilentlyContinue
   FileName: C:\ps-test\Start-ActivityTracker.ps1

Stream                   Length
------                   ------
Zone.Identifier              26

PS C:\> C:\ps-test\Start-ActivityTracker.ps1
c:\ps-test\Start-ActivityTracker.ps1 : File c:\ps-test\Start-ActivityTracker.ps1 cannot
be loaded. The file c:\ps-test\Start-ActivityTracker.ps1 is not digitally signed. The script
will not execute on the system. For more information, see about_Execution_Policies.

At line:1 char:1
+ c:\ps-test\Start-ActivityTracker.ps1
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : SecurityError: (:) [], PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess

PS C:\> Get-Item C:\ps-test\Start-ActivityTracker.ps1 | Unblock-File
```

## PARAMETERS

### -LiteralPath

Specifies the files to unblock. Unlike **Path**, the value of the **LiteralPath** parameter is used
exactly as it is typed. No characters are interpreted as wildcards. If the path includes escape
characters, enclose it in single quotation marks. Single quotation marks tell PowerShell not to
interpret any characters as escape sequences.

```yaml
Type: System.String[]
Parameter Sets: ByLiteralPath
Aliases: PSPath, LP

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path

Specifies the files to unblock. Wildcard characters are supported.

```yaml
Type: System.String[]
Parameter Sets: ByPath
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
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

Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

You can pipe a file path to `Unblock-File`.

## OUTPUTS

### None

This cmdlet does not generate any output.

## NOTES

- Support for macOS was added in PowerShell 7.
- The `Unblock-File` cmdlet works only in file system drives.
- `Unblock-File` performs the same operation as the **Unblock** button on the **Properties** dialog
  box in File Explorer.
- If you use the `Unblock-File` cmdlet on a file that is not blocked, the command has no effect on
  the unblocked file and the cmdlet does not generate errors.

## RELATED LINKS

[about_Execution_Policies](../Microsoft.PowerShell.Core/About/about_Execution_Policies.md)

[Get-Item](../Microsoft.PowerShell.Management/Get-Item.md)

[Out-File](Out-File.md)

[FileSystem Provider](../Microsoft.PowerShell.Core/about/about_FileSystem_Provider.md)
