---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 02/23/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: New-Item
---
# New-Item

## SYNOPSIS
Creates a new item.

## SYNTAX

### pathSet (Default) - All providers

```
New-Item [-Path] <String[]> [-ItemType <String>] [-Value <Object>] [-Force]
 [-Credential <PSCredential>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### nameSet - All providers

```
New-Item [[-Path] <String[]>] -Name <String> [-ItemType <String>] [-Value <Object>] [-Force]
 [-Credential <PSCredential>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### pathSet (Default) - WSMan provider

```
New-Item [-Path] <string[]> -ConnectionURI <uri> [-ItemType <string>] [-Value <Object>] [-Force]
 [-Credential <pscredential>] [-WhatIf] [-Confirm] [-OptionSet <hashtable>]
 [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <string>]
 [-SessionOption <SessionOption>] [-Port <int>] [<CommonParameters>]
```

### nameSet - WSMan provider

```
New-Item [[-Path] <string[]>] -Name <string> [-ItemType <string>] [-Value <Object>] [-Force]
 [-Credential <pscredential>] [-WhatIf] [-Confirm] [-OptionSet <hashtable>]
 [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <string>]
 [-SessionOption <SessionOption>] [-ApplicationName <string>] [-Port <int>] [-UseSSL]
 [<CommonParameters>]
```

### pathSet (Default) - Alias provider

```
New-Item [-Path] <string[]> [-ItemType <string>] [-Value <Object>] [-Force]
 [-Credential <pscredential>] [-WhatIf] [-Confirm] [-Options <ScopedItemOptions>]
 [<CommonParameters>]
```

### nameSet - Alias provider

```
New-Item [[-Path] <string[]>] -Name <string> [-ItemType <string>] [-Value <Object>] [-Force]
 [-Credential <pscredential>] [-WhatIf] [-Confirm] [-Options <ScopedItemOptions>]
 [<CommonParameters>]
```

## DESCRIPTION

The `New-Item` cmdlet creates a new item and sets its value. The types of items that can be created
depend on the location of the item. For example, in the file system, `New-Item` creates files and
folders. In the registry, `New-Item` creates registry keys and entries.

`New-Item` can also set the value of the items that it creates. For example, when it creates a new
file, `New-Item` can add initial content to the file.

## EXAMPLES

### Example 1: Create a file in the current directory

This command creates a text file that is named "testfile1.txt" in the current directory. The dot
('.') in the value of the **Path** parameter indicates the current directory. The quoted text that
follows the **Value** parameter is added to the file as content.

```powershell
New-Item -Path . -Name "testfile1.txt" -ItemType "file" -Value "This is a text string."
```

### Example 2: Create a directory

This command creates a directory named "Logfiles" in the `C:` drive. The **ItemType** parameter
specifies that the new item is a directory, not a file or other file system object.

```powershell
New-Item -Path "c:\" -Name "logfiles" -ItemType "directory"
```

### Example 3: Create a profile

This command creates a PowerShell profile in the path that is specified by the `$profile` variable.

You can use profiles to customize PowerShell. `$profile` is an automatic (built-in) variable that
stores the path and file name of the "CurrentUser/CurrentHost" profile. By default, the profile does
not exist, even though PowerShell stores a path and file name for it.

In this command, the `$profile` variable represents the path of the file. **ItemType** parameter
specifies that the command creates a file. The **Force** parameter lets you create a file in the
profile path, even when the directories in the path do not exist.

After you create a profile, you can enter aliases, functions, and scripts in the profile to
customize your shell.

For more information, see [about_Automatic_Variables](../Microsoft.PowerShell.Core/About/about_Automatic_Variables.md)
and [about_Profiles](../Microsoft.PowerShell.Core/About/about_Profiles.md).

```powershell
New-Item -Path $profile -ItemType "file" -Force
```

### Example 4: Create a directory in a different directory

This example creates a new Scripts directory in the "C:\PS-Test" directory.

The name of the new directory item, "Scripts", is included in the value of **Path** parameter,
instead of being specified in the value of **Name**. As indicated by the syntax, either command form
is valid.

```powershell
New-Item -ItemType "directory" -Path "c:\ps-test\scripts"
```

### Example 5: Create multiple files

This example creates files in two different directories. Because **Path** takes multiple strings,
you can use it to create multiple items.

```powershell
New-Item -ItemType "file" -Path "c:\ps-test\test.txt", "c:\ps-test\Logs\test.log"
```

### Example 6: Use wildcards to create files in multiple directories

The `New-Item` cmdlet supports wildcards in the **Path** parameter. The following command creates a
`temp.txt` file in all of the directories specified by the wildcards in the **Path** parameter.

```powershell
Get-ChildItem -Path C:\Temp\
```

```Output
    Directory:  C:\Temp

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d-----        5/15/2019   6:45 AM        1   One
d-----        5/15/2019   6:45 AM        1   Two
d-----        5/15/2019   6:45 AM        1   Three
```

```powershell
New-Item -Path C:\Temp\* -Name temp.txt -ItemType File | Select-Object FullName
```

```Output
FullName
--------
C:\Temp\One\temp.txt
C:\Temp\Three\temp.txt
C:\Temp\Two\temp.txt
```

The `Get-ChildItem` cmdlet shows three directories under the `C:\Temp` directory. Using wildcards
the `New-Item` cmdlet creates a `temp.txt` file in all of the directories under the current
directory. The `New-Item` cmdlet outputs the items you created, which is piped to `Select-Object`
to verify the paths of the newly created files.

### Example 7: Create a symbolic link to a file or folder

This example creates a symbolic link to the Notice.txt file in the current folder.

```powershell
$link = New-Item -ItemType SymbolicLink -Path .\link -Target .\Notice.txt
$link | Select-Object LinkType, Target
```

```Output
LinkType     Target
--------     ------
SymbolicLink {.\Notice.txt}
```

In this example, **Target** is an alias for the **Value** parameter. The target of the symbolic link
can be a relative path. Prior to PowerShell v6.2, the target must be a fully-qualified path.

Beginning in PowerShell 7.1, you can now create to a **SymbolicLink** to a folder on Windows using a
relative path.

### Example 8: Use the -Force parameter to attempt to recreate folders

This example creates a folder with a file inside. Then, attempts to create the same folder using
`-Force`. It will not overwrite the folder but simply return the existing folder object with the
file created intact.

```powershell
PS> New-Item -Path .\TestFolder -ItemType Directory
PS> New-Item -Path .\TestFolder\TestFile.txt -ItemType File

PS> New-Item -Path .\TestFolder -ItemType Directory -Force

    Directory: C:\
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----         5/1/2020   8:03 AM                TestFolder

PS> Get-ChildItem .\TestFolder\

    Directory: C:\TestFolder
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         5/1/2020   8:03 AM              0 TestFile.txt
```

### Example 9: Use the -Force parameter to overwrite existing files

This example creates a file with a value and then recreates the file using `-Force`. This overwrites
the existing file, as you can see by the length property.

```powershell
PS> New-Item ./TestFile.txt -ItemType File -Value 'This is just a test file'

    Directory: C:\Source\Test
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         5/1/2020   8:32 AM             24 TestFile.txt

New-Item ./TestFile.txt -ItemType File -Force

    Directory: C:\Source\Test
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         5/1/2020   8:32 AM              0 TestFile.txt
```

> [!NOTE]
> When using `New-Item` with the `-Force` switch to create registry keys, the command will behave
> the same as when overwriting a file. If the registry key already exists, the key and all
> properties and values will be overwritten with an empty registry key.

## PARAMETERS

### -ApplicationName

This is a dynamic parameter made available by the **WSMan** provider. The **WSMan** provider and
this parameter are only available on Windows.

Specifies the application name in the connection. The default value of the **ApplicationName**
parameter is **WSMAN**.

For more information, see [New-WSManInstance](../Microsoft.WSMan.Management/New-WSManInstance.md).

```yaml
Type: System.String
Parameter Sets: nameSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Authentication

This is a dynamic parameter made available by the **WSMan** provider. The **WSMan** provider and
this parameter are only available on Windows.

Specifies the authentication mechanism to be used at the server.

For more information, see [New-WSManInstance](../Microsoft.WSMan.Management/New-WSManInstance.md).

```yaml
Type: Microsoft.WSMan.Management.AuthenticationMechanism
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CertificateThumbprint

This is a dynamic parameter made available by the **WSMan** provider. The **WSMan** provider and
this parameter are only available on Windows.

Specifies the digital public key certificate (X509) of a user account that has permission to perform
this WSMan action. Enter the certificate thumbprint of the certificate.

For more information, see [New-WSManInstance](../Microsoft.WSMan.Management/New-WSManInstance.md).

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

### -ConnectionURI

This is a dynamic parameter made available by the **WSMan** provider. The **WSMan** provider and
this parameter are only available on Windows.

Specifies the connection endpoint for WSMan.

For more information, see [New-WSManInstance](../Microsoft.WSMan.Management/New-WSManInstance.md).

```yaml
Type: System.Uri
Parameter Sets: pathSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential

> [!NOTE]
> This parameter isn't supported by any providers installed with PowerShell. To impersonate another
> user or elevate your credentials when running this cmdlet, use `Invoke-Command`.

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

### -Force

Forces this cmdlet to create an item that writes over an existing read-only item. Implementation
varies from provider to provider. Even using the **Force** parameter, the cmdlet can't override
security restrictions.

Beginning in PowerShell 7.4, this parameter also allows you to overwrite an existing Junction.
Previously, this would fail with a "cannot be removed because it is not empty" error.

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

### -ItemType

Specifies the provider-specified type of the new item. The available values of this parameter depend
on the current provider you are using.

If your location is in a `FileSystem` drive, the following values are allowed:

- `File`
- `Directory`
- `SymbolicLink`
- `Junction`
- `HardLink`

> [!NOTE]
> Creating a `SymbolicLink` type on Windows requires elevation as administrator. However, Windows 10
> (build 14972 or newer) with Developer Mode enabled no longer requires elevation creating symbolic
> links.

In a `Certificate` drive, these are the values you can specify:

- `Certificate Provider`
- `Certificate`
- `Store`
- `StoreLocation`

For more information see [about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Type

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name

Specifies the name of the new item. You can specify the name of the new item in the **Name** or
**Path** parameter value, and you can specify the path of the new item in **Name** or **Path**
value. Items names passed using the **Name** parameter are created relative to the value of the
**Path** parameter.

```yaml
Type: System.String
Parameter Sets: nameSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Options

This is a dynamic parameter made available by the **Alias** provider. For more information, see
[New-Alias](../Microsoft.PowerShell.Utility/New-Alias.md).

Specifies the value of the **Options** property of an alias.

Valid values are:

- `None`: The alias has no constraints (default value)
- `ReadOnly`: The alias can be deleted but can't be changed without using the **Force** parameter
- `Constant`: The alias can't be deleted or changed
- `Private`: The alias is available only in the current scope
- `AllScope`: The alias is copied to any new scopes that are created
- `Unspecified`: The option isn't specified

```yaml
Type: System.Management.Automation.ScopedItemOptions
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OptionSet

This is a dynamic parameter made available by the **WSMan** provider. The **WSMan** provider and
this parameter are only available on Windows.

Passes a set of switches to a service to modify or refine the nature of the request.

For more information, see [New-WSManInstance](../Microsoft.WSMan.Management/New-WSManInstance.md).

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases: OS

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the path of the location of the new item. The default is the current location when
**Path** is omitted. You can specify the name of the new item in **Name**, or include it in
**Path**. Items names passed using the **Name** parameter are created relative to the value of the
**Path** parameter.

For this cmdlet, the **Path** parameter works like the **LiteralPath** parameter of other cmdlets.
Wildcard characters are not interpreted. All characters are passed to the location's provider. The
provider may not support all characters. For example, you can't create a filename that contains an
asterisk (`*`) character.

```yaml
Type: System.String[]
Parameter Sets: pathSet, nameSet
Aliases:

Required: True (pathSet), False (nameSet)
Position: 0
Default value: Current location
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Port

This is a dynamic parameter made available by the **WSMan** provider. The **WSMan** provider and
this parameter are only available on Windows.

Specifies the port to use when the client connects to the WinRM service.

For more information, see [New-WSManInstance](../Microsoft.WSMan.Management/New-WSManInstance.md).

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SessionOption

This is a dynamic parameter made available by the **WSMan** provider. The **WSMan** provider and
this parameter are only available on Windows.

Defines a set of extended options for the WS-Management session.

For more information, see [New-WSManInstance](../Microsoft.WSMan.Management/New-WSManInstance.md).

```yaml
Type: Microsoft.WSMan.Management.SessionOption
Parameter Sets: (All)
Aliases: SO

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSSL

This is a dynamic parameter made available by the **WSMan** provider. The **WSMan** provider and
this parameter are only available on Windows.

Specifies that the Secure Sockets Layer (SSL) protocol should be used to establish a connection to
the remote computer. By default, SSL isn't used.

For more information, see [New-WSManInstance](../Microsoft.WSMan.Management/New-WSManInstance.md).

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: nameSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value

Specifies the value of the new item. You can also pipe a value to `New-Item`.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases: Target

Required: False
Position: Named
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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.Object

You can pipe a value for the new item to this cmdlet.

## OUTPUTS

### System.Collections.DictionaryEntry

The cmdlet returns a **DictionaryEntry** object when creating a new environment variable.

### System.IO.DirectoryInfo

The cmdlet returns a **DirectoryInfo** object when creating a new directory in the filesystem.

### System.IO.FileInfo

The cmdlet returns a **FileInfo** object when creating a new file in the filesystem.

### System.Management.Automation.AliasInfo

The cmdlet returns an **AliasInfo** object when creating a new alias.

### System.Management.Automation.FunctionInfo

The cmdlet returns a **FunctionInfo** object when creating a new function.

### System.Management.Automation.PSVariable

The cmdlet returns a **PSVariable** object when creating a new variable.

## NOTES

PowerShell includes the following aliases for `New-Item`:

- All platforms:
  - `ni`

`New-Item` is designed to work with the data exposed by any provider. To list the providers
available in your session, type `Get-PsProvider`. For more information, see
[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

## RELATED LINKS

[Clear-Item](Clear-Item.md)

[Copy-Item](Copy-Item.md)

[Get-Item](Get-Item.md)

[Invoke-Item](Invoke-Item.md)

[Move-Item](Move-Item.md)

[Remove-Item](Remove-Item.md)

[Rename-Item](Rename-Item.md)

[Set-Item](Set-Item.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)
