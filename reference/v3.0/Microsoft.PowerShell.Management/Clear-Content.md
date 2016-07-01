---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Clear Content
ms.technology:  powershell
external help file:  PSITPro3_Management.xml
online version:  http://go.microsoft.com/fwlink/?LinkId=204573
schema:  2.0.0
---


# Clear-Content
## SYNOPSIS
Deletes the contents of an file, but does not delete the file.
## SYNTAX

### Path (Default)
```
Clear-Content [-Path] <String[]> [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>] [-Force]
 [-Credential <PSCredential>] [-WhatIf] [-Confirm] [-UseTransaction] [-Stream <String>] [<CommonParameters>]
```

### LiteralPath
```
Clear-Content -LiteralPath <String[]> [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>] [-Force]
 [-Credential <PSCredential>] [-WhatIf] [-Confirm] [-UseTransaction] [-Stream <String>] [<CommonParameters>]
```

## DESCRIPTION
The Clear-Content cmdlet deletes the contents of an item, such as deleting the text from a file, but it does not delete the item.
As a result, the item exists, but it is empty.
Clear-Content is similar to Clear-Item, but it works on items with contents, instead of items with values.

In the file system, Clear-Content clears the content in a file, but does not delete the file.
It has no effect on folders.

Note: This custom cmdlet help file explains how the Clear-Content cmdlet works in a file system drive.
For information about the Clear-Content cmdlet in all drives, type "Get-Help Clear-Content -Path $null" or see Clear-Content at http://go.microsoft.com/fwlink/?LinkID=113282.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-Content C:\Test\Copy-Script.ps1 -Stream Zone.Identifier

[ZoneTransfer]
ZoneId=3

C:\PS>Clear-Content C:\Test\Copy-Script.ps1 -Stream Zone.Identifier

C:\PS>Get-Content C:\Test\Copy-Script.ps1 -Stream Zone.Identifier
C:\PS>
```

Description

-----------

This example shows how the Clear-Content cmdlet clears the content from an alternate data stream while leaving the stream intact.

The first command uses the Get-Content cmdlet to get the content of the Zone.Identifier stream in the Copy-Script.ps1 file, which was downloaded from the Internet.

The second command uses the Clear-Content cmdlet to clear the content. 

The third command repeats the first command.
It verifies that the content is cleared, but the stream remains.
If the stream were deleted, the command would generate an error.

You can use a method like this one to clear the content of an alternate data stream.
However, it is not the recommended way to eliminate security checks that block files that are downloaded from the Internet.
If you verify that a downloaded file is safe, use the Unblock-File cmdlet.
### -------------------------- EXAMPLE 2 --------------------------
```
Clear-Content ..\SmpUsers\*\init.txt
```

Description

-----------

This command deletes all of the content from the "init.txt" files in all subdirectories of the SmpUsers directory.
The files are not deleted, but they are empty.
### -------------------------- EXAMPLE 3 --------------------------
```
Clear-Content -Path * -Filter *.log -Force
```

Description

-----------

This command deletes the contents of all files in the current directory with the ".log" file name extension, including files with the read-only attribute.
The asterisk (*) in the path represents all items in the current directory.
The Force parameter makes the command effective on read-only files.
Using a filter to restrict the command to files with the ".log" file name extension instead of specifying "*.log" in the path makes the operation faster.
### -------------------------- EXAMPLE 4 --------------------------
```
Clear-Content c:\Temp\* -Include Smp* -Exclude *2* -WhatIf
```

Description

-----------

This command requests a prediction of what would happen if you submitted the command: "clear-content c:\temp\* -include smp* -exclude *2*".
The result lists the files that would be cleared; in this case, files in the Temp directory whose names begin with "Smp", unless the file names include a "2".
To execute the command, run it again without the Whatif parameter.
## PARAMETERS

### -Stream
Deletes the content in the specified alternate data stream, but does not delete the alternate data stream.
Enter the stream name.
Wildcards are not supported.

Stream is a dynamic parameter that the FileSystem provider adds to the Set-Content cmdlet.
This parameter works only in file system drives.

You can use the Clear-Content cmdlet to clear the content of an alternate data stream.
However, it is not the recommended way to eliminate security checks that block files that are downloaded from the Internet.
If you verify that a downloaded file is safe, use the Unblock-File cmdlet.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.

Type a user name, such as "User01" or "Domain01\User01", or enter a PSCredential object, such as one generated by the Get-Credential cmdlet.
If you type a user name, you will be prompted for a password.

This parameter is not supported by any providers installed with Windows PowerShell.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: Current user
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Exclude
Omits the specified items.
The value of this parameter qualifies the Path parameter.
Enter a path element or pattern, such as "*.txt".
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: True
```

### -Filter
Specifies a filter in the provider's format or language.
The value of this parameter qualifies the Path parameter.
The syntax of the filter, including the use of wildcards, depends on the provider.
Filters are more efficient than other parameters, because the provider applies them when retrieving the objects, rather than having Windows PowerShell filter the objects after they are retrieved.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: True
```

### -Force
Allows the cmdlet to clear the file contents even if the file is read-only.
Implementation varies from provider to provider.
For more information, see about_Providers.
Even using the Force parameter, the cmdlet cannot override security restrictions.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Include
Clears only the specified items.
The value of this parameter qualifies the Path parameter.
Enter a path element or pattern, such as "*.txt".
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: True
```

### -LiteralPath
Specifies the paths to the items from which content is deleted.
Unlike Path, the value of LiteralPath is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: LiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
Specifies the paths to the items from which content is deleted.
Wildcards are permitted.
The paths must be paths to items, not to containers.
For example, you must specify a path to one or more files, not a path to a directory.
Wildcards are permitted.
This parameter is required, but the parameter name ("Path") is optional.

```yaml
Type: String[]
Parameter Sets: Path
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
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

### -UseTransaction
Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see

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

## OUTPUTS

## NOTES
* You can also refer to Clear-Content by its built-in alias, "clc". For more information, see about_Aliases.

  If you omit the -Path parameter name, the value of Path must be the first parameter in the command.
For example, "clear-content c:\mydir\*.txt".
If you include the parameter name, you can list the parameters in any order.

  You can use Clear-Content with the Windows PowerShell File System provider and with other providers that manipulate content.
To clear items that are not considered to be content, such as items managed by the Windows PowerShell Certificate or Registry providers, use Clear-Item.

  The Clear-Content cmdlet is designed to work with the data exposed by any provider.
To list the providers available in your session, type "Get-PsProvider".
For more information, see about_Providers.

*
## RELATED LINKS

[Add-Content (all providers); http://go.microsoft.com/fwlink/?LinkID=113278]()

[FileSystem Provider]()

[Clear-Content]()

[Get-Content]()

[Get-ChildItem]()

[Get-Content]()

[Get-Item]()

[Remove-Item]()

[Set-Content]()

[Test-Path]()

