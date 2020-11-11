---
description: FileSystem 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 10/18/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_filesystem_provider?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: FileSystem Provider
---
# FileSystem provider

## Provider name

FileSystem

## Drives

`C:`, `D:` ...

## Capabilities

**Filter**, **ShouldProcess**

## Short description

Provides access to files and directories.

## Detailed description

The PowerShell **FileSystem** provider lets you get, add, change, clear, and
delete files and directories in PowerShell.

The **FileSystem** drives are a hierarchical namespace containing the
directories and files on your computer. A **FileSystem** drive can be a logical
or phsyical drive, directory, or mapped network share.

The **FileSystem** provider supports the following cmdlets, which are covered
in this article.

- [Get-Location](xref:Microsoft.PowerShell.Management.Get-Location)
- [Set-Location](xref:Microsoft.PowerShell.Management.Set-Location)
- [Get-Item](xref:Microsoft.PowerShell.Management.Get-Item)
- [Get-ChildItem](xref:Microsoft.PowerShell.Management.Get-ChildItem)
- [Invoke-Item](xref:Microsoft.PowerShell.Management.Invoke-Item)
- [Move-Item](xref:Microsoft.PowerShell.Management.Move-Item)
- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)
- [Remove-Item](xref:Microsoft.PowerShell.Management.Remove-Item)
- [Get-ItemProperty](xref:Microsoft.PowerShell.Management.Get-ItemProperty)
- [Set-ItemProperty](xref:Microsoft.PowerShell.Management.Set-ItemProperty)
- [Clear-Item](xref:Microsoft.PowerShell.Management.Clear-Item)
- [Clear-ItemProperty](xref:Microsoft.PowerShell.Management.Clear-ItemProperty)
- [Remove-Item](xref:Microsoft.PowerShell.Management.Remove-Item)
- [Remove-ItemProperty](xref:Microsoft.PowerShell.Management.Remove-ItemProperty)
- [Get-Acl](xref:Microsoft.PowerShell.Security.Get-Acl)
- [Set-Acl](xref:Microsoft.PowerShell.Security.Set-Acl)
- [Get-AuthenticodeSignature](xref:Microsoft.PowerShell.Security.Get-AuthenticodeSignature)
- [Set-AuthenticodeSignature](xref:Microsoft.PowerShell.Security.Set-AuthenticodeSignature)

## Types exposed by this provider

Files are instances of the [System.IO.FileInfo](/dotnet/api/system.io.fileinfo) class.  Directories are
instances of the [System.IO.DirectoryInfo](/dotnet/api/system.io.directoryinfo) class.

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

> [!NOTE]
> PowerShell uses aliases to allow you a familiar way to work with provider
> paths. Commands such as `dir` and `ls` are now aliases for
> [Get-ChildItem](xref:Microsoft.PowerShell.Management.Get-ChildItem),
> `cd` is an alias for [Set-Location](xref:Microsoft.PowerShell.Management.Set-Location). and `pwd` is
> an alias for [Get-Location](xref:Microsoft.PowerShell.Management.Get-Location).

## Getting files and directories

The `Get-ChildItem` cmdlet returns all files and directories in the
current location. You can specify a different path to search and use built
in parameters to filter and control the recursion depth.

```powershell
Get-ChildItem
```

To read more about cmdlet usage, see [Get-ChildItem](xref:Microsoft.PowerShell.Management.Get-ChildItem).

## Copying files and directories

The `Copy-Item` cmdlet copies files and directories to a location you specify.
Parameters are available to filter and recurse, similar to `Get-ChildItem`.

The following command copies all of the files and directories under the path
"C:\temp\" to the folder "C:\Windows\Temp".

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
directory, the command will fail unless you specify the Force parameter.

```powershell
Copy-Item -Path C:\a\* -Destination C:\c -Recurse
```

For more information, see [Copy-Item](xref:Microsoft.PowerShell.Management.Copy-Item).

## Moving files and directories

