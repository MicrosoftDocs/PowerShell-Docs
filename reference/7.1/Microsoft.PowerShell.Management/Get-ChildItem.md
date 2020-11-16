---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 03/27/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-ChildItem
---
# Get-ChildItem

## SYNOPSIS

Gets the items and child items in one or more specified locations.

## SYNTAX

### Items (Default)

```
Get-ChildItem [[-Path] <string[]>] [[-Filter] <string>] [-Include <string[]>] [-Exclude <string[]>]
 [-Recurse] [-Depth <uint32>] [-Force] [-Name] [-Attributes <FlagsExpression[FileAttributes]>]
 [-FollowSymlink] [-Directory] [-File] [-Hidden] [-ReadOnly] [-System] [<CommonParameters>]
```

### LiteralItems

```
Get-ChildItem [[-Filter] <string>] -LiteralPath <string[]> [-Include <string[]>]
 [-Exclude <string[]>] [-Recurse] [-Depth <uint32>] [-Force] [-Name]
 [-Attributes <FlagsExpression[FileAttributes]>] [-FollowSymlink] [-Directory] [-File] [-Hidden]
 [-ReadOnly] [-System] [<CommonParameters>]
```

## DESCRIPTION

The `Get-ChildItem` cmdlet gets the items in one or more specified locations. If the item is a
container, it gets the items inside the container, known as child items. You can use the **Recurse**
parameter to get items in all child containers and use the **Depth** parameter to limit the number
of levels to recurse.

`Get-ChildItem` doesn't display empty directories. When a `Get-ChildItem` command includes the
**Depth** or **Recurse** parameters, empty directories aren't included in the output.

