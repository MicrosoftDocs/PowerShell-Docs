---
ms.date:  2/4/2019
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

```
Get-Content [-Path] <string[]> [-ReadCount <long>] [-TotalCount <long>] [-Tail <int>]
[-Filter <string>] [-Include <string[]>] [-Exclude <string[]>] [-Force] [-Credential <pscredential>]
[-UseTransaction] [-Delimiter <string>] [-Wait] [-Raw]
[-Encoding <FileSystemCmdletProviderEncoding>] [-Stream <string>] [<CommonParameters>]
```

### LiteralPath

```
Get-Content -LiteralPath <string[]> [-ReadCount <long>] [-TotalCount <long>] [-Tail <int>]
[-Filter <string>] [-Include <string[]>] [-Exclude <string[]>] [-Force] [-Credential <pscredential>]
[-UseTransaction] [-Delimiter <string>] [-Wait] [-Raw]
[-Encoding <FileSystemCmdletProviderEncoding>] [-Stream <string>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-Content` cmdlet gets the content of the item at the location specified by the path, such as
the text in a file or the content of a function. For files, the content is read one line at a time
and returns a collection of objects, each of which represents a line of content.

Beginning in PowerShell 3.0, `Get-Content` can also get a specified number of lines from the
beginning or end of an item.

If you need to create files or directories for the following examples, see [New-Item](New-Item.md).

## EXAMPLES

### Example 1: Get the content of a text file

This example gets the content of a file in the current directory.

```powershell
Set-Content -Path .\Test1.txt -Value 'Hello, World'
Get-Content -Path .\Test1.txt
```

```Output
Hello, World
```

The `Set-Content` cmdlet uses the **Path** and **Value** parameters to create the **Test1.txt** file
in the current directory. The **Value** parameter includes the text string **Hello, World**. The
`Get-Content` cmdlet uses the **Path** parameter to specify the **Test1.txt** file and displays the
content in the PowerShell console.

### Example 2: Get content from a text file and write the content to another file

This command gets the first five lines of a file, writes that content to a new file, and then
displays the new file's contents.

The **LineNumbers.txt** file in this example contains 100 lines of text in the following format,
**This is Line X**.

```powershell
Get-Content -Path .\LineNumbers.txt -TotalCount 5 | Set-Content -Path .\FiveLines.txt
Get-Content -Path .\FiveLines.txt
```

```Output
This is Line 1
This is Line 2
This is Line 3
This is Line 4
This is Line 5
```

The `Get-Content` cmdlet uses the **Path** parameter to get content from the file
**LineNumbers.txt**. The **TotalCount** parameter specifies that the first five lines are retrieved.
The string is sent down the pipeline to the `Set-Content` cmdlet. `Set-Content` uses the **Path**
parameter to create **FiveLines.txt**, a new file that contains the five lines of text. The
`Get-Content` cmdlet uses the **Path** parameter to get content from **FiveLines.txt** and displays
the content in the PowerShell console.

### Example 3: Get a specific line of content from a text file

This command gets a specific number of lines from a file and then displays only the last line of
that content.

```powershell
(Get-Content -Path .\LineNumbers.txt -TotalCount 25)[-1]
```

```Output
This is Line 25
```

The `Get-Content` cmdlet uses the **Path** parameter to get content from the file
**LineNumbers.txt**. The **TotalCount** parameter gets the first 25 lines of content. The
`Get-Content` command is wrapped in parentheses so that the command completes before going to the
next step. The `[-1]` specifies the last line of content and displays that line in the PowerShell
console.

To get content from the end of a file, you can adjust the array number. For example, `[-6]` will
display **This is Line 20**.

### Example 4: Get the first line and last line of a text file

This command gets the first line and last line of content from each `*.txt` file in the current
directory.

```powershell
Get-ChildItem -Path .\*.txt | ForEach-Object {Get-Content $_ -TotalCount 1; Get-Content $_ -Tail 1}
```

```Output
This is Line 1
This is Line 5
This is Line 1
This is Line 100
```

The `Get-ChildItem` cmdlet uses the **Path** parameter to specify the text files in the current
directory. For this example, the **FiveLines.txt** and **LineNumbers.txt** from the previous
examples. The objects are sent down the pipeline to the `ForEach-Object` cmdlet. `ForEach-Object`
uses a script block to process the `Get-Content` cmdlet. `Get-Content` uses the `$_` automatic
variable to specify each object received from the pipeline. The **TotalCount** parameter gets the
first line of each file and the **Tail** parameter gets the last line of each file. The output is
displayed in the PowerShell console.

### Example 5: Get the content of an alternate data stream

