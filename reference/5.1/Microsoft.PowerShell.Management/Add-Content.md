---
ms.date:  04/23/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821565
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Add-Content
---
# Add-Content

## SYNOPSIS
Adds content to the specified items, such as adding words to a file.

## SYNTAX

### Path (Default)

```
Add-Content [-Path] <string[]> [-Value] <Object[]> [-PassThru] [-Filter <string>] [-Include
<string[]>] [-Exclude <string[]>] [-Force] [-Credential <pscredential>] [-WhatIf] [-Confirm]
[-UseTransaction] [-NoNewline] [-Encoding <FileSystemCmdletProviderEncoding>] [-Stream <string>]
[<CommonParameters>]
```

### LiteralPath

```
Add-Content [-Value] <Object[]> -LiteralPath <string[]> [-PassThru] [-Filter <string>] [-Include
<string[]>] [-Exclude <string[]>] [-Force] [-Credential <pscredential>] [-WhatIf] [-Confirm]
[-UseTransaction] [-NoNewline] [-Encoding <FileSystemCmdletProviderEncoding>] [-Stream <string>]
[<CommonParameters>]
```

## DESCRIPTION

The `Add-Content` cmdlet appends content to a specified item or file. You can specify the content
by typing the content in the command or by specifying an object that contains the content.

If you need to create files or directories for the following examples, see [New-Item](New-Item.md).

## EXAMPLES

### Example 1: Add a string to all text files with an exception

This example appends a value to text files in the current directory but excludes files based on
their file name.

```powershell
Add-Content -Path .\*.txt -Exclude help* -Value 'End of file'
```

The `Add-Content` cmdlet uses the **Path** parameter to specify all .txt files in the current
directory. The **Exclude** parameter ignores file names that match the specified pattern. The
**Value** parameter specifies the text string that is written to the files.

Use [Get-Content](Get-Content.md) to display the contents of these files.

### Example 2: Add a date to the end of the specified files

This example appends the date to files in the current directory and displays the date in the
PowerShell console.

```powershell
Add-Content -Path .\DateTimeFile1.log, .\DateTimeFile2.log -Value (Get-Date) -PassThru
Get-Content -Path .\DateTimeFile1.log
```

The `Add-Content` cmdlet uses the **Path** and **Value** parameters to create two new files in the
current directory. The **Value** parameter specifies the `Get-Date` cmdlet to get the date and
passes the date to `Add-Content`. The `Add-Content` cmdlet writes the date to each file. The
**PassThru** parameter passes an object that represents the date object. Because there is no other
cmdlet to receive the passed object, it is displayed in the PowerShell console. The `Get-Content`
cmdlet displays the updated file, DateTimeFile1.log.

### Example 3: Add the contents of a specified file to another file

This example gets the content from a file and appends that content into another file.

```powershell
Add-Content -Path .\CopyToFile.txt -Value (Get-Content -Path .\CopyFromFile.txt)
Get-Content -Path .\CopyToFile.txt
```

The `Add-Content` cmdlet uses the **Path** parameter to specify the new file in the current
directory, CopyToFile.txt. The **Value** parameter uses the `Get-Content` cmdlet to get the
contents of the file, CopyFromFile.txt. The parentheses around the `Get-Content` cmdlet ensure that
the command finishes before the `Add-Content` command begins. The **Value** parameter is passed to
`Add-Content`. The `Add-Content` cmdlet appends the data to the CopyToFile.txt file. The
`Get-Content` cmdlet displays the updated file, CopyToFile.txt.

### Example 4: Use a variable to add the contents of a specified file to another file

This example gets the content from a file and stores the content in a variable. The variable is
used to append the content into another file.

```powershell
$From = Get-Content -Path .\CopyFromFile.txt
Add-Content -Path .\CopyToFile.txt -Value $From
Get-Content -Path .\CopyToFile.txt
```

The `Get-Content` cmdlet gets the contents of CopyFromFile.txt and stores the contents in the
`$From` variable. The `Add-Content` cmdlet uses the **Path** parameter to specify the
CopyToFile.txt file in the current directory. The **Value** parameter uses the `$From` variable and
passes the content to `Add-Content`. The `Add-Content` cmdlet updates the CopyToFile.txt file. The
`Get-Content` cmdlet displays CopyToFile.txt.

### Example 5: Create a new file and copy content

This example creates a new file and copies an existing file's content into the new file.

```powershell
Add-Content -Path .\NewFile.txt -Value (Get-Content -Path .\CopyFromFile.txt)
Get-Content -Path .\NewFile.txt
```

The `Add-Content` cmdlet uses the **Path** and **Value** parameters to create a new file in the
current directory. The **Value** parameter uses the `Get-Content` cmdlet to get the contents of an
existing file, CopyFromFile.txt. The parentheses around the `Get-Content` cmdlet ensure that the
command finishes before the `Add-Content` command begins. The **Value** parameter passes the
content to `Add-Content` which updates the NewFile.txt file. The `Get-Content` cmdlet displays the
contents of the new file, NewFile.txt.

### Example 6: Add content to a read-only file

This command adds the value to the file even if the **IsReadOnly** file attribute is set to True.
The steps to create a read-only file are included in the example.

```powershell
New-Item -Path .\IsReadOnlyTextFile.txt -ItemType File
Set-ItemProperty -Path .\IsReadOnlyTextFile.txt -Name IsReadOnly -Value $True
Get-ChildItem -Path .\IsReadOnlyTextFile.txt
Add-Content -Path .\IsReadOnlyTextFile.txt -Value 'Add value to read-only text file' -Force
Get-Content -Path .\IsReadOnlyTextFile.txt
```

