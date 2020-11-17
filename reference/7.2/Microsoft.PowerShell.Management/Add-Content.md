---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 08/19/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/add-content?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Add-Content
---
# Add-Content

## SYNOPSIS
Adds content to the specified items, such as adding words to a file.

## SYNTAX

### Path (Default)

```
Add-Content [-Path] <string[]> [-Value] <Object[]> [-PassThru] [-Filter <string>]
 [-Include <string[]>] [-Exclude <string[]>] [-Force] [-Credential <pscredential>] [-WhatIf]
 [-Confirm] [-NoNewline] [-Encoding <Encoding>] [-AsByteStream] [-Stream <string>]
 [<CommonParameters>]
```

### LiteralPath

```
Add-Content [-Value] <Object[]> -LiteralPath <string[]> [-PassThru] [-Filter <string>]
 [-Include <string[]>] [-Exclude <string[]>] [-Force] [-Credential <pscredential>] [-WhatIf]
 [-Confirm] [-NoNewline] [-Encoding <Encoding>] [-AsByteStream] [-Stream <string>]
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

The **Path** parameter specifies all `.txt` files in the current directory, but the **Exclude**
parameter ignores file names that match the specified pattern. The **Value** parameter specifies the
text string that is written to the files.

### Example 2: Add a date to the end of the specified files

This example appends the date to files in the current directory and displays the date in the
PowerShell console.

```powershell
Add-Content -Path .\DateTimeFile1.log, .\DateTimeFile2.log -Value (Get-Date) -PassThru
Get-Content -Path .\DateTimeFile1.log
```

```Output
Tuesday, May 14, 2019 8:24:27 AM
Tuesday, May 14, 2019 8:24:27 AM
5/14/2019 8:24:27 AM
```

The `Add-Content` cmdlet creates two new files in the current directory. The **Value** parameter contains
the output of the `Get-Date` cmdlet. The **PassThru** parameter outputs the added contents to the pipeline.
Because there is no other cmdlet to receive the output, it is displayed in the PowerShell console.
The `Get-Content` cmdlet displays the updated file, `DateTimeFile1.log`.

### Example 3: Add the contents of a specified file to another file

This example gets the content from a file and stores the content in a variable. The variable is
used to append the content into another file.

```powershell
$From = Get-Content -Path .\CopyFromFile.txt
Add-Content -Path .\CopyToFile.txt -Value $From
Get-Content -Path .\CopyToFile.txt
```

- The `Get-Content` cmdlet gets the contents of `CopyFromFile.txt` and stores the contents in the
  `$From` variable.
- The `Add-Content` cmdlet updates the `CopyToFile.txt` file using the contents of the `$From`
  variable.
- The `Get-Content` cmdlet displays CopyToFile.txt.

### Example 4: Add the contents of a specified file to another file using the pipeline

This example gets the content from a file and pipes it to the `Add-Content` cmdlet.

```powershell
Get-Content -Path .\CopyFromFile.txt | Add-Content -Path .\CopyToFile.txt
Get-Content -Path .\CopyToFile.txt
```

The `Get-Content` cmdlet gets the contents of `CopyFromFile.txt`. The results are piped to the
`Add-Content` cmdlet, which updates the `CopyToFile.txt`.
The last `Get-Content` cmdlet displays `CopyToFile.txt`.

### Example 5: Create a new file and copy content

This example creates a new file and copies an existing file's content into the new file.

```powershell
Add-Content -Path .\NewFile.txt -Value (Get-Content -Path .\CopyFromFile.txt)
Get-Content -Path .\NewFile.txt
```

- The `Add-Content` cmdlet uses the **Path** and **Value** parameters to create a new file in the
  current directory.
- The `Get-Content` cmdlet gets the contents of an existing file, `CopyFromFile.txt`
  and passes it to the **Value** parameter. The parentheses around the `Get-Content` cmdlet ensure
  that the command finishes before the `Add-Content` command begins.
- The `Get-Content` cmdlet displays the contents of the new file, `NewFile.txt`.

### Example 6: Add content to a read-only file

This command adds a value to the file even if the **IsReadOnly** file attribute is set to **True**.
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
-ar--         1/28/2019     13:35              0 IsReadOnlyTextFile.txt
```

- The `New-Item` cmdlet uses the **Path** and **ItemType** parameters to create the file
  `IsReadOnlyTextFile.txt` in the current directory.
- The `Set-ItemProperty` cmdlet uses the **Name** and **Value** parameters to change the file's
  **IsReadOnly** property to True.
- The `Get-ChildItem` cmdlet shows the file is empty (0) and has the read-only attribute (`r`).
- The `Add-Content` cmdlet uses the **Path** parameter to specify the file. The **Value** parameter
  includes the text string to append to the file. The **Force** parameter writes the text to the
  read-only file.
- The `Get-Content` cmdlet uses the **Path** parameter to display the file's contents.

To remove the read-only attribute, use the `Set-ItemProperty` command with the **Value** parameter
set to `False`.

### Example 7: Use Filters with Add-Content

You can specify a filter to the `Add-Content` cmdlet. When using filters to qualify the **Path**
parameter, you need to include a trailing asterisk (`*`) to indicate the contents of the
path.

The following command adds the word "Done" the content of all `*.txt` files in the `C:\Temp`
directory.

```powershell
Add-Content -Path C:\Temp\* -Filter *.txt -Value "Done"
```

## PARAMETERS

### -AsByteStream

Specifies that the content should be read as a stream of bytes. This parameter was introduced in
PowerShell 6.0.

A warning occurs when you use the **AsByteStream** parameter with the **Encoding** parameter. The
**AsByteStream** parameter ignores any encoding and the output is returned as a stream of bytes.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential

> [!NOTE]
> This parameter is not supported by any providers installed with PowerShell.
> To impersonate another user, or elevate your credentials when running this cmdlet,
> use [Invoke-Command](../Microsoft.PowerShell.Core/Invoke-Command.md).

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Encoding

Specifies the type of encoding for the target file. The default value is `utf8NoBOM`.

Encoding is a dynamic parameter that the FileSystem provider adds to the `Add-Content` cmdlet. This
parameter works only in file system drives.

The acceptable values for this parameter are as follows:

- `ascii`: Uses the encoding for the ASCII (7-bit) character set.
- `bigendianunicode`: Encodes in UTF-16 format using the big-endian byte order.
- `bigendianutf32`: Encodes in UTF-32 format using the big-endian byte order.
- `oem`: Uses the default encoding for MS-DOS and console programs.
- `unicode`: Encodes in UTF-16 format using the little-endian byte order.
- `utf7`: Encodes in UTF-7 format.
- `utf8`: Encodes in UTF-8 format.
- `utf8BOM`: Encodes in UTF-8 format with Byte Order Mark (BOM)
- `utf8NoBOM`: Encodes in UTF-8 format without Byte Order Mark (BOM)
- `utf32`: Encodes in UTF-32 format.

Beginning with PowerShell 6.2, the **Encoding** parameter also allows numeric IDs of registered code
pages (like `-Encoding 1251`) or string names of registered code pages (like
`-Encoding "windows-1251"`). For more information, see the .NET documentation for
[Encoding.CodePage](/dotnet/api/system.text.encoding.codepage?view=netcore-2.2).

> [!NOTE]
> **UTF-7*** is no longer recommended to use. In PowerShell 7.1, a warning is written if you
> specify `utf7` for the **Encoding** parameter.

```yaml
Type: System.Text.Encoding
Parameter Sets: (All)
Aliases:
Accepted values: ASCII, BigEndianUnicode, BigEndianUTF32, OEM, Unicode, UTF7, UTF8, UTF8BOM, UTF8NoBOM, UTF32

Required: False
Position: Named
Default value: UTF8NoBOM
Accept pipeline input: False
Accept wildcard characters: False
```

### -Exclude

Specifies, as a string array, an item or items that this cmdlet excludes in the operation. The value
of this parameter qualifies the **Path** parameter. Enter a path element or pattern, such as
`*.txt`. Wildcard characters are permitted. The **Exclude** parameter is effective only when the
command includes the contents of an item, such as `C:\Windows\*`, where the wildcard character
specifies the contents of the `C:\Windows` directory.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Filter

Specifies a filter to qualify the **Path** parameter. The [FileSystem](../Microsoft.PowerShell.Core/About/about_FileSystem_Provider.md)
provider is the only installed PowerShell provider that supports the use of filters. You can find
the syntax for the **FileSystem** filter language in [about_Wildcards](../Microsoft.PowerShell.Core/About/about_Wildcards.md).
Filters are more efficient than other parameters, because the provider applies them when the cmdlet
gets the objects rather than having PowerShell filter the objects after they are retrieved.

```yaml
Type: System.String
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Include

Specifies, as a string array, an item or items that this cmdlet includes in the operation. The value
of this parameter qualifies the **Path** parameter. Enter a path element or pattern, such as
`"*.txt"`. Wildcard characters are permitted. The **Include** parameter is effective only when the
command includes the contents of an item, such as `C:\Windows\*`, where the wildcard character
specifies the contents of the `C:\Windows` directory.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -LiteralPath

Specifies a path to one or more locations. The value of **LiteralPath** is used exactly as it is
typed. No characters are interpreted as wildcards. If the path includes escape characters, enclose
it in single quotation marks. Single quotation marks tell PowerShell not to interpret any characters
as escape sequences.

For more information, see [about_Quoting_Rules](../Microsoft.Powershell.Core/About/about_Quoting_Rules.md).

```yaml
Type: System.String[]
Parameter Sets: LiteralPath
Aliases: PSPath, LP

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
Type: System.Management.Automation.SwitchParameter
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the path to the items that receive the additional content.
Wildcard characters are permitted.
The paths must be paths to items, not to containers.
For example, you must specify a path to one or more files, not a path to a directory.
If you specify multiple paths, use commas to separate the paths.

```yaml
Type: System.String[]
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
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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
Type: System.Object[]
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
Type: System.Management.Automation.SwitchParameter
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object, System.Management.Automation.PSCredential

You can pipe values, paths, or credentials to `Set-Content`.

## OUTPUTS

### None or System.String

When you use the **PassThru** parameter, `Add-Content` generates a **System.String** object that
represents the content. Otherwise, this cmdlet does not generate any output.

## NOTES

- When you pipe an object to `Add-Content`, the object is converted to a string before it is added to
  the item. The object type determines the string format, but the format might be different than the
  default display of the object. To control the string format, use the formatting parameters of the
  sending cmdlet.
- You can also refer to `Add-Content` by its built-in alias, `ac`. For more information, see
  [about_Aliases](../Microsoft.PowerShell.Core/About/about_Aliases.md).
- The `Add-Content` cmdlet is designed to work with the data exposed by any provider. To list the
  providers available in your session, type `Get-PSProvider`. For more information, see
  [about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

## RELATED LINKS

[about_Aliases](../Microsoft.PowerShell.Core/About/about_Aliases.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)

[Clear-Content](Clear-Content.md)

[Get-Content](Get-Content.md)

[Get-Item](Get-Item.md)

[New-Item](New-Item.md)

[Set-Content](Set-Content.md)