This command moves the `c.txt` file in the `C:\a` directory to the `C:\a\aa`
directory:

```powershell
Move-Item -Path C:\a\c.txt -Destination C:\a\aa
```

The command will not automatically overwrite an existing file that has the same
name. To force the cmdlet to overwrite an existing file, specify the Force
parameter.

You cannot move a directory when that directory is the current location. When
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
them as input to the
[ConvertTo-Html](xref:Microsoft.PowerShell.Utility.ConvertTo-Html) cmdlet:

```powershell
Get-Content -Path Test.txt | ConvertTo-Html
```

You can also retrieve the content of a file by prefixing its provider path with
the dollar sign (`$`). The path must be enclosed in curly braces due to variable
naming restrictions. For more information, see [about_Variables](about_Variables.md).

```powershell
${C:\Windows\System32\Drivers\etc\hosts}
```

### Add content to a file

This command appends the "test content" string to the `Test.txt` file:

```powershell
Add-Content -Path test.txt -Value "test content"
```

The existing content in the `Test.txt` file is not deleted.

### Replace the content of a file

This command replaces the contents of the `Test.txt` file with the "test
content" string:

```powershell
Set-Content -Path test.txt -Value "test content"
```

It overwrites the contents of `Test.txt`. You can use the **Value** parameter
of the [New-Item](xref:Microsoft.PowerShell.Management.New-Item) cmdlet to
add content to a file when you create it.

### Loop through the contents of a file

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
[Get-Content](xref:Microsoft.PowerShell.Management.Get-Content).

For more information about arrays, see [about_Arrays](../About/about_Arrays.md).

```powershell
$e = Get-Content c:\test\employees.txt -Delimited "End Of Employee Record"
$e[0]
```

## Managing security descriptors

### View the ACL for a file

This command returns a
[System.Security.AccessControl.FileSecurity](/dotnet/api/system.security.accesscontrol.filesecurity)
object:

```powershell
Get-Acl -Path test.txt | Format-List -Property *
```

For more information about this object, pipe the command to the
[Get-Member](xref:Microsoft.PowerShell.Utility.Get-Member) cmdlet. Or, see
[FileSecurity](/dotnet/api/system.security.accesscontrol.filesecurity) Class.

### Modify the ACL for a file

### Create and set an ACL for a file

## Creating files and directories

### Create a directory

This command creates the `logfiles` directory on the `C` drive:

```powershell
New-Item -Path c:\ -Name logfiles -Type directory
```

PowerShell also includes a `mkdir` function (alias `md`) that uses the
[New-Item](xref:Microsoft.PowerShell.Management.New-Item) cmdlet to
create a new directory.

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

The first command uses the
[Get-Service](xref:Microsoft.PowerShell.Management.Get-Service) cmdlet to
get information about local services.

It pipes the information to the
[Export-Csv](xref:Microsoft.PowerShell.Utility.Export-Csv) cmdlet and then
stores that information in the `Services.csv` file.

The second command uses
[Invoke-Item](xref:Microsoft.PowerShell.Management.Invoke-Item) to open the
`services.csv` file in the program associated with the `.csv` extension:

```powershell
Get-Service | Export-Csv -Path services.csv
Invoke-Item -Path services.csv
```

## Getting files and folders with specified attributes

### Get System files

This command gets system files in the current directory and its subdirectories.

It uses the `-File` parameter to get only files (not directories) and the
`-System` parameter to get only items with the "system" attribute.

It uses the `-Recurse` parameter to get the items in the current directory and
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

- [Add-Content](xref:Microsoft.PowerShell.Management.Add-Content)
- [Get-Content](xref:Microsoft.PowerShell.Management.Get-Content)
- [Set-Content](xref:Microsoft.PowerShell.Management.Set-Content)

### Delimiter \<System.String\>

Specifies the delimiter that
[Get-Content](xref:Microsoft.PowerShell.Management.Get-Content) uses to
divide the file into objects while it reads.

