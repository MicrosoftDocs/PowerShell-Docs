---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Add Content
ms.technology:  powershell
external help file:  PSITPro4_Management.xml
online version:  http://technet.microsoft.com/library/hh847782(v=wps.630).aspx
schema:  2.0.0
---


# Add-Content
## SYNOPSIS
Appends content, such as words or data, to a file.
## SYNTAX

### Path (Default)
```
Add-Content [-Value] <Object[]> [-PassThru] [-Path] <String[]> [-Filter <String>] [-Include <String[]>]
 [-Exclude <String[]>] [-Force] [-Credential <PSCredential>] [-WhatIf] [-Confirm] [-UseTransaction]
 [-Encoding <FileSystemCmdletProviderEncoding>] [-Stream <String>] [<CommonParameters>]
```

### LiteralPath
```
Add-Content [-Value] <Object[]> [-PassThru] -LiteralPath <String[]> [-Filter <String>] [-Include <String[]>]
 [-Exclude <String[]>] [-Force] [-Credential <PSCredential>] [-WhatIf] [-Confirm] [-UseTransaction]
 [-Encoding <FileSystemCmdletProviderEncoding>] [-Stream <String>] [<CommonParameters>]
```

## DESCRIPTION
The Add-Content cmdlet appends content to a specified item or file.
You can specify the content by typing the content in the command or by specifying an object that contains the content.

In file system drives, the Add-Content cmdlet appends the content you specify to the end of a file.
This cmdlet is not valid on folders.

Note: This custom cmdlet help file explains how the Add-Content cmdlet works in a file system drive.
For information about the Add-Content cmdlet in all drives, type "Get-Help Add-Content -Path $null" or see Add-Content at http://go.microsoft.com/fwlink/?LinkID=113278.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Add-Content -Path *.txt -Exclude help* -Value "END"
```

Description

-----------

This command adds "END" to all text files in the current directory, except for those with file names that begin with "help."
### -------------------------- EXAMPLE 2 --------------------------
```
Add-Content -Path file1.log, file2.log -Value (get-date) -PassThru
```

Description

-----------

This command adds the date to the end of the File1.log and File2.log files and then displays the date at the command line. 

The command uses the Get-Date cmdlet to get the date, and it uses the Value parameter to pass the date to Add-Content.
The PassThru parameter sends the added content through the pipeline.
Because there is no other cmdlet to receive the passed content, it is displayed at the command line.
### -------------------------- EXAMPLE 3 --------------------------
```
Add-Content -Path monthly.txt -Value (Get-Content c:\rec1\weekly.txt)
```

Description

-----------

This command adds the contents of the Weekly.txt file to the end of the Monthly.txt file.
It uses the Get-Content cmdlet to get the contents of the Weekly.txt file, and it uses the Value parameter to pass the content of weekly.txt to Add-Content.
The parentheses ensure that the Get-Content command is complete before the Add-Content command begins.

You can also copy the content of Weekly.txt to a variable, such as $w, and then use the Value parameter to pass the variable to Add-Content.
In that case, the command would be "add-content -path monthly.txt -value $w".
### -------------------------- EXAMPLE 4 --------------------------
```
Add-Content -Value (Get-Content test.log) -Path C:\tests\test134\logs\test134.log
```

Description

-----------

This command creates a new directory and file and copies the content of an existing file to the newly created file.

This command uses the Add-Content cmdlet to add the content.
The value of the Value parameter is a Get-Content command that gets content from an existing file, Test.log. 

The value of the path parameter is a path that does not exist when the command runs.
In this example, only the C:\Tests directories exist.
The command creates the remaining directories and the Test134.log file.

The Force parameter is not required for this command.
Add-Content creates directories to complete a path even without the Force parameter.
### -------------------------- EXAMPLE 5 --------------------------
```
Get-Content test.xml | Add-Content final.xml -Force -Encoding UTF8
```

Description

-----------

This command appends the contents of the final.xml file to the contents of the test.xml file. 

The command uses the Force parameter so that the command is successful even if the Final.xml file is read-only.
It uses the Encoding parameter to specify an encoding of UTF-8.
## PARAMETERS

### -Encoding
Specifies the file encoding.
The default is ASCII.

Valid values are:

-- ASCII:  Uses the encoding for the ASCII (7-bit) character set.
-- BigEndianUnicode:  Encodes in UTF-16 format using the big-endian byte order.
-- Byte:   Encodes a set of characters into a sequence of bytes.
-- String:  Uses the encoding type for a string.
-- Unicode:  Encodes in UTF-16 format using the little-endian byte order.
-- UTF7:   Encodes in UTF-7 format.
-- UTF8:  Encodes in UTF-8 format.
-- Unknown:  The encoding type is unknown or invalid.
The data can be treated as binary.

Encoding is a dynamic parameter that the FileSystem provider adds to the Add-Content cmdlet.
This parameter works only in file system drives.

```yaml
Type: FileSystemCmdletProviderEncoding
Parameter Sets: (All)
Aliases: 
Accepted values: Unknown, String, Unicode, Byte, BigEndianUnicode, UTF8, UTF7, UTF32, Ascii, Default, Oem

Required: False
Position: Named
Default value: ASCII
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Adds contents to files even if they are read-only.
Without this parameter, read-only files are not affected.

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

### -Stream
Adds the content to the specified alternate data stream.
If the stream does not yet, exist, Add-Content creates it.
Enter the stream name.
Wildcards are not supported.

Stream is a dynamic parameter that the FileSystem provider adds to the Add-Content cmdlet.
This parameter works only in file system drives.

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

### -Confirm
Prompts you for confirmation before executing the command.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Describes what would happen if you executed the command without actually executing the command.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

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
Aliases: usetx

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

### -Include
Adds only the specified items.
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
Specifies the path to the items that receive the additional content.
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

### -PassThru
Returns an object representing the added content.
By default, this cmdlet does not generate any output.

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

### -Path
Specifies the path to the items that receive the additional content.
Wildcards are permitted.
If you specify multiple paths, use commas to separate the paths.

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

### -Value
Specifies the content to be added.
Type a quoted string, such as "This data is for internal use only", or specify an object that contains content, such as the DateTime object that Get-Date generates.

You cannot specify the contents of a file by typing its path, because the path is just a string, but you can use a Get-Content command to get the content and pass it to the Value parameter.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: 
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### Sytem.Object[], System.String[], System.Management.Automation.PSCredential
You can pipe the value (object), a path, or a credential object to Add-Contnet.
## OUTPUTS

### None or System.String
When you use the Passthru parameter, Add-Content generates a System.String object representing the content.
Otherwise, this cmdlet does not generate any output.
## NOTES
* When you pipe an object to Add-Content, the object is converted to a string before it is added to the item. The object type determines the string format, but the format might be different than the default display of the object. To control the string format, use the formatting parameters of the sending cmdlet.

  You can also refer to Add-Content by its built-in alias, "ac".
For more information, see about_Aliases.

  The Add-Content cmdlet is designed to work with the data exposed by any provider.
To list the providers available in your session, type "Get-PsProvider".
For more information, see about_Providers.

*
## RELATED LINKS

[Add-Content (generic): http://go.microsoft.com/fwlink/?LinkID=113278]()

[FileSystem Provider]()

[Clear-Content]()

[Get-Content]()

[Get-ChildItem]()

[Get-Content]()

[Get-Item]()

[Remove-Item]()

[Set-Content]()

[Test-Path]()

