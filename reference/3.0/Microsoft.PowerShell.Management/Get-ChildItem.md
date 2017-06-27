---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=113308
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Get-ChildItem
---

# Get-ChildItem

## Synopsis
Gets the items and child items in one or more specified locations.

## Syntax

### Items (Default)

```powershell
Get-ChildItem [[-Path] <String[]>] [[-Filter] <String>] [-Include <String[]>] [-Exclude <String[]>] [-Recurse]
 [-Force] [-Name] [-UseTransaction]
 [-Attributes <System.Management.Automation.FlagsExpression`1[System.IO.FileAttributes]>] [-Directory] [-File]
 [-Hidden] [-ReadOnly] [-System] [<CommonParameters>]
```

### Literal Items

```powershell
Get-ChildItem -LiteralPath <String[]> [[-Filter] <String>] [-Include <String[]>] [-Exclude <String[]>]
 [-Recurse] [-Force] [-Name] [-UseTransaction]
 [-Attributes <System.Management.Automation.FlagsExpression`1[System.IO.FileAttributes]>] [-Directory] [-File]
 [-Hidden] [-ReadOnly] [-System] [<CommonParameters>]
```

## Description
The `Get-ChildItem` cmdlet gets the items in one or more specified locations.
If the item is a container, it gets the items inside the container, known as child items.
You can use the `-Recurse` parameter to get items in all child containers.

A location can be a file system location, such as a directory, or a location exposed by a different Windows PowerShell provider, such as a registry hive or a certificate store.

## Examples

### Example 1
```powershell
Get-ChildItem
```

This command gets the child items in the current location.
If the location is a file system directory, it gets the files and sub-directories in the current directory.
If the item does not have child items, this command returns to the command prompt without displaying anything.

The default display lists the mode (attributes), last write time, file size (length), and the name of the file.
The valid values for mode are `d` (directory), `a` (archive), `r` (read-only), `h` (hidden), and `s` (system).

### Example 2
```powershell
Get-ChildItem -Path *.txt -Recurse -Force
```

This command gets all of the .txt files in the current directory and its subdirectories.
The `-Recurse` parameter directs Windows PowerShell to get objects recursively, and it indicates that the subject of the command is the specified directory and its contents.
The `-Force` parameter adds hidden files to the display.

To use the `-Recurse` parameter on Windows PowerShell 2.0 and earlier versions of Windows PowerShell, the value use the `-Path` parameter must be a container.
Use the `-Include` parameter to specify the .txt file type.
For example, `Get-ChildItem -Path .\* -Include *.txt -Recurse`

### Example 3
```powershell
Get-ChildItem -Path C:\Windows\Logs\* -Include *.txt -Exclude A*
```

This command lists the .txt files in the Logs subdirectory, except for those whose names start with the letter A.
It uses the wildcard character (`*`) to indicate the contents of the Logs subdirectory, not the directory container.
Because the command does not include the `-Recurse` parameter, `Get-ChildItem` does not include the content of directory automatically; you need to specify it.

### Example 4
```powershell
Get-ChildItem -Path HKLM:\Software
```

This command gets all of the registry keys in the HKEY_LOCAL_MACHINE\SOFTWARE key in the registry of the local computer.

### Example 5
```powershell
Get-ChildItem -Name
```

This command gets only the names of items in the current directory.

### Example 6
```powershell
Import-Module Microsoft.PowerShell.Security
Get-ChildItem -Path Cert:\* -Recurse -CodeSigningCert
```

This command gets all of the certificates in the Windows PowerShell Cert: drive that have code-signing authority.

The first command imports the Microsoft.PowerShell.Security module into the session.
This module includes the Certificate provider that creates the Cert: drive.

The second command uses the `Get-ChildItem` cmdlet.
The value of the `-Path` parameter is the Cert: drive.
The `-Recurse` parameter requests a recursive search.
The `-CodeSigningCert` parameter is a dynamic parameter that the Certificate provider adds to the `Get-ChildItem` cmdlet.
This parameter gets only certificates that have code-signing authority.

For more information about the Certificate provider and the Cert: drive, go to [Certificate Provider](../../Microsoft.PowerShell.Security/Providers/certificate-provider.md) or use the `Update-Help` cmdlet to download the help files for the Microsoft.PowerShell.Security module and then type `Get-Help Certificate`.

### Example 7
```powershell
Get-ChildItem -Path C:\Windows -Include *mouse* -Exclude *.png
```

This command gets all of the items in the C:\Windows directory and its subdirectories that have "mouse" in the file name, except for those with a .png file name extension.

## Parameters

### -Attributes
Gets files and folders with the specified attributes. This parameter supports all attributes and lets you specify complex combinations of attributes.

For example, to get non-system files (not directories) that are encrypted or compressed, type:
```powershell
Get-ChildItem -Attributes !Directory+!System+Encrypted, !Directory+!System+Compressed
```

To find files and folders with commonly used attributes, you can use the `-Attributes` parameter, or the `-Directory`, `-File`, `-Hidden`, `-ReadOnly`, and `-System` switch parameters.

The `-Attributes` parameter supports the following attributes:
- Archive
- Compressed
- Device
- Directory
- Encrypted
- Hidden
- Normal
- NotContentIndexed
- Offline
- ReadOnly
- ReparsePoint
- SparseFile
- System
- Temporary

For a description of these attributes, see the [FileAttributes Enumeration](http://go.microsoft.com/fwlink/?LinkId=201508).

Use the following operators to combine attributes.
- `!`   (NOT)
- `+`   (AND)
- `,`   (OR)

No spaces are permitted between an operator and its attribute. However, spaces are permitted before commas.

You can use the following abbreviations for commonly used attributes:
- `D`   (Directory)
- `H`   (Hidden)
- `R`   (Read-only)
- `S`   (System)

```yaml
Type: System.Management.Automation.FlagsExpression`1[System.IO.FileAttributes]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Directory
Gets directories (folders).  

To get only directories, use the `-Directory` parameter and omit the `-File` parameter. To exclude directories, use the `-File` parameter and omit the `-Directory` parameter, or use the `-Attributes` parameter. 

To get directories, use the Directory parameter, its "`ad`" alias, or the Directory attribute of the `-Attributes` parameter.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: ad, d

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -File
Gets files. 

To get only files, use the `-File` parameter and omit the Directory parameter. To exclude files, use the `-Directory` parameter and omit the `-File` parameter, or use the `-Attributes` parameter.

To get files, use the File parameter, its "`af`" alias, or the File value of the `-Attributes` parameter.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: af

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Hidden
Gets only hidden files and directories (folders).  By default, `Get-ChildItem` gets only non-hidden items, but you can use the `-Force` parameter to include hidden items in the results.

To get only hidden items, use the `-Hidden` parameter, its "`h`" or "`ah`" aliases, or the Hidden value of the `-Attributes` parameter. To exclude hidden items, omit the `-Hidden` parameter or use the `-Attributes` parameter.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: ah, h

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReadOnly
Gets only read-only files and directories (folders).  

To get only read-only items, use the `-ReadOnly` parameter, its "`ar`" alias, or the ReadOnly value of the `-Attributes` parameter. To exclude read-only items, use the `-Attributes` parameter.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: ar

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -System
Gets only system files and directories (folders).

To get only system files and folders, use the `-System` parameter, its "`as`" alias, or the System value of the `-Attributes` parameter. To exclude system files and folders, use the `-Attributes` parameter.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: as

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Allows the cmdlet to get items that cannot otherwise not be accessed by the user, such as hidden or system files.
Implementation varies among providers.
For more information, see [about_Provider](../../Microsoft.PowerShell.Core/about/about_Providers.md).
Even when using the `-Force` parameter, the cmdlet cannot override security restrictions.

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

### -UseTransaction
Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see about_Transactions.

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

### -Exclude
Omits the specified items.
The value of this parameter qualifies the `-Path` parameter.
Enter a path element or pattern, such as "*.txt".
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Filter
Specifies a filter in the provider's format or language.
The value of this parameter qualifies the `-Path` parameter.
The syntax of the filter, including the use of wildcards, depends on the provider.
Filters are more efficient than other parameters, because the provider applies them when retrieving the objects, rather than having Windows PowerShell filter the objects after they are retrieved.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Include
Gets only the specified items.
The value of this parameter qualifies the `-Path` parameter.
Enter a path element or pattern, such as "*.txt".
Wildcards are permitted.

The `-Include` parameter is effective only when the command includes the `-Recurse` parameter or the path leads to the contents of a directory, such as C:\Windows\*, where the "`*`" wildcard character specifies the contents of the C:\Windows directory.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -LiteralPath
Specifies a path to one or more locations.
Unlike the `-Path` parameter, the value of the `-LiteralPath` parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: LiteralItems
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Gets only the names of the items in the locations.
If you pipe the output of this command to another command, only the item names are sent.

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

### -Path
Specifies a path to one or more locations.
Wildcards are permitted.
The default location is the current directory (`.`).

```yaml
Type: String[]
Parameter Sets: Items
Aliases: 

Required: False
Position: 1
Default value: Current directory
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -Recurse
Gets the items in the specified locations and in all child items of the locations.

In Windows PowerShell 2.0 and earlier versions of Windows PowerShell, the `-Recurse` parameter works only when the value of the `-Path` parameter is a container that has child items, such as C:\Windows or C:\Windows\*, and not when it is an item does not have child items, such as C:\Windows\*.exe.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: s

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](../../Microsoft.PowerShell.Core/about/about_CommonParameters.md).

## Inputs

### System.String
You can pipe a string that contains a path to `Get-ChildItem`.

## Outputs

### System.Object
The type of object that `Get-ChildItem` returns is determined by the objects in the provider drive path.

### System.String
If you use the `-Name` parameter, `Get-ChildItem` returns the object names as strings.

## Notes
You can also refer to `Get-ChildItem` by its built-in aliases, "`ls`", "`dir`", and "`gci`". For more information, see about_Aliases.

`Get-ChildItem` does not get hidden items by default.
To get hidden items, use the `-Force` parameter.

The `Get-ChildItem` cmdlet is designed to work with the data exposed by any provider.
To list the providers available in your session, type "`Get-PSProvider`".
For more information, see [about_Providers](../../Microsoft.PowerShell.Core/about/about_Providers.md).

## Related Links

[Get-Alias](../Microsoft.PowerShell.Utility/Get-Alias.md)

[Get-Item](Get-Item.md)

[Get-Location](Get-Location.md)

[Get-Process](Get-Process.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)
