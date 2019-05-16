---
ms.date:  5/16/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=289621
external help file:  System.Management.Automation.dll-Help.xml
title:  Update-Help
---

# Update-Help

## SYNOPSIS
Downloads and installs the newest help files on your computer.

## SYNTAX

### Path (Default)

```
Update-Help [[-Module] <string[]>] [[-SourcePath] <string[]>] [[-UICulture] <cultureinfo[]>]
[-Recurse] [-Credential <pscredential>] [-UseDefaultCredentials] [-Force] [<CommonParameters>]
```

### LiteralPath

```
Update-Help [[-Module] <string[]>] [[-UICulture] <cultureinfo[]>] [-LiteralPath <string[]>]
[-Recurse] [-Credential <pscredential>] [-UseDefaultCredentials] [-Force] [<CommonParameters>]
```

## DESCRIPTION

The `Update-Help` cmdlet downloads the newest help files for PowerShell modules and installs them on
your computer. You can use the `Get-Help` cmdlet to view the new help files immediately. You don't
need to restart PowerShell to make the change effective.

`Update-Help` checks the version of the help files on your computer. If you don't have help files
for a module or don't have the newest help files for a module, `Update-Help` downloads the newest
help files from the internet or a file share and installs them on your computer in the correct
module folder.

Without parameters, `Update-Help` updates the help files for modules in the session and for all
installed modules that support Updatable Help. Modules that aren't in the current session are
included. PowerShell modules are stored in a location listed in the `$env:PSModulePath` environment
variable. For more information, see [about_Updatable_Help](/About/about_Updatable_Help.md).

You can also use the **Module** parameter to update help for a particular module and use the
**UICulture** parameter to download help files in multiple languages and locales.

You can use `Update-Help` even on computers that aren't connected to the internet. Use the
`Save-Help` cmdlet to download help files from the internet and save them in a file system location,
such as a shared folder or file system directory. Then use the **SourcePath** parameter of
`Update-Help` to get the updated help files from a file system location and install them on the
computer.

You can automate help updates by adding the `Update-Help` cmdlet to your PowerShell profile. By
default, `Update-Help` runs only one time per day on each computer. To override the once-per-day
limit, use the **Force** parameter.

This cmdlet was introduced in Windows PowerShell 3.0.

> [!IMPORTANT]
> `Update-Help` requires administrative privileges.
>
> You must be a member of the Administrators group on the computer
> to update the help files for the PowerShell Core modules.
>
> To download or update the help files for modules in the PowerShell
> installation directory (`$PSHOME\Modules`), including the PowerShell
> Core modules, start PowerShell by using the Run as administrator option.
> For example: `Start-Process powershell.exe -Verb RunAs`.
>
> You can also update help files by using the Update Windows PowerShell Help
> menu item in the Help menu in Windows PowerShell Integrated Scripting
> Environment (ISE).
>
> The Update Windows PowerShell Help item runs an `Update-Help` cmdlet
> without parameters.
> To update help for modules in the `$PSHOME` directory,
> start Windows PowerShell ISE by using the Run as administrator option.

## EXAMPLES

### Example 1: Update help for all modules

This command updates help for installed modules that support Updatable Help for the UI culture
language that is set in Windows.

```powershell
Update-Help
```

### Example 2: Update help for specified modules

This command updates help only for the **ServerManager** module and for modules that have names that
begin with **Microsoft.PowerShell**.

```powershell
Update-Help -Module ServerManager, Microsoft.PowerShell*
```

### Example 3: Update help in different languages

This command updates the Japanese and English help files for all modules.

If a module currently doesn't provide help files for the specified UI culture, the error message
lists the UI cultures that the module supports. In this example, the error message indicates that
the ServerManager module currently provides help files only in **en-US**.

```powershell
Update-Help -UICulture ja-JP, en-US
```

```Output
Update-Help : Failed to update Help for the module(s) 'ServerManager' with UI culture(s) {ja-JP} :
The specified culture is not supported: ja-JP. Specify a culture from the following list: {en-US}.
```

### Example 4: Update help automatically

This command creates a scheduled job that updates help for all modules every day at 3:00 AM.

```powershell
Register-ScheduledJob -Name UpdateHelpJob -Credential Domain01\User01 -ScriptBlock {Update-Help} -Trigger (New-JobTrigger -Daily -At "3 AM")
```

