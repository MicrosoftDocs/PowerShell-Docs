---
ms.date: 09/13/2016
ms.topic: reference
title: Windows PowerShell Provider Overview
description: Windows PowerShell Provider Overview
---
# Windows PowerShell Provider Overview

A Windows PowerShell provider allows any data store to be exposed like a file system as if it were a
mounted drive. For example, the built-in Registry provider allows you to navigate the registry like
you would navigate the `c` drive of your computer. A provider can also override the `Item` cmdlets
(for example, `Get-Item`, `Set-Item`, etc.) such that the data in your data store can be treated
like files and directories are treated when navigating a file system. For more information about
providers and drives, and the built-in providers in Windows PowerShell, see
[about_Providers](/powershell/module/microsoft.powershell.core/about/about_providers).

## Providers and Drives

A Provider defines the logic that is used to access, navigate, and edit a data store, while a drive
specifies a specific entry point to a data store (or a portion of a data store) that is of the type
defined by the provider. For example, the Registry provider allows you to access hives and keys in a
registry, and the HKLM and HKCU drives specify the corresponding hives within the registry. The HKLM
and HKCU drives both use the Registry provider.

When you write a provider, you can specify default drives-drives that are created automatically when
the provider is available. You also define a method to create new drives that use that provider.

## Type of Providers

There are several types of providers, each of which provides a different level of functionality. A
provider is implemented as a class that derives from one of the descendants of the
[System.Management.Automation.SessionStateCategory](/dotnet/api/system.management.automation.sessionstatecategory)
**CmdletProvider** class. For information about the different types of providers, see
[Provider types](./provider-types.md).

## Provider cmdlets

Providers can implement methods that correspond to cmdlets, creating custom behaviors for those
cmdlets when used in a drive for that provider. Depending on the type of provider, different sets of
cmdlets are available. For a complete list of the cmdlets available for customization in providers,
see [Provider cmdlets](./provider-cmdlets.md).

## Provider paths

Users navigate provider drives like file systems. Because of this, they expect the syntax of paths
to correspond to the paths used in file system navigation. When a user runs a provider cmdlet, they
specify a path to the item to be accessed. The path that is specified can be interpreted in several
ways. A provider should support one or more of the following path types.

### Drive-qualified paths

A drive-qualified path is a combination of the item name, the container and subcontainers in which
the item is located, and the Windows PowerShell drive through which the item is accessed. (Drives
are defined by the provider that is used to access the data store. This path starts with the drive
name followed by a colon (:). For example: `get-childitem C:`

### Provider-qualified paths

To allow the Windows PowerShell engine to initialize and uninitialize your provider, the provider
must support a provider-qualified path. For example, the user can initialize and uninitialize the
FileSystem provider because it defines the following provider-qualified path:
`FileSystem::\\uncshare\abc\bar`.

### Provider-direct paths

To allow remote access to your Windows PowerShell provider, it should support a provider-direct path
to pass directly to the Windows PowerShell provider for the current location. For example, the
registry Windows PowerShell provider can use `\\server\regkeypath` as a provider-direct path.

### Provider-internal paths

To allow the provider cmdlet to access data using non-Windows PowerShell application programming
interfaces (APIs), your Windows PowerShell provider should support a provider-internal path. This
path is indicated after the "::" in the provider-qualified path. For example, the provider-internal
path for the filesystem Windows PowerShell provider is `\\uncshare\abc\bar`.

## Overriding cmdlet parameters

The behavior of some provider-specific cmdlets can be overridden by a provider. For a list of
parameters that can be overridden, and how to override them in your provider class, see
[Provider cmdlet parameters](./provider-cmdlet-parameters.md)

## Dynamic parameters

Providers can define dynamic parameters that are added to a provider cmdlet when the user specifies
a certain value for one of the static parameters of the cmdlet. A provider does this by implementing
one or more dynamic parameter methods. For a list of cmdlet parameters that can be used to add
dynamic parameter, and the methods used to implement them, see
[Provider cmdlet dynamic parameters](./provider-cmdlet-dynamic-parameters.md).

## Provider capabilities

The
[System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
enumeration defines a number of capabilities that providers can support. These include the ability
to use wildcards, filter items, and support transactions. To specify capabilities for a provider,
add a list of values of the
[System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
enumeration, combined with a logical `OR` operation, as the
[System.Management.Automation.Provider.Cmdletproviderattribute.Providercapabilities*](/dotnet/api/System.Management.Automation.Provider.CmdletProviderAttribute.ProviderCapabilities)
property (the second parameter of the attribute) of the
[System.Management.Automation.Provider.Cmdletproviderattribute](/dotnet/api/System.Management.Automation.Provider.CmdletProviderAttribute)
attribute for your provider class. For example, the following attribute specifies that the provider
supports the
[System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
**ShouldProcess** and
[System.Management.Automation.Provider.ProviderCapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
**Transactions** capabilities.

```csharp
[CmdletProvider(RegistryProvider.ProviderName, ProviderCapabilities.ShouldProcess | ProviderCapabilities.Transactions)]

```

## Provider cmdlet help

When writing a provider, you can implement your own Help for the provider cmdlets that you support.
This includes a single help topic for each provider cmdlet or multiple versions of a help topic for
cases where the provider cmdlet acts differently based on the use of dynamic parameters. To support
provider cmdlet-specific help, your provider must implement the
[System.Management.Automation.Provider.Icmdletprovidersupportshelp](/dotnet/api/System.Management.Automation.Provider.ICmdletProviderSupportsHelp)
interface.

The Windows PowerShell engine calls the
[System.Management.Automation.Provider.Icmdletprovidersupportshelp.Gethelpmaml*](/dotnet/api/System.Management.Automation.Provider.ICmdletProviderSupportsHelp.GetHelpMaml)
method to display the Help topic for your provider cmdlets. The engine provides the name of the
cmdlet that the user specified when running the `Get-Help` cmdlet and the current path of the user.
The current path is required if your provider implements different versions of the same provider
cmdlet for different drives. The method must return a string that contains the XML for the cmdlet
Help.

The content for the Help file is written using PSMAML XML. This is the same XML schema that is used
for writing Help content for stand-alone cmdlets. Add the content for your custom cmdlet Help to the
Help file for your provider under the `CmdletHelpPaths` element. The following example shows the
`command` element for a single provider cmdlet, and it shows how you specify the name of the
provider cmdlet that your provider. supports

```xml
<CmdletHelpPaths>
  <command:command>
    <command:details>
      <command:name>ProviderCmdletName</command:name>
      <command:verb>Verb</command:verb>
      <command:noun>Noun</command:noun>
    <command:details>
  </command:command>
<CmdletHelpPath>
```

## See Also

[Windows PowerShell Provider Functionality](./provider-types.md)

[Provider Cmdlets](./provider-cmdlets.md)

[Writing a Windows PowerShell Provider](./writing-a-windows-powershell-provider.md)