This example describes how to use the **Stream** parameter to get the content of an alternate data
stream for files stored on a Windows NTFS volume.

```
PS> Set-Content -Path .\Stream.txt -Value 'This is the content of the Stream.txt file'

PS> Get-Item -Path .\Stream.txt -Stream *

PSPath        : Microsoft.PowerShell.Core\FileSystem::C:\Test\Stream.txt::$DATA
PSParentPath  : Microsoft.PowerShell.Core\FileSystem::C:\Test
PSChildName   : Stream.txt::$DATA
PSDrive       : C
PSProvider    : Microsoft.PowerShell.Core\FileSystem
PSIsContainer : False
FileName      : C:\Test\Stream.txt
Stream        : :$DATA
Length        : 44

PS> Get-Content -Path .\Stream.txt -Stream $DATA

This is the content of the Stream.txt file

PS> Add-Content -Path .\Stream.txt -Stream NewStream -Value 'Added a stream named NewStream to Stream.txt'

PS> Get-Item -Path .\Stream.txt -Stream *

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

PS> Get-Content -Path .\Stream.txt -Stream NewStream

Added a stream named NewStream to Stream.txt
```

The `Set-Content` cmdlet uses the **Path** and **Value** parameters to create a new file named
**Stream.txt** in the current directory. The **Value** parameter inserts content into the file,
**This is the content of the Stream.txt file**. The `Get-Item` cmdlet uses the **Stream** parameter
with the asterisk (`*`) wildcard to display the existing streams for **Stream.txt**. The
`Get-Content` cmdlet uses the **Stream** parameter to display the content stored in the `$DATA`
stream, which is the file's content.

The `Add-Content` cmdlet uses the **Stream** parameter to create a new stream named, **NewStream**.
The **Value** parameter adds content to the stream, **Added a stream named NewStream to
Stream.txt**. The `Get-Item` cmdlet displays information about the **Stream.txt** file and the
stream that was added, **NewStream**. The `Get-Content` cmdlet uses the **Stream** parameter to
display the content stored in **NewStream**.


### Example 6: Get file contents as a hashtable

The commands in this example get the contents of a module manifest file (.psd1) as a hash table. The
manifest file contains a hash table. If you get the contents without the **Raw** dynamic parameter,
it is returned as an array of newline-delimited strings.

For more information about PowerShell modules, see [Understanding a Windows PowerShell Module](/powershell/developer/module/understanding-a-windows-powershell-module).

```
PS> $Manifest = (Get-Module -ListAvailable PSDiagnostics).Path

PS> $Manifest

C:\WINDOWS\System32\WindowsPowerShell\v1.0\Modules\PSDiagnostics\PSDiagnostics.psd1

PS> $Hash = Invoke-Expression -Command (Get-Content $Manifest -Raw)

PS> $Hash

Name                           Value
----                           -----
Copyright                      © Microsoft Corporation. All rights reserved.
ModuleToProcess                PSDiagnostics.psm1
CompatiblePSEditions           {Desktop}
PowerShellVersion              5.1
CompanyName                    Microsoft Corporation
GUID                           c61d6278-02a3-4618-ae37-a524d40a7f44
Author                         Microsoft Corporation
FunctionsToExport              {Disable-PSTrace, Disable-PSWSManCombinedTrace, ...}
CLRVersion                     2.0.50727
CmdletsToExport                {}
AliasesToExport                {}
ModuleVersion                  1.0.0.0

PS> $Hash.ModuleToProcess

PSDiagnostics.psm1
```

The `Get-Module` cmdlet uses the **ListAvailable** parameter and specifies the **PSDiagnostics**
module. The command is wrapped with parentheses so that the object's path property is stored in the
`$Manifest` variable. The `$Manifest` variable displays the path to the module manifest file on the
local computer.

The `Invoke-Expression` cmdlet evaluates the results of `Get-Content` that uses the `$Manifest`
variable as input. The **Raw** parameter returns the value as one string. The string is stored in
the `$Hash` variable.

The contents of the `$Hash` variable are displayed in the PowerShell console. To get the value of
the `ModuleToProcess` key in the module manifest, use the `$Hash.ModuleToProcess` property.

## PARAMETERS

### -Path

Specifies the path to an item where `Get-Content` gets the content. Wildcards are permitted.

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

### -LiteralPath

Specifies the path to an item. Unlike the **Path** parameter, the value of **LiteralPath** is used
exactly as it is typed. No characters are interpreted as wildcards. If the path includes escape
characters, enclose it in single quotation marks. Single quotation marks tell PowerShell not to
interpret any characters as escape sequences.

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

