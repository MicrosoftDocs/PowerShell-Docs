---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 08/19/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/get-content?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-Content
---
# Get-Content

## SYNOPSIS
Gets the content of the item at the specified location.

## SYNTAX

### Path (Default)

```
Get-Content [-ReadCount <Int64>] [-TotalCount <Int64>] [-Tail <Int32>] [-Path] <String[]>
 [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>] [-Force] [-Credential <PSCredential>]
 [-Delimiter <String>] [-Wait] [-Raw] [-Encoding <Encoding>] [-AsByteStream] [-Stream <String>]
 [<CommonParameters>]
```

### LiteralPath

```
Get-Content [-ReadCount <Int64>] [-TotalCount <Int64>] [-Tail <Int32>] -LiteralPath <String[]>
 [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>] [-Force] [-Credential <PSCredential>]
 [-Delimiter <String>] [-Wait] [-Raw] [-Encoding <Encoding>] [-AsByteStream] [-Stream <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-Content` cmdlet gets the content of the item at the location specified by the path, such as
the text in a file or the content of a function. For files, the content is read one line at a time
and returns a collection of objects, each of which represents a line of content.

Beginning in PowerShell 3.0, `Get-Content` can also get a specified number of lines from the
beginning or end of an item.

## EXAMPLES

### Example 1: Get the content of a text file

This example gets the content of a file in the current directory. The `LineNumbers.txt` file
contains 100 lines in the format, **This is Line X** and is used in several examples.

```powershell
1..100 | ForEach-Object { Add-Content -Path .\LineNumbers.txt -Value "This is line $_." }
Get-Content -Path .\LineNumbers.txt
```

```Output
This is Line 1
This is Line 2
...
This is line 99.
This is line 100.
```

The array values 1-100 are sent down the pipeline to the `ForEach-Object` cmdlet. `ForEach-Object`
uses a script block with the `Add-Content` cmdlet to create the `LineNumbers.txt` file. The variable
`$_` represents the array values as each object is sent down the pipeline. The `Get-Content` cmdlet
uses the **Path** parameter to specify the `LineNumbers.txt` file and displays the content in the
PowerShell console.

### Example 2: Limit the number of lines Get-Content returns

This command gets the first five lines of a file. The **TotalCount** parameter is used to gets the
first five lines of content. This example uses the `LineNumbers.txt` file that was created in
Example 1.

```powershell
Get-Content -Path .\LineNumbers.txt -TotalCount 5
```

```Output
This is Line 1
This is Line 2
This is Line 3
This is Line 4
This is Line 5
```

### Example 3: Get a specific line of content from a text file

This command gets a specific number of lines from a file and then displays only the last line of
that content. The **TotalCount** parameter gets the first 25 lines of content. This example uses the
`LineNumbers.txt` file that was created in Example 1.

```powershell
(Get-Content -Path .\LineNumbers.txt -TotalCount 25)[-1]
```

```Output
This is Line 25
```

The `Get-Content` command is wrapped in parentheses so that the command completes before going to
the next step. `Get-Content`returns an array of lines, this allows you to add the index notation after
the parenthesis to retrieve a specific line number. In this case, the `[-1]` index specifies the
last index in the returned array of 25 retrieved lines.

### Example 4: Get the last line of a text file

This command gets the first line and last line of content from a file. This example uses the
`LineNumbers.txt` file that was created in Example 1.

```powershell
Get-Item -Path .\LineNumbers.txt | Get-Content -Tail 1
```

```Output
This is Line 100
```

This example uses the `Get-Item` cmdlet to demonstrate that you can pipe files into the
`Get-Content` parameter. The **Tail** parameter gets the last line of the file. This method is
faster than retrieving all of the lines and using the `[-1]` index notation.

### Example 5: Get the content of an alternate data stream

This example describes how to use the **Stream** parameter to get the content of an alternate data
stream for files stored on a Windows NTFS volume. In this example, the `Set-Content` cmdlet is used
to create sample content in a file named `Stream.txt`.

```powershell
Set-Content -Path .\Stream.txt -Value 'This is the content of the Stream.txt file'
# Specify a wildcard to the Stream parameter to display all streams of the recently created file.
Get-Item -Path .\Stream.txt -Stream *
```

```Output
PSPath        : Microsoft.PowerShell.Core\FileSystem::C:\Test\Stream.txt::$DATA
PSParentPath  : Microsoft.PowerShell.Core\FileSystem::C:\Test
PSChildName   : Stream.txt::$DATA
PSDrive       : C
PSProvider    : Microsoft.PowerShell.Core\FileSystem
PSIsContainer : False
FileName      : C:\Test\Stream.txt
Stream        : :$DATA
Length        : 44
```

