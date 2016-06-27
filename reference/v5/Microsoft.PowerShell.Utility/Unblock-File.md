---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294021
schema: 2.0.0
---

# Unblock-File
## SYNOPSIS
Unblocks files that were downloaded from the Internet.

## SYNTAX

### ByPath (Default)
```
Unblock-File [-Path] <String[]> [-InformationAction <ActionPreference>] [-InformationVariable <String>]
 [-WhatIf] [-Confirm]
```

### ByLiteralPath
```
Unblock-File -LiteralPath <String[]> [-InformationAction <ActionPreference>] [-InformationVariable <String>]
 [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Unblock-File cmdlet lets you open files that were downloaded from the Internet.
It unblocks Windows PowerShell script files that were downloaded from the Internet so you can run them, even when the Windows PowerShell execution policy is RemoteSigned.
By default, these files are blocked to protect the computer from untrusted files.

Before using the Unblock-File cmdlet, review the file and its source and verify that it is safe to open.

Internally, the Unblock-File cmdlet removes the Zone.Identifier alternate data stream, which has a value of "3" to indicate that it was downloaded from the Internet.

For more information about Windows PowerShell execution policies, see about_Execution_Policies (http://go.microsoft.com/fwlink/?LinkID=135170).

This cmdlet is introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Unblock a file
```
PS C:\>Unblock-File -Path C:\Users\User01\Documents\Downloads\PowerShellTips.chm
```

This command unblocks the PowerShellTips.chm file.

### Example 2: Unblock multiple files
```
PS C:\>dir C:\Downloads\*PowerShell* | Unblock-File
```

This command unblocks all of the files in the C:\Downloads directory whose names include "PowerShell".
Do not run a command like this one until you have verified that all files are safe.

### Example 3: Find and unblock scripts
```
The first command uses the Stream parameter of the Get-Item cmdlet get files with the Zone.Identifier stream.Although you could pipe the output directly to the Unblock-File cmdlet (Get-Item * -Stream "Zone.Identifier" -ErrorAction SilentlyContinue | ForEach {Unblock-File $_.FileName}), it is prudent to review the file and confirm that it is safe before unblocking.
PS C:\>Get-Item * -Stream "Zone.Identifier" -ErrorAction SilentlyContinue
   FileName: C:\ps-test\Start-ActivityTracker.ps1

Stream                   Length
------                   ------
Zone.Identifier              26

The second command shows what happens when you run a blocked script in a Windows PowerShell session in which the execution policy is RemoteSigned. The RemoteSigned policy prevents you from running scripts that are downloaded from the Internet unless they are digitally signed.
PS C:\>C:\ps-test\Start-ActivityTracker.ps1
c:\ps-test\Start-ActivityTracker.ps1 : File c:\ps-test\Start-ActivityTracker.ps1 cannot
be loaded. The file c:\ps-test\Start-ActivityTracker.ps1 is not digitally signed. The script
will not execute on the system. For more information, see about_Execution_Policies at
http://go.microsoft.com/fwlink/?LinkID=135170.
At line:1 char:1
+ c:\ps-test\Start-ActivityTracker.ps1
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : SecurityError: (:) [], PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess

The third command uses the Unblock-File cmdlet to unblock the script so it can run in the session.
PS C:\>Get-Item C:\ps-test\Start-ActivityTracker.ps1 | Unblock-File
```

This command shows how to find and unblock Windows PowerShell scripts.

## PARAMETERS

### -InformationAction
@{Text=}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
@{Text=}

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath
Specifies the files to unblock.
Unlike Path, the value of the LiteralPath parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: ByLiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
Specifies the files to unblock.
Wildcard characters are supported.

```yaml
Type: String[]
Parameter Sets: ByPath
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
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
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.String
You can pipe a file path to Unblock-File.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES
The Unblock-File cmdlet works only in file system drives.

Unblock-File performs the same operation as the Unblock button on the Properties dialog box in File Explorer.

If you use the Unblock-File cmdlet on a file that is not blocked, the command has no effect on the unblocked file and the cmdlet does not generate errors.

## RELATED LINKS

[about_Execution_Policies]()

[Get-Item]()

[FileSystem Provider]()