Locations are exposed to `Get-ChildItem` by PowerShell providers. A location can be a file system
directory, registry hive, or a certificate store. For more information, see [about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

## EXAMPLES

### Example 1: Get child items from a file system directory

This example gets the child items from a file system directory. The filenames and subdirectory
names are displayed. For empty locations, the command doesn't return any output and returns to the
PowerShell prompt.

The `Get-ChildItem` cmdlet uses the **Path** parameter to specify the directory `C:\Test`.
`Get-ChildItem` displays the files and directories in the PowerShell console.

```powershell
Get-ChildItem -Path C:\Test
```

```Output
   Directory: C:\Test

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----        2/15/2019     08:29                Logs
-a----        2/13/2019     08:55             26 anotherfile.txt
-a----        2/12/2019     15:40         118014 Command.txt
-a----         2/1/2019     08:43            183 CreateTestFile.ps1
-ar---        2/12/2019     14:31             27 ReadOnlyFile.txt
```

By default `Get-ChildItem` lists the mode (**Attributes**), **LastWriteTime**, file size (**Length**),
and the **Name** of the item. The letters in the **Mode** property can be interpreted as follows:

- `l` (link)
- `d` (directory)
- `a` (archive)
- `r` (read-only)
- `h` (hidden)
- `s` (system).

For more information about the mode flags, see
[about_Filesystem_Provider](../microsoft.powershell.core/about/about_filesystem_provider.md#attributes-flagsexpression).

### Example 2: Get child item names in a directory

This example lists only the names of items in a directory.

The `Get-ChildItem` cmdlet uses the **Path** parameter to specify the directory `C:\Test`. The
**Name** parameter returns only the file or directory names from the specified path.

```powershell
Get-ChildItem -Path C:\Test -Name
```

```Output
Logs
anotherfile.txt
Command.txt
CreateTestFile.ps1
ReadOnlyFile.txt
```

### Example 3: Get child items in the current directory and subdirectories

This example displays **.txt** files that are located in the current directory and its
subdirectories.

```powershell
Get-ChildItem -Path C:\Test\*.txt -Recurse -Force
```

```Output
    Directory: C:\Test\Logs\Adirectory

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        2/12/2019     16:16             20 Afile4.txt
-a-h--        2/12/2019     15:52             22 hiddenfile.txt
-a----        2/13/2019     13:26             20 LogFile4.txt

    Directory: C:\Test\Logs\Backup

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        2/12/2019     16:16             20 ATextFile.txt
-a----        2/12/2019     15:50             20 LogFile3.txt

    Directory: C:\Test\Logs

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        2/12/2019     16:16             20 Afile.txt
-a-h--        2/12/2019     15:52             22 hiddenfile.txt
-a----        2/13/2019     13:26             20 LogFile1.txt

    Directory: C:\Test

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        2/13/2019     08:55             26 anotherfile.txt
-a----        2/12/2019     15:40         118014 Command.txt
-a-h--        2/12/2019     15:52             22 hiddenfile.txt
-ar---        2/12/2019     14:31             27 ReadOnlyFile.txt
```

The `Get-ChildItem` cmdlet uses the **Path** parameter to specify `C:\Test\*.txt`. **Path** uses the
asterisk (`*`) wildcard to specify all files with the filename extension `.txt`. The **Recurse**
parameter searches the **Path** directory its subdirectories, as shown in the **Directory:**
headings. The **Force** parameter displays hidden files such as `hiddenfile.txt` that have a mode
of **h**.

### Example 4: Get child items using the Include parameter

In this example `Get-ChildItem` uses the **Include** parameter to find specific items from the
directory specified by the **Path** parameter.

```powershell
# When using the -Include parameter, if you don't include an asterisk in the path
# the command returns no output.
Get-ChildItem -Path C:\Test\ -Include *.txt
```

```Output

```

```powershell
Get-ChildItem -Path C:\Test\* -Include *.txt
```

```Output
    Directory: C:\Test

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        2/13/2019     08:55             26 anotherfile.txt
-a----        2/12/2019     15:40         118014 Command.txt
-ar---        2/12/2019     14:31             27 ReadOnlyFile.txt
```

The `Get-ChildItem` cmdlet uses the **Path** parameter to specify the directory **C:\Test**. The
**Path** parameter includes a trailing asterisk (`*`) wildcard to specify the directory's contents.
The **Include** parameter uses an asterisk (`*`) wildcard to specify all files with the file name
extension **.txt**.

When the **Include** parameter is used, the **Path** parameter needs a trailing asterisk (`*`)
wildcard to specify the directory's contents. For example, `-Path C:\Test\*`.

- If the **Recurse** parameter is added to the command, the trailing asterisk (`*`) in the **Path**
  parameter is optional. The **Recurse** parameter gets items from the **Path** directory and its
  subdirectories. For example, `-Path C:\Test\ -Recurse -Include *.txt`
- If a trailing asterisk (`*`) isn't included in the **Path** parameter, the command doesn't return
  any output and returns to the PowerShell prompt. For example, `-Path C:\Test\`.

### Example 5: Get child items using the Exclude parameter

The example's output shows the contents of the directory **C:\Test\Logs**. The output is a reference
for the other commands that use the **Exclude** and **Recurse** parameters.

```powershell
Get-ChildItem -Path C:\Test\Logs
```

```Output
    Directory: C:\Test\Logs

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----        2/15/2019     13:21                Adirectory
d-----        2/15/2019     08:28                AnEmptyDirectory
d-----        2/15/2019     13:21                Backup
-a----        2/12/2019     16:16             20 Afile.txt
-a----        2/13/2019     13:26             20 LogFile1.txt
-a----        2/12/2019     16:24             23 systemlog1.log
```

```powershell
Get-ChildItem -Path C:\Test\Logs\* -Exclude A*
```

```Output
    Directory: C:\Test\Logs

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----        2/15/2019     13:21                Backup
-a----        2/13/2019     13:26             20 LogFile1.txt
-a----        2/12/2019     16:24             23 systemlog1.log
```

The `Get-ChildItem` cmdlet uses the **Path** parameter to specify the directory `C:\Test\Logs`.
The **Exclude** parameter uses the asterisk (`*`) wildcard to specify any files or directories that
begin with **A** or **a** are excluded from the output.

When the **Exclude** parameter is used, a trailing asterisk (`*`) in the **Path** parameter is
optional. For example, `-Path C:\Test\Logs` or `-Path C:\Test\Logs\*`.

- If a trailing asterisk (`*`) isn't included in the **Path** parameter, the contents of the **Path**
  parameter are displayed. The exceptions are filenames or subdirectory names that match the
  **Exclude** parameter's value.
- If a trailing asterisk (`*`) is included in the **Path** parameter, the command recurses into the
  **Path** parameter's subdirectories. The exceptions are filenames or subdirectory names that match
  the **Exclude** parameter's value.
- If the **Recurse** parameter is added to the command, the recursion output is the same whether or
  not the **Path** parameter includes a trailing asterisk (`*`).

### Example 6: Get the registry keys from a registry hive

This example gets all the registry keys from `HKEY_LOCAL_MACHINE\HARDWARE`.

`Get-ChildItem` uses the **Path** parameter to specify the registry key `HKLM:\HARDWARE`. The
hive's path and top level of registry keys are displayed in the PowerShell console.

For more information, see [about_Registry_Provider](../Microsoft.PowerShell.Core/About/about_Registry_Provider.md).

```powershell
Get-ChildItem -Path HKLM:\HARDWARE
```

```Output
    Hive: HKEY_LOCAL_MACHINE\HARDWARE

Name             Property
----             --------
ACPI
DESCRIPTION
DEVICEMAP
RESOURCEMAP
UEFI
```

```powershell
Get-ChildItem -Path HKLM:\HARDWARE -Exclude D*
```

```Output
   Hive: HKEY_LOCAL_MACHINE\HARDWARE

Name                           Property
----                           --------
ACPI
RESOURCEMAP
```

The first command shows the contents of the `HKLM:\HARDWARE` registry key. The **Exclude** parameter
tells `Get-ChildItem` not to return any subkeys that start with `D*`. Currently, the **Exclude**
parameter only works on subkeys, not item properties.

### Example 7: Get all certificates with code-signing authority

This example gets each certificate in the PowerShell **Cert:** drive that has code-signing
authority.

The `Get-ChildItem` cmdlet uses the **Path** parameter to specify the **Cert:** provider. The
**Recurse** parameter searches the directory specified by **Path** and its subdirectories. The
**CodeSigningCert** parameter gets only certificates that have code-signing authority.

```powershell
Get-ChildItem -Path Cert:\* -Recurse -CodeSigningCert
```

For more information about the Certificate provider and the Cert: drive,
see [about_Certificate_Provider](../Microsoft.PowerShell.Security/About/about_Certificate_Provider.md).

### Example 8: Get items using the Depth parameter

This example displays the items in a directory and its subdirectories. The **Depth** parameter
determines the number of subdirectory levels to include in the recursion. Empty directories are
excluded from the output.

```powershell
Get-ChildItem -Path C:\Parent -Depth 2
```

```Output
    Directory: C:\Parent

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----        2/14/2019     10:24                SubDir_Level1
-a----        2/13/2019     08:55             26 file.txt

    Directory: C:\Parent\SubDir_Level1

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----        2/14/2019     10:24                SubDir_Level2
-a----        2/13/2019     08:55             26 file.txt

    Directory: C:\Parent\SubDir_Level1\SubDir_Level2

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----        2/14/2019     10:22                SubDir_Level3
-a----        2/13/2019     08:55             26 file.txt
```

The `Get-ChildItem` cmdlet uses the **Path** parameter to specify **C:\Parent**. The **Depth**
parameter specifies two levels of recursion. `Get-ChildItem` displays the contents of the directory
specified by the **Path** parameter and the two levels of subdirectories.

### Example 9: Getting hard link information

In PowerShell 6.2, an alternate view was added to get hard link information.

```powershell
Get-ChildItem -Path C:\PathContainingHardLink | Format-Table -View childrenWithHardLink
```

### Example 9: Output for Non-Windows Operating Systems

In PowerShell 7.1 on Unix systems, the `Get-ChildItem` provides Unix-like output:

```powershell
PS> Get-ChildItem /etc/r*
```

```Output
    Directory: /etc

UnixMode   User Group    LastWriteTime Size Name
--------   ---- -----    ------------- ---- ----
drwxr-xr-x root wheel  9/30/2019 19:19  128 racoon
-rw-r--r-- root wheel  9/26/2019 18:20 1560 rc.common
-rw-r--r-- root wheel  7/31/2017 17:30 1560 rc.common~previous
-rw-r--r-- root wheel  9/27/2019 20:34 5264 rc.netboot
lrwxr-xr-x root wheel  11/8/2019 15:35   22 resolv.conf -> /private/var/run/resolv.conf
-rw-r--r-- root wheel 10/23/2019 17:41    0 rmtab
-rw-r--r-- root wheel 10/23/2019 17:41 1735 rpc
-rw-r--r-- root wheel  7/25/2017 18:37 1735 rpc~previous
-rw-r--r-- root wheel 10/23/2019 18:42  891 rtadvd.conf
-rw-r--r-- root wheel  8/24/2017 21:54  891 rtadvd.conf~previous
```

The new properties that are now part of the output are:

- **UnixMode** is the file permissions as represented on a Unix system
- **User** is the file owner
- **Group** is the group owner
- **Size** is the size of the file or directory as represented on a Unix system

> [!NOTE]
> This feature was moved from experimental to mainstream in PowerShell 7.1.

## Parameters

### -Attributes

Gets files and folders with the specified attributes. This parameter supports all attributes and
lets you specify complex combinations of attributes.

For example, to get non-system files (not directories) that are encrypted or compressed, type:

`Get-ChildItem -Attributes !Directory+!System+Encrypted, !Directory+!System+Compressed`

To find files and folders with commonly used attributes, use the **Attributes** parameter. Or, the
parameters **Directory**, **File**, **Hidden**, **ReadOnly**, and **System**.

The **Attributes** parameter supports the following properties:

- **Archive**
- **Compressed**
- **Device**
- **Directory**
- **Encrypted**
- **Hidden**
- **IntegrityStream**
- **Normal**
- **NoScrubData**
- **NotContentIndexed**
- **Offline**
- **ReadOnly**
- **ReparsePoint**
- **SparseFile**
- **System**
- **Temporary**

For a description of these attributes, see the [FileAttributes Enumeration](/dotnet/api/system.io.fileattributes).

To combine attributes, use the following operators:

- `!` (NOT)
- `+` (AND)
- `,` (OR)

Don't use spaces between an operator and its attribute. Spaces are accepted after commas.

For common attributes, use the following abbreviations:

- `D` (Directory)
- `H` (Hidden)
- `R` (Read-only)
- `S` (System)

```yaml
Type: System.Management.Automation.FlagsExpression`1[System.IO.FileAttributes]
Parameter Sets: (All)
Aliases:
Accepted values: Archive, Compressed, Device, Directory, Encrypted, Hidden, IntegrityStream, Normal, NoScrubData, NotContentIndexed, Offline, ReadOnly, ReparsePoint, SparseFile, System, Temporary

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Depth

This parameter was added in PowerShell 5.0 and enables you to control the depth of recursion. By
default, `Get-ChildItem` displays the contents of the parent directory. The **Depth** parameter
determines the number of subdirectory levels that are included in the recursion and displays the
contents.

For example, `Depth 2` includes the **Path** parameter's directory, first level of subdirectories,
and second level of subdirectories. By default directory names and filenames are included in the
output.

> [!NOTE]
> On a Windows computer from PowerShell or **cmd.exe**, you can display a graphical view of a
> directory structure with the **tree.com** command.

```yaml
Type: System.UInt32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Directory

To get a list of directories, use the **Directory** parameter or the **Attributes** parameter with
the **Directory** property. You can use the **Recurse** parameter with **Directory**.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: ad, d

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Exclude

Specifies, as a string array, a property or property that this cmdlet excludes from the operation.
The value of this parameter qualifies the **Path** parameter. Enter a path element or pattern, such
as `*.txt` or `A*`. Wildcard characters are accepted.

A trailing asterisk (`*`) in the **Path** parameter is optional. For example, `-Path C:\Test\Logs`
or `-Path C:\Test\Logs\*`. If a trailing asterisk (`*`) is included, the command recurses into the
**Path** parameter's subdirectories. Without the asterisk (`*`), the contents of the **Path**
parameter are displayed. More details are included in Example 5 and the Notes section.

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

### -File

To get a list of files, use the **File** parameter. You can use the **Recurse** parameter with
**File**.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: af

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter

Specifies a filter to qualify the **Path** parameter. The [FileSystem](../Microsoft.PowerShell.Core/About/about_FileSystem_Provider.md)
provider is the only installed PowerShell provider that supports filters. Filters are more efficient
than other parameters. The provider applies filter when the cmdlet gets the objects rather than
having PowerShell filter the objects after they're retrieved. The filter string is passed to the
.NET API to enumerate files. The API only supports `*` and `?` wildcards.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -FollowSymlink

By default, the `Get-ChildItem` cmdlet displays symbolic links to directories found during
recursion, but doesn't recurse into them. Use the **FollowSymlink** parameter to search the
directories that target those symbolic links. The **FollowSymlink** is a dynamic parameter and is
supported only in the **FileSystem** provider.

This parameter was introduced in PowerShell 6.0.

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

### -Force

Allows the cmdlet to get items that otherwise can't be accessed by the user, such as hidden or
system files. The **Force** parameter doesn't override security restrictions. Implementation varies
among providers. For more information, see [about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

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

### -Hidden

To get only hidden items, use the **Hidden** parameter or the **Attributes** parameter with the
**Hidden** property. By default, `Get-ChildItem` doesn't display hidden items. Use the **Force**
parameter to get hidden items.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: ah, h

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

Specifies a path to one or more locations. The value of **LiteralPath** is used exactly as it's
typed. No characters are interpreted as wildcards. If the path includes escape characters, enclose
it in single quotation marks. Single quotation marks tell PowerShell to not interpret any characters
as escape sequences.

For more information, see [about_Quoting_Rules](../Microsoft.Powershell.Core/About/about_Quoting_Rules.md).

```yaml
Type: System.String[]
Parameter Sets: LiteralItems
Aliases: PSPath, LP

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name

Gets only the names of the items in the location. The output is a string object that can be sent
down the pipeline to other commands. Wildcards are permitted.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Path

Specifies a path to one or more locations. Wildcards are accepted. The default location is the
current directory (`.`).

```yaml
Type: System.String[]
Parameter Sets: Items
Aliases:

Required: False
Position: 0
Default value: Current directory
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -ReadOnly

To get only read-only items, use the **ReadOnly** parameter or the **Attributes** parameter
**ReadOnly** property.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: ar

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Recurse

Gets the items in the specified locations and in all child items of the locations.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: s

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -System

Gets only system files and directories. To get only system files and folders, use the **System**
parameter or **Attributes** parameter **System** property.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: as

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string that contains a path to `Get-ChildItem`.

## OUTPUTS

### System.Object

The type of object that `Get-ChildItem` returns is determined by the objects in the provider drive
path.

### System.String

If you use the **Name** parameter, `Get-ChildItem` returns the object names as strings.

## NOTES

- `Get-ChildItem` can be run using any of the built-in aliases, `ls`, `dir`, and `gci`. For more
  information, see [about_Aliases](../Microsoft.PowerShell.Core/About/about_Aliases.md).
- `Get-ChildItem` doesn't get hidden items by default. To get hidden items, use the **Force**
  parameter.
- The `Get-ChildItem` cmdlet is designed to work with the data exposed by any provider. To list the
  providers available in your session, type `Get-PSProvider`.
  For more information, see [about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

## RELATED LINKS

[about_Certificate_Provider](../Microsoft.PowerShell.Security/About/about_Certificate_Provider.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)

[about_Quoting_Rules](../Microsoft.Powershell.Core/About/about_Quoting_Rules.md)

[about_Registry_Provider](../Microsoft.PowerShell.Core/About/about_Registry_Provider.md)

[ForEach-Object](../Microsoft.PowerShell.Core/ForEach-Object.md)

[Get-Alias](../Microsoft.PowerShell.Utility/Get-Alias.md)

[Get-Item](Get-Item.md)

[Get-Location](Get-Location.md)

[Get-Process](Get-Process.md)

[Get-PSProvider](Get-PSProvider.md)

[Split-Path](Split-Path.md)

