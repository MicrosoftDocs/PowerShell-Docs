---
ms.date: 09/13/2016
ms.topic: reference
title: How to Create a Windows PowerShell Provider
description: How to Create a Windows PowerShell Provider
---
# How to Create a Windows PowerShell Provider

This section describes how to build a Windows PowerShell provider. A Windows PowerShell provider can
be considered in two ways. To the user, the provider represents a set of stored data. For example,
the stored data can be the Internet Information Services (IIS) Metabase, the Microsoft Windows
Registry, the Windows file system, Active Directory, and the variable and alias data stored by
Windows PowerShell.

To the developer, the Windows PowerShell provider is the interface between the user and the data
that the user needs to access. From this perspective, each type of provider described in this
section supports a set of specific base classes and interfaces that allow the Windows PowerShell
runtime to expose certain cmdlets to the user in a common way.

## Providers Provided by Windows PowerShell

Windows PowerShell provides several providers (such as the FileSystem provider, Registry provider,
and Alias provider) that are used to access known data stores. For more information about the
providers supplied by Windows PowerShell, use the following command to access online Help:

**PS>get-help about_providers**

## Accessing the Stored Data Using Windows PowerShell Paths

Windows PowerShell providers are accessible to the Windows PowerShell runtime and to commands
programmatically through the use of Windows PowerShell paths. Most of the time, these paths are used
to directly access the data through the provider. However, some paths can be resolved to
provider-internal paths that allow a cmdlet to use non-Windows PowerShell application programming
interfaces (APIs) to access the data. For more information about how Windows PowerShell providers
operate within Windows PowerShell, see
[How Windows PowerShell Works](/previous-versions/ms714658(v=vs.85)).

## Exposing Provider Cmdlets Using Windows PowerShell Drives

A Windows PowerShell provider exposes its supported cmdlets using virtual Windows PowerShell drives.
Windows PowerShell applies the following rules for a Windows PowerShell drive:

- The name of a drive can be any alphanumeric sequence.
- A drive can be specified at any valid point on a path, called a "root".
- A drive can be implemented for any stored data, not just the file system.
- Each drive keeps its own current working location, allowing the user to retain context when
  shifting between drives.

## In This Section

The following table lists topics that include code examples that build on each other. Starting with
the second topic, the basic Windows PowerShell provider can be initialized and uninitialized by the
Windows PowerShell runtime, the next topic adds functionality for accessing the data, the next topic
adds functionality for manipulating the data (the items in the stored data), and so on.

|                                                    Topic                                                    |                                                                                         Definition                                                                                          |
| ----------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Designing Your Windows PowerShell Provider](./designing-your-windows-powershell-provider.md)               | This topic discusses things you should consider before implementing a Windows PowerShell provider. It summarizes the Windows PowerShell provider base classes and interfaces that are used. |
| [Creating a Basic Windows PowerShell Provider](./creating-a-basic-windows-powershell-provider.md)           | This topic shows how to create a Windows PowerShell provider that allows the Windows PowerShell runtime to initialize and uninitialize the provider.                                        |
| [Creating a Windows PowerShell Drive Provider](./creating-a-windows-powershell-drive-provider.md)           | This topic shows how to create a Windows PowerShell provider that allows the user to access a data store through a Windows PowerShell drive.                                                |
| [Creating a Windows PowerShell Item Provider](./creating-a-windows-powershell-item-provider.md)             | This topic shows how to create a Windows PowerShell provider that allows the user to manipulate the items in a data store.                                                                  |
| [Creating a Windows PowerShell Container Provider](./creating-a-windows-powershell-container-provider.md)   | This topic shows how to create a Windows PowerShell provider that allows the user to work on multilayer data stores.                                                                        |
| [Creating a Windows PowerShell Navigation Provider](./creating-a-windows-powershell-navigation-provider.md) | This topic shows how to create a Windows PowerShell provider that allows the user to navigate the items of a data store in a hierarchical manner.                                           |
| [Creating a Windows PowerShell Content Provider](./creating-a-windows-powershell-content-provider.md)       | This topic shows how to create a Windows PowerShell provider that allows the user to manipulate the content of items in a data store.                                                       |
| [Creating a Windows PowerShell Property Provider](./creating-a-windows-powershell-property-provider.md)     | This topic shows how to create a Windows PowerShell provider that allows the user to manipulate the properties of items in a data store.                                                    |

## See Also

[How Windows PowerShell Works](/previous-versions/ms714658(v=vs.85))

[Windows PowerShell SDK](../windows-powershell-reference.md)

[Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)
