---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Get Item
ms.technology:  powershell
external help file:  PSITPro4_Management.xml
online version:  http://technet.microsoft.com/library/jj628239(v=wps.630).aspx
schema:  2.0.0
---


# Get-Item
## SYNOPSIS
Gets files and folders.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Get-Item [-Path] <String[]> [-Credential <PSCredential>] [-Exclude <String[]>] [-Filter <String>] [-Force]
 [-Include <String[]>] [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_2
```
Get-Item [-Credential <PSCredential>] [-Exclude <String[]>] [-Filter <String>] [-Force] [-Include <String[]>]
 -LiteralPath <String[]> [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_3
```
Get-Item [-Stream <string>]
```

## DESCRIPTION
The Get-Item cmdlet gets the item at the specified location.
It does not get the contents of the item at the location unless you use a wildcard character (*) to request all the contents of the item.

The Get-Item cmdlet is used by Windows PowerShell providers to enable you to navigate through different types of data stores.

In the file system, the Get-Item cmdlet gets files and folders.

Note: This custom cmdlet help file explains how the Get-Item cmdlet works in a file system drive.
For information about the Get-Item cmdlet in all drives, type "Get-Help Get-Item -Path $null" or see Get-Item at http://go.microsoft.com/fwlink/?LinkID=113319.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-Item C:\Users\User01\Downloads\InternetFile.docx -Stream *

   FileName: C:\Users\User01\Downloads\InternetFile.docx

Stream                   Length
------                   ------
:$DATA                    45056
Zone.Identifier              26
```

Description

-----------

This command gets all stream data from a file that was downloaded from the Internet.
The Zone.Identifier stream identifies a file that originated on the Internet.
The $DATA stream is the default.

The Stream parameter is introduced in Windows PowerShell 3.0.

### -------------------------- EXAMPLE 2 --------------------------
```
Get-Item C:\ps-test\* -Stream Zone.Identifier -ErrorAction SilentlyContinue


   FileName: C:\ps-test\Copy-Script.ps1

Stream                   Length
------                   ------
Zone.Identifier              26


   FileName: C:\ps-test\Start-ActivityTracker.ps1

Stream                   Length
------                   ------
Zone.Identifier              26
```

Description

-----------

This command gets Zone.Identifier stream data from all files in the C:\ps-test directory.
The command uses the Stream parameter to specify the alternate stream and he ErrorAction parameter with a value of SilentlyContinue to suppress non-terminating errors that are generated when a file has no alternate data streams. 

The Stream parameter is introduced in Windows PowerShell 3.0.

### -------------------------- EXAMPLE 3 --------------------------
```
Get-Item .

Directory: C:\

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----         7/26/2006  10:01 AM            ps-test
```

Description

-----------

This command gets the current directory.
The dot (.) represents the item at the current location (not its contents).

### -------------------------- EXAMPLE 4 --------------------------
```
Get-Item *

Directory: C:\ps-test

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----         7/26/2006   9:29 AM            Logs
d----         7/26/2006   9:26 AM            Recs
-a---         7/26/2006   9:28 AM         80 date.csv
-a---         7/26/2006  10:01 AM         30 filenoext
-a---         7/26/2006   9:30 AM      11472 process.doc
-a---         7/14/2006  10:47 AM         30 test.txt
```

Description

-----------

This command gets the current directory of the C: drive.
The object that is retrieved represents only the directory, not its contents.

### -------------------------- EXAMPLE 5 --------------------------
```
Get-Item C:\
```

Description

-----------

This command gets the items in the C: drive.
The wildcard character (*) represents all the items in the container, not just the container.

In Windows PowerShell, use a single asterisk (*) to get contents, instead of the traditional "*.*".
The format is interpreted literally, so "*.*" would not retrieve directories or file names without a dot.

### -------------------------- EXAMPLE 6 --------------------------
```
(Get-Item C:\Windows).LastAccessTime
```

Description

-----------

This command gets the LastAccessTime property of the C:\Windows directory.
LastAccessTime is just one property of file system directories.
To see all of the properties of a directory, type "(Get-Item \<directory-name\>) | Get-Member".

### -------------------------- EXAMPLE 7 --------------------------
```
Get-Item C:\Windows\*.* -Exclude w*
```

Description

-----------

This command gets items in the Windows directory with names that include a dot (.), but do not begin with w*.
This command works only when the path includes a wildcard character (*) to specify the contents of the item.

## PARAMETERS

### -Stream
Gets the specified alternate NTFS file stream from the file.
Enter the stream name.
Wildcards are supported.
To get all streams, use an asterisk (*).
This parameter is not valid on folders.

Stream is a dynamic parameter that the FileSystem provider adds to the Get-Item cmdlet.
This parameter works only in file system drives.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: string
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: No alternate file streams
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.

Type a user-name, such as "User01" or "Domain01\User01", or enter a PSCredential object, such as one generated by the Get-Credential cmdlet.
If you type a user name, you will be prompted for a password.

This parameter is not supported by any providers installed with Windows PowerShell.

```yaml
Type: PSCredential
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
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

The Exclude parameter is effective only when the command includes the contents of an item, such as C:\Windows\*, where the wildcard character specifies the contents of the C:\Windows directory.

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
Allows the cmdlet to get items that cannot otherwise be accessed, such as hidden items.
Implementation varies from provider to provider.
For more information, see about_Providers.
Even using the Force parameter, the cmdlet cannot override security restrictions.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: Force
Accept pipeline input: False
Accept wildcard characters: False
```

### -Include
Retrieves only the specified items.
The value of this parameter qualifies the Path parameter.
Enter a path element or pattern, such as "*.txt".
Wildcards are permitted.

The Include parameter is effective only when the command includes the contents of an item, such as C:\Windows\*, where the wildcard character specifies the contents of the C:\Windows directory.

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
Specifies a path to the item.
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
Specifies the path to an item.
Get-Item gets the item at the specified location.
Wildcards are permitted.
This parameter is required, but the parameter name ("Path") is optional.

Use a dot (.) to specify the current location.
Use the wildcard character (*) to specify all the items in the current location.

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

### System.String[ ]
You can pipe a path to the Get-Item cmdlet.

## OUTPUTS

### System.IO.FileInfo, System.IO.DirectoryInfo, Microsoft.PowerShell.Commands.AlternateStreamData
In the file system, Get-Item returns files and folders.
If you use the Stream parameter, it returns AlternateStreamData objects.

## NOTES
* You can also refer to Get-Item by its built-in alias, "gi". For more information, see about_Aliases.

  Get-Item does not have a Recurse parameter, because it gets only an item, not its contents.
To get the contents of an item recursively, use Get-ChildItem.

  To navigate through the registry, use Get-Item to get registry keys and Get-ItemProperty to get registry values and data.
The registry values are considered to be properties of the registry key.

  The Get-Item cmdlet is designed to work with the data exposed by any provider.
To list the providers available in your session, type "Get-PsProvider".
For more information, see about_Providers.

*

## RELATED LINKS

[Get-Item (generic); http://go.microsoft.com/fwlink/?LinkID=113319]()

[FileSystem Provider]()

[Add-Content]()

[Clear-Content]()

[Get-Content]()

[Get-ChildItem]()

[Get-Content]()

[Get-Item]()

[Remove-Item]()

[Set-Content]()

[Test-Path]()

