---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 5/16/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/update-help?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Update-Help
---

# Update-Help

## SYNOPSIS
Downloads and installs the newest help files on your computer.

## SYNTAX

### Path (Default)

```
Update-Help [[-Module] <String[]>] [-FullyQualifiedModule <ModuleSpecification[]>]
 [[-SourcePath] <String[]>] [-Recurse] [[-UICulture] <CultureInfo[]>] [-Credential <PSCredential>]
 [-UseDefaultCredentials] [-Force] [-Scope <UpdateHelpScope>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### LiteralPath

```
Update-Help [[-Module] <String[]>] [-FullyQualifiedModule <ModuleSpecification[]>]
 [-LiteralPath <String[]>] [-Recurse] [[-UICulture] <CultureInfo[]>] [-Credential <PSCredential>]
 [-UseDefaultCredentials] [-Force] [-Scope <UpdateHelpScope>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Update-Help` cmdlet downloads the newest help files for PowerShell modules and installs them on
your computer. You need not restart PowerShell to make the change effective. You can use the
`Get-Help` cmdlet to view the new help files immediately.

`Update-Help` checks the version of the help files on your computer. If you don't have help files
for a module or if your help files are outdated, `Update-Help` downloads the newest help files. The
help files can be downloaded and installed from the internet or a file share.

Without parameters, `Update-Help` updates the help files for modules in the session and for all
installed modules that support Updatable Help. Modules that are installed but not loaded in the
current session are included. PowerShell modules are stored in a location listed in the
`$env:PSModulePath` environment variable. For more information, see
[about_Updatable_Help](./About/about_Updatable_Help.md).

You can use the **Module** parameter to update help files for a particular module. Use the
**UICulture** parameter to download help files in multiple languages and locales.

You can also use `Update-Help` on computers that are not connected to the internet. First, use the
`Save-Help`cmdlet to download help files from the internet and save them in a shared folder that is
accessible to the system not connected to the internet. Then use the **SourcePath** parameter of
`Update-Help` to download the updated help files from the shared and install them on the computer.

You can automate help updates by adding the `Update-Help` cmdlet to your PowerShell profile. By
default, `Update-Help` runs only one time per day on each computer. To override the once-per-day
limit, use the **Force** parameter.

The `Update-Help` cmdlet was introduced in Windows PowerShell 3.0.

> [!IMPORTANT]
> `Update-Help` requires administrative privileges in PowerShell 6.0 and below.
> PowerShell 6.1 and above set the default **Scope** to `CurrentUser`.
> Prior to PowerShell 6.1, the **Scope** parameter was not available.
>
> You must be a member of the Administrators group on the computer
> to update the help files for the PowerShell Core modules.
>
> To download or update the help files for modules in the PowerShell
> installation directory (`$PSHOME\Modules`), including the PowerShell
> Core modules, start PowerShell by using the **Run as administrator** option.
> For example: `Start-Process pwsh.exe -Verb RunAs`.

## EXAMPLES

### Example 1: Update help files for all modules

The `Update-Help` cmdlet updates help files for installed modules that support Updatable Help. The
user-interface (UI) culture language is set in the operating system.

```powershell
Update-Help
```

### Example 2: Update help files for specified modules

The `Update-Help` cmdlet updates help files only for module names that begin with
**Microsoft.PowerShell**.

```powershell
Update-Help -Module Microsoft.PowerShell*
```

### Example 3: Update help files for different languages

The `Update-Help` cmdlet updates the Japanese (ja-JP) and English (en-US) help files for all
modules.

If a module doesn't provide help files for a specified UI culture, an error message is displayed for
the module and UI culture. In this example, the error message indicates that the **ja-JP** help
files were not found for module **Microsoft.PowerShell.Utility**.

```powershell
Update-Help -UICulture ja-JP, en-US
```

```Output
Update-Help : Failed to update Help for the module(s) 'Microsoft.PowerShell.Utility' with UI culture(s) {ja-JP}
No UI culture was found that matches the following pattern: ja-JP.
```

### Example 4: Update help files on multiple computers from a file share

In this example, updated help files are downloaded from the internet and saved in a file share. User
credentials are needed that have permissions to access the file share and install updates. When a
file share is used, it's possible to update computers that are behind firewalls or aren't connected
to the internet.

```powershell
Save-Help -DestinationPath \\Server01\Share\PSHelp -Credential Domain01\Admin01
Invoke-Command -ComputerName (Get-Content Servers.txt) -ScriptBlock {
     Update-Help -SourcePath \\Server01\Share\PSHelp -Credential Domain01\Admin01
}
```

The `Save-Help` command downloads the newest help files for all modules that support Updatable Help.
The **DestinationPath** parameter saves the files in the `\\Server01\Share\PSHelp` file share. The
**Credential** parameter specifies a user who has permission to access the file share.

The `Invoke-Command` cmdlet runs remote `Update-Help` commands on multiple computers. The
**ComputerName** parameter gets a list of remote computers from the **Servers.txt** file. The
**ScriptBlock** parameter runs the `Update-Help` command and uses the **SourcePath** parameter to
specify the file share that contains the updated help files. The **Credential** parameter specifies
a user who can access the file share and run the remote `Update-Help` command.

### Example 5: Get a list of updated help files

The `Update-Help` cmdlet updates help for a specified module. The cmdlet uses the **Verbose** common
parameter to display the list of help files that were updated. You can use **Verbose** to view
output for all help files or help files for a specific module.

Without the **Verbose** parameter, `Update-Help` doesn't display the results of the command. The
**Verbose** parameter output is useful to verify that the help files were updated or if the latest
version is installed.

```powershell
Update-Help -Module Microsoft.PowerShell.Utility -Verbose
```

### Example 6: Find modules that support Updatable Help

This example lists modules that support Updatable Help. The command uses the module's
**HelpInfoUri** property to identify modules that support Updatable Help. The **HelpInfoUri**
property contains an address that is redirected when the `Update-Help` cmdlet is run.

```powershell
Get-Module -ListAvailable | Where-Object -Property HelpInfoUri
```

```output
   Directory: C:\program files\powershell\6\Modules

ModuleType Version    Name                                PSEdition ExportedCommands
---------- -------    ----                                --------- ----------------
Manifest   6.1.0.0    CimCmdlets                          Core      {Get-CimAssociatedInstance... }
Manifest   1.2.2.0    Microsoft.PowerShell.Archive        Desk      {Compress-Archive... }
Manifest   6.1.0.0    Microsoft.PowerShell.Diagnostics    Core      {Get-WinEvent, New-WinEvent}

    Directory: C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules

ModuleType Version    Name                                PSEdition ExportedCommands
---------- -------    ----                                --------- ----------------
Manifest   2.0.1.0    Appx                                Core,Desk {Add-AppxPackage, ... }
Script     1.0.0.0    AssignedAccess                      Core,Desk {Clear-AssignedAccess, ... }
Manifest   1.0.0.0    BitLocker                           Core,Desk {Unlock-BitLocker, ... }
```

### Example 7: Inventory updated help files

In this example, the script `Get-UpdateHelpVersion.ps1` creates an inventory of the Updatable Help
files for each module and their version numbers.

The script identifies modules that support Updatable Help by using the **HelpInfoUri** property of
modules. For modules that support Updatable Help, the script looks for and parses the help
information file (*helpinfo.xml) to find the latest version number.

The script uses the **PSCustomObject** class and a hash table to create a custom output object.

```powershell
# Get-UpdateHelpVersion.ps1
Param(
    [parameter(Mandatory=$False)]
    [String[]]
    $Module
)
$HelpInfoNamespace = @{helpInfo='http://schemas.microsoft.com/powershell/help/2010/05'}

if ($Module) { $Modules = Get-Module $Module -ListAvailable | where {$_.HelpInfoUri} }
else { $Modules = Get-Module -ListAvailable | where {$_.HelpInfoUri} }

foreach ($mModule in $Modules)
{
    $mDir = $mModule.ModuleBase

    if (Test-Path $mdir\*helpinfo.xml)
    {
        $mName=$mModule.Name
        $mNodes = dir $mdir\*helpinfo.xml -ErrorAction SilentlyContinue |
            Select-Xml -Namespace $HelpInfoNamespace -XPath "//helpInfo:UICulture"
        foreach ($mNode in $mNodes)
        {
            $mCulture=$mNode.Node.UICultureName
            $mVer=$mNode.Node.UICultureVersion

            [PSCustomObject]@{"ModuleName"=$mName; "Culture"=$mCulture; "Version"=$mVer}
        }
    }
}
```

```Output
ModuleName                              Culture                                 Version
----------                              -------                                 -------
ActiveDirectory                         en-US                                   3.0.0.0
ADCSAdministration                      en-US                                   3.0.0.0
ADCSDeployment                          en-US                                   3.0.0.0
ADDSDeployment                          en-US                                   3.0.0.0
ADFS                                    en-US                                   3.0.0.0
```

## PARAMETERS

### -Credential

Specifies credentials of a user who has permission to access the file system location specified by
**SourcePath**. This parameter is valid only when the **SourcePath** or **LiteralPath** parameter is
used in the command.

The **Credential** parameter enables you to run `Update-Help` commands with the **SourcePath**
parameter on remote computers. By providing explicit credentials, you can run the command on a
remote computer and access a file share on a third computer without encountering an access denied
error or using CredSSP authentication to delegate credentials.

Type a user name, such as **User01** or **Domain01\User01**, or enter a **PSCredential** object
generated by the `Get-Credential` cmdlet. If you type a user name, you're prompted to enter the
password.

Credentials are stored in a [PSCredential](/dotnet/api/system.management.automation.pscredential)
object and the password is stored as a [SecureString](/dotnet/api/system.security.securestring).

> [!NOTE]
> For more information about **SecureString** data protection, see
> [How secure is SecureString?](/dotnet/api/system.security.securestring#how-secure-is-securestring).

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Current user
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Indicates that this cmdlet doesn't follow the once-per-day limitation, skips version checking, and
downloads files that exceed the 1 GB limit.

Without this parameter, `Update-Help` runs only once in each 24-hour period. Downloads are limited
to 1 GB of uncompressed content per module and help files are only installed when they're newer than
the existing files on the computer.

The once-per-day limit protects the servers that host the help files and makes it practical for you
to add an `Update-Help` command to your PowerShell profile without incurring the resource cost of
repeated connections or downloads.

To update help for a module in multiple UI cultures without the **Force** parameter, include all UI
cultures in the same command, such as:

`Update-Help -Module PSScheduledJobs -UICulture en-US, fr-FR, pt-BR`

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

### -FullyQualifiedModule

Specifies modules with names that are specified in the form of **ModuleSpecification** objects.
These modules are described in the Remarks section of
[ModuleSpecification Constructor (Hashtable)](/dotnet/api/microsoft.powershell.commands.modulespecification.-ctor?view=powershellsdk-1.1.0#Microsoft_PowerShell_Commands_ModuleSpecification__ctor_System_Collections_Hashtable_).

For example, the **FullyQualifiedModule** parameter accepts a module name that is specified in the
format:

`@{ModuleName = "modulename"; ModuleVersion = "version_number"}`

or

`@{ModuleName = "modulename"; ModuleVersion = "version_number"; Guid = "GUID"}.`

**ModuleName** and **ModuleVersion** are required, but **Guid** is optional.

You can't specify the **FullyQualifiedModule** parameter in the same command as a **Module**
parameter.

```yaml
Type: Microsoft.PowerShell.Commands.ModuleSpecification[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LiteralPath

Specifies the folder for updated help files instead of downloading them from the internet. Use this
parameter or **SourcePath** if you've used the `Save-Help` cmdlet to download help files to a
directory.

You can pipeline a directory object, such as from the `Get-Item` or `Get-ChildItem` cmdlets, to
`Update-Help`.

Unlike the value of **SourcePath**, the value of **LiteralPath** is used exactly as it's typed. No
characters are interpreted as wildcard characters. If the path includes escape characters, enclose
it in single quotation marks. Single quotation marks tell PowerShell not to interpret any characters
as escape sequences.

```yaml
Type: System.String[]
Parameter Sets: LiteralPath
Aliases: PSPath, LP

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Module

Updates help for the specified modules. Enter one or more module names or name patterns in a
comma-separated list, or specify a file that lists one module name on each line. Wildcard characters
are permitted. You can pipeline modules from the `Get-Module` cmdlet to the `Update-Help` cmdlet.

The modules that you specify must be installed on the computer, but they don't have to be imported
into the current session. You can specify any module in the session or any module that is installed
in a location listed in the `$env:PSModulePath` environment variable.

A value of `*` (all) attempts to update help for all modules that are installed on the computer.
Modules that don't support Updatable Help are included. This value might generate errors when the
command encounters modules that don't support Updatable Help. Instead, run `Update-Help` without
parameters.

The **Module** parameter of the `Update-Help` cmdlet doesn't accept the full path of a module file
or module manifest file. To update help for a module that isn't in a `$env:PSModulePath` location,
import the module into the current session before you run the `Update-Help` command.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Name

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Recurse

Performs a recursive search for help files in the specified directory. This parameter is valid only
when the command uses the **SourcePath** parameter.

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

### -Scope

Specifies the system scope where help is updated. Updates at the **AllUsers** scope require
administrative privileges on Windows systems. The `-Scope` parameter was introduced in PowerShell
Core version 6.1.

**CurrentUser** is the default scope for help files in PowerShell 6.1 and above. **AllUsers** can be
specified to install or update help for all users. On Unix systems `sudo` privileges are required to
update help for all users. For example: `sudo pwsh -c Update-Help`

The acceptable values are:

- CurrentUser
- AllUsers

```yaml
Type: Microsoft.PowerShell.Commands.UpdateHelpScope
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: CurrentUser
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SourcePath

Specifies a file system folder where `Update-Help` gets updated help files, instead of downloading
them from the internet. Enter the path of a folder. Don't specify a file name or file name
extension. You can pipeline a folder, such as one from the `Get-Item` or `Get-ChildItem` cmdlets, to
`Update-Help`.

By default, `Update-Help` downloads updated help files from the internet. Use **SourcePath** when
you've used the `Save-Help` cmdlet to download updated help files to a directory.

To specify a default value for **SourcePath**, go to **Group Policy**, **Computer Configuration**,
and **Set the default source path for Update-Help**. This Group Policy setting prevents users from
using `Update-Help` to download help files from the internet.
For more information, see [about_Group_Policy_Settings](./About/about_Group_Policy_Settings.md).

```yaml
Type: System.String[]
Parameter Sets: Path
Aliases: Path

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UICulture

Specifies UI culture values that `Update-Help` uses to get updated help files. Enter one or more
language codes, such as **es-ES**, a variable that contains culture objects, or a command that gets
culture objects, such as a `Get-Culture` or `Get-UICulture` command. Wildcard characters aren't
permitted and you can't submit a partial language code, such as **de**.

By default, `Update-Help` gets help files in the UI culture set for the operating system. If you
specify the **UICulture** parameter, `Update-Help` looks for help only for the specified UI culture.

> [!NOTE]
> Ubuntu 18.04 changed the default locale setting to `C.UTF.8`, which is not a recognized UI
> culture. `Update-Help` silently fails to download help unless you use this parameter with a
> supported locale like `en-US`. This could occur on any platform that uses an unsupported value.

Commands that use the **UICulture** parameter succeed only when the module provides help files for
the specified UI culture. If the command fails because the specified UI culture isn't supported, an
error message is displayed.

```yaml
Type: System.Globalization.CultureInfo[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseDefaultCredentials

Indicates that `Update-Help` runs the command, including the internet download, by using the
credentials of the current user. By default, the command runs without explicit credentials.

This parameter is effective only when the web download uses NT LAN Manager (NTLM), negotiate, or
Kerberos-based authentication.

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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.IO.DirectoryInfo

You can pipe a directory path to `Update-Help`.

### System.Management.Automation.PSModuleInfo

You can pipe a module object from the `Get-Module` cmdlet to `Update-Help`.

## OUTPUTS

### None

`Update-Help` doesn't generate any output.

## NOTES

To update help for the PowerShell Core modules, that contain the commands that are installed with
PowerShell, or any module in the `$PSHOME\Modules` directory, start PowerShell with the option to
**Run as administrator**.

Only members of the Administrators group on the computer can update help for the PowerShell Core
modules, the commands that are installed together with PowerShell, and for modules in the
`$PSHOME\Modules` folder. If you don't have permission to update help files, you can read the help
files online. For example, `Get-Help Update-Help -Online`.

Modules are the smallest unit of updatable help. You can't update help for a particular cmdlet. To
find the module that contains a particular cmdlet, use the **ModuleName** property of the
`Get-Command` cmdlet, for example, `(Get-Command Update-Help).ModuleName`.

Because help files are installed in the module directory, the `Update-Help` cmdlet can install
updated help file only for modules that are installed on the computer. However, the `Save-Help`
cmdlet can save help for modules that aren't installed on the computer.

If `Update-Help` can't find updated help files for a module, or can't find updated help in the
specified language, it continues silently without displaying an error message. To see status and
progress details, use the **Verbose** parameter.

The `Update-Help` cmdlet was introduced in Windows PowerShell 3.0. It doesn't work in earlier
versions of PowerShell. On computers that have both Windows PowerShell 2.0 and Windows
PowerShell 3.0, use the `Update-Help` cmdlet in a Windows PowerShell 3.0 session to download and
update help files. The help files are available to both Windows PowerShell 2.0 and Windows
PowerShell 3.0.

The `Update-Help` and `Save-Help` cmdlets use the following ports to download help files: Port 80
for HTTP and port 443 for HTTPS.

`Update-Help` supports all modules and the PowerShell Core snap-ins. It doesn't support any other
snap-ins.

To update help for a module in a location that isn't listed in the `$env:PSModulePath` environment
variable, import the module into the current session and then run an `Update-Help` command. Run
`Update-Help` without parameters or use the **Module** parameter to specify the module name. The
**Module** parameter of the `Update-Help` and `Save-Help` cmdlets doesn't accept the full path of a
module file or module manifest file.

Any module can support Updatable Help. For instructions for supporting Updatable Help in the modules
that you author, see [Supporting Updatable Help](/powershell/scripting/developer/module/supporting-updatable-help).

The `Update-Help` and `Save-Help` cmdlets are not supported on Windows Preinstallation Environment
(Windows PE).

## RELATED LINKS

[Get-Culture](../Microsoft.PowerShell.Utility/Get-Culture.md)

[Get-Help](Get-Help.md)

[Get-Module](Get-Module.md)

[Get-UICulture](../Microsoft.PowerShell.Utility/Get-UICulture.md)

[Start-Job](Start-Job.md)

[Save-Help](Save-Help.md)
