---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 03/06/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/save-help?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Save-Help
---
# Save-Help

## SYNOPSIS
Downloads and saves the newest help files to a file system directory.

## SYNTAX

### Path (Default)

```
Save-Help [-DestinationPath] <String[]> [[-Module] <PSModuleInfo[]>]
 [-FullyQualifiedModule <ModuleSpecification[]>] [[-UICulture] <CultureInfo[]>]
 [-Credential <PSCredential>] [-UseDefaultCredentials] [-Force] [-Scope <UpdateHelpScope>]
 [<CommonParameters>]
```

### LiteralPath

```
Save-Help -LiteralPath <String[]> [[-Module] <PSModuleInfo[]>]
 [-FullyQualifiedModule <ModuleSpecification[]>] [[-UICulture] <CultureInfo[]>]
 [-Credential <PSCredential>] [-UseDefaultCredentials] [-Force] [-Scope <UpdateHelpScope>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Save-Help` cmdlet downloads the newest help files for PowerShell modules and saves them to a
directory that you specify. This feature lets you update the help files on computers that don't have
access to the internet, and makes it easier to update the help files on multiple computers. This
cmdlet was introduced in Windows PowerShell 3.0.

Beginning in Windows PowerShell 4.0, you can use `Save-Help` to download help files for modules that
are installed on remote computers. It's also possible to save a **PSModuleInfo** object using
`Export-Clixml` on a computer that doesn't have internet access, import the object on a computer
that does have internet access, and then run `Save-Help` on the **PSModuleInfo** object. Once you
have the saved help, you can copy it to the remote computer and install it by running `Update-Help`.
This process can be used to install help on computers that don't have any kind of network access.

Without parameters, a `Save-Help` command downloads the newest help for all modules in the session
and for modules that are installed on the computer in a location listed in the **PSModulePath**
environment variable. This action skips modules that don't support Updatable Help without warning.

The `Save-Help` cmdlet checks the version of any help files in the destination folder. If newer help
files are available, this cmdlet downloads the newest help files from the internet, and then saves
them in the folder. The `Save-Help` cmdlet works just like the `Update-Help` cmdlet, except that it
saves the downloaded content, instead of extracting the help files and installing them on the
computer.

The saved help for each module consists of one help information (HelpInfo XML) file and a cabinet or
ZIP archive (`.cab` or `.zip`) for the help files in each language. On Windows, the command
downloads the cabinet files. On Linux and macOS, the command downloads ZIP files.

To save the help files for modules in the PowerShell installation folder (`$PSHOME\Modules`), start
PowerShell by using the **Run as administrator option**. You must be a member of the Administrators
group on the computer to download the help files for these modules.

To install saved help files, run `Update-Help` with the **SourcePath** parameter to specify the
folder containing the saved Help files. `Update-Help` extracts the help files from the archive and
installs them on in the appropriate location.

## EXAMPLES

### Example 1: Save the help for the DhcpServer module

This example shows three different ways to use `Save-Help` to save the help for the **DhcpServer**
module from an internet-connected client computer, without installing the **DhcpServer** module or
the DHCP Server role on the local computer.

```powershell
# Option 1:
# 1. Run Invoke-Command to get the PSModuleInfo object for the DhcpServer module,
# 2. Save-Help on the PSModuleInfo object to save the help files to a folder on
#    the local computer.

$mod = Invoke-Command -ComputerName RemoteServer -ScriptBlock {
    Get-Module -Name DhcpServer -ListAvailable
}
Save-Help -Module $mod -DestinationPath C:\SavedHelp


# Option 2:
# 1. Open a PSSession to the remote computer that's running the DhcpServer module
# 2. Get the PSModuleInfo object from the remote computer
# 3. Save-Help on the PSModuleInfo object

$session = New-PSSession -ComputerName "RemoteServer"
$mod = Get-Module -PSSession $session -Name "DhcpServer" -ListAvailable
Save-Help -Module $mod -DestinationPath C:\SavedHelp


# Option 3:
# 1. Open a CimSession to the remote computer that's running the DhcpServer module
# 2. Get the PSModuleInfo object from the remote computer
# 3. Save-Help on the PSModuleInfo object
$cimsession = New-CimSession -ComputerName "RemoteServer"
$mod = Get-Module -CimSession $cimsession -Name "DhcpServer" -ListAvailable
Save-Help -Module $mod -DestinationPath "C:\SavedHelp"
```

### Example 2: Install help for the DhcpServer module

This example shows how to install help for a computer that is not network connected. For this
example, the first computer isn't connected to an accessible network. Files must be copied to it
using removable media. The second computer is connected to the internet and can download the help
files.

```powershell
# On the first computer, get the PSModuleInfo object for the module and save it to
# removable media.

Get-Module -Name "DhcpServer" -ListAvailable |
    Export-CliXml -Path E:\UsbFlashDrive\DhcpModule.xml

# Move the removable media to a computer that has internet access, and then import the
# PSModuleInfo object. Run Save-Help on the imported PSModuleInfo object and save the help
# files to the removable media.

$moduleInfo = Import-CliXml E:\UsbFlashDrive\DhcpModule.xml
Save-Help -Module $moduleInfo -DestinationPath E:\UsbFlashDrive\SavedHelp

# Finally, move the removable media back to the first computer and install the help.

Update-Help -Module DhcpServer -SourcePath E:\UsbFlashDrive\SavedHelp
```

### Example 3: Save help for all modules

This command downloads the newest help files for all modules on the local computer. It saves the
help files in the `\\Server01\Fileshare01` folder.

```powershell
Save-Help -DestinationPath \\Server01\FileShare01
```

### Example 4: Save help for a module on the computer

This command downloads the newest help files for the **ServerManager** module, and then saves them
in the `\\Server01\Fileshare01` folder.

```powershell
$saveHelpSplat = @{
    Module = 'ServerManager'
    DestinationPath = '\\Server01\FileShare01'
    Credential = 'Domain01/Admin01'
}
Save-Help @saveHelpSplat
```

When a module is installed on the computer, you can type the module name as the value of the
**Module** parameter, even if the module isn't imported into the current session.

The command uses the **Credential** parameter to supply the credentials of a user who has permission
to write to the file share.

### Example 5: Save help for a module on a different computer

These commands download the newest help files for the **CustomSQL** module and save them in the
`\\Server01\Fileshare01` folder.

```powershell
Invoke-Command -ComputerName Server02 { Get-Module -Name CustomSQL -ListAvailable } |
    Save-Help -DestinationPath \\Server01\FileShare01 -Credential Domain01\Admin01
```

Because the **CustomSQL** module isn't installed on the computer, the sequence includes an
`Invoke-Command` command that gets the module object for the CustomSQL module from the Server02
computer and then pipes the module object to the `Save-Help` cmdlet.

When a module isn't installed on the computer, `Save-Help` needs the module object, which includes
information about the location of the newest help files.

### Example 6: Save help for a module in multiple languages

This command saves help for the core PowerShell modules in four different UI cultures. The language
packs for these locales don't have to be installed on the computer.

```powershell
$saveHelpSplat = @{
    Module = 'Microsoft.PowerShell*'
    UICulture = 'de-DE', 'en-US', 'fr-FR', 'ja-JP'
    DestinationPath = "D:\Help"
}
Save-Help @saveHelpSplat
```

`Save-Help` can download help files for modules in different UI cultures only when the module owner
makes the translated files available on the internet.

### Example 7: Save help more than one time each day

This command saves help for all modules that are installed on the computer. The command specifies
the **Force** parameter to override the rule that prevents the `Save-Help` cmdlet from downloading
help more than once in each 24-hour period.

```powershell
Save-Help -Force -DestinationPath \\Server3\AdminShare\Help
```

The **Force** parameter also overrides the 1 GB restriction and circumvents version checking.
Therefore, you can download files even if the version isn't later than the version in the
destination folder.

The command uses the `Save-Help` cmdlet to download and save the help files to the specified folder.
The **Force** parameter is required when you have to run a `Save-Help` command more than one time
each day.

## PARAMETERS

### -Credential

Specifies a user credential. This cmdlet runs the command by using credentials of a user who has
permission to access the file system location specified by the **DestinationPath** parameter. This
parameter is valid only when the **DestinationPath** or **LiteralPath** parameter is used in the
command.

This parameter enables you to run `Save-Help` commands that use the **DestinationPath** parameter on
remote computers. By providing explicit credentials, you can run the command on a remote computer
and access a file share on a third computer without encountering an access denied error or using
CredSSP authentication to delegate credentials.

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
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DestinationPath

Specifies the path of the folder in which the help files are saved. Don't specify a filename or
filename extension.

```yaml
Type: System.String[]
Parameter Sets: Path
Aliases: Path

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Indicates that this cmdlet doesn't follow the once-per-day limitation, skips version checking, and
downloads files that exceed the 1 GB limit.

Without this parameter, only one `Save-Help` command for each module is permitted in each 24-hour
period, downloads are limited to 1 GB of uncompressed content per module, and help files for a
module are installed only when they're newer than the files on the computer.

The once-per-day limit protects the servers that host the help files, and makes it practical for you
to add a `Save-Help` command to your PowerShell profile.

To save help for a module in multiple UI cultures without the **Force** parameter, include all UI
cultures in the same command, such as:
`Save-Help -Module PSScheduledJobs -UICulture en-US, fr-FR, pt-BR`

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

### -FullyQualifiedModule

The value can be a module name, a full module specification, or a path to a module file.

When the value is a path, the path can be fully qualified or relative. A relative path is resolved
relative to the script that contains the using statement.

When the value is a name or module specification, PowerShell searches the **PSModulePath** for the
specified module.

A module specification is a hashtable that has the following keys.

- `ModuleName` - **Required** Specifies the module name.
- `GUID` - **Optional** Specifies the GUID of the module.
- It's also **Required** to specify at least one of the three below keys.
  - `ModuleVersion` - Specifies a minimum acceptable version of the module.
  - `MaximumVersion` - Specifies the maximum acceptable version of the module.
  - `RequiredVersion` - Specifies an exact, required version of the module. This can't be used with
    the other Version keys.

You can't specify the **FullyQualifiedModule** parameter in the same command as a **Module**
parameter. the two parameters are mutually exclusive.

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

Specifies a path of the destination folder. Unlike the value of the **DestinationPath** parameter,
the value of the **LiteralPath** parameter is used exactly as it's typed. No characters are
interpreted as wildcard characters. If the path includes escape characters, enclose it in single
quotation marks. Single quotation marks tell PowerShell not to interpret any characters as escape
sequences.

```yaml
Type: System.String[]
Parameter Sets: LiteralPath
Aliases: PSPath, LP

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Module

Specifies modules for which this cmdlet downloads help. Enter one or more module names or name
patters in a comma-separated list or in a file that has one module name on each line. Wildcard
characters are permitted. You can also pipe module objects from the `Get-Module` cmdlet to
`Save-Help`.

By default, `Save-Help` downloads help for all modules that support Updatable Help and are installed
on the local computer in a location listed in the **PSModulePath** environment variable.

To save help for modules that aren't installed on the computer, run a `Get-Module` command on a
remote computer. Then pipe the resulting module objects to the `Save-Help` cmdlet or submit the
module objects as the value of the **Module** or **InputObject** parameters.

If the module that you specify is installed on the computer, you can enter the module name or a
module object. If the module isn't installed on the computer, you must enter a module object, such
as one returned by the `Get-Module` cmdlet.

The **Module** parameter of the `Save-Help` cmdlet doesn't accept the full path of a module file or
module manifest file. To save help for a module that's not in a **PSModulePath** location, import
the module into the current session before you run the `Save-Help` command.

A value of "*" (all) attempts to update help for all modules that are installed on the computer.
This includes modules that don't support Updatable Help. This value might generate errors when the
command encounters modules that don't support Updatable Help.

```yaml
Type: System.Management.Automation.PSModuleInfo[]
Parameter Sets: (All)
Aliases: Name

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -Scope

This parameter does nothing in this cmdlet.

```yaml
Type: Microsoft.PowerShell.Commands.UpdateHelpScope
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UICulture

Specifies UI culture values for which this cmdlet gets updated help files. Enter one or more
language codes, such as `es-ES`, a variable that contains culture objects, or a command that gets
culture objects, such as a `Get-Culture` or `Get-UICulture` command. Wildcard characters aren't
permitted.

By default, `Save-Help` gets help files in the UI culture set for the operating system or its
fallback culture. If you specify the **UICulture** parameter, `Save-Help` only looks for help for
the specified language.

Beginning in PowerShell 7.4, you can use a partial language code, such as `en` to download help in
English for any region.

```yaml
Type: System.Globalization.CultureInfo[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Current UI culture
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseDefaultCredentials

Indicates that this cmdlet runs the command, including the web download, with the credentials of the
current user. By default, the command runs without explicit credentials.

This parameter is effective only when the web download uses NTLM, negotiate, or Kerberos-based
authentication.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSModuleInfo

You can pipe a module object to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

- To save help for modules in the $PSHOME\Modules folder, start PowerShell by using the Run as
  administrator option. Only members of the Administrators group on the computer can download help
  for modules in the $PSHOME\Modules folder.
- The saved help for each module consists of one help information (HelpInfo XML) file and one
  cabinet (.cab) file for the help files each UI culture. You don't have to extract the help files
  from the cabinet file. The `Update-Help` cmdlet extracts the help files, validates the XML, and
  then installs the help files and the help information file in a language-specific subfolder of the
  module folder.
- The `Save-Help` cmdlet can save help for modules that aren't installed on the computer. However,
  because help files are installed in the module folder, the `Update-Help` cmdlet can install
  updated help file only for modules that are installed on the computer.
- If `Save-Help` can't find updated help files for a module, or can't find updated help files in
  the specified language, it continues silently without displaying an error message. To see which
  files were saved by the command, specify the **Verbose** parameter.
- Modules are the smallest unit of updatable help. You can't save help for a particular cmdlet,
  only for all cmdlets in module. To find the module that contains a particular cmdlet, use the
  **ModuleName** property together with the `Get-Command` cmdlet, for example,
  `(Get-Command \<cmdlet-name\>).ModuleName`
- `Save-Help` supports all modules and the core PowerShell snap-ins. It doesn't support any other
  snap-ins.
- The `Update-Help` and `Save-Help` cmdlets use the following ports to download help files: Port 80
  for HTTP and port 443 for HTTPS.
- The `Update-Help` and `Save-Help` cmdlets aren't supported on Windows Preinstallation Environment
  (Windows PE).

## RELATED LINKS

[Get-Help](Get-Help.md)

[Get-Module](Get-Module.md)

[Update-Help](Update-Help.md)
