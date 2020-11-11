---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 08/25/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/copy-item?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Copy-Item
---

# Copy-Item

## SYNOPSIS
Copies an item from one location to another.

## SYNTAX

### Path (Default)

```
Copy-Item [-Path] <String[]> [[-Destination] <String>] [-Container] [-Force] [-Filter <String>]
 [-Include <String[]>] [-Exclude <String[]>] [-Recurse] [-PassThru] [-Credential <PSCredential>]
 [-WhatIf] [-Confirm] [-FromSession <PSSession>] [-ToSession <PSSession>] [<CommonParameters>]
```

### LiteralPath

```
Copy-Item -LiteralPath <String[]> [[-Destination] <String>] [-Container] [-Force] [-Filter <String>]
 [-Include <String[]>] [-Exclude <String[]>] [-Recurse] [-PassThru] [-Credential <PSCredential>]
 [-WhatIf] [-Confirm] [-FromSession <PSSession>] [-ToSession <PSSession>] [<CommonParameters>]
```

## DESCRIPTION

The `Copy-Item` cmdlet copies an item from one location to another location in the same namespace.
For instance, it can copy a file to a folder, but it can't copy a file to a certificate drive.

This cmdlet doesn't cut or delete the items being copied. The particular items that the cmdlet can
copy depend on the PowerShell provider that exposes the item. For instance, it can copy files and
directories in a file system drive and registry keys and entries in the registry drive.

This cmdlet can copy and rename items in the same command. To rename an item, enter the new name in
the value of the **Destination** parameter. To rename an item and not copy it, use the `Rename-Item`
cmdlet.

## EXAMPLES

### Example 1: Copy a file to the specified directory

This example copies the `mar1604.log.txt` file to the `C:\Presentation` directory. The original file
isn't deleted.

```powershell
Copy-Item "C:\Wabash\Logfiles\mar1604.log.txt" -Destination "C:\Presentation"
```

### Example 2: Copy directory contents to an existing directory

This example copies the contents of the `C:\Logfiles` directory into the existing `C:\Drawings`
directory. The `Logfiles` directory isn't copied.

If the `Logfiles` directory contains files in subdirectories, those subdirectories are copied with
their file trees intact. By default, the **Container** parameter is set to **True**, which preserves
the directory structure.

```powershell
Copy-Item -Path "C:\Logfiles\*" -Destination "C:\Drawings" -Recurse
```

> [!NOTE]
> If you need to include the `Logfiles` directory in the copy, remove the `\*` from the **Path**.
> For example:
>
> `Copy-Item -Path "C:\Logfiles" -Destination "C:\Drawings" -Recurse`

### Example 3: Copy directory and contents to a new directory

This example copies the contents of the `C:\Logfiles` source directory and creates a new destination
directory. The new destination directory, `\Logs` is created in `C:\Drawings`.

To include the source directory's name, copy to an existing destination directory as shown in
**Example 2**. Or, name the new destination directory with the same as the source directory.

```powershell
Copy-Item -Path "C:\Logfiles" -Destination "C:\Drawings\Logs" -Recurse
```

> [!NOTE]
> If the **Path** includes `\*`, all the directory's file contents, including the subdirectory
> trees, are copied to the new destination directory. For example:
>
> `Copy-Item -Path "C:\Logfiles\*" -Destination "C:\Drawings\Logs" -Recurse`

### Example 4: Copy a file to the specified directory and rename the file

This example uses the `Copy-Item` cmdlet to copy the `Get-Widget.ps1` script from the
`\\Server01\Share` directory to the `\\Server12\ScriptArchive` directory. As part of the copy
operation, the command changes the item name from `Get-Widget.ps1` to `Get-Widget.ps1.txt`, so it
can be attached to email messages.

```powershell
Copy-Item "\\Server01\Share\Get-Widget.ps1" -Destination "\\Server12\ScriptArchive\Get-Widget.ps1.txt"
```

### Example 5: Copy a file to a remote computer

A session is created to the remote computer named **Server01** with the credential of
`Contoso\User01` and stores the results in the variable named `$Session`.

The `Copy-Item` cmdlet copies `test.log` from the `D:\Folder001` folder to the `C:\Folder001_Copy`
folder on the remote computer using the session information stored in the `$Session` variable. The
original file isn't deleted.

