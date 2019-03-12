---
ms.date:  1/30/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821629
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Set-Content
---
# Set-Content

## SYNOPSIS
Writes new content or replaces existing content in a file.

## SYNTAX

### Path (Default)

```
Set-Content [-Path] <string[]> [-Value] <Object[]> [-PassThru] [-Filter <string>]
[-Include <string[]>] [-Exclude <string[]>] [-Force] [-Credential <pscredential>]
[-WhatIf] [-Confirm] [-NoNewline] [-Encoding <Encoding>][-AsByteStream] [-Stream <string>]
[<CommonParameters>]
```

### LiteralPath

```
Set-Content [-Value] <Object[]> -LiteralPath <string[]> [-PassThru] [-Filter <string>]
[-Include <string[]>] [-Exclude <string[]>] [-Force] [-Credential <pscredential>]
[-WhatIf] [-Confirm] [-NoNewline] [-Encoding <Encoding>][-AsByteStream] [-Stream <string>]
[<CommonParameters>]
```

## DESCRIPTION

`Set-Content` is a string-processing cmdlet that writes new content or replaces the content in a
file. `Set-Content` replaces the existing content and differs from the `Add-Content` cmdlet that
appends content to a file. To send content to `Set-Content` you can use the **Value** parameter on
the command line or send content through the pipeline.

If you need to create files or directories for the following examples, see [New-Item](New-Item.md).

## EXAMPLES

### Example 1: Replace the contents of multiple files in a directory

This example replaces the content for multiple files in the current directory.

```
PS> Get-ChildItem -Path .\Test*.txt

Test1.txt
Test2.txt
Test3.txt

PS> Set-Content -Path .\Test*.txt -Value 'Hello, World'

PS> Get-Content -Path .\Test*.txt

Hello, World
Hello, World
Hello, World
```

The `Get-ChildItem` cmdlet uses the **Path** parameter to list **.txt** files that begin with
`Test*` in the current directory. The `Set-Content` cmdlet uses the **Path** parameter to specify
the `Test*.txt` files. The **Value** parameter provides the text string **Hello, World** that
replaces the existing content in each file. The `Get-Content` cmdlet uses the **Path** parameter to
specify the `Test*.txt` files and displays each file's content in the PowerShell console.

### Example 2: Create a new file and write content

This example creates a new file and writes the current date and time to the file.

```powershell
Set-Content -Path .\DateTime.txt -Value (Get-Date)
Get-Content -Path .\DateTime.txt
```

```Output
1/30/2019 09:55:08
```

`Set-Content` uses the **Path** and **Value** parameters to create a new file named **DateTime.txt**
in the current directory. The **Value** parameter uses `Get-Date` to get the current date and time.
`Set-Content` writes the **DateTime** object to the file as a string. The `Get-Content` cmdlet uses
the **Path** parameter to display the content of **DateTime.txt** in the PowerShell console.

### Example 3: Replace text in a file

This command replaces all instances of word within an existing file.

```
PS> Get-Content -Path .\Notice.txt

Warning
Replace Warning with a new word.
The word Warning was replaced.

PS> (Get-Content -Path .\Notice.txt) | ForEach-Object {$_ -Replace 'Warning', 'Caution'} | Set-Content -Path .\Notice.txt

PS> Get-Content -Path .\Notice.txt

Caution
Replace Caution with a new word.
The word Caution was replaced.
```

The `Get-Content` cmdlet uses the **Path** parameter to specify the **Notice.txt** file in the
current directory and displays the file's content in the PowerShell console.

The `Get-Content` cmdlet uses the **Path** parameter to specify the **Notice.txt** file in the
current directory. The `Get-Content` command is wrapped with parentheses so that the command
finishes before being sent down the pipeline. The contents of the **Notice.txt** file are sent down
the pipeline to the `ForEach-Object` cmdlet. `ForEach-Object` uses the automatic variable `$_` and
replaces each occurrence of **Warning** with **Caution**. The objects are sent down the pipeline to
the `Set-Content` cmdlet. `Set-Content` uses the **Path** parameter to specify the **Notice.txt**
file and writes the updated content to the file.

The `Get-Content` cmdlet displays the updated file content in the PowerShell console.

## PARAMETERS

### -AsByteStream

Specifies that the content should be read as a stream of bytes. This parameter was introduced in
PowerShell 6.0.

A warning occurs when you use the **AsByteStream** parameter with the **Encoding** parameter. The
**AsByteStream** parameter ignores any encoding and the output is returned as a stream of bytes.

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

### -Credential

Specifies a user account that has permission to perform this action. The default is the current
user.

Type a user name, such as **User01** or **Domain01\User01**, or enter a **PSCredential** object,
such as one generated by the `Get-Credential` cmdlet. If you type a user name, you will be prompted
for a password.

> [!WARNING]
> This parameter is not supported by any providers installed with PowerShell.

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

### -Encoding

Specifies the type of encoding for the target file. The default value is **UTF8NoBOM**.

