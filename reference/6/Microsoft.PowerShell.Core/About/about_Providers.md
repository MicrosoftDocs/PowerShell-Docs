---
ms.date:  01/03/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Providers
---
# About Providers

## Short description
Describes how PowerShell providers provide access to data and
components that would not otherwise be easily accessible at the command line.
The data is presented in a consistent format that resembles a file system
drive.

## Long description

PowerShell providers are Microsoft .NET Framework-based programs that
make the data in a specialized data store available in PowerShell so
that you can view and manage it.

The data that a provider exposes appears in a drive, and you access the data
in a path like you would on a hard disk drive. You can use any of the built-in
cmdlets that the provider supports to manage the data in the provider drive.
And, you can use custom cmdlets that are designed especially for the data.

The providers can also add dynamic parameters to the built-in cmdlets. These
are parameters that are available only when you use the cmdlet with the
provider data.

## Built-in providers

PowerShell includes a set of built-in providers that you can use to
access the different types of data stores.

|Provider    |Drive        |Data store                                 |
|------------|-------------|-------------------------------------------|
|Alias       |Alias:       |PowerShell aliases                 |
|Certificate |Cert:        |x509 certificates for digital signatures   |
|Environment |Env:         |Windows environment variables              |
|FileSystem  |(*)          |File system drives, directories, and files |
|Function    |Function:    |PowerShell functions               |
|Registry    |HKLM:, HKCU: |Windows registry                           |
|Variable    |Variable:    |PowerShell variables               |
|WSMan       |WSMan:       |WS-Management configuration information    |

(*) The FileSystem drives vary on each system.

You can also create your own PowerShell providers, and you can install
providers that others develop. To list the providers that are available in
your session, type:

```powershell
Get-PSProvider
```

## Installing and removing providers

Providers are typically installed via PowerShell modules. Importing the module
loads the provider into your session. You cannot uninstall the built-in
providers. You can uninstall providers loaded by other modules.

You can unload a provider from the current session. You can do this by using the
`Remove-Module` cmdlet. This cmdlet does not uninstall the provider, but it
makes the provider unavailable in the session.

You can also use the `Remove-PSDrive` cmdlet to remove any drive from the
current session. This data on the drive is not affected, but the drive is no
longer available in that session.

## Viewing providers

To view the PowerShell providers on your computer, type:

```powershell
Get-PSProvider
```

The output lists the built-in providers and the providers that you added to
the session.

## The provider cmdlets

The following cmdlets are designed to work with the data exposed by any
provider. You can use the same cmdlets in the same way to manage the different
types of data that providers expose. After you learn to manage the data of one
provider, you can use the same procedures with the data from any provider.

For example, the `New-Item` cmdlet creates a new item. In the `C:` drive that is
supported by the **FileSystem** provider, you can use `New-Item` to create a new
file or folder. In the drives that are supported by the **Registry** provider,
you can use `New-Item` to create a new registry key. In the `Alias:` drive,
you can use `New-Item` to create a new alias.

For detailed information about any of the following cmdlets, type:

```
Get-Help <cmdlet-name> -Detailed
```

### ChildItem cmdlets

- [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md)

### Content Cmdlets

- [Add-Content](../../Microsoft.PowerShell.Management/Add-Content.md)
- [Clear-Content](../../Microsoft.PowerShell.Management/Clear-Content.md)
- [Get-Content](../../Microsoft.PowerShell.Management/Get-Content.md)
- [Set-Content](../../Microsoft.PowerShell.Management/Set-Content.md)

### Item Cmdlets

- [Clear-Item](../../Microsoft.PowerShell.Management/Clear-Item.md)
- [Copy-Item](../../Microsoft.PowerShell.Management/Copy-Item.md)
- [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)
- [Invoke-Item](../../Microsoft.PowerShell.Management/Invoke-Item.md)
- [Move-Item](../../Microsoft.PowerShell.Management/Move-Item.md)
- [New-Item](../../Microsoft.PowerShell.Management/New-Item.md)
- [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md)
- [Rename-Item](../../Microsoft.PowerShell.Management/Rename-Item.md)
- [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)

### ItemProperty cmdlets

- [Clear-ItemProperty](../../Microsoft.PowerShell.Management/Clear-ItemProperty.md)
- [Copy-ItemProperty](../../Microsoft.PowerShell.Management/Copy-ItemProperty.md)
- [Get-ItemProperty](../../Microsoft.PowerShell.Management/Get-ItemProperty.md)
- [Move-ItemProperty](../../Microsoft.PowerShell.Management/Move-ItemProperty.md)
- [New-ItemProperty](../../Microsoft.PowerShell.Management/New-ItemProperty.md)
- [Remove-ItemProperty](../../Microsoft.PowerShell.Management/Remove-ItemProperty.md)
- [Rename-ItemProperty](../../Microsoft.PowerShell.Management/Rename-ItemProperty.md)
- [Set-ItemProperty](../../Microsoft.PowerShell.Management/Set-ItemProperty.md)

### Location cmdlets

- [Get-Location](../../Microsoft.PowerShell.Management/Get-Location.md)
- [Pop-Location](../../Microsoft.PowerShell.Management/Pop-Location.md)
- [Push-Location](../../Microsoft.PowerShell.Management/Push-Location.md)
- [Set-Location](../../Microsoft.PowerShell.Management/Set-Location.md)

### Path cmdlets

