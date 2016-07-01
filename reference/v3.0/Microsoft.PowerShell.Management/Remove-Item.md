---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Remove Item
ms.technology:  powershell
external help file:  PSITPro3_Management.xml
online version:  http://go.microsoft.com/fwlink/?LinkId=271999
schema:  2.0.0
---


# Remove-Item
## SYNOPSIS
Deletes files and folders.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Remove-Item [-Path] <String[]> [-Credential <PSCredential>] [-Exclude <String[]>] [-Filter <String>] [-Force]
 [-Include <String[]>] [-Recurse] [-Confirm] [-WhatIf] [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_2
```
Remove-Item [-Credential <PSCredential>] [-Exclude <String[]>] [-Filter <String>] [-Force]
 [-Include <String[]>] [-Recurse] -LiteralPath <String[]> [-Confirm] [-WhatIf] [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_3
```
Remove-Item [-Stream <string>]
```

## DESCRIPTION
The Remove-Item cmdlet deletes one or more items.
Because it is supported by many providers, it can delete many different types of items, including files, directories, registry keys, variables, aliases, and functions.

In file system drives, the Remove-Item cmdlet deletes files and folders. 

If you use the Stream dynamic parameter, it deletes the specified alternate data stream, but does not delete the file.

Note: This custom cmdlet help file explains how the Remove-Item cmdlet works in a file system drive.
For information about the Remove-Item cmdlet in all drives, type "Get-Help Remove-Item -Path $null" or see Remove-Item at http://go.microsoft.com/fwlink/?LinkID=113373.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-Item C:\Test\Copy-Script.ps1 -Stream Zone.Identifier


   FileName: \\C:\Test\Copy-Script.ps1

Stream                   Length
------                   ------
Zone.Identifier              26


C:\PS>Remove-Item C:\Test\Copy-Script.ps1 -Stream Zone.Identifier

C:\PS>Get-Item C:\Test\Copy-Script.ps1 -Stream Zone.Identifier

get-item : Could not open alternate data stream 'Zone.Identifier' of file 'C:\Test\Copy-Script.ps1'.
At line:1 char:1
+ get-item 'C:\Test\Copy-Script.ps1' -Stream Zone.Identifier
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (C:\Test\Copy-Script.ps1:String) [Get-Item], FileNotFoundE
   xception
    + FullyQualifiedErrorId : AlternateDataStreamNotFound,Microsoft.PowerShell.Commands.GetItemCommand


C:\PS>Get-Item C:\Test\Copy-Script.ps1


    Directory: C:\Test


Mode                LastWriteTime     Length Name
----                -------------     ------ ----
-a---          8/4/2011  11:15 AM       9436 Copy-Script.ps1
```

Description

-----------

This example shows how to use the Stream dynamic parameter of the Remove-Item cmdlet to delete an alternate data stream.
The stream parameter is introduced in Windows PowerShell 3.0.

The first command uses the Stream dynamic parameter of the Get-Item cmdlet to get the Zone.Identifier stream of the Copy-Script.ps1 file. 

The second command uses the Stream dynamic parameter of the Remove-Item cmdlet to remove the Zone.Identifier stream of the file.

The third command uses the Stream dynamic parameter of the Get-Item cmdlet to verify that the Zone.Identifier stream is deleted.

The fourth command Get-Item cmdlet without the Stream parameter to verify that the file is not deleted.

### -------------------------- EXAMPLE 2 --------------------------
```
Remove-Item C:\Test\*.*
```

Description

-----------

This command deletes all of the files with names that include a dot (.) from the C:\Test directory.
Because the command specifies a dot, the command does not delete directories or files with no file name extension.

### -------------------------- EXAMPLE 3 --------------------------
```
Remove-Item * -Include *.doc -Exclude *1*
```

Description

-----------

This command deletes from the current directory all files with a .doc file name extension and a name that does not include "1".
It uses the wildcard character (*) to specify the contents of the current directory.
It uses the Include and Exclude parameters to specify the files to delete.

### -------------------------- EXAMPLE 4 --------------------------
```
Remove-Item -Path C:\Test\hidden-RO-file.txt -Force
```

Description

-----------

This command deletes a file that is both hidden and read-only.
It uses the Path parameter to specify the file.
It uses the Force parameter to give permission to delete it.
Without Force, you cannot delete read-only or hidden files.

### -------------------------- EXAMPLE 5 --------------------------
```
Get-ChildItem * -Include *.csv -Recurse | Remove-Item
```

Description

-----------

This command deletes all of the CSV files in the current directory and all subdirectories recursively.

Because the Recurse parameter in this cmdlet is faulty, the command uses the Get-Childitem cmdlet to get the desired files, and it uses the pipeline operator to pass them to the Remove-Item cmdlet.

In the Get-ChildItem command, the Path parameter has a value of *, which represents the contents of the current directory.
It uses the Include parameter to specify the CSV file type, and it uses the Recurse parameter to make the retrieval recursive.

If you try to specify the file type in the path, such as "-path *.csv", the cmdlet interprets the subject of the search to be a file that has no child items, and Recurse fails.

## PARAMETERS

### -Stream
Deletes the specified alternate data stream from a file, but does not delete the file.
Enter the stream name.
Wildcards are supported.
This parameter is not valid on folders.

Stream is a dynamic parameter that the FileSystem provider adds to the Remove-Item cmdlet.
This parameter works only in file system drives.

You can use the Remove-Item cmdlet to delete an alternate data stream.
However, it is not the recommended way to eliminate security checks that block files that are downloaded from the Internet.
If you verify that a downloaded file is safe, use the Unblock-File cmdlet.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: string
Parameter Sets: UNNAMED_PARAMETER_SET_3
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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: 
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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: True
```

### -Force
Allows the cmdlet to remove items that cannot otherwise be changed, such as hidden or read-only files or read-only aliases or variables.
The cmdlet cannot remove constant aliases or variables. 
Implementation varies from provider to provider.
For more information, see about_Providers.
Even using the Force parameter, the cmdlet cannot override security restrictions.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Include
Deletes only the specified items.
The value of this parameter qualifies the Path parameter.
Enter a path element or pattern, such as "*.txt".
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: True
```

### -LiteralPath
Specifies a path to the items being removed.
Unlike Path, the value of LiteralPath is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -Path
Specifies a path to the items being removed.
Wildcards are permitted.
The parameter name ("-Path") is optional.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: True
```

### -Recurse
Deletes the items in the specified locations and in all child items of the locations.

When it is used with the Include parameter, the Recurse parameter might not delete all child directories or all child items.
This is a known issue; as a workaround, try piping results of the Get-ChildItem -Recurse cmdlet into the Remove-Item cmdlet, as described in Example 4 in this topic.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES
* You can also refer to Remove-Item by any of its built-in aliases, "del", "erase", "rmdir", "rd", "ri", or "rm". For more information, see about_Aliases.

  The Remove-Item cmdlet is designed to work with the data exposed by any provider.
To list the providers available in your session, type "Get-PsProvider".
For more information, see about_Providers.

*

## RELATED LINKS

[Remove-Item (generic); http://go.microsoft.com/fwlink/?LinkID=113373]()

[FileSystem Provider]()

[Clear-Content]()

[Get-Content]()

[Get-ChildItem]()

[Get-Content]()

[Get-Item]()

[Remove-Item]()

[Set-Content]()

[Test-Path]()

