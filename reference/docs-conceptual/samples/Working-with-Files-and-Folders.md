---
description: This article discusses how to deal with specific file and folder manipulation tasks using PowerShell.
ms.date: 10/18/2023
title: Working with files and folders
---
# Working with files and folders

Navigating through PowerShell drives and manipulating the items on them is similar to manipulating
files and folders on Windows disk drives. This article discusses how to deal with specific file and
folder manipulation tasks using PowerShell.

## Listing all files and folders within a folder

You can get all items directly within a folder using `Get-ChildItem`. Add the optional **Force**
parameter to display hidden or system items. For example, this command displays the direct contents
of PowerShell Drive `C:`.

```powershell
Get-ChildItem -Path C:\ -Force
```

The command lists only the directly contained items, much like using the `dir` command in `cmd.exe`
or `ls` in a UNIX shell. To show items in subfolder, you need to specify the **Recurse** parameter.
The following command lists everything on the `C:` drive:

```powershell
Get-ChildItem -Path C:\ -Force -Recurse
```

`Get-ChildItem` can filter items with its **Path**, **Filter**, **Include**, and **Exclude**
parameters, but those are typically based only on name. You can perform complex filtering based on
other properties of items using `Where-Object`.

The following command finds all executables within the Program Files folder that were last modified
after October 1, 2005 and that are neither smaller than 1 megabyte nor larger than 10 megabytes:

```powershell
Get-ChildItem -Path $env:ProgramFiles -Recurse -Include *.exe |
    Where-Object -FilterScript {
        ($_.LastWriteTime -gt '2005-10-01') -and ($_.Length -ge 1mb) -and ($_.Length -le 10mb)
    }
```

## Copying files and folders

Copying is done with `Copy-Item`. The following command backs up your PowerShell profile script:

```powershell
if (Test-Path -Path $PROFILE) {
    Copy-Item -Path $PROFILE -Destination $($PROFILE -replace 'ps1$', 'bak')
}
```

The `Test-Path` command checks whether the profile script exists.

If the destination file already exists, the copy attempt fails. To overwrite a pre-existing
destination, use the **Force** parameter:

```powershell
if (Test-Path -Path $PROFILE) {
    Copy-Item -Path $PROFILE -Destination $($PROFILE -replace 'ps1$', 'bak') -Force
}
```

This command works even when the destination is read-only.

Folder copying works the same way. This command copies the folder `C:\temp\test1` to the new folder
`C:\temp\DeleteMe` recursively:

```powershell
Copy-Item C:\temp\test1 -Recurse C:\temp\DeleteMe
```

You can also copy a selection of items. The following command copies all `.txt` files contained
anywhere in `C:\data` to `C:\temp\text`:

```powershell
Copy-Item -Filter *.txt -Path c:\data -Recurse -Destination C:\temp\text
```

You can still run native commands like `xcopy.exe` and `robocopy.exe` to copy files.

## Creating files and folders

Creating new items works the same on all PowerShell providers. If a PowerShell provider has more
than one type of item—for example, the FileSystem PowerShell provider distinguishes between
directories and files—you need to specify the item type.

This command creates a new folder `C:\temp\New Folder`:

```powershell
New-Item -Path 'C:\temp\New Folder' -ItemType Directory
```

This command creates a new empty file `C:\temp\New Folder\file.txt`

```powershell
New-Item -Path 'C:\temp\New Folder\file.txt' -ItemType File
```

> [!IMPORTANT]
> When using the **Force** switch with the `New-Item` command to create a folder, and the folder
> already exists, it _won't_ overwrite or replace the folder. It will simply return the existing
> folder object. However, if you use `New-Item -Force` on a file that already exists, the file
> is overwritten.

## Removing all files and folders within a folder

You can remove contained items using `Remove-Item`, but you will be prompted to confirm the
removal if the item contains anything else. For example, if you attempt to delete the folder
`C:\temp\DeleteMe` that contains other items, PowerShell prompts you for confirmation before
deleting the folder:

```powershell
Remove-Item -Path C:\temp\DeleteMe
```

```Output
Confirm
The item at C:\temp\DeleteMe has children and the Recurse parameter wasn't
specified. If you continue, all children will be removed with the item. Are you
sure you want to continue?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help
(default is "Y"):
```

If you don't want to be prompted for each contained item, specify the **Recurse** parameter:

```powershell
Remove-Item -Path C:\temp\DeleteMe -Recurse
```

## Mapping a local folder as a drive

You can also map a local folder, using the `New-PSDrive` command. The following command creates a
local drive `P:` rooted in the local Program Files directory, visible only from the PowerShell
session:

```powershell
New-PSDrive -Name P -Root $env:ProgramFiles -PSProvider FileSystem
```

Just as with network drives, drives mapped within PowerShell are immediately visible to the
PowerShell shell. To create a mapped drive visible from File Explorer, use the **Persist**
parameter. However, only remote paths can be used with **Persist**.

## Reading a text file into an array

One of the more common storage formats for text data is in a file with separate lines treated as
distinct data elements. The `Get-Content` cmdlet can be used to read an entire file in one step,
as shown here:

```powershell
Get-Content -Path $PROFILE
# Load modules and change to the PowerShell-Docs repository folder
Import-Module posh-git
Set-Location C:\Git\PowerShell-Docs
```

`Get-Content` treats the data read from the file as an array, with one element per line of file
content. You can confirm this by checking the **Length** of the returned content:

```powershell
PS> (Get-Content -Path $PROFILE).Length
3
```

This command is most useful for getting lists of information into PowerShell. For example, you might
store a list of computer names or IP addresses in the file `C:\temp\domainMembers.txt`, with one
name on each line of the file. You can use `Get-Content` to retrieve the file contents and put them
in the variable `$Computers`:

```powershell
$Computers = Get-Content -Path C:\temp\DomainMembers.txt
```

`$Computers` is now an array containing a computer name in each element.