Encoding is a dynamic parameter that the FileSystem provider adds to `Set-Content`. This parameter
works only in file system drives.

The acceptable values for this parameter are as follows:

- **ASCII**: Uses the encoding for the ASCII (7-bit) character set.
- **BigEndianUnicode**: Encodes in UTF-16 format using the big-endian byte order.
- **Byte**: Encodes a set of characters into a sequence of bytes.
- **Default**: Encodes using the default value: ASCII.
- **OEM**: Uses the default encoding for MS-DOS and console programs.
- **String**: Uses the encoding type for a string.
- **Unicode**: Encodes in UTF-16 format using the little-endian byte order.
- **UTF7**: Encodes in UTF-7 format.
- **UTF8**: Encodes in UTF-8 format.
- **UTF8BOM**: Encodes in UTF-8 format with Byte Order Mark (BOM)
- **UTF8NoBOM**: Encodes in UTF-8 format without Byte Order Mark (BOM)
- **UTF32**: Encodes in UTF-32 format.
- **Unknown**: The encoding type is unknown or invalid; the data can be treated as binary.

```yaml
Type: Encoding
Parameter Sets: (All)
Aliases:
Accepted values: ASCII, BigEndianUnicode, Byte, Default, OEM, String, Unicode, UTF7, UTF8, UTF8BOM, UTF8NoBOM, UTF32, Unknown

Required: False
Position: Named
Default value: UTF8NoBOM
Accept pipeline input: False
Accept wildcard characters: False
```

### -Exclude

Omits the specified items. The value of this parameter qualifies the Path parameter. Enter a path
element or pattern, such as `*.txt`. Wildcards are permitted.

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

Specifies a filter in the provider's format or language. The value of this parameter qualifies the
**Path** parameter. The syntax of the filter, including the use of wildcards, depends on the
provider. **Filters** are more efficient than other parameters because the provider applies filters
when objects are retrieved. Otherwise, PowerShell processes filters after the objects are retrieved.

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

Forces the cmdlet to set the contents of a file, even if the file is read-only. Implementation
varies from provider to provider. For more information, see [about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).
The **Force** parameter does not override security restrictions.

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

### -Include

Changes only the specified items. The value of this parameter qualifies the **Path** parameter.
Enter a path element or pattern, such as `*.txt`. Wildcards are permitted.

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

Specifies the path of the item that receives the content. Unlike **Path**, the value of
**LiteralPath** is used exactly as it is typed. No characters are interpreted as wildcards. If the
path includes escape characters, enclose it in single quotation marks. Single quotation marks tell
PowerShell not to interpret any characters as escape sequences.

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

### -NoNewline

The string representations of the input objects are concatenated to form the output. No spaces or
newlines are inserted between the output strings. No newline is added after the last output string.

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

### -PassThru

Returns an object that represents the content. By default, this cmdlet does not generate any output.

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

Specifies the path of the item that receives the content. Wildcard characters are permitted.

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

### -Stream

Specifies an alternative data stream for content. If the stream does not exist, this cmdlet creates
it. Wildcard characters are not supported.

**Stream** is a dynamic parameter that the **FileSystem** provider adds to `Set-Content`. This
parameter works only in file system drives.

You can use the `Set-Content` cmdlet to change the content of the **Zone.Identifier** alternate data
stream. However, we do not recommend this as a way to eliminate security checks that block files
that are downloaded from the Internet. If you verify that a downloaded file is safe, use the
`Unblock-File` cmdlet.

This parameter was introduced in PowerShell 3.0.

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

### -Value

Specifies the new content for the item.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

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

Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`,
`-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`,
`-Verbose`, `-WarningAction`, and `-WarningVariable`.
For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object

You can pipe an object that contains the new value for the item to `Set-Content`.

## OUTPUTS

### None or System.String

When you use the **PassThru** parameter, `Set-Content` generates a **System.String** object that
represents the content. Otherwise, this cmdlet does not generate any output.

## NOTES

You can also refer to `Set-Content` by its built-in alias, `sc`. For more information, see
[about_Aliases](../Microsoft.PowerShell.Core/About/about_Aliases.md).

`Set-Content` is designed for string processing. If you pipe non-string objects to `Set-Content`,
it converts the object to a string before writing it. To write objects to files, use `Out-File`.

The `Set-Content` cmdlet is designed to work with the data exposed by any provider. To list the
providers available in your session, type `Get-PsProvider`. For more information, see
[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

## RELATED LINKS

[about_Aliases](../Microsoft.PowerShell.Core/About/about_Aliases.md)

[about_Automatic_Variables.md](../Microsoft.PowerShell.Core/About/about_Automatic_Variables.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)

[Add-Content](Add-Content.md)

[Clear-Content](Clear-Content.md)

[Get-ChildItem](Get-ChildItem.md)

[Get-Content](Get-Content.md)

[ForEach-Object](../Microsoft.PowerShell.Core/ForEach-Object.md)

[New-Item](New-Item.md)