```Output
Id         Name            JobTriggers     Command                                  Enabled
--         ----            -----------     -------                                  -------
1          UpdateHelpJob   1               Update-Help                              True
```

The command uses the `Register-ScheduledJob` cmdlet to create a scheduled job that runs an
`Update-Help` command. The command uses the **Credential** parameter to run `Update-Help` by using
the credentials of a member of the Administrators group on the computer. The value of the
**Trigger** parameter is a `New-JobTrigger` command that creates a job trigger that starts the job
every day at 3:00 AM.

To run the `Register-ScheduledJob` command, start PowerShell by using the **Run as administrator**
option. PowerShell prompts you for the password of the user specified in the **Credential**
parameter. The credentials are stored with the scheduled job. You aren't prompted when the job runs.

You can use the `Get-ScheduledJob` cmdlet to view the scheduled job, use the `Set-ScheduledJob`
cmdlet to change it, and use the `Unregister-ScheduledJob` cmdlet to delete it. You can also view
and manage the scheduled job in Task Scheduler in the following path:

`Task Scheduler Library\Microsoft\Windows\PowerShell\ScheduledJobs`.

### Example 5: Update help on multiple computers from a file share

These commands download updated help files for system modules from the internet and save them in a
file share. Then the commands install the updated help files from the file share on multiple
computers. Use a strategy such as the one shown in this example. You can update the help files on
many computers, even computers that are behind firewalls or aren't connected to the internet.

```powershell
Save-Help -DestinationPath \\Server01\Share\PSHelp -Credential Domain01\Admin01
Invoke-Command -ComputerName (Get-Content Servers.txt) -ScriptBlock {
  Update-Help -SourcePath \\Server01\Share\Help -Credential Domain01\Admin01
}
```

The `Save-Help` command downloads the newest help files for all modules that support Updatable Help.
The command saves the downloaded help files in the \\Server01\Share\PSHelp file share. The command
uses the **Credential** parameter of the `Save-Help` cmdlet to specify the credentials of a user who
has permission to access the remote file share. By default, the command doesn't run with explicit
credentials and attempts to access the file share might fail.

The `Invoke-Command` cmdlet runs remote `Update-Help` commands on many computers. The
`Invoke-Command` command gets the list of computers from the Servers.txt file. The `Update-Help`
command installs the help files from the file share on all of the remote computers. The remote
computer needs access to the file share at the specified path. The `Update-Help` command uses the
**SourcePath** parameter to get the updated help files from the file share, instead of the internet,
and the **Credential** parameter to run the command by using explicit credentials. By default, the
command runs with network token privileges and attempts to access the file share from each remote
computer.

### Example 6: Get a List of Updated Help Files

This command updates help for two modules. It uses the **Verbose** common parameter of `Update-Help`
to get a list of the help files that the command updated.

```powershell
Update-Help -Module BestPractices, ServerManager -Verbose
```

Without the **Verbose** parameter, `Update-Help` doesn't display the results of the command. The
**Verbose** parameter is especially useful when you want to verify that you have updated help files
for a particular module or a particular locale.

### Example 7: Find modules that support Updatable Help

This command gets modules that support Updatable Help.

```powershell
Get-Module -ListAvailable | Where HelpInfoUri
```

The command uses the **HelpInfoUri** property of modules to identify modules that support Updatable
Help. The value of the **HelpInfoUri** property contains the address of the internet location where
the module stores its Updatable Help information file.

This command uses the simplified syntax of the `Where-Object` cmdlet. This syntax was introduced in
Windows PowerShell 3.0.

### Example 8: Inventory updated help files

The example `Get-UpdateHelpVersion.ps1` script creates an inventory of the Updatable Help files for
each module and their version numbers. Copy the script and paste it in a text file.