```powershell
# Retrieve the content of the primary, or $DATA stream.
Get-Content -Path .\Stream.txt -Stream $DATA
```

```Output
This is the content of the Stream.txt file
```

```powershell
# Use the Stream parameter of Add-Content to create a new Stream containing sample content.
Add-Content -Path .\Stream.txt -Stream NewStream -Value 'Added a stream named NewStream to Stream.txt'
# Use Get-Item to verify the stream was created.
Get-Item -Path .\Stream.txt -Stream *
```

```Output
PSPath        : Microsoft.PowerShell.Core\FileSystem::C:\Test\Stream.txt::$DATA
PSParentPath  : Microsoft.PowerShell.Core\FileSystem::C:\Test
PSChildName   : Stream.txt::$DATA
PSDrive       : C
PSProvider    : Microsoft.PowerShell.Core\FileSystem
PSIsContainer : False
FileName      : C:\Test\Stream.txt
Stream        : :$DATA
Length        : 44

PSPath        : Microsoft.PowerShell.Core\FileSystem::C:\Test\Stream.txt:NewStream
PSParentPath  : Microsoft.PowerShell.Core\FileSystem::C:\Test
PSChildName   : Stream.txt:NewStream
PSDrive       : C
PSProvider    : Microsoft.PowerShell.Core\FileSystem
PSIsContainer : False
FileName      : C:\Test\Stream.txt
Stream        : NewStream
Length        : 46
```

```powershell
# Retrieve the content of your newly created Stream.
Get-Content -Path .\Stream.txt -Stream NewStream
```

```Output
Added a stream named NewStream to Stream.txt
```

