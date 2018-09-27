---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  FileSystem Provider
online version:  http://go.microsoft.com/fwlink/?LinkId=821468
---
# FileSystem provider

## Provider name

FileSystem

## Drives

*C:*, *D:* ...

## Capabilities

**Filter**, **ShouldProcess**

## Short description

Provides access to files and directories.

## Detailed description

The PowerShell **FileSystem** provider lets you get, add, change, clear, and delete files and directories in PowerShell.

The **FileSystem** drives are a hierarchical namespace containing the directories and files on your computer. A **FileSystem** drive can be a logical or phsyical drive, directory, or mapped network share.

The **FileSystem** provider supports the following cmdlets, which are covered
in this article.

- [Get-Location](../../Microsoft.PowerShell.Management/Get-Location.md)
- [Set-Location](../../Microsoft.PowerShell.Management/Set-Location.md)
- [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)
- [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md)
- [Invoke-Item](../../Microsoft.PowerShell.Management/Invoke-Item.md)
- [Move-Item](../../Microsoft.PowerShell.Management/Move-Item.md)
- [New-Item](../../Microsoft.PowerShell.Management/New-Item.md)
- [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md)
- [Get-ItemProperty](../../Microsoft.PowerShell.Management/Get-ItemProperty.md)
- [Set-ItemProperty](../../Microsoft.PowerShell.Management/Set-ItemProperty.md)
- [Get-Acl](../Get-Acl.md)
- [Set-Acl](../Set-Acl.md)
- [Get-AuthenticodeSignature](../Get-AuthenticodeSignature.md)
- [Set-AuthenticodeSignature](../Set-AuthenticodeSignature.md)

{{Make sure list is correct}}

## Types exposed by this provider

Files are instances of the `System.IO.FileInfo` class.  Directories are
instances of the `System.IO.DirectoryInfo` class.

{{change these into links to the classes}}

## Working with provider paths

