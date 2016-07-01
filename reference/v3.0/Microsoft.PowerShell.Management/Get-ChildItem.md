---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Get ChildItem
ms.technology:  powershell
external help file:  PSITPro3_Management.xml
online version:  http://go.microsoft.com/fwlink/?LinkId=204557
schema:  2.0.0
---


# Get-ChildItem
## SYNOPSIS
Gets the files and folders in a file system drive.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Get-ChildItem [[-Path] <String[]>] [[-Filter] <String>] [-Exclude <String[]>] [-Force] [-Include <String[]>]
 [-Name] [-Recurse] [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_2
```
Get-ChildItem [[-Filter] <String>] [-Exclude <String[]>] [-Force] [-Include <String[]>] [-Name] [-Recurse]
 -LiteralPath <String[]> [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_3
```
Get-ChildItem [-Attributes <FileAttributes]>] [-Directory] [-File] [-Force] [-Hidden] [-ReadOnly] [-System]
 [-UseTransaction]
```

## DESCRIPTION
The Get-ChildItem cmdlet gets the items in one or more specified locations.
If the item is a container, it gets the items inside the container, known as child items.
You can use the Recurse parameter to get items in all child containers.

A location can be a file system location, such as a directory, or a location exposed by a different Windows PowerShell provider, such as a registry hive or a certificate store.

In a file system drive, the Get-ChildItem cmdlet gets the directories, subdirectories, and files.
In a file system directory, it gets subdirectories and files. 

By default, Get-ChildItem gets non-hidden items, but you can use the Directory, File, Hidden, ReadOnly, and System parameters to get only items with these attributes.
To create a complex attribute search, use the Attributes parameter.
If you use these parameters, Get-ChildItem gets only the items that meet all search conditions, as though the parameters were connected by an AND operator. 

Note: This custom cmdlet help file explains how the Get-ChildItem cmdlet works in a file system drive.
For information about the Get-ChildItem cmdlet in all drives, type "Get-Help Get-ChildItem -Path $null" or see Get-ChildItem at http://go.microsoft.com/fwlink/?LinkID=113308.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-ChildItem
```

Description

-----------

This command gets the files and subdirectories in the current directory.
If the current directory does not have child items, the command does not return any results.

### -------------------------- EXAMPLE 2 --------------------------
```
Get-Childitem -System -File -Recurse
```

Description

-----------

This command gets system files in the current directory and its subdirectories.

### -------------------------- EXAMPLE 3 --------------------------
```
Get-ChildItem -Attributes !Directory,!Directory+Hidden

C:\PS> dir -att !d,!d+h
```

Description

-----------

These command get all files, including hidden files, in the current directory, but exclude subdirectories.
The second command uses aliases and abbreviations, but has the same effect as the first.

### -------------------------- EXAMPLE 4 --------------------------
```
dir -ad
```

Description

-----------

This command gets the subdirectories in the current directory.
It uses the "dir" alias of the Get-ChildItem cmdlet and the "ad" alias of the Directory parameter.

### -------------------------- EXAMPLE 5 --------------------------
```
Get-ChildItem -File -Attributes !ReadOnly -path C:\ps-test
```

Description

-----------

This command gets read-write files in the C:\ps-test directory.

### -------------------------- EXAMPLE 6 --------------------------
```
get-childitem . -include *.txt -recurse -force
```

Description

-----------

This command gets all of the .txt files in the current directory and its subdirectories. 

The dot (.) represents the current directory.
The Include parameter specifies the file name extension.
The Recurse parameter directs Windows PowerShell to search for objects recursively, and it indicates that the subject of the command is the specified directory and its contents.
The Force parameter adds hidden files to the display.

### -------------------------- EXAMPLE 7 --------------------------
```
get-childitem c:\windows\logs\* -include *.txt -exclude A*
```

Description

-----------

This command gets the .txt files in the Logs subdirectory, except for those whose names start with the letter A.
It uses the wildcard character (*) to indicate the contents of the Logs subdirectory, not the directory container.
Because the command does not include the Recurse parameter, Get-ChildItem does not include the contents of the current directory automatically; you need to specify it.

### -------------------------- EXAMPLE 8 --------------------------
```
get-childitem -name
```

Description

-----------

This command retrieves only the names of items in the current directory.

## PARAMETERS

### -Attributes
Gets files and folders with the specified attributes.
This parameter supports all attributes and lets you specify complex combinations of attributes.

For example, to get non-system files (not directories) that are encrypted or compressed, type:
    Get-ChildItem -Attributes !Directory+!System+Encrypted, !Directory+!System+Compressed

To find files and folders with commonly used attributes, you can use the Attributes parameter, or the Directory, File, Hidden, ReadOnly, and System switch parameters.