```
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

The script identifies modules that support Updatable Help by using the **HelpInfoUri** property of
modules. For modules that support Updatable Help, the script looks for and parses the help
information file (helpinfo.xml) to find the latest version number.

The script uses the **PSCustomObject** class and a hash table to create a custom output object.

## PARAMETERS

### -Credential

Specifies credentials of a user who has permission to access the file system location specified by
**SourcePath**. This parameter is valid only when the **SourcePath** or **LiteralPath** parameter is
used in the command.

The **Credential** parameter enables you to run `Update-Help` commands with the **SourcePath**
parameter on remote computers. By providing explicit credentials, you can run the command on a
remote computer and access a file share on a third computer without encountering an access denied
error or using CredSSP authentication to delegate credentials.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Indicates that this cmdlet doesn't follow the once-per-day limitation, skips version checking, and
downloads files that exceed the 1 GB limit.

Without this parameter, `Update-Help` runs only once in each 24-hour period. Downloads are limited
to 1 GB of uncompressed content per module and help files are installed only when they're newer than
the files on the computer.

The once-per-day limit protects the servers that host the help files and makes it practical for you
to add an `Update-Help` command to your PowerShell profile without incurring the resource cost of
repeated connections or downloads.

To update help for a module in multiple UI cultures without the **Force** parameter, include all UI
cultures in the same command, such as:

`Update-Help -Module PSScheduledJobs -UICulture en-US, fr-FR, pt-BR`

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

### -LiteralPath

Specifies the folder for updated help files instead of downloading them from the internet. Use this
parameter or **SourcePath** if you've used the `Save-Help` cmdlet to download help files to a
directory.

You can also pipe a directory object, such as one from the `Get-Item` or `Get-ChildItem` cmdlets, to
`Update-Help`.

Unlike the value of **SourcePath**, the value of **LiteralPath** is used exactly as it's typed. No
characters are interpreted as wildcard characters. If the path includes escape characters, enclose
it in single quotation marks. Single quotation marks tell PowerShell not to interpret any characters
as escape sequences.

```yaml
Type: String[]
Parameter Sets: LiteralPath
Aliases: PSPath

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Module

Updates help for the specified modules. Enter one or more module names or name patterns in a
comma-separated list, or specify a file that lists one module name on each line. Wildcard characters
are permitted. You can also pipe modules from the `Get-Module` cmdlet, to the `Update-Help` cmdlet.

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
Type: String[]
Parameter Sets: (All)
Aliases: Name

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Recurse

Searches recursively for help files in the specified directory. This parameter is valid only when
the command uses the **SourcePath** parameter.

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

### -SourcePath

Specifies a file system folder from which this cmdlet gets updated help files, instead of
downloading them from the internet. Enter the path of a folder. Don't specify a file name or file
name extension. You can also pipe a folder, such as one from the `Get-Item` or `Get-ChildItem`
cmdlets, to `Update-Help`.

By default, `Update-Help` downloads updated help files from the internet. Use this parameter when
you've used the `Save-Help` cmdlet to download updated help files to a directory.

Administrators can use the Set the default source path for Update-Help Group Policy setting under
Computer Configuration to specify a default value for **SourcePath**. This Group Policy setting
prevents users from using `Update-Help` to download help files from the internet. For more
information, see [about_Group_Policy_Settings](about/about_Group_Policy_Settings.md).

```yaml
Type: String[]
Parameter Sets: Path
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UICulture

Specifies UI culture values for which this cmdlet gets updated help files. Enter one or more
language codes, such as **es-ES**, a variable that contains culture objects, or a command that gets
culture objects, such as a `Get-Culture` or `Get-UICulture` command. Wildcard characters aren't
permitted and you can't submit a partial language code, such as **de**.

By default, `Update-Help` gets help files in the UI culture set for Windows or its fallback culture.
If you specify the **UICulture** parameter, `Update-Help` looks for help only for the specified UI
culture, not in any fallback culture.

Commands that use the **UICulture** parameter succeed only when the module provides help files for
the specified UI culture. If the command fails because the specified UI culture isn't supported, the
error message includes a list of UI cultures that the module supports.

```yaml
Type: CultureInfo[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseDefaultCredentials

Indicates that this cmdlet runs the command, including the internet download, by using the
credentials of the current user. By default, the command runs without explicit credentials.

This parameter is effective only when the web download uses NT LAN Manager (NTLM), negotiate, or
Kerberos-based authentication.

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
versions of Windows PowerShell. On computers that have both Windows PowerShell 2.0 and Windows
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
that you author, see [Supporting Updatable Help](/powershell/developer/module/supporting-updatable-help).

The `Update-Help` and `Save-Help` cmdlets are not supported on Windows Preinstallation Environment
(Windows PE).

## RELATED LINKS

[Get-Culture](../Microsoft.PowerShell.Utility/Get-Culture.md)

[Get-Help](Get-Help.md)

[Get-Module](Get-Module.md)

[Get-UICulture](../Microsoft.PowerShell.Utility/Get-UICulture.md)

[Start-Job](Start-Job.md)

[Save-Help](Save-Help.md)