A provider path can either be *Absolute* or *Relative*.  An *Absolute* path
should be usable from any location and start with a drive name followed by a
colon `:`.  Separate containers in your paths using a backslash `\` or a
forward slash `/`.  If you are referencing a specific item, it should be the
last item in the path. An *Absolute* path is absolute, it should not
change based on your current location.

This is an example of an *Absolute* path.

```
C:\Windows\System32\shell.dll
```

A *Relative* path begins with a dot `.` or double dot `..`.  The dot `.`
indicates the current location, the double dot `..` represents the location
directly above your current location. You can use multiple combinations
of dot `.` and double dot `..`. A *Relative* path can change based on your
current location.

This is an example of a *Relative* path.

```
PS C:\Windows\System32\> .\shell.dll
```

Notice that this path is only valid if you are in the System32 directory.

If any element in the fully qualified name includes spaces, you must enclose
the name in quotation marks `" "`. The following example shows a fully
qualified path that includes spaces.

```
"C:\Program Files\Internet Explorer\iexplore.exe"
```

## Navigating the FileSystem drives

The **FileSystem** provider exposes its data stores by mapping any logical
drives on the computer as PowerShell drives. To work with a **FileSystem**
drive you can change your location to a drive uing the drive name followed
by a colon (`:`).

```powershell
Set-Location C:
```

You can also work with the **FileSystem** provider from any other PowerShell
drive. To reference a file or directory from another location, use the drive name (`C:`, `D:`, ...) in the path.

PowerShell uses aliases to allow you a familiar way to work with provider
paths. Commands such as `dir` and `ls` are now aliases for
[Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md), and
`cd` is an alias for
[Set-Location](../../Microsoft.PowerShell.Management/Set-Location.md).

### Example 1: Getting to a FileSystem drive

This command uses the `Set-Location` cmdlet to change the current location
to the root of a **FileSystem** drive. You can use this command from any drive in PowerShell. Use a backslash (\\) or a forward slash (/) to indicate a level of the **FileSystem** drive.

```powershell
Set-Location C:
```

{{Should I combine Navigation and Provider Paths??}}

### Example 2: Get the current location

This command gets the current location:

```powershell
Get-Location
```

The [Get-Location](../../Microsoft.PowerShell.Management/Get-Location.md)
cmdlet includes the functionality of commands like the `cd` command in the
Windows Command Prompt and the `pwd` command in UNIX. For more information,
type:

```powershell
Get-Help Get-Location
```

## Getting file and directory information

### Example 1: Get all items in the current directory

This command gets all the files and directories in the current directory:

```powershell
Get-ChildItem
```

By default, the
[Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md) cmdlet
does not recurse. If files and folders are present in the current directory
when you run this command, a
[System.IO.FileInfo](https://msdn.microsoft.com/library/system.io.fileinfo)
object and a
[System.IO.DirectoryInfo](https://msdn.microsoft.com/library/system.io.directoryinfo)
object are returned.

### Example 2: Get only files in the current directory

This command gets all the files in the current directory:

```powershell
Get-ChildItem -File
```

The command uses the
[Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md) cmdlet
to get all files and directories. It pipes the results to the
[Where-Object](../Where-Object.md) cmdlet, which selects only the objects that
are not (`!`) containers.

### Example 3: Get only directories in the current location

The command uses the
[Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md) cmdlet
to get all files and directories. It pipes the results to
[Where-Object](../Where-Object.md), which select only the objects that are
containers.

```powershell
Get-ChildItem | Where-Object {$_.psiscontainer}
```

## Copying files and directories

### Example 1: Copy a file to a new location

This command copies the `a.txt` file from the `C:\a` directory to the `C:\a\bb`
directory:

```powershell
Copy-Item -Path C:\a\a.txt -Destination C:\a\bb\a.txt
```

It overwrites files in the destination directory without prompting for
confirmation.

### Example 2: Copy files to a new location using wildcards

This command copies all the files in the `C:\a\bb` directory that have the
`.txt` file name extension to the `C:\a\cc\ccc\` directory:

```powershell
Copy-Item -Path C:\a\bb\*.txt -Destination C:\a\cc\ccc\
```

It uses the original names of the files. The command overwrites the existing
files in the destination directory without prompting for confirmation.

### Example 3: Recursively copy files to a new location using wildcards

Copies all the directories and files in the `C:\a` directory to the `C:\c`
directory. If any of the directories to copy already exist in the destination
directory, the command will fail unless you specify the Force parameter.

```powershell
Copy-Item -Path C:\a\* -Destination C:\c -Recurse
```

## Moving files and directories

### Example 1: Move a file to a new location

This command moves the `c.txt` file in the `C:\a` directory to the `C:\a\aa`
directory:

```powershell
Move-Item -Path C:\a\c.txt -Destination C:\a\aa
```

The command will not automatically overwrite an existing file that has the same
name. To force the cmdlet to overwrite an existing file, specify the Force
parameter.

### Example 2: Move a directory to a new location

This command moves the `C:\a` directory and all its contents to the `C:\b`
directory:

```powershell
Move-Item -Path C:\a -Destination C:\b
```

You cannot move a directory when that directory is the current location.

## Managing file content

### Example 1: Add content to a file

This command appends the "test content" string to the `Test.txt` file:

```powershell
Add-Content -Path test.txt -Value "test content"
```

The existing content in the `Test.txt` file is not deleted.

### Example 2: Get the content of a file

This command gets the contents of the `Test.txt` file and displays them in the
console:

```powershell
Get-Content -Path test.txt
```

You can pipe the contents of the file to another cmdlet. For example, the
following command reads the contents of the `Test.txt` file and then supplies
them as input to the
[ConvertTo-Html](../../Microsoft.PowerShell.Utility/ConvertTo-Html.md) cmdlet:

```powershell
Get-Content -Path test.txt | ConvertTo-Html
```

### Example 3: Replace the content of a file

This command replaces the contents of the `Test.txt` file with the "test
content" string:

```powershell
Set-Content -Path test.txt -Value "test content"
```

It overwrites the contents of `Test.txt`. You can use the **Value** parameter
of the [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) cmdlet to
add content to a file when you create it.

### Example 4: Loop through the contents of a file

By default, the `Get-Content` cmdlet uses the end-of-line character as its
delimiter, so it gets a file as a collection of strings, with each line as one
string in the file.

You can use the `-Delimiter` parameter to specify an alternate delimiter. If
you set it to the characters that denote the end of a section or the beginning
of the next section, you can split the file into logical parts.

The first command gets the `Employees.txt` file and splits it into sections,
each of which ends with the words "End of Employee Record" and it saves it in
the `$e` variable.

The second command uses array notation to get the first item in the collection
in `$e`. It uses an index of 0, because PowerShell arrays are zero-based.

For more information about `Get-Content` cmdlet, see the help topic for the
[Get-Content](../../Microsoft.PowerShell.Management/Get-Content.md).

For more information about arrays, see [about_Arrays](../About/about_Arrays.md).

```powershell
$e = Get-Content c:\test\employees.txt -Delimited "End Of Employee Record"
$e[0]
```

## Managing security descriptors

### Example 1: View the ACL for a file

This command returns a
[System.Security.AccessControl.FileSecurity](https://msdn.microsoft.com/library/system.security.accesscontrol.filesecurity)
object:

```powershell
Get-Acl -Path test.txt | Format-List -Property *
```

For more information about this object, pipe the command to the
[Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md) cmdlet. Or, see
"[FileSecurity](http://go.microsoft.com/fwlink/?LinkId=145718) Class" in the
MSDN (Microsoft Developer Network) library.

### Example 2: Modify the ACL for a file

### Example 3: Create and set an ACL for a file

## Creating files and directories

### Example 1: Create a directory

This command creates the `logfiles` directory on the `C` drive:

```powershell
New-Item -Path c:\ -Name logfiles -Type directory
```

PowerShell also includes a `mkdir` function (alias `md`) that uses the
[New-Item](../../Microsoft.PowerShell.Management/New-Item.md) cmdlet to
create a new directory.

### Example 2: Create a file

This command creates the `log2.txt` file in the `C:\logfiles` directory and
then adds the "test log" string to the file:

```powershell
New-Item -Path c:\logfiles -Name log2.txt -Type file
```

### Example 3: Create a file with content

Creates a file called `log2.txt` in the `C:\logfiles` directory and adds the
string "test log" to the file.

```powershell
New-Item -Path c:\logfiles -Name log2.txt -Type file -Value "test log"
```

## Renaming files and directories

### Example 1: Rename a file

This command renames the `a.txt` file in the `C:\a` directory to `b.txt`:

```powershell
Rename-Item -Path c:\a\a.txt -NewName b.txt
```

### Example 2: Rename a directory

This command renames the `C:\a\cc` directory to `C:\a\dd`:

```powershell
Rename-Item -Path c:\a\cc -NewName dd
```

## Deleting files and directories

### Example 1: Delete a file

This command deletes the `Test.txt` file in the current directory:

```powershell
Remove-Item -Path test.txt
```

### Example 2: Delete files using wildcards

This command deletes all the files in the current directory that have the
`.xml` file name extension:

```powershell
Remove-Item -Path *.xml
```

## Starting a program by invoking an associated file

### Example 1: Invoke a file

The first command uses the
[Get-Service](../../Microsoft.PowerShell.Management/Get-Service.md) cmdlet to
get information about local services.

It pipes the information to the
[Export-Csv](../../Microsoft.PowerShell.Utility/Export-Csv.md) cmdlet and then
stores that information in the `Services.csv` file.

The second command uses
[Invoke-Item](../../Microsoft.PowerShell.Management/Invoke-Item.md) to open the
`services.csv` file in the program associated with the `.csv` extension:

```powershell
Get-Service | Export-Csv -Path services.csv
Invoke-Item -Path services.csv
```

## Getting files and folders with specified attributes

### Example 1: Get System files

This command gets system files in the current directory and its subdirectories.

It uses the `-File` parameter to get only files (not directories) and the
`-System` parameter to get only items with the "system" attribute.

It uses the `-Recurse` parameter to get the items in the current directory and
all subdirectories.

```powershell
Get-ChildItem -File -System -Recurse
```

### Example 2: Get Hidden files

This command gets all files, including hidden files, in the current directory.

It uses the **Attributes** parameter with two values, `!Directory+Hidden`,
which gets hidden files, and `!Directory`, which gets all other files.

```powershell
Get-ChildItem -Attributes !Directory,!Directory+Hidden
```

`dir -att !d,!d+h` is the equivalent of this command.

### Example 3: Get Compressed and Encrypted files

This command gets files in the current directory that are either compressed or
encrypted.

It uses the `-Attributes` parameter with two values, `Compressed` and
`Encrypted`. The values are separated by a comma `,` which represents the "OR"
operator.

```powershell
Get-ChildItem -Attributes Compressed,Encrypted
```

## Dynamic parameters

Dynamic parameters are cmdlet parameters that are added by a PowerShell
provider and are available only when the cmdlet is being used in the
provider-enabled drive.

### Encoding \<Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding\>

Specifies the file encoding. The default is ASCII.

- **ASCII**:  Uses the encoding for the ASCII (7-bit) character set.
- **BigEndianUnicode**:  Encodes in UTF-16 format using the big-endian byte order.
- **String**:  Uses the encoding type for a string.
- **Unicode**:  Encodes in UTF-16 format using the little-endian byte order.
- **UTF7**:   Encodes in UTF-7 format.
- **UTF8**:  Encodes in UTF-8 format.
- **UTF8BOM**: Encodes in UTF-8 format with Byte Order Mark (BOM)
- **UF8NOBOM**: Encodes in UTF-8 format without Byte Order Mark (BOM)
- **UTF32**:  Encodes in UTF-32 format.
- **Default**: Encodes in the default installed code page.
- **OEM**: Uses the default encoding for MS-DOS and console programs.
- **Unknown**:  The encoding type is unknown or invalid. The data can be treated
  as binary.

#### Cmdlets supported

- [Add-Content](../../Microsoft.PowerShell.Management/Add-Content.md)
- [Get-Content](../../Microsoft.PowerShell.Management/Get-Content.md)
- [Set-Content](../../Microsoft.PowerShell.Management/Set-Content.md)

### Delimiter \<System.String\>

Specifies the delimiter that
[Get-Content](../../Microsoft.PowerShell.Management/Get-Content.md) uses to
divide the file into objects while it reads.

The default is `\n`, the end-of-line character.

When reading a text file,
[Get-Content](../../Microsoft.PowerShell.Management/Get-Content.md) returns a
collection of string objects, each of which ends with the delimiter character.

Entering a delimiter that does not exist in the file,
[Get-Content](../../Microsoft.PowerShell.Management/Get-Content.md) returns the
entire file as a single, un-delimited object.

You can use this parameter to split a large file into smaller files by
specifying a file separator, such as "End of Example", as the delimiter. The
delimiter is preserved (not discarded) and becomes the last item in each file
section.

> [!NOTE]
> Currently, when the value of the `-Delimiter` parameter is an empty string,
> [Get-Content](../../Microsoft.PowerShell.Management/Get-Content.md) does not return anything.
> This is a known issue. To force [Get-Content](../../Microsoft.PowerShell.Management/Get-Content.md) to return the entire
> file as a single, undelimited string, enter a value that does not exist in
> the file.

#### Cmdlets supported

- [Get-Content](../../Microsoft.PowerShell.Management/Get-Content.md)

### Wait \<System.Management.Automation.SwitchParameter\>

Waits for content to be appended to the file. If content is appended, it
returns the appended content. If the content has changed, it returns the entire
file.

When waiting,
[Get-Content](../../Microsoft.PowerShell.Management/Get-Content.md) checks the
file once each second until you interrupt it, such as by pressing CTRL+C.

#### Cmdlets supported

- [Get-Content](../../Microsoft.PowerShell.Management/Get-Content.md)

### Attributes \<FlagsExpression\>

Gets files and folders with the specified attributes. This parameter supports
all attributes and lets you specify complex combinations of attributes.

The `-Attributes` parameter was introduced in Windows PowerShell 3.0.

The `-Attributes` parameter supports the following attributes:

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

For a description of these attributes, see the
[FileAttributes](http://go.microsoft.com/fwlink/?LinkId=201508) enumeration.

Use the following operators to combine attributes.

- `!` - NOT
- `+` - AND
- `,` - OR

No spaces are permitted between an operator and its attribute. However, spaces
are permitted before commas.

#### Cmdlets supported

- [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md)

### Directory \<System.Management.Automation.SwitchParameter\>

Gets directories (folders).

The `-Directory` parameter was introduced in Windows PowerShell 3.0.

To get only directories, use the `-Directory` parameter and omit the `-File`
parameter. To exclude directories, use the `-File` parameter and omit the
`-Directory` parameter, or use the `-Attributes` parameter.

#### Cmdlets supported

- [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md)

### File \<System.Management.Automation.SwitchParameter\>

Gets files.

The `-File` parameter was introduced in Windows PowerShell 3.0.

To get only files, use the `-File` parameter and omit the `-Directory`
parameter. To exclude files, use the `-Directory` parameter and omit the
`-File` parameter, or use the `-Attributes` parameter.

#### Cmdlets supported

- [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md)

### Hidden \<System.Management.Automation.SwitchParameter\>

Gets only hidden files and directories (folders). By default, [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md) gets only non-hidden items.

The `-Hidden` parameter was introduced in Windows PowerShell 3.0.

To get only hidden items, use the `-Hidden` parameter, its `h` or `ah` aliases,
or the **Hidden** value of the `-Attributes` parameter. To exclude hidden
items, omit the `-Hidden` parameter or use the `-Attributes` parameter.

#### Cmdlets supported

- [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md)

### ReadOnly \<System.Management.Automation.SwitchParameter\>

Gets only read-only files and directories (folders).

The `-ReadOnly` parameter was introduced in Windows PowerShell 3.0.

To get only read-only items, use the `-ReadOnly` parameter, its `ar` alias, or
the **ReadOnly** value of the `-Attributes` parameter. To exclude read-only
items, use the `-Attributes` parameter.

#### Cmdlets supported

- [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md)

### System \<System.Management.Automation.SwitchParameter\>

Gets only system files and directories (folders).

The `-System` parameter was introduced in Windows PowerShell 3.0.

To get only system files and folders, use the `-System` parameter, its `as`
alias, or the **System** value of the `-Attributes` parameter. To exclude
system files and folders, use the `-Attributes` parameter.

#### Cmdlets supported

- [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md)

### NewerThan \<System.DateTime\>

Returns `$True` when the `LastWriteTime` value of a file is greater than the
specified date. Otherwise, it returns `$False`.

Enter a [DateTime](https://msdn.microsoft.com/library/system.datetime) object,
such as one that the [Get-Date](../../Microsoft.PowerShell.Utility/Get-Date.md)
cmdlet returns, or a string that can be converted to a
[DateTime](https://msdn.microsoft.com/library/system.datetime) object, such as
`"August 10, 2011 2:00 PM"`.

#### Cmdlets supported

- [Test-Path](../../Microsoft.PowerShell.Management/Test-Path.md)

### OlderThan \<System.DateTime\>

Returns `$True` when the `LastWriteTime` value of a file is less than the
specified date. Otherwise, it returns `$False`.

Enter a [DateTime](https://msdn.microsoft.com/library/system.datetime) object,
such as one that the [Get-Date](../../Microsoft.PowerShell.Utility/Get-Date.md)
cmdlet returns, or a string that can be converted to a
[DateTime](https://msdn.microsoft.com/library/system.datetime) object, such as
`"August 10, 2011 2:00 PM"`.

#### Cmdlets supported

- [Test-Path](../../Microsoft.PowerShell.Management/Test-Path.md)

### Stream \<System.String\>

Manages alternate data streams. Enter the stream name. Wildcards are permitted
only in [Get-Item](Get-Item.md) for and [Remove-Item](Remove-Item.md) commands
in a file system drive.

#### Cmdlets supported

- [Add-Content](../../Microsoft.PowerShell.Management/Add-Content.md)
- [Clear-Content](../../Microsoft.PowerShell.Management/Clear-Content.md)
- [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)
- [Get-Content](../../Microsoft.PowerShell.Management/Get-Content.md)
- [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md)
- [Set-Content](../../Microsoft.PowerShell.Management/Set-Content.md)

### Raw \<SwitchParameter\>

Ignores newline characters. Returns contents as a single item.

#### Cmdlets supported

- [Get-Content](../../Microsoft.PowerShell.Management/Get-Content.md)

## Getting help

Beginning in Windows PowerShell 3.0, you can get customized help topics for
provider cmdlets that explain how those cmdlets behave in a file system drive.

To get the help topics that are customized for the file system drive, run a
[Get-Help](../Get-Help.md) command in a file system drive or use the `-Path`
parameter of [Get-Help](../Get-Help.md) to specify a file system drive.

```powershell
Get-Help Get-ChildItem
```

```powershell
Get-Help Get-ChildItem -Path c:
```

{{Make provider specific>}}

## See also

[about_Providers](../About/about_Providers.md)