```Output
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-ar---        1/28/2019     13:35              0 IsReadOnlyTextFile.txt
```

The `New-Item` cmdlet uses the **Path** and **ItemType** parameters to create the file
IsReadOnlyTextFile.txt in the current directory. The `Set-ItemProperty` cmdlet uses the **Name**
and **Value** parameters to change the file's **IsReadOnly** property to True. The `Get-ChildItem`
cmdlet shows the file is empty (0) and has the read-only attribute (`r`). The `Add-Content` cmdlet
uses the **Path** parameter to specify the file. The **Value** parameter includes the text string
to append to the file. The **Force** parameter writes the text to the read-only file. The
`Get-Content` cmdlet uses the **Path** parameter to display the file's contents.

To remove the read-only attribute, use the `Set-ItemProperty` command with the **Value** parameter
set to `False`.

## PARAMETERS

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

Specifies the type of encoding for the target file. The default value is **Default**.

The acceptable values for this parameter are as follows:

- **ASCII** Uses ASCII (7-bit) character set.
- **BigEndianUnicode** Uses UTF-16 with the big-endian byte order.
- **BigEndianUTF32** Uses UTF-32 with the big-endian byte order.
- **Byte** Encodes a set of characters into a sequence of bytes.
- **Default** Uses the encoding that corresponds to the system's active code page (usually ANSI).
- **OEM** Uses the encoding that corresponds to the system's current OEM code page.
- **String** Same as **Unicode**.
- **Unicode** Uses UTF-16 with the little-endian byte order.
- **Unknown** Same as **Unicode**.
- **UTF7** Uses UTF-7.
- **UTF8** Uses UTF-8.
- **UTF32** Uses UTF-32 with the little-endian byte order.

Encoding is a dynamic parameter that the FileSystem provider adds to the `Add-Content` cmdlet. This
parameter works only in file system drives.

```yaml
Type: FileSystemCmdletProviderEncoding
Parameter Sets: (All)
Aliases:
Accepted values: ASCII, BigEndianUnicode, BigEndianUTF32, Byte, Default, OEM, String, Unicode, Unknown, UTF7, UTF8, UTF32

Required: False
Position: Named
Default value: Default
Accept pipeline input: False
Accept wildcard characters: False
```

### -Exclude

Omits the specified items. The value of this parameter qualifies the **Path** parameter. Enter a
path element or pattern, such as **\*.txt**. Wildcards are permitted.

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

Specifies a filter in the provider's format or language. The value of this parameter qualifies the
**Path** parameter. The syntax of the filter, including the use of wildcards, depends on the
provider. **Filters** are more efficient than other parameters because the provider applies filters
when objects are retrieved. Otherwise, PowerShell processes filters after the objects are
retrieved.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Force

Overrides the read-only attribute, allowing you to add content to a read-only file. For example,
**Force** will override the read-only attribute or create directories to complete a file path, but
it will not attempt to change file permissions.

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

Adds only the specified items. The value of this parameter qualifies the **Path** parameter. Enter
a path element or pattern, such as **\*.txt**. Wildcards are permitted.

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

Specifies the path to the items that receive the additional content. Unlike **Path**, the value of
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

Indicates that this cmdlet does not add a new line or carriage return to the content.

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

Returns an object representing the added content. By default, this cmdlet does not generate any
output.

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

Specifies the path to the items that receive the additional content. Wildcards are permitted. If
you specify multiple paths, use commas to separate the paths.

```yaml
Type: String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Stream

Specifies an alternative data stream for content. If the stream does not exist, this cmdlet creates
it. Wildcard characters are not supported.

**Stream** is a dynamic parameter that the FileSystem provider adds to `Add-Content`. This
parameter works only in file system drives.

You can use the `Add-Content` cmdlet to change the content of the **Zone.Identifier** alternate
data stream. However, we do not recommend this as a way to eliminate security checks that block
files that are downloaded from the Internet. If you verify that a downloaded file is safe, use the
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

### -UseTransaction

Includes the command in the active transaction. This parameter is valid only when a transaction is
in progress. For more information, see [about_Transactions](../Microsoft.PowerShell.Core/About/about_Transactions.md).

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

### -Value

Specifies the content to be added. Type a quoted string, such as **This data is for internal use
only**, or specify an object that contains content, such as the **DateTime** object that `Get-Date`
generates.

You cannot specify the contents of a file by typing its path, because the path is just a string.
You can use a `Get-Content` command to get the content and pass it to the **Value** parameter.

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
`-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object, System.Management.Automation.PSCredential

You can pipe values, paths, or credentials to `Set-Content`.

## OUTPUTS

### None or System.String

When you use the **PassThru** parameter, `Add-Content` generates a **System.String** object that
represents the content. Otherwise, this cmdlet does not generate any output.

## NOTES

When you pipe an object to `Add-Content`, the object is converted to a string before it is added to
the item. The object type determines the string format, but the format might be different than the
default display of the object. To control the string format, use the formatting parameters of the
sending cmdlet.

You can also refer to `Add-Content` by its built-in alias, `ac`. For more information, see
[about_Aliases](../Microsoft.PowerShell.Core/About/about_Aliases.md).

The `Add-Content` cmdlet is designed to work with the data exposed by any provider. To list the
providers available in your session, type `Get-PSProvider`. For more information, see
[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

## RELATED LINKS

[about_Aliases](../Microsoft.PowerShell.Core/About/about_Aliases.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)

[about_Transactions](../Microsoft.PowerShell.Core/About/about_Transactions.md)

[Clear-Content](Clear-Content.md)

[Get-Content](Get-Content.md)

[Get-Item](Get-Item.md)

[New-Item](New-Item.md)

[Set-Content](Set-Content.md)