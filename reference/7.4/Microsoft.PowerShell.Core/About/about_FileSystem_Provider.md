---
description: FileSystem
Locale: en-US
ms.date: 07/10/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_filesystem_provider?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_FileSystem_Provider
---
# about_FileSystem_Provider

## Provider name

FileSystem

## Drives

`C:`, `D:`, `Temp:` ...

## Capabilities

**Filter**, **ShouldProcess**

## Short description

Provides access to files and directories.

## Detailed description

The PowerShell **FileSystem** provider lets you get, add, change, clear, and
delete files and directories in PowerShell.

The **FileSystem** drives are a hierarchical namespace containing the
directories and files on your computer. A **FileSystem** drive can be a logical
or physical drive, directory, or mapped network share.

Beginning in PowerShell Version 7.0, a drive called `TEMP:` is mapped to the
user's temporary directory path. PowerShell uses the .NET [GetTempPath()][05]
method to determine the location of the temporary folder. On Windows, the
location is the same as `$env:TEMP`. On non-Windows systems, the location is
the same as `$env:TMPDIR` or `/tmp` if the environment variable isn't defined.

The **FileSystem** provider supports the following cmdlets, which are covered
in this article.

- [Get-Location][20]
- [Set-Location][29]
- [Get-Item][18]
- [Get-ChildItem][16]
- [Invoke-Item][22]
- [Move-Item][23]
- [New-Item][24]
- [Remove-Item][25]
- [Get-ItemProperty][19]
- [Set-ItemProperty][28]
- [Clear-Item][13]
- [Clear-ItemProperty][14]
- [Remove-Item][25]
- [Remove-ItemProperty][26]
- [Get-Acl][31]
- [Set-Acl][33]
- [Get-AuthenticodeSignature][32]
- [Set-AuthenticodeSignature][34]
- [Add-Content][11]
- [Clear-Content][12]
- [Get-Content][17]
- [Set-Content][27]

## Types exposed by this provider

Files are instances of the [System.IO.FileInfo][04] class. Directories are
instances of the [System.IO.DirectoryInfo][02] class.

The PowerShell Extended Type System adds extra properties to these object types
to provide additional information. Some information is platform specific. For
example, the possible values of the **LinkType** property depend on the
platform and filesystem being used. Linux and macOS filesystems support
`HardLink` and `SymLink`. Windows NTFS supports `HardLink`, `SymLink`,
`Junction`, and several other values for **LinkType**.

When you use `Get-Item` or `Get-ChildItem` to information about a linked item,
the **Mode** property contains an `l` to indicate that the item is a link. The
**LinkType** property contains the type of link.

`AppExecLink` links are created when you install an application from the
Microsoft Store. For `AppExecLink` links, Windows doesn't provide values for
the **LinkType** or **LinkTarget** properties.

```powershell
Get-Item ~\AppData\Local\Microsoft\WindowsApps\winget.exe

    Directory: C:\Users\user1\AppData\Local\Microsoft\WindowsApps

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
la---            6/8/2023 12:20 PM              0 winget.exe ->
```

## Navigating the FileSystem drives

The **FileSystem** provider exposes its data stores by mapping any logical
drives on the computer as PowerShell drives. To work with a **FileSystem**
drive you can change your location to a drive using the drive name followed by
a colon (`:`).

```powershell
Set-Location C:
```

You can also work with the **FileSystem** provider from any other PowerShell
drive. To reference a file or directory from another location, use the drive
name (`C:`, `D:`, ...) in the path.

> [!NOTE]
> PowerShell uses aliases to allow you a familiar way to work with provider
> paths. Commands such as `dir` and `ls` are now aliases for
> `Get-ChildItem`, `cd` is an alias for `Set-Location`. and `pwd` is an
> alias for `Get-Location`.

## Getting files and directories

The `Get-ChildItem` cmdlet returns all files and directories in the
current location. You can specify a different path to search and use built
in parameters to filter and control the recursion depth.

```powershell
Get-ChildItem
```

To read more about cmdlet usage, see [Get-ChildItem][16].

## Copying files and directories

