---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 03/18/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/get-content?view=powershell-7.6&WT.mc_id=ps-gethelp
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
 [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>] [-Force]
 [-Credential <PSCredential>] [-Delimiter <String>] [-Wait] [-Raw] [-Encoding <Encoding>]
 [-AsByteStream] [-Stream <String>] [<CommonParameters>]
```

### LiteralPath

```
Get-Content [-ReadCount <Int64>] [-TotalCount <Int64>] [-Tail <Int32>] -LiteralPath <String[]>
 [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>] [-Force]
 [-Credential <PSCredential>] [-Delimiter <String>] [-Wait] [-Raw] [-Encoding <Encoding>]
 [-AsByteStream] [-Stream <String>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-Content` cmdlet gets the content of the item at the location specified by the path, such as
the text in a file or the content of a function. For files, the content is read one line at a time
and returns a collection of objects, each representing a line of content.

Beginning in PowerShell 3.0, `Get-Content` can also get a specified number of lines from the
beginning or end of an item.

## EXAMPLES

### Example 1: Get the content of a text file

This example gets the content of a file in the current directory. The `LineNumbers.txt` file
has 100 lines in the format, **This is Line X** and is used in several examples.

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

This command gets the first five lines of a file. The **TotalCount** parameter gets the first five
lines of content. This example uses the `LineNumbers.txt` referenced in Example 1.

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
`LineNumbers.txt` file referenced in Example 1.

```powershell
(Get-Content -Path .\LineNumbers.txt -TotalCount 25)[-1]
```

```Output
This is Line 25
```

The `Get-Content` command is wrapped in parentheses so that the command completes before going to
the next step. `Get-Content`returns an array of lines, this allows you to add the index notation
after the parenthesis to retrieve a specific line number. In this case, the `[-1]` index specifies
the last index in the returned array of 25 retrieved lines.

### Example 4: Get the last line of a text file

This command gets the last line of content from a file. This example uses the `LineNumbers.txt` file
that was created in Example 1.

```powershell
Get-Item -Path .\LineNumbers.txt | Get-Content -Tail 1
```

```Output
This is Line 100
```

This example uses the `Get-Item` cmdlet to demonstrate that you can pipe files to `Get-Content`. The
**Tail** parameter gets the last line of the file. This method is faster than retrieving all the
lines in a variable and using the `[-1]` index notation.

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
# Retrieve the content of the primary stream.
# Note the single quotes to prevent variable substitution.
Get-Content -Path .\Stream.txt -Stream ':$DATA'
```

```Output
This is the content of the Stream.txt file
```

```powershell
# Alternative way to get the same content.
Get-Content -Path .\Stream.txt -Stream ""
# The primary stream doesn't need to be specified to get the primary stream of the file.
# This gets the same data as the prior two examples.
Get-Content -Path .\Stream.txt
```

```Output
This is the content of the Stream.txt file
```

```powershell
# Use the Stream parameter of Add-Content to create a new Stream containing sample content.
$addContentSplat = @{
    Path = '.\Stream.txt'
    Stream = 'NewStream'
    Value = 'Added a stream named NewStream to Stream.txt'
}
Add-Content @addContentSplat

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
[FileSystem provider](../microsoft.powershell.core/about/about_filesystem_provider.md#stream-string).
By default `Get-Content` only retrieves data from the default, or `:$DATA` stream. **Streams** can
be used to store hidden data such as attributes, security settings, or other data. They can also be
stored on directories without being child items.

### Example 6: Get raw content

The commands in this example get the contents of a file as one string, instead of an array of
strings. By default, without the **Raw** dynamic parameter, content is returned as an array of
newline-delimited strings. This example uses the `LineNumbers.txt` file referenced in Example 1.

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
Get-Member -InputObject $byteArray
```

```Output
   TypeName: System.Byte[]

Name           MemberType            Definition
----           ----------            ----------
Count          AliasProperty         Count = Length
Add            Method                int IList.Add(System.Object value)
```

The first command uses the **AsByteStream** parameter to get the stream of bytes from the file. The
**Raw** parameter ensures that the bytes are returned as a `[System.Byte[]]`. If the **Raw**
parameter was absent, the return value is a stream of bytes, which is interpreted by PowerShell as
`[System.Object[]]`.

## PARAMETERS

### -AsByteStream

Specifies that the content should be read as a stream of bytes. The **AsByteStream** parameter was
introduced in Windows PowerShell 6.0.

A warning occurs when you use the **AsByteStream** parameter with the **Encoding** parameter. The
**AsByteStream** parameter ignores any encoding and the output is returned as a stream of bytes.

When reading from and writing to binary files, use the **AsByteStream** parameter and a value of 0
for the **ReadCount** parameter. A **ReadCount** value of 0 reads the entire file in a single read
operation. The default **ReadCount** value, 1, reads one byte in each read operation and converts
each byte into a separate object. Piping single-byte output to `Set-Content` causes errors unless
you use the **AsByteStream** parameter with `Set-Content`.

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
> This parameter isn't supported by any providers installed with PowerShell. To impersonate another
> user, or elevate your credentials when running this cmdlet, use
> [Invoke-Command](../Microsoft.PowerShell.Core/Invoke-Command.md).

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
collection of string objects, each ending with an end-of-line character. When you enter a delimiter
that doesn't exist in the file, `Get-Content` returns the entire file as a single, undelimited
object.

You can use this parameter to split a large file into smaller files by specifying a file separator,
as the delimiter. The delimiter is preserved (not discarded) and becomes the last item in each file
section.

**Delimiter** is a dynamic parameter that the **FileSystem** provider adds to the `Get-Content`
cmdlet. This parameter works only in file system drives.

> [!NOTE]
> Currently, when the value of the **Delimiter** parameter is an empty string, `Get-Content` does
> not return anything. This is a known issue. To force `Get-Content` to return the entire file as
> a single, undelimited string. Enter a value that doesn't exist in the file.

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

### -Encoding

Specifies the type of encoding for the target file. The default value is `utf8NoBOM`.

The acceptable values for this parameter are as follows:

- `ascii`: Uses the encoding for the ASCII (7-bit) character set.
- `ansi`: Uses the encoding for the for the current culture's ANSI code page. This option was added
  in PowerShell 7.4.
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

Beginning with PowerShell 6.2, the **Encoding** parameter also allows numeric IDs of registered code
pages (like `-Encoding 1251`) or string names of registered code pages (like
`-Encoding "windows-1251"`). For more information, see the .NET documentation for
[Encoding.CodePage](/dotnet/api/system.text.encoding.codepage?view=netcore-2.2).

Starting with PowerShell 7.4, you can use the `Ansi` value for the **Encoding** parameter to pass
the numeric ID for the current culture's ANSI code page without having to specify it manually.

> [!NOTE]
> **UTF-7*** is no longer recommended to use. As of PowerShell 7.1, a warning is written if you
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

Specifies, as a string array, an item or items that this cmdlet excludes in the operation.
The value of this parameter qualifies the **Path** parameter.

Enter a path element or pattern, such as `*.txt`. Wildcard characters are permitted.

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

### -Filter

Specifies a filter to qualify the **Path** parameter. The
[FileSystem](../Microsoft.PowerShell.Core/About/about_FileSystem_Provider.md) provider is the only
installed PowerShell provider that supports the use of filters. You can find the syntax for the
**FileSystem** filter language in
[about_Wildcards](../Microsoft.PowerShell.Core/About/about_Wildcards.md). Filters are more efficient
than other parameters, because the provider applies them when the cmdlet gets the objects rather
than having PowerShell filter the objects after they're retrieved.

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

**Force** can override a read-only attribute or create directories to complete a file path. The
**Force** parameter doesn't attempt to change file permissions or override security restrictions.

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

Specifies a path to one or more locations. The value of **LiteralPath** is used exactly as it's
typed. No characters are interpreted as wildcards. If the path includes escape characters, enclose
it in single quotation marks. Single quotation marks tell PowerShell not to interpret any characters
as escape sequences.

For more information, see
[about_Quoting_Rules](../Microsoft.Powershell.Core/About/about_Quoting_Rules.md).

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

### -ReadCount

Specifies how many lines of content are sent through the pipeline at a time. The default value is 1.
A value of 0 (zero) or negative numbers sends all the content at one time.

This parameter doesn't change the content displayed, but it does affect the time it takes to
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

### -Stream

> [!NOTE]
> This Parameter is only available on Windows.

Gets the contents of the specified alternate NTFS file stream from the file. Enter the stream name.
Wildcards aren't supported.

**Stream** is a dynamic parameter that the **FileSystem** provider adds to the `Get-Content` cmdlet.
This parameter works only in file system drives on Windows systems.

This parameter was introduced in Windows PowerShell 3.0. In PowerShell 7.2, `Get-Content` can
retrieve the content of alternative data streams from directories as well as files.

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

### -Tail

Specifies the number of lines from the end of a file or other item. You can use the **Tail**
parameter name or its alias, **Last**. A value of `0` returns no lines. Negative values cause an
error.

This parameter was introduced in PowerShell 3.0.

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

### -TotalCount

Specifies the number of lines from the beginning of a file or other item. A value of `0` returns no
lines. Negative values cause an error.

You can use the **TotalCount** parameter name or its aliases, **First** or **Head**.

```yaml
Type: System.Int64
Parameter Sets: (All)
Aliases: First, Head

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Wait

Causes the cmdlet to wait indefinitely, keeping the file open, until interrupted. While waiting,
`Get-Content` checks the file once per second and outputs new lines if present. When used with the
**TotalCount** parameter, `Get-Content` waits until the specified number of lines are available in
the specified file. For example, if you specify a **TotalCount** of 10 and the file already has 10
or more lines, `Get-Content` returns the 10 lines and exits. If the file has fewer than 10 lines,
`Get-Content` outputs each line as it arrives, but waits until the tenth line arrives before
exiting.

You can interrupt **Wait** by pressing <kbd>Ctrl</kbd>+<kbd>C</kbd>. Deleting the file causes a
non-terminating error that also interrupts the waiting.

**Wait** is a dynamic parameter that the FileSystem provider adds to the `Get-Content` cmdlet. This
parameter works only in file system drives. **Wait** can't be combined with **Raw**.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int64

You can pipe the read count or total count to this cmdlet.

### System.String[]

You can pipe paths to this cmdlet.

### System.Management.Automation.PSCredential

You can pipe credentials to this cmdlet.

## OUTPUTS

### System.Byte

When you use the **AsByteStream** parameter, this cmdlet returns the content as bytes.

### System.String

By default, this cmdlet returns the content as an array of strings, one per line. When you use the
**Raw** parameter, it returns a single string containing every line in the file.

## NOTES

PowerShell includes the following aliases for `Get-Content`:

- All platforms:
  - `gc`
  - `type`
- Windows:
  - `cat`

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
