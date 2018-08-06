---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821583
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Get-Content
---

# Get-Content

## SYNOPSIS
Gets the content of the item at the specified location.

## SYNTAX

### Path (Default)
```powershell
Get-Content [-Path] <String[]> [-ReadCount <Int64>] [-TotalCount <Int64>]
 [-Tail <Int32>] [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>]
 [-Force] [-Credential <PSCredential>] [-UseTransaction]
 [-Delimiter <String>] [-Wait] [-Raw]
 [-Encoding <FileSystemCmdletProviderEncoding>] [-Stream <String>]
 [<CommonParameters>]
```

### LiteralPath
```powershell
Get-Content -LiteralPath <String[]> [-ReadCount <Int64>] [-TotalCount <Int64>]
 [-Tail <Int32>] [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>]
 [-Force] [-Credential <PSCredential>] [-UseTransaction]
 [-Delimiter <String>] [-Wait] [-Raw]
 [-Encoding <FileSystemCmdletProviderEncoding>] [-Stream <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The **Get-Content** cmdlet gets the content of the item at the location specified by the path, such as the text in a file.
It reads the content one line at a time and returns a collection of objects, each of which represents a line of content.

Beginning in Windows PowerShell 3.0, this cmdlet can also get a specified number of lines from the beginning or end of an item.

## EXAMPLES

### Example 1: Get the content of a text file
```
PS C:\> Get-Content -Path "C:\Chapters\Chapter1.txt"
```

This command gets the content of the Chapter1.txt file.
It uses the *Path* parameter to specify the name of the item.
**Get-Content** passes the content down the pipeline, but because there are no other pipeline elements, the content is formatted by default and displayed at the command line.

### Example 2: Get the first 50 lines from a text file and store the results in another file
```
PS C:\> Get-Content "C:\Logs\Log060912.txt" -TotalCount 50 | Set-Content "Sample.txt"
```

This command gets the first 50 lines of the Log060912.txt file and stores them in the Sample.txt file.
The command uses the **Get-Content** cmdlet to get the text in the file.
(The name of *Path* parameter, which is optional, is omitted.) The *TotalCount* parameter limits the content retrieved to the first 50 lines.
The pipeline operator (|) sends the result to the Set-Content cmdlet, which places it in the Sample.txt file.

### Example 3: Get the fifth line of a text file
```
PS C:\> (Get-Content Cmdlets.txt -TotalCount 5)[-1]
```

This command gets the fifth line of the Cmdlets.txt text file.
It uses the *TotalCount* parameter to get the first five lines and then uses array notation to get the last line (indicated by "-1") of the resulting set.

### Example 4: Get the first and last line of a text file
```
PS C:\> dir .\*.txt | ForEach {Get-Content $_ -Head 1; Get-Content $_ -Tail 1}
```

This command gets the first and last lines of each text file in the current directory.
The command uses the *Tail* parameter and the *Head* alias of the *TotalCount* parameter

## PARAMETERS

### -Encoding
This parameter is not supported by any providers that are installed with PowerShell.

```yaml
Type: FileSystemCmdletProviderEncoding
Parameter Sets: (All)
Aliases:
Accepted values: Unknown, String, Unicode, Byte, BigEndianUnicode, UTF8, UTF7, UTF32, Ascii, Default, Oem, BigEndianUTF32

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Delimiter
This parameter is not supported by any providers that are installed with PowerShell.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Forces the command to run without asking for user confirmation.

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

### -Raw
This parameter is not supported by any providers that are installed with PowerShell.

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

### -Wait
This parameter is not supported by any providers that are installed with PowerShell.

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

### -Stream
This parameter is not supported by any providers that are installed with PowerShell.

```yaml
Type: String
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

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.

Type a user name, such as User01 or Domain01\User01, or enter a **PSCredential** object, such as one generated by the Get-Credential cmdlet.
If you type a user name, you will be prompted for a password.

This parameter is not supported by any providers that are installed with PowerShell.

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

### -Exclude
Specifies, as a string array, the item or items that this cmdlet omits when performing the operation.
The value of this parameter qualifies the *Path* parameter.
Enter a path element or pattern, such as *.txt.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter
Specifies a filter in the provider's format or language.
The value of this parameter qualifies the *Path* parameter.
The syntax of the filter, including the use of wildcards, depends on the provider.
Filters are more efficient than other parameters, because the provider applies them when this cmdlet gets the objects, rather than having PowerShell filter the objects after they are retrieved.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Include
Specifies, as a string array, the item or items that this cmdlet includes in the operation.
The value of this parameter qualifies the *Path* parameter.
Enter a path element or pattern, such as *.txt.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath
Specifies the path to an item.
Unlike the *Path* parameter, the value of *LiteralPath* is used exactly as it is typed.
No characters are interpreted as wildcards.
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
Specifies the path to an item.
**Get-Content** gets the content of the item.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ReadCount
Specifies how many lines of content are sent through the pipeline at a time.
The default value is 1.
A value of 0 (zero) sends all of the content at one time.

This parameter does not change the content displayed, but it does affect the time it takes to display the content.
As the value of *ReadCount* increases, the time it takes to return the first line increases, but the total time for the operation decreases.
This can make a perceptible difference in very large items.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TotalCount
Specifies the number of lines from the beginning of a file or other item.
The default is -1 (all lines).

You can use the *TotalCount* parameter name or its aliases, First or Head.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: First, Head

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Tail
Specifies the number of lines from the end of a file or other item.

This parameter was introduced in Windows PowerShell 3.0.

You can use the *Tail* parameter name or its alias, Last.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Last

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Byte, System.String
This cmdlet returns strings or bytes.
The output type depends upon the content that it gets.

## NOTES
* This cmdlet is designed to work with the data exposed by any provider. To get the providers in your session, use the Get-PSProvider cmdlet. For more information, see [about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)

*

## RELATED LINKS

[Add-Content](Add-Content.md)

[Clear-Content](Clear-Content.md)

[Set-Content](Set-Content.md)

[Get-PSProvider](Get-PSProvider.md)