The `Copy-Item` cmdlet copies files and directories to a location you specify.
Parameters are available to filter and recurse, similar to `Get-ChildItem`.

The following command copies all of the files and directories under the path
`C:\temp\` to the folder `C:\Windows\Temp`.

```powershell
Copy-Item -Path C:\temp\* -Destination C:\Windows\Temp -Recurse -File
```

`Copy-Item` overwrites files in the destination directory without prompting for
confirmation.

This command copies the `a.txt` file from the `C:\a` directory to the `C:\a\bb`
directory.

```powershell
Copy-Item -Path C:\a\a.txt -Destination C:\a\bb\a.txt
```

Copies all the directories and files in the `C:\a` directory to the `C:\c`
directory. If any of the directories to copy already exist in the destination
directory, the command fails unless you specify the **Force** parameter.

```powershell
Copy-Item -Path C:\a\* -Destination C:\c -Recurse
```

For more information, see [Copy-Item][15].

## Moving files and directories

This command moves the `c.txt` file in the `C:\a` directory to the `C:\a\aa`
directory:

```powershell
Move-Item -Path C:\a\c.txt -Destination C:\a\aa
```

By default, the cmdlet doesn't overwrite an existing file that has the same
name. To force the cmdlet to overwrite an existing file, specify the **Force**
parameter.

You can't move a directory when that directory is the current location. When
you use `Move-Item` to move the directory at the current location, you see
this error.

```
C:\temp> Move-Item -Path C:\temp\ -Destination C:\Windows\Temp

Move-Item : Cannot move item because the item at 'C:\temp\' is in use.
At line:1 char:1
+ Move-Item C:\temp\ C:\temp2\
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (:) [Move-Item], PSInvalidOperationException
    + FullyQualifiedErrorId : InvalidOperation,Microsoft.PowerShell.Commands.MoveItemCommand