The Attributes parameter supports the following attributes: Archive, Compressed, Device, Directory, Encrypted, Hidden, Normal, NotContentIndexed, Offline, ReadOnly, ReparsePoint, SparseFile, System, and Temporary.
For a description of these attributes, see the FileAttributes enumeration at http://go.microsoft.com/fwlink/?LinkId=201508.

Use the following operators to combine attributes.
    ! 
NOT
   +    AND
   ,      OR
No spaces are permitted between an operator and its attribute.
However, spaces are permitted before commas.

You can use the following abbreviations for commonly used attributes:
    D    Directory
    H    Hidden
    R    Read-only
    S     System

```yaml
Type: FileAttributes]
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Directory
Gets directories (folders).
 

To get only directories, use the Directory parameter and omit the File parameter.
To exclude directories, use the File parameter and omit the Directory parameter, or use the Attributes parameter. 

To get directories, use the Directory parameter, its "ad" alias, or the Directory attribute of the Attributes parameter.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -File
Gets files. 

To get only files, use the File parameter and omit the Directory parameter.
To exclude files, use the Directory parameter and omit the File parameter, or use the Attributes parameter.

To get files, use the File parameter, its "af" alias, or the File value of the Attributes parameter.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Hidden
Gets only hidden files and directories (folders). 
By default, Get-ChildItem gets only non-hidden items, but you can use the Force parameter to include hidden items in the results.

To get only hidden items, use the Hidden parameter, its "h" or "ah" aliases, or the Hidden value of the Attributes parameter.
To exclude hidden items, omit the Hidden parameter or use the Attributes parameter.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReadOnly
Gets only read-only files and directories (folders).
 

To get only read-only items, use the ReadOnly parameter, its "ar" alias, or the ReadOnly value of the Attributes parameter.
To exclude read-only items, use the Attributes parameter.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -System
Gets only system files and directories (folders).

To get only system files and folders, use the System parameter, its "as" alias, or the System value of the Attributes parameter.
To exclude system files and folders, use the Attributes parameter.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Gets hidden files and folders.
By default, hidden files and folder are excluded.
You can also get hidden files and folders by using the Hidden parameter or the Hidden value of the Attributes parameter.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseTransaction
Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see about_Transactions.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
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
Position: 2
Default value: 
Accept pipeline input: False
Accept wildcard characters: True
```

### -Include
Gets only the specified items.
The value of this parameter qualifies the Path parameter.
Enter a path element or pattern, such as "*.txt".
Wildcards are permitted.

The Include parameter is effective only when the command includes the Recurse parameter or the path leads to the contents of a directory, such as C:\Windows\*, where the wildcard character specifies the contents of the C:\Windows directory.

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
Specifies a path to one or more locations.
Unlike the Path parameter, the value of the LiteralPath parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: PSPath

Required: True
Position: Named
Default value: 
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -Name
Gets only the names of the items in the locations.
If you pipe the output of this command to another command, only the item names are sent.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies a path to one or more locations.
Wildcards are permitted.
The default location is the current directory (.).

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: 1
Default value: Current directory
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: True
```

### -Recurse
Gets the items in the specified locations and in all child items of the locations.

In Windows PowerShell 2.0 and earlier versions of Windows PowerShell, the Recurse parameter works only when the value of the Path parameter is a container that has child items, such as C:\Windows or C:\Windows\*, and not when it is an item does not have child items, such as C:\Windows\*.exe.

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

### System.String[]
You can pipe a file system path (in quotation marks) to Get-ChildItem.

## OUTPUTS

### System.IO.DirectoryInfo, System.IO.FileInfo, System.String

## NOTES
* You can also refer to Get-ChildItem by its built-in aliases, "ls", "dir", and "gci". For more information, see about_Aliases.

  Get-ChildItem does not get hidden items by default.
To get hidden items, use the Force parameter.

  The Get-ChildItem cmdlet is designed to work with the data exposed by any provider.
To list the providers available in your session, type "Get-PSProvider".
For more information, see about_Providers (http://go.microsoft.com/fwlink/?LinkID=113250).

*

The Attributes, Directory, File, Hidden, ReadOnly, and System parameters were introduced in Windows PowerShell 3.0 and 
are effective only in file system drives. 

Get-ChildItem Alias Reference:
---------------------------------
Get-ChildItem     dir
Directory         d, ad
File              af
Hidden            h, ah
ReadOnly          ar
System            as

## RELATED LINKS

[Get-ChildItem (generic); http://go.microsoft.com/fwlink/?LinkID=113308]()

[FileSystem Provider]()

[Clear-Content]()

[Get-Content]()

[Get-ChildItem]()

[Get-Content]()

[Get-Item]()

[Remove-Item]()

[Set-Content]()

[Test-Path]()