The default is `\n`, the end-of-line character.

When reading a text file,
[Get-Content](xref:Microsoft.PowerShell.Management.Get-Content) returns a
collection of string objects, each of which ends with the delimiter character.

Entering a delimiter that does not exist in the file,
[Get-Content](xref:Microsoft.PowerShell.Management.Get-Content) returns the
entire file as a single, un-delimited object.

You can use this parameter to split a large file into smaller files by
specifying a file separator, such as "End of Example", as the delimiter. The
delimiter is preserved (not discarded) and becomes the last item in each file
section.

> [!NOTE]
> Currently, when the value of the `-Delimiter` parameter is an empty string,
> [Get-Content](xref:Microsoft.PowerShell.Management.Get-Content) does not return anything.
> This is a known issue. To force [Get-Content](xref:Microsoft.PowerShell.Management.Get-Content) to return the entire
> file as a single, undelimited string, enter a value that does not exist in
> the file.

#### Cmdlets supported

- [Get-Content](xref:Microsoft.PowerShell.Management.Get-Content)

### Wait \<System.Management.Automation.SwitchParameter\>

Waits for content to be appended to the file. If content is appended, it
returns the appended content. If the content has changed, it returns the entire
file.

When waiting,
[Get-Content](xref:Microsoft.PowerShell.Management.Get-Content) checks the
file once each second until you interrupt it, such as by pressing CTRL+C.

#### Cmdlets supported

- [Get-Content](xref:Microsoft.PowerShell.Management.Get-Content)

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
[FileAttributes](/dotnet/api/system.io.fileattributes) enumeration.

Use the following operators to combine attributes.

- `!` - NOT
- `+` - AND
- `,` - OR

No spaces are permitted between an operator and its attribute. However, spaces
are permitted before commas.

#### Cmdlets supported

- [Get-ChildItem](xref:Microsoft.PowerShell.Management.Get-ChildItem)

### Directory \<System.Management.Automation.SwitchParameter\>

Gets directories (folders).

The `-Directory` parameter was introduced in Windows PowerShell 3.0.

To get only directories, use the `-Directory` parameter and omit the `-File`
parameter. To exclude directories, use the `-File` parameter and omit the
`-Directory` parameter, or use the `-Attributes` parameter.

#### Cmdlets supported

- [Get-ChildItem](xref:Microsoft.PowerShell.Management.Get-ChildItem)

### File \<System.Management.Automation.SwitchParameter\>

Gets files.

The `-File` parameter was introduced in Windows PowerShell 3.0.

To get only files, use the `-File` parameter and omit the `-Directory`
parameter. To exclude files, use the `-Directory` parameter and omit the
`-File` parameter, or use the `-Attributes` parameter.

#### Cmdlets supported

- [Get-ChildItem](xref:Microsoft.PowerShell.Management.Get-ChildItem)

### Hidden \<System.Management.Automation.SwitchParameter\>

Gets only hidden files and directories (folders). By default, [Get-ChildItem](xref:Microsoft.PowerShell.Management.Get-ChildItem) gets only non-hidden items.

The `-Hidden` parameter was introduced in Windows PowerShell 3.0.

To get only hidden items, use the `-Hidden` parameter, its `h` or `ah` aliases,
or the **Hidden** value of the `-Attributes` parameter. To exclude hidden
items, omit the `-Hidden` parameter or use the `-Attributes` parameter.

#### Cmdlets supported

- [Get-ChildItem](xref:Microsoft.PowerShell.Management.Get-ChildItem)

### ReadOnly \<System.Management.Automation.SwitchParameter\>

Gets only read-only files and directories (folders).

The `-ReadOnly` parameter was introduced in Windows PowerShell 3.0.

To get only read-only items, use the `-ReadOnly` parameter, its `ar` alias, or
the **ReadOnly** value of the `-Attributes` parameter. To exclude read-only
items, use the `-Attributes` parameter.

#### Cmdlets supported