The **Stream** parameter is a dynamic parameter of the
[FileSystem provider](../microsoft.powershell.core/about/about_filesystem_provider.md#stream-systemstring).
By default `Get-Content` only retrieves data from the primary, or `$DATA` stream. **Streams** can be
used to store hidden data such as attributes, security settings, or other data.

### Example 6: Get raw content

The commands in this example get the contents of a file as one string, instead of an array of
strings. By default, without the **Raw** dynamic parameter, content is returned as an array of
newline-delimited strings. This example uses the `LineNumbers.txt` file that was created in Example
1.

```powershell
$raw = Get-Content -Path .\LineNumbers.txt -Raw
$lines = Get-Content -Path .\LineNumbers.txt
Write-Host "Raw contains $($raw.Count) lines."
Write-Host "Lines contains $($lines.Count) lines."
```

```Output
Raw contains 1 lines.
Lines contains 100 lines.
```

### Example 7: Use Filters with Get-Content

You can specify a filter to the `Get-Content` cmdlet. When using filters to qualify the **Path**
parameter, you need to include a trailing asterisk (`*`) to indicate the contents of the
path.

The following command gets the content of all `*.log` files in the `C:\Temp` directory.

```powershell
Get-Content -Path C:\Temp\* -Filter *.log
```

### Example 8: Get file contents as a byte array

This example demonstrates how to get the contents of a file as a `[byte[]]` as a single object.

```powershell
$byteArray = Get-Content -Path C:\temp\test.txt -AsByteStream -Raw
Get-Member -InputObject $bytearray
```

```Output
   TypeName: System.Byte[]

Name           MemberType            Definition
----           ----------            ----------
Count          AliasProperty         Count = Length
Add            Method                int IList.Add(System.Object value)
```

The first command uses the **AsByteStream** parameter to get the stream of bytes from the file.
The **Raw** parameter ensures that the bytes are returned as a `[System.Byte[]]`. If the **Raw**
parameter was absent, the return value is a stream of bytes, which is interpreted by
PowerShell as `[System.Object[]]`.

## PARAMETERS

### -Path

Specifies the path to an item where `Get-Content` gets the content. Wildcard characters are
permitted. The paths must be paths to items, not to containers. For example, you must specify a path
to one or more files, not a path to a directory.

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

### -ReadCount

Specifies how many lines of content are sent through the pipeline at a time. The default value is 1.
A value of 0 (zero) sends all of the content at one time.

This parameter does not change the content displayed, but it does affect the time it takes to
display the content. As the value of **ReadCount** increases, the time it takes to return the first
line increases, but the total time for the operation decreases. This can make a perceptible
difference in large items.

```yaml
Type: System.Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TotalCount

Specifies the number of lines from the beginning of a file or other item. The default is -1 (all
lines).

You can use the **TotalCount** parameter name or its aliases, **First** or **Head**.

```yaml
Type: System.Int64
Parameter Sets: (All)
Aliases: First, Head

Required: False
Position: Named
Default value: -1
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Tail

Specifies the number of lines from the end of a file or other item. You can use the **Tail**
parameter name or its alias, **Last**. This parameter was introduced in PowerShell 3.0.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: Last

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
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

### -Exclude

Specifies, as a string array, an item or items that this cmdlet excludes in the operation.
The value of this parameter qualifies the **Path** parameter.

Enter a path element or pattern, such as `*.txt`.
Wildcard characters are permitted.

The **Exclude** parameter is effective only when the command includes the contents of an item,
such as `C:\Windows\*`, where the wildcard character specifies the contents of the `C:\Windows`
directory.

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

### -Force

**Force** will override a read-only attribute or create directories to complete a file path. The
**Force** parameter does not attempt to change file permissions or override security restrictions.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
Default value: Current user
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Delimiter

Specifies the delimiter that `Get-Content` uses to divide the file into objects while it reads. The
default is `\n`, the end-of-line character. When reading a text file, `Get-Content` returns a
collection of string objects, each of which ends with an end-of-line character. When you enter a
delimiter that does not exist in the file, `Get-Content` returns the entire file as a single,
undelimited object.

You can use this parameter to split a large file into smaller files by specifying a file separator,
as the delimiter. The delimiter is preserved (not discarded) and becomes the last item in each file
section.

**Delimiter** is a dynamic parameter that the **FileSystem** provider adds to the `Get-Content`
cmdlet. This parameter works only in file system drives.

> [!NOTE]
> Currently, when the value of the **Delimiter** parameter is an empty string, `Get-Content` does
> not return anything. This is a known issue. To force `Get-Content` to return the entire file as
> a single, undelimited string. Enter a value that does not exist in the file.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: End-of-line character
Accept pipeline input: False
Accept wildcard characters: False
```

### -Wait

Keeps the file open after all existing lines have been output. While waiting, `Get-Content` checks
the file once each second and outputs new lines if present. You can interrupt **Wait** by pressing
**CTRL+C**. Waiting also ends if the file gets deleted, in which case a non-terminating error is
reported.

**Wait** is a dynamic parameter that the FileSystem provider adds to the `Get-Content` cmdlet. This
parameter works only in file system drives. **Wait** cannot be combined with **Raw**.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Raw

Ignores newline characters and returns the entire contents of a file in one string with the newlines
preserved. By default, newline characters in a file are used as delimiters to separate the input
into an array of strings. This parameter was introduced in PowerShell 3.0.

**Raw** is a dynamic parameter that the **FileSystem** provider adds to the `Get-Content` cmdlet
This parameter works only in file system drives.

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

### -Encoding

Specifies the type of encoding for the target file. The default value is `utf8NoBOM`.

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

Encoding is a dynamic parameter that the **FileSystem** provider adds to the `Get-Content` cmdlet.
This parameter is available only in file system drives.

When reading from and writing to binary files, use the **AsByteStream** parameter and a value of 0
for the **ReadCount** parameter. A **ReadCount** value of 0 reads the entire file in a single read
operation. The default **ReadCount** value, 1, reads one byte in each read operation and converts
each byte into a separate object, which causes errors when you use the `Set-Content` cmdlet to write
the bytes to a file unless you use **AsByteStream** parameter.

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

### -Stream

Gets the contents of the specified alternate NTFS file stream from the file. Enter the stream name.
Wildcards are not supported.

**Stream** is a dynamic parameter that the **FileSystem** provider adds to the `Get-Content` cmdlet.
This parameter works only in file system drives on Windows systems. This parameter was introduced in
Windows PowerShell 3.0.

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

### -AsByteStream

Specifies that the content should be read as a stream of bytes. The **AsByteStream** parameter was
introduced in Windows PowerShell 6.0.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`,
`-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`,
`-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.Int64, System.String[], System.Management.Automation.PSCredential

You can pipe the read count, total count, paths, or credentials to `Get-Content`.

## OUTPUTS

### System.Byte, System.String

`Get-Content` returns strings or bytes. The output type depends upon the type of content that you
specify as input.

## NOTES

The `Get-Content` cmdlet is designed to work with the data exposed by any provider. To get the
providers in your session, use the `Get-PSProvider` cmdlet. For more information, see
[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

## RELATED LINKS

[about_Automatic_Variables](../Microsoft.PowerShell.Core/About/about_Automatic_Variables.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)

[Add-Content](Add-Content.md)

[Clear-Content](Clear-Content.md)

[ForEach-Object](../Microsoft.PowerShell.Core/ForEach-Object.md)

[Get-PSProvider](Get-PSProvider.md)

[Set-Content](Set-Content.md)

