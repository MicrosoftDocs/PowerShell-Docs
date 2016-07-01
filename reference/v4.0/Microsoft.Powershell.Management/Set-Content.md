---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Set Content
ms.technology:  powershell
external help file:  PSITPro4_Management.xml
online version:  http://technet.microsoft.com/library/hh847827(v=wps.630).aspx
schema:  2.0.0
---


# Set-Content
## SYNOPSIS
Replaces the contents of a file with contents that you specify.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Set-Content [-Path] <String[]> [-Value] <Object[]> [-Credential <PSCredential>] [-Exclude <String[]>]
 [-Filter <String>] [-Force] [-Include <String[]>] [-PassThru] [-Confirm] [-WhatIf] [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_2
```
Set-Content [-Value] <Object[]> [-Credential <PSCredential>] [-Exclude <String[]>] [-Filter <String>] [-Force]
 [-Include <String[]>] [-PassThru] -LiteralPath <String[]> [-Confirm] [-WhatIf] [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_3
```
Set-Content [-Encoding] [-Force] [-Stream <string>] [-Confirm] [-WhatIf] [-UseTransaction]
```

## DESCRIPTION
The Set-Content cmdlet is a string-processing cmdlet that writes or replaces the content in the specified item, such as a file.
Whereas the Add-Content cmdlet appends content to a file, Set-Content replaces the existing content.
You can type the content in the command or send content through the pipeline to Set-Content.

In file system drives, the Set-Content cmdlet overwrites or replaces the content of one or more files with the content that you specify.
This cmdlet is not valid on folders.

Note: This custom cmdlet help file explains how the Set-Content cmdlet works in a file system drive.
For information about the Set-Content cmdlet in all drives, type "Get-Help Set-Content -Path $null" or see Set-Content at http://go.microsoft.com/fwlink/?LinkID=113392.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Set-Content -Path C:\Test1\test*.txt -Value "Hello, World"
```

Description

-----------

This command replaces the contents of all files in the Test1 directory that have names beginning with "test" with "Hello, World".
This example shows how to specify content by typing it in the command.

### -------------------------- EXAMPLE 2 --------------------------
```
Get-Date | Set-Content C:\Test1\date.csv
```

Description

-----------

This command creates a comma-separated variable-length (csv) file that contains only the current date and time.
It uses the Get-Date cmdlet to get the current system date and time.
The pipeline operator passes the result to Set-Content, which creates the file and writes the content.

If the Test1 directory does not exist, the command fails, but if the file does not exist, the command will create it.

### -------------------------- EXAMPLE 3 --------------------------
```
Get-Content Notice.txt | ForEach-Object {$_ -replace "Warning", "Caution"} | Set-Content Notice.txt
```

Description

-----------

This command replaces all instances of "Warning" with "Caution" in the Notice.txt file. 

It uses the Get-Content cmdlet to get the content of Notice.txt.
The pipeline operator sends the results to the ForEach-Object cmdlet, which applies the expression to each line of content in Get-Content.
The expression uses the "$_" symbol to refer to the current item and the Replace parameter to specify the text to be replaced. 

Another pipeline operator sends the changed content to Set-Content which replaces the text in Notice.txt with the new content.

The parentheses around the Get-Content command ensure that the Get operation is complete before the Set operation begins.
Without them, the command will fail because the two functions will be trying to access the same file.

### -------------------------- EXAMPLE 4 --------------------------
```
Get-Content test.xml | Set-Content final.xml -Force -Encoding UTF8
```

Description

-----------

This command replaces the contents of the final.xml file with the contents of the test.xml file. 

The command uses the Force parameter so that the command is successful even if the Final.xml file is read-only.
It uses the Encoding dynamic parameter to specify an encoding of UTF-8.

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

Encoding is a dynamic parameter that the FileSystem provider adds to the Set-Content cmdlet.
This parameter works only in file system drives.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 
Accepted values: Unknown, String, Unicode, Byte, BigEndianUnicode, UTF8, UTF7, UTF32, Ascii, Default, Oem

Required: False
Position: Named
Default value: ASCII
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Replaces the contents of a file, even if the file is read-only.
Without this parameter, read-only files are not changed.

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

### -Stream
Creates or replaces the content in the specified alternate data stream.
If the stream does not yet exist, Set-Content creates it.
Enter the stream name.
Wildcards are not supported.

Stream is a dynamic parameter that the FileSystem provider adds to the Set-Content cmdlet.
This parameter works only in file system drives.

You can use the Set-Content cmdlet to change the content of the Zone.Identifier alternate data stream.
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

### -Confirm
Prompts you for confirmation before executing the command.

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

### -WhatIf
Describes what would happen if you executed the command without actually executing the command.

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

### -Include
Changes only the specified items.
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
Specifies the path to the item that will receive the content.
Unlike Path, the value of LiteralPath is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -PassThru
Returns an object representing the content.
By default, this cmdlet does not generate any output.

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

### -Path
Specifies the path to the item that will receive the content.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Value
Specifies the new content for the item.

```yaml
Type: Object[]
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 2
Default value: 
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

### System.Object[], System.String[], System.Management.Automation.PSCredential
You can pipe a value (object), a path, or a credential object to Set-Content

## OUTPUTS

### None or System.String
When you use the Passthru parameter, Set-Content generates a System.String object representing the content.
Otherwise, this cmdlet does not generate any output.

## NOTES
* You can also refer to Set-Content by its built-in alias, "sc". For more information, see about_Aliases.

  Set-Content is designed for string processing.
If you pipe non-string objects to Set-Content, it converts the object to a string before writing it.
To write objects to files, use Out-File.

  The Set-Content cmdlet is designed to work with the data exposed by any provider.
To list the providers available in your session, type "Get-PsProvider".
For more information, see about_Providers.

*

## RELATED LINKS

[Set-Content (generic); http://go.microsoft.com/fwlink/?LinkID=113392]()

[FileSystem Provider]()

[Clear-Content]()

[Get-Content]()

[Get-ChildItem]()

[Get-Content]()

[Get-Item]()

[Remove-Item]()

[Set-Content]()

[Test-Path]()