```powershell
$Session = New-PSSession -ComputerName "Server01" -Credential "Contoso\User01"
Copy-Item "D:\Folder001\test.log" -Destination "C:\Folder001_Copy\" -ToSession $Session
```

### Example 6: Copy a folder to a remote computer

A session is created to the remote computer named **Server01** with the credential of
`Contoso\User01` and stores the results in the variable named `$Session`.

The `Copy-Item` cmdlet copies the `D:\Folder002` folder to the
`C:\Folder002_Copy` directory on the remote computer using the session information stored in the
`$Session` variable. Any subfolders or files are not copied without using the **Recurse** switch.
The operation creates the `Folder002_Copy` folder if it doesn't already exist.

```powershell
$Session = New-PSSession -ComputerName "Server02" -Credential "Contoso\User01"
Copy-Item "D:\Folder002\" -Destination "C:\Folder002_Copy\" -ToSession $Session
```

### Example 7: Recursively copy the entire contents of a folder to a remote computer

A session is created to the remote computer named **Server01** with the credential of
`Contoso\User01` and stores the results in the variable named `$Session`.

The `Copy-Item` cmdlet copies the entire contents from the `D:\Folder003` folder to the
`C:\Folder003_Copy` directory on the remote computer using the session information stored in the
`$Session` variable. The subfolders are copied with their file trees intact. The operation creates
the `Folder003_Copy` folder if it doesn't already exist.

```powershell
$Session = New-PSSession -ComputerName "Server04" -Credential "Contoso\User01"
Copy-Item "D:\Folder003\" -Destination "C:\Folder003_Copy\" -ToSession $Session -Recurse
```

### Example 8: Copy a file to a remote computer and then rename the file

A session is created to the remote computer named **Server01** with the credential of
`Contoso\User01` and stores the results in the variable named `$Session`.

The `Copy-Item` cmdlet copies `scriptingexample.ps1` from the `D:\Folder004` folder to the
`C:\Folder004_Copy` folder on the remote computer using the session information stored in the
`$Session` variable. As part of the copy operation, the command changes the item name from
`scriptingexample.ps1` to `scriptingexample_copy.ps1`, so it can be attached to email messages. The
original file isn't deleted.

```powershell
$Session = New-PSSession -ComputerName "Server04" -Credential "Contoso\User01"
Copy-Item "D:\Folder004\scriptingexample.ps1" -Destination "C:\Folder004_Copy\scriptingexample_copy.ps1" -ToSession $Session
```

### Example 9: Copy a remote file to the local computer

A session is created to the remote computer named **Server01** with the credential of
`Contoso\User01` and stores the results in the variable named `$Session`.

The `Copy-Item` cmdlet copies `test.log` from the remote `C:\MyRemoteData\` to the local
`D:\MyLocalData` folder using the session information stored in the `$Session` variable. The
original file isn't deleted.

```powershell
$Session = New-PSSession -ComputerName "Server01" -Credential "Contoso\User01"
Copy-Item "C:\MyRemoteData\test.log" -Destination "D:\MyLocalData\" -FromSession $Session
```

### Example 10: Copy the entire contents of a remote folder to the local computer

A session is created to the remote computer named **Server01** with the credential of
`Contoso\User01` and stores the results in the variable named `$Session`.

The `Copy-Item` cmdlet copies the entire contents from the remote `C:\MyRemoteData\scripts` folder
to the local `D:\MyLocalData` folder using the session information stored in the `$Session`
variable. If the scripts folder contains files in subfolders, those subfolders are copied with their
file trees intact.

```powershell
$Session = New-PSSession -ComputerName "Server01" -Credential "Contoso\User01"
Copy-Item "C:\MyRemoteData\scripts" -Destination "D:\MyLocalData\" -FromSession $Session
```

### Example 11: Recursively copy the entire contents of a remote folder to the local computer

A session is created to the remote computer named **Server01** with the credential of
`Contoso\User01` and stores the results in the variable named `$Session`.

The `Copy-Item` cmdlet copies the entire contents from the remote `C:\MyRemoteData\scripts` folder
to the local `D:\MyLocalData\scripts` folder using the session information stored in the `$Session`
variable. Because the **Recurse** parameter is used, the operation creates the scripts folder if it
doesn't already exist. If the scripts folder contains files in subfolders, those subfolders are
copied with their file trees intact.

```powershell
$Session = New-PSSession -ComputerName "Server01" -Credential "Contoso\User01"
Copy-Item "C:\MyRemoteData\scripts" -Destination "D:\MyLocalData\scripts" -FromSession $Session -Recurse
```

### Example 12: Recursively copy files from a folder tree into the current folder

This example shows how to copy files from a multilevel folder structure into a single flat folder.
The first three commands show the existing folder structure and the contents of two files, both
names `file3.txt`.

```powershell
PS C:\temp\test> (Get-ChildItem C:\temp\tree -Recurse).FullName
C:\temp\tree\subfolder
C:\temp\tree\file1.txt
C:\temp\tree\file2.txt
C:\temp\tree\file3.txt
C:\temp\tree\subfolder\file3.txt
C:\temp\tree\subfolder\file4.txt
C:\temp\tree\subfolder\file5.txt