### -ReadCount

Specifies how many lines of content are sent through the pipeline at a time. The default value is 1.
A value of 0 (zero) sends all of the content at one time.

This parameter does not change the content displayed, but it does affect the time it takes to
display the content. As the value of **ReadCount** increases, the time it takes to return the first
line increases, but the total time for the operation decreases. This can make a perceptible
difference in large items.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TotalCount

Specifies the number of lines from the beginning of a file or other item.
The default is -1 (all lines).

You can use the **TotalCount** parameter name or its aliases, **First** or **Head**.

```yaml
Type: Int64
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
Type: Int32
Parameter Sets: (All)
Aliases: Last

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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
Accept wildcard characters: True
```

### -Include

Specifies, as a string array, the item that this cmdlet includes in the operation. The value of this
parameter qualifies the **Path** parameter. Enter a path element or pattern, such as `*.txt`.
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

### -Exclude

Specifies, as a string array, the item that this cmdlet omits when performing the operation. The
value of this parameter qualifies the **Path** parameter. Enter a path element or pattern, such as
`*.txt`. Wildcards are permitted.

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

### -Force

**Force** will override a read-only attribute or create directories to complete a file path. The
**Force** parameter does not attempt to change file permissions or override security restrictions.

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
cmdlet This parameter works only in file system drives.

> [!NOTE]
> Currently, when the value of the **Delimiter** parameter is an empty string, `Get-Content` does
> not return anything. This is a known issue To force `Get-Content` to return the entire file as a
> single, undelimited string, enter a value that does not exist in the file.

```yaml
Type: String
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
Type: SwitchParameter
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
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Encoding

Specifies the type of encoding for the target file. The default value is **ASCII**.

The acceptable values for this parameter are as follows:

- **ASCII** Uses ASCII (7-bit) character set.
- **BigEndianUnicode** Uses UTF-16 with the big-endian byte order.
- **BigEndianUTF32** Uses UTF-32 with the big-endian byte order.
- **Byte** Encodes a set of characters into a sequence of bytes.
- **Default** Uses the encoding that corresponds to the system's active code page.
- **OEM** Uses the encoding that corresponds to the system's current OEM code page.
- **String** Same as **Unicode**.
- **Unicode** Uses UTF-16 with the little-endian byte order.
- **Unknown** Same as **Unicode**.
- **UTF7** Uses UTF-7.
- **UTF8** Uses UTF-8.
- **UTF32** Uses UTF-32 with the little-endian byte order.

Encoding is a dynamic parameter that the **FileSystem** provider adds to the `Get-Content` cmdlet.
This parameter works only in file system drives.

When reading from and writing to binary files, use a value of **Byte** for the **Encoding** dynamic
parameter and a value of 0 for the **ReadCount** parameter. A **ReadCount** value of 0 reads the
entire file in a single read operation and converts it into a single object (PSObject). The default
**ReadCount** value, 1, reads one byte in each read operation and converts each byte into a separate
object, which causes errors when you use the `Set-Content` cmdlet to write the bytes to a file.

```yaml
Type: FileSystemCmdletProviderEncoding
Parameter Sets: (All)
Aliases:
Accepted values: ASCII, BigEndianUnicode, BigEndianUTF32, Byte, Default, OEM, String, Unicode, Unknown, UTF7, UTF8, UTF32

Required: False
Position: Named
Default value: ASCII
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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`,
`-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`,
`-Verbose`, `-WarningAction`, and `-WarningVariable`.
For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int64, System.String[], System.Management.Automation.PSCredential

You can pipe the read count, total count, paths, or credentials to `Get-Content`.

## OUTPUTS

### System.Byte, System.String

`Get-Content` returns strings or bytes. The output type depends upon the type of content that you
specify as input.

## NOTES

The `Get-Content` cmdlet is designed to work with the data exposed by any provider. To get the
providers in your session, use the `Get-PSProvider` cmdlet.
For more information, see [about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

## RELATED LINKS

[about_Hash_Tables](../Microsoft.PowerShell.Core/About/about_Hash_Tables.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)

[about_Transactions](../Microsoft.PowerShell.Core/About/about_Transactions.md)

[Add-Content](Add-Content.md)

[Clear-Content](Clear-Content.md)

[Get-PSProvider](Get-PSProvider.md)

[Invoke-Expression](../Microsoft.PowerShell.Utility/Invoke-Expression.md)

[New-Item](New-Item.md)

[Set-Content](Set-Content.md)

[Understanding a Windows PowerShell Module](/powershell/developer/module/understanding-a-windows-powershell-module)