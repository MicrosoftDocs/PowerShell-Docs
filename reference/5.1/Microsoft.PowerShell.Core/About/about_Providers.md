---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Providers
---

# About Providers
## about_Providers


# SHORT DESCRIPTION

Describes how Windows PowerShell providers provide access to data and
components that would not otherwise be easily accessible at the command
line. The data is presented in a consistent format that resembles a file
system drive.

# LONG DESCRIPTION

Windows PowerShell providers are Microsoft .NET Framework-based programs
that make the data in a specialized data store available in Windows
PowerShell so that you can view and manage it.

The data that a provider exposes appears in a drive, and you access the
data in a path like you would on a hard disk drive. You can use any of the
built-in cmdlets that the provider supports to manage the data in the
provider drive. And, you can use custom cmdlets that are designed
especially for the data.

The providers can also add dynamic parameters to the built-in cmdlets.
These are parameters that are available only when you use the cmdlet with
the provider data.

# BUILT-IN PROVIDERS

Windows PowerShell includes a set of built-in providers that you can use
to access the different types of data stores.

| Provider    | Drive        | Data store                                 |
| ----------- | ------------ | ------------------------------------------ |
| Alias       | Alias:       | Windows PowerShell aliases                 |
| Certificate | Cert:        | x509 certificates for digital signatures   |
| Environment | Env:         | Windows environment variables              |
| FileSystem  | (*)          | File system drives, directories, and files |
| Function    | Function:    | Windows PowerShell functions               |
| Registry    | HKLM:, HKCU: | Windows registry                           |
| Variable    | Variable:    | Windows PowerShell variables               |
| WSMan       | WSMan:       | WS-Management configuration information    |

(*) The FileSystem drives vary on each system.

You can also create your own Windows PowerShell providers, and you can
install providers that others develop. To list the providers that are
available in your session, type:

Get-PSProvider

# INSTALLING AND REMOVING PROVIDERS

Windows PowerShell providers are delivered to you in Windows PowerShell
modules, which are .NET Framework-based programs that are compiled
into .dll files. The snap-ins can include providers and cmdlets.

Before you use the provider features, you have to install the snap-in and
then add it to your Windows PowerShell session. For more information, see
about_PSSnapins.

You cannot uninstall a provider, although you can remove the Windows
PowerShell snap-in for the provider from the current session. If you do,
you remove all the contents of the snap-in, including its cmdlets.

To remove a provider from the current session, use the Remove-PSSnapin
cmdlet. This cmdlet does not uninstall the provider, but it makes
the provider unavailable in the session.

You can also use the Remove-PSDrive cmdlet to remove any drive from the
current session. This data on the drive is not affected, but the drive is
no longer available in that session.

# VIEWING PROVIDERS

To view the Windows PowerShell providers on your computer, type:

Get-PSProvider

The output lists the built-in providers and the providers that you added
to the session.

# THE PROVIDER CMDLETS

The following cmdlets are designed to work with the data exposed by
any provider. You can use the same cmdlets in the same way to manage
the different types of data that providers expose. After you
learn to manage the data of one provider, you can use the same
procedures with the data from any provider.

For example, the New-Item cmdlet creates a new item. In the C: drive that
is supported by the FileSystem provider, you can use New-Item to create a
new file or folder. In the drives that are supported by the Registry
provider, you can use New-Item to create a new registry key. In the Alias:
drive, you can use New-Item to create a new alias.

For detailed information about any of the following cmdlets, type:

Get-Help <cmdlet-name> -Detailed

# CHILDITEM CMDLETS

Get-ChildItem

# CONTENT CMDLETS

Add-Content
Clear-Content
Get-Content
Set-Content

# ITEM CMDLETS

Clear-Item
Copy-Item
Get-Item
Invoke-Item
Move-Item
New-Item
Remove-Item
Rename-Item
Set-Item

# ITEMPROPERTY CMDLETS

Clear-ItemProperty
Copy-ItemProperty
Get-ItemProperty
Move-ItemProperty
New-ItemProperty
Remove-ItemProperty
Rename-ItemProperty
Set-ItemProperty

# LOCATION CMDLETS

Get-Location
Pop-Location
Push-Location
Set-Location

# PATH CMDLETS

Join-Path
Convert-Path
Split-Path
Resolve-Path
Test-Path

# PSDRIVE CMDLETS

Get-PSDrive
New-PSDrive
Remove-PSDrive

# PSPROVIDER CMDLETS

Get-PSProvider

# VIEWING PROVIDER DATA

The primary benefit of a provider is that it exposes its data in a familiar
and consistent way. The model for data presentation is a file system
drive.

To use data that the provider exposes, you view it, move through it,
and change it as though it were data on a hard drive. Therefore, the most
important information about a provider is the name of the drive
that it supports.

The drive is listed in the default display of the Get-PSProvider cmdlet,
but you can get information about the provider drive by using the
Get-PSDrive cmdlet. For example, to get all the properties of the
Function: drive, type:

Get-PSDrive Function | Format-List *

You can view and move through the data in a provider drive just as
you would on a file system drive.

To view the contents of a provider drive, use the Get-Item or Get-ChildItem
cmdlets. Type the drive name followed by a colon (:). For example, to
view the contents of the Alias: drive, type:

Get-Item Alias:

You can view and manage the data in any drive from another drive by
including the drive name in the path. For example, to view the
HKLM\Software registry key in the HKLM: drive from another drive, type:

Get-ChildItem HKLM:\SOFTWARE

To open the drive, use the Set-Location cmdlet. Remember the colon
when you specify the drive path. For example, to change your location
to the root directory of the Cert: drive, type:

Set-Location Cert:

Then, to view the contents of the Cert: drive, type:

Get-ChildItem

# MOVING THROUGH HIERARCHICAL DATA

You can move through a provider drive just as you would a hard disk drive.
If the data is arranged in a hierarchy of items within items, use a
backslash () to indicate a child item. Use the following format:

drive:\location\child-location\...

For example, to change your location to the HKLM\Software registry key,
type a Set-Location command, such as:

Set-Location HKLM:\SOFTWARE

You can also use relative references to locations. A dot (.) represents the
current location. For example, if you are in the HKLM:\Software\Microsoft
registry key, and you want to list the registry subkeys in the
HKLM:\Software\Microsoft\PowerShell key, type the following command:

Get-ChildItem .\PowerShell

# FINDING DYNAMIC PARAMETERS

Dynamic parameters are cmdlet parameters that are added to a cmdlet
by a provider. These parameters are available only when the cmdlet is
used with the provider that added them.

For example, the Cert: drive adds the CodeSigningCert parameter
to the Get-Item and Get-ChildItem cmdlets. You can use this parameter
only when you use Get-Item or Get-ChildItem in the Cert: drive.

For a list of the dynamic parameters that a provider supports, see the
Help file for the provider. Type:

Get-Help <provider-name>

For example:

Get-Help Certificate

# LEARNING ABOUT PROVIDERS

Although all provider data appears in drives, and you use the same methods
to move through them, the similarity stops there. The data stores that
the provider exposes can be as varied as Active Directory locations and
Microsoft Exchange Server mailboxes.

For information about individual Windows PowerShell providers, type:

Get-Help <ProviderName>

For example:

Get-Help Registry

For a list of Help topics about the providers, type:

Get-Help * -Category provider

# SEE ALSO

about_Locations

[about_Path_Syntax](about_Path_Syntax.md)