PS C:\temp\test> Get-Content C:\temp\tree\file3.txt
This is file3.txt in the root folder

PS C:\temp\test> Get-Content C:\temp\tree\subfolder\file3.txt
This is file3.txt in the subfolder

PS C:\temp\test> Copy-Item -Path C:\temp\tree -Filter *.txt -Recurse -Container:$false
PS C:\temp\test> (Get-ChildItem . -Recurse).FullName
C:\temp\test\subfolder
C:\temp\test\file1.txt
C:\temp\test\file2.txt
C:\temp\test\file3.txt
C:\temp\test\file4.txt
C:\temp\test\file5.txt

PS C:\temp\test> Get-Content .\file3.txt
This is file3.txt in the subfolder
```

The `Copy-Item` cmdlet has the **Container** parameter set to `$false`. This causes the contents of
the source folder to be copied but does not preserve the folder structure. Notice that files with
the same name are overwritten in the destination folder.

## PARAMETERS

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

### -Container

Indicates that this cmdlet preserves container objects during the copy operation. By default, the
**Container** parameter is set to **True**.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: True
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

### -Destination

Specifies the path to the new location. The default is the current directory.

To rename the item being copied, specify a new name in the value of the **Destination** parameter.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Current directory
Accept pipeline input: True (ByPropertyName)
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
gets the objects rather than having PowerShell filter the objects after they're retrieved.

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

Indicates that this cmdlet copies items that can't otherwise be changed, such as copying over a
read-only file or alias.

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

### -FromSession

Specifies the **PSSession** object from which a remote file is being copied. When you use this
parameter, the **Path** and **LiteralPath** parameters refer to the local path on the remote
machine.

```yaml
Type: System.Management.Automation.Runspaces.PSSession
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

Specifies a path to one or more locations. The value of **LiteralPath** is used exactly as it's
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

### -PassThru

Returns an object that represents the item with which you're working. By default, this cmdlet
doesn't generate any output.

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

### -Path

Specifies, as a string array, the path to the items to copy. Wildcard characters are permitted.

```yaml
Type: System.String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -Recurse

Indicates that this cmdlet does a recursive copy.

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

### -ToSession

Specifies the **PSSession** object to which a remote file is being copied. When you use this
parameter, the **Destination** parameter refers to the local path on the remote
machine.

```yaml
Type: System.Management.Automation.Runspaces.PSSession
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet isn't run.

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`,
`-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`,
`-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string that contains a path to this cmdlet.

## OUTPUTS

### None or an object representing the copied item

When you use the **PassThru** parameter, this cmdlet returns an object that represents the copied
item. Otherwise, this cmdlet doesn't generate any output.

## NOTES

This cmdlet is designed to work with the data exposed by any provider. To list the providers
available in your session, type `Get-PSProvider`. For more information, see [about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

## RELATED LINKS

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)

[Clear-Item](Clear-Item.md)

[Get-Item](Get-Item.md)

[Get-PSProvider](Get-PSProvider.md)

[Invoke-Item](Invoke-Item.md)

[Move-Item](Move-Item.md)

[New-Item](New-Item.md)

[Remove-Item](Remove-Item.md)

[Rename-Item](Rename-Item.md)

[Set-Item](Set-Item.md)