```

## Managing file content

### Get the content of a file

This command gets the contents of the "Test.txt" file and displays them in the
console.

```powershell
Get-Content -Path Test.txt
```

You can pipe the contents of the file to another cmdlet. For example, the
following command reads the contents of the `Test.txt` file and then supplies
them as input to the [ConvertTo-Html][35] cmdlet:

```powershell
Get-Content -Path Test.txt | ConvertTo-Html
```

You can also retrieve the content of a file by prefixing its provider path with
the dollar sign (`$`). The path must be enclosed in curly braces due to
variable naming restrictions. For more information, see [about_Variables][09].

```powershell
${C:\Windows\System32\Drivers\etc\hosts}
```

### Add content to a file

This command appends the "test content" string to the `Test.txt` file:

```powershell
Add-Content -Path test.txt -Value "test content"
```

The existing content in the `Test.txt` file isn't deleted.

### Replace the content of a file

This command replaces the contents of the `Test.txt` file with the "test
content" string:

```powershell
Set-Content -Path test.txt -Value "test content"
```

It overwrites the contents of `Test.txt`. You can use the **Value** parameter
of the `New-Item` cmdlet to add content to a file when you create it.

### Loop through the contents of a file

By default, the `Get-Content` cmdlet uses the end-of-line character as its
delimiter, so it gets a file as a collection of strings, with each line as one
string in the file.

You can use the **Delimiter** parameter to specify an alternate delimiter. If
you set it to the characters that denote the end of a section or the beginning
of the next section, you can split the file into logical parts.

The first command gets the `Employees.txt` file and splits it into sections,
each of which ends with the words "End of Employee Record" and it saves it in
the `$e` variable.

The second command uses array notation to get the first item in the collection
in `$e`. It uses an index of 0, because PowerShell arrays are zero-based.

For more information about `Get-Content` cmdlet, see the help topic for the
`Get-Content`.

For more information about arrays, see [about_Arrays][07].

```powershell
$e = Get-Content c:\test\employees.txt -Delimited "End Of Employee Record"
$e[0]
```

## Managing security descriptors

### View the ACL for a file

This command returns a [System.Security.AccessControl.FileSecurity][06] object:

```powershell
Get-Acl -Path test.txt | Format-List -Property *
```

For more information about this object, pipe the command to the
[Get-Member][38] cmdlet or see the [FileSecurity][06] Class.

## Creating files and directories

### Create a directory

This command creates the `logfiles` directory on the `C` drive:

```powershell
New-Item -Path c:\ -Name logfiles -Type directory
```

PowerShell also includes a `mkdir` function (alias `md`) that uses the
`New-Item` cmdlet to create a new directory.

### Create a file

This command creates the `log2.txt` file in the `C:\logfiles` directory and
then adds the "test log" string to the file:

```powershell
New-Item -Path c:\logfiles -Name log2.txt -Type file
```

### Create a file with content

Creates a file called `log2.txt` in the `C:\logfiles` directory and adds the
string "test log" to the file.

```powershell
New-Item -Path c:\logfiles -Name log2.txt -Type file -Value "test log"
```

## Renaming files and directories

### Rename a file

This command renames the `a.txt` file in the `C:\a` directory to `b.txt`:

```powershell
Rename-Item -Path c:\a\a.txt -NewName b.txt
```

### Rename a directory

This command renames the `C:\a\cc` directory to `C:\a\dd`:

```powershell
Rename-Item -Path c:\a\cc -NewName dd
```

## Deleting files and directories

### Delete a file

This command deletes the `Test.txt` file in the current directory:

```powershell
Remove-Item -Path test.txt
```

### Delete files using wildcards

This command deletes all the files in the current directory that have the
`.xml` file name extension:

```powershell
Remove-Item -Path *.xml
```

## Starting a program by invoking an associated file

### Invoke a file

The [Get-Service][21] cmdlet to get information about local services and pipes
the information to the [Export-Csv][36] cmdlet to store the information in the
`Services.csv` file.

Then [Invoke-Item][22] opens the `services.csv` file in the program associated
with the `.csv` extension:

```powershell
Get-Service | Export-Csv -Path services.csv
Invoke-Item -Path services.csv
```

## Getting files and folders with specified attributes

### Get System files

This command gets system files in the current directory and its subdirectories.

It uses the **File** parameter to get only files (not directories) and the
**System** parameter to get only items with the "system" attribute.

It uses the **Recurse** parameter to get the items in the current directory and
all subdirectories.

```powershell
Get-ChildItem -File -System -Recurse
```

### Get Hidden files

This command gets all files, including hidden files, in the current directory.

It uses the **Attributes** parameter with two values, `!Directory+Hidden`,
which gets hidden files, and `!Directory`, which gets all other files.

```powershell
Get-ChildItem -Attributes !Directory,!Directory+Hidden
```

`dir -att !d,!d+h` is the equivalent of this command.

### Get Compressed and Encrypted files

This command gets files in the current directory that are either compressed or
encrypted.

It uses the **Attributes** parameter with two values, `Compressed` and
`Encrypted`. The values are separated by a comma `,` which represents the "OR"
operator.

```powershell
Get-ChildItem -Attributes Compressed,Encrypted
```

## Dynamic parameters

Dynamic parameters are cmdlet parameters that are added by a PowerShell
provider and are available only when the cmdlet is being used in the
provider-enabled drive.

### Encoding \<Encoding\>

Specifies the file encoding. The default is ASCII.

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

#### Cmdlets supported

- `Add-Content`
- `Get-Content`
- `Set-Content`

### Delimiter \<String\>

Specifies the delimiter that `Get-Content` uses to divide the file into
objects while it reads.

The default is `\n`, the end-of-line character.

When reading a text file, `Get-Content` returns a collection of string
objects, each of which ends with the delimiter character.

Entering a delimiter that doesn't exist in the file, `Get-Content` returns
the entire file as a single, un-delimited object.

You can use this parameter to split a large file into smaller files by
specifying a file separator, such as "End of Example", as the delimiter. The
delimiter is preserved (not discarded) and becomes the last item in each file
section.

> [!NOTE]
> Currently, when the value of the **Delimiter** parameter is an empty string,
> `Get-Content` doesn't return anything. This is a known issue. To force
> `Get-Content` to return the entire file as a single, undelimited string,
> enter a value that doesn't exist in the file.

#### Cmdlets supported

- `Get-Content`

### Wait \<SwitchParameter\>

Waits for content to be appended to the file. If content is appended, it
returns the appended content. If the content has changed, it returns the entire
file.

When waiting, `Get-Content` checks the file once each second until you
interrupt it, such as by pressing CTRL+C.

#### Cmdlets supported

- `Get-Content`

### Attributes \<FlagsExpression\>

Gets files and folders with the specified attributes. This parameter supports
all attributes and lets you specify complex combinations of attributes.

The **Attributes** parameter was introduced in Windows PowerShell 3.0.

The **Attributes** parameter supports the following attributes:

- **Archive**
- **Compressed**
- **Device**
- **Directory**
- **Encrypted**
- **Hidden**
- **Normal**
- **NotContentIndexed**
- **Offline**
- **ReadOnly**
- **ReparsePoint**
- **SparseFile**
- **System**
- **Temporary**

For a description of these attributes, see the [FileAttributes][03]
enumeration.

Use the following operators to combine attributes.

- `!` - NOT
- `+` - AND
- `,` - OR

No spaces are permitted between an operator and its attribute. However, spaces
are permitted before commas.

#### Cmdlets supported

- `Get-ChildItem`

### Directory \<SwitchParameter\>

Gets directories (folders).

The **Directory** parameter was introduced in Windows PowerShell 3.0.

To get only directories, use the **Directory** parameter and omit the **File**
parameter. To exclude directories, use the **File** parameter and omit the
**Directory** parameter, or use the **Attributes** parameter.

#### Cmdlets supported

- `Get-ChildItem`

### File \<SwitchParameter\>

Gets files.

The **File** parameter was introduced in Windows PowerShell 3.0.

To get only files, use the **File** parameter and omit the **Directory**
parameter. To exclude files, use the **Directory** parameter and omit the
**File** parameter, or use the **Attributes** parameter.

#### Cmdlets supported

- `Get-ChildItem`

### Hidden \<SwitchParameter\>

Gets only hidden files and directories (folders). By default,
`Get-ChildItem` gets only
non-hidden items.

The **Hidden** parameter was introduced in Windows PowerShell 3.0.

To get only hidden items, use the **Hidden** parameter, its `h` or `ah` aliases,
or the **Hidden** value of the **Attributes** parameter. To exclude hidden
items, omit the **Hidden** parameter or use the **Attributes** parameter.

#### Cmdlets supported

- `Get-ChildItem`

### ReadOnly \<SwitchParameter\>

Gets only read-only files and directories (folders).

The **ReadOnly** parameter was introduced in Windows PowerShell 3.0.

To get only read-only items, use the **ReadOnly** parameter, its `ar` alias, or
the **ReadOnly** value of the **Attributes** parameter. To exclude read-only
items, use the **Attributes** parameter.

#### Cmdlets supported

- `Get-ChildItem`

### System \<SwitchParameter\>

Gets only system files and directories (folders).

The **System** parameter was introduced in Windows PowerShell 3.0.

To get only system files and folders, use the **System** parameter, its `as`
alias, or the **System** value of the **Attributes** parameter. To exclude
system files and folders, use the **Attributes** parameter.

#### Cmdlets supported

- `Get-ChildItem`

### NewerThan \<DateTime\>

Returns `$True` when the `LastWriteTime` value of a file is greater than the
specified date. Otherwise, it returns `$False`.

Enter a [DateTime][01] object, such as one that the [Get-Date][37] cmdlet
returns, or a string that can be converted to a **DateTime** object, such as
`"August 10, 2011 2:00 PM"`.

#### Cmdlets supported

- [Test-Path][30]

### OlderThan \<DateTime\>

Returns `$True` when the `LastWriteTime` value of a file is less than the
specified date. Otherwise, it returns `$False`.

Enter a **DateTime** object, such as one that the `Get-Date` cmdlet
returns, or a string that can be converted to a [DateTime][01] object, such as
`"August 10, 2011 2:00 PM"`.

#### Cmdlets supported

- `Test-Path`

### Stream \<String\>

Manages alternate data streams. Enter the stream name. Wildcards are permitted
only in `Get-Item` for and
`Remove-Item` commands in a
file system drive.

#### Cmdlets supported

- `Add-Content`
- `Clear-Content`
- `Get-Item`
- `Get-Content`
- `Remove-Item`
- `Set-Content`

### Raw \<SwitchParameter\>

Ignores newline characters. Returns contents as a single item.

#### Cmdlets supported

- `Get-Content`

### ItemType \<String\>

This parameter allows you to specify the type of item to create with
`New-Item`.

The available values of this parameter depend on the current provider you are
using.

In a `FileSystem` drive, the following values are allowed:

- File
- Directory
- SymbolicLink
- Junction
- HardLink

### Cmdlets supported

- `New-Item`

## Using the pipeline

Provider cmdlets accept pipeline input. You can use the pipeline to simplify
task by sending provider data from one cmdlet to another provider cmdlet. To
read more about how to use the pipeline with provider cmdlets, see the cmdlet
references provided throughout this article.

## Getting help

Beginning in Windows PowerShell 3.0, you can get customized help topics for
provider cmdlets that explain how those cmdlets behave in a file system drive.

To get the help topics that are customized for the file system drive, run a
[Get-Help][10] command in a file system drive or use the **Path** parameter of
`Get-Help` to specify a file system drive.

```powershell
Get-Help Get-ChildItem
```

```powershell
Get-Help Get-ChildItem -Path c:
```

## See also

- [about_Providers][08]

<!-- updated link references -->
[01]: /dotnet/api/system.datetime
[02]: /dotnet/api/system.io.directoryinfo
[03]: /dotnet/api/system.io.fileattributes
[04]: /dotnet/api/system.io.fileinfo
[05]: /dotnet/api/system.io.path.gettemppath
[06]: /dotnet/api/system.security.accesscontrol.filesecurity
[07]: about_Arrays.md
[08]: about_Providers.md
[09]: about_Variables.md
[10]: xref:Microsoft.PowerShell.Core.Get-Help
[11]: xref:Microsoft.PowerShell.Management.Add-Content
[12]: xref:Microsoft.PowerShell.Management.Clear-Content
[13]: xref:Microsoft.PowerShell.Management.Clear-Item
[14]: xref:Microsoft.PowerShell.Management.Clear-ItemProperty
[15]: xref:Microsoft.PowerShell.Management.Copy-Item
[16]: xref:Microsoft.PowerShell.Management.Get-ChildItem
[17]: xref:Microsoft.PowerShell.Management.Get-Content
[18]: xref:Microsoft.PowerShell.Management.Get-Item
[19]: xref:Microsoft.PowerShell.Management.Get-ItemProperty
[20]: xref:Microsoft.PowerShell.Management.Get-Location
[21]: xref:Microsoft.PowerShell.Management.Get-Service
[22]: xref:Microsoft.PowerShell.Management.Invoke-Item
[23]: xref:Microsoft.PowerShell.Management.Move-Item
[24]: xref:Microsoft.PowerShell.Management.New-Item
[25]: xref:Microsoft.PowerShell.Management.Remove-Item
[26]: xref:Microsoft.PowerShell.Management.Remove-ItemProperty
[27]: xref:Microsoft.PowerShell.Management.Set-Content
[28]: xref:Microsoft.PowerShell.Management.Set-ItemProperty
[29]: xref:Microsoft.PowerShell.Management.Set-Location
[30]: xref:Microsoft.PowerShell.Management.Test-Path
[31]: xref:Microsoft.PowerShell.Security.Get-Acl
[32]: xref:Microsoft.PowerShell.Security.Get-AuthenticodeSignature
[33]: xref:Microsoft.PowerShell.Security.Set-Acl
[34]: xref:Microsoft.PowerShell.Security.Set-AuthenticodeSignature
[35]: xref:Microsoft.PowerShell.Utility.ConvertTo-Html
[36]: xref:Microsoft.PowerShell.Utility.Export-Csv
[37]: xref:Microsoft.PowerShell.Utility.Get-Date
[38]: xref:Microsoft.PowerShell.Utility.Get-Member