- [Get-ChildItem](xref:Microsoft.PowerShell.Management.Get-ChildItem)

### System \<System.Management.Automation.SwitchParameter\>

Gets only system files and directories (folders).

The `-System` parameter was introduced in Windows PowerShell 3.0.

To get only system files and folders, use the `-System` parameter, its `as`
alias, or the **System** value of the `-Attributes` parameter. To exclude
system files and folders, use the `-Attributes` parameter.

#### Cmdlets supported

- [Get-ChildItem](xref:Microsoft.PowerShell.Management.Get-ChildItem)

### NewerThan \<System.DateTime\>

Returns `$True` when the `LastWriteTime` value of a file is greater than the
specified date. Otherwise, it returns `$False`.

Enter a [DateTime](/dotnet/api/system.datetime) object,
such as one that the [Get-Date](xref:Microsoft.PowerShell.Utility.Get-Date)
cmdlet returns, or a string that can be converted to a
[DateTime](/dotnet/api/system.datetime) object, such as
`"August 10, 2011 2:00 PM"`.

#### Cmdlets supported

- [Test-Path](xref:Microsoft.PowerShell.Management.Test-Path)

### OlderThan \<System.DateTime\>

Returns `$True` when the `LastWriteTime` value of a file is less than the
specified date. Otherwise, it returns `$False`.

Enter a [DateTime](/dotnet/api/system.datetime) object,
such as one that the [Get-Date](xref:Microsoft.PowerShell.Utility.Get-Date)
cmdlet returns, or a string that can be converted to a
[DateTime](/dotnet/api/system.datetime) object, such as
`"August 10, 2011 2:00 PM"`.

#### Cmdlets supported

- [Test-Path](xref:Microsoft.PowerShell.Management.Test-Path)

### Stream \<System.String\>

Manages alternate data streams. Enter the stream name. Wildcards are permitted
only in [Get-Item](xref:Microsoft.PowerShell.Management.Get-Item) for and [Remove-Item](xref:Microsoft.PowerShell.Management.Remove-Item) commands
in a file system drive.

#### Cmdlets supported

- [Add-Content](xref:Microsoft.PowerShell.Management.Add-Content)
- [Clear-Content](xref:Microsoft.PowerShell.Management.Clear-Content)
- [Get-Item](xref:Microsoft.PowerShell.Management.Get-Item)
- [Get-Content](xref:Microsoft.PowerShell.Management.Get-Content)
- [Remove-Item](xref:Microsoft.PowerShell.Management.Remove-Item)
- [Set-Content](xref:Microsoft.PowerShell.Management.Set-Content)

### Raw \<SwitchParameter\>

Ignores newline characters. Returns contents as a single item.

#### Cmdlets supported

- [Get-Content](xref:Microsoft.PowerShell.Management.Get-Content)

### ItemType \<String\>

This parameter allows you to specify the tye of item to create with `New-Item`

The available values of this parameter depend on the current provider you are using.

In a `FileSystem` drive, the following values are allowed:

- File
- Directory
- SymbolicLink
- Junction
- HardLink

### Cmdlets supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

## Using the pipeline

Provider cmdlets accept pipeline input. You can use the pipeline to simplify
task by sending provider data from one cmdlet to another provider cmdlet.
To read more about how to use the pipeline with provider cmdlets, see the
cmdlet references provided throughout this article.

## Getting help

Beginning in Windows PowerShell 3.0, you can get customized help topics for
provider cmdlets that explain how those cmdlets behave in a file system drive.

To get the help topics that are customized for the file system drive, run a
[Get-Help](xref:Microsoft.PowerShell.Core.Get-Help) command in a file system drive or use the `-Path`
parameter of [Get-Help](xref:Microsoft.PowerShell.Core.Get-Help) to specify a file system drive.

```powershell
Get-Help Get-ChildItem
```

```powershell
Get-Help Get-ChildItem -Path c:
```

## See also

[about_Providers](../About/about_Providers.md)