- [Join-Path](../../Microsoft.PowerShell.Management/Join-Path.md)
- [Convert-Path](../../Microsoft.PowerShell.Management/Convert-Path.md)
- [Split-Path](../../Microsoft.PowerShell.Management/Split-Path.md)
- [Resolve-Path](../../Microsoft.PowerShell.Management/Resolve-Path.md)
- [Test-Path](../../Microsoft.PowerShell.Management/Test-Path.md)

### PSDrive cmdlets

- [Get-PSDrive](../../Microsoft.PowerShell.Management/Get-PSDrive.md)
- [New-PSDrive](../../Microsoft.PowerShell.Management/New-PSDrive.md)
- [Remove-PSDrive](../../Microsoft.PowerShell.Management/Remove-PSDrive.md)

### PSProvider Cmdlets

- [Get-PSProvider](../../Microsoft.PowerShell.Management/Get-PSProvider.md)

## Viewing provider data

The primary benefit of a provider is that it exposes its data in a familiar
and consistent way. The model for data presentation is a file system
drive.

To use data that the provider exposes, you view it, move through it,
and change it as though it were data on a hard drive. Therefore, the most
important information about a provider is the name of the drive
that it supports.

The drive is listed in the default display of the `Get-PSProvider` cmdlet,
but you can get information about the provider drive by using the
`Get-PSDrive` cmdlet. For example, to get all the properties of the
Function: drive, type:

```powershell
Get-PSDrive Function | Format-List *
```

You can view and move through the data in a provider drive just as
you would on a file system drive.

To view the contents of a provider drive, use the Get-Item or Get-ChildItem
cmdlets. Type the drive name followed by a colon (:). For example, to
view the contents of the Alias: drive, type:

```powershell
Get-Item alias:
```

You can view and manage the data in any drive from another drive by
including the drive name in the path. For example, to view the
HKLM\Software registry key in the HKLM: drive from another drive, type:

```powershell
Get-ChildItem HKLM:\SOFTWARE\
```

To open the drive, use the Set-Location cmdlet. Remember the colon
when you specify the drive path. For example, to change your location
to the root directory of the Cert: drive, type:

```powershell
Set-Location cert:
```

Then, to view the contents of the Cert: drive, type:

```powershell
Get-ChildItem
```

## Moving through hierarchical data

You can move through a provider drive just as you would a hard disk drive.
If the data is arranged in a hierarchy of items within items, use a
backslash (`\`) to indicate a child item. Use the following format:

```
drive:\location\child-location\...
```

For example, to change your location to the HKLM\Software registry key,
type a Set-Location command, such as:

```powershell
Set-Location HKLM:\SOFTWARE\
```

If any element in the fully qualified name includes spaces, you must enclose
the name in quotation marks `" "`. The following example shows a fully
qualified path that includes spaces.

```
"C:\Program Files\Internet Explorer\iexplore.exe"
```

You can also use relative references to locations. A dot (`.`) represents the
current location. For example, if you are in the HKLM:\Software\Microsoft
registry key, and you want to list the registry subkeys in the
HKLM:\Software\Microsoft\PowerShell key, type the following command:

```powershell
Get-ChildItem .\PowerShell
```

In addition, two dots (`..`) refers to the directory or container directly
above your current location. You can combine dots (`.`) and double dots (`..`)
along with your paths to work through a provider hierarchy.

```
PS C:\Windows\System32> cd "..\..\Program Files"
PS C:\Program Files>
```

## Provider Home

Providers also have a **Home** location.  This location is shared by all
`PSDrives` backed by the provider. It can be retrieved by viewing the **Home**
property of the provider.

```powershell
Get-PSProvider | Format-Table Name, Home
```

```output
Name        Home
----        ----
Registry
Alias
Environment
FileSystem  C:\Users\robreed
Function
Variable
Certificate
```

The **FileSystem** provider is the only provider that has a default value for
**Home**. It is the same value as `$Home` see [about_Automatic_Variables](about_Automatic_Variables.md).

You can set the **Home** directory for a provider, for the current session,
using its property.

```powershell
(Get-PSProvider FileSystem).Home = "C:\"
```

The `~` character can be used to represent the provider's home directory.
If the provider does not have a **Home** location set, you will see an error.

```powershell
Cert:\> Set-Location ~
```

```output
Set-Location : Home location for this provider is not set. To set the home
location, call "(get-psprovider 'Certificate').Home = 'path'".
At line:1 char:1
+ Set-Location ~
+ ~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (:) [Set-Location],
                              PSInvalidOperationException
...
```

## Finding dynamic parameters

Dynamic parameters are cmdlet parameters that are added to a cmdlet by a
provider. These parameters are available only when the cmdlet is used with the
provider that added them.

For example, the `Cert:` drive adds the **CodeSigningCert** parameter to the
`Get-Item` and `Get-ChildItem` cmdlets. You can use this parameter only when you
use `Get-Item` or `Get-ChildItem` in the `Cert:` drive.

For a list of the dynamic parameters that a provider supports, see the Help
file for the provider. Type:

```
Get-Help <provider-name>
```

For example:

```powershell
Get-Help certificate
```

## Learning about providers

Although all provider data appears in drives, and you use the same methods to
move through them, the similarity stops there. The data stores that the
provider exposes can be as varied as Active Directory locations and Microsoft
Exchange Server mailboxes.

For information about individual PowerShell providers, type:

```
Get-Help <ProviderName>
```

For example:

```powershell
Get-Help registry
```

For a list of Help topics about the providers, type:

```powershell
Get-Help * -Category Provider
```

## See also

[about_Locations](about_Locations.md)

[about_Path_Syntax](about_Path_Syntax.md)