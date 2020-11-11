---
ms.date: 09/13/2016
ms.topic: reference
title: Designing Your Windows PowerShell Provider
description: Designing Your Windows PowerShell Provider
---
# Designing Your Windows PowerShell Provider

You should implement a Windows PowerShell provider if your product or configuration exposes a set of
stored data, such as a database that the user will want to navigate or browse. Additionally, if your
product provides a container, even if it is not a multilevel container, it makes sense to implement
a Windows PowerShell provider. For example, you might want to implement a Windows PowerShell
container provider if the cmdlet verb Copy, Move, Rename, New, or Remove makes sense as an operation
on your product or configuration data.

## Windows PowerShell Paths Identify Your Provider

The Windows PowerShell runtime uses Windows PowerShell paths to access the appropriate Windows
PowerShell provider. When a cmdlet specifies one of these paths, the runtime knows which provider to
use to access the associated data store. These paths include drive-qualified paths,
provider-qualified paths, provider-direct paths, and provider-internal paths. Each Windows
PowerShell provider must support one or more of these paths.

For more information about Windows PowerShell paths, see How Windows PowerShell Works.

### Defining a Drive-Qualified Path

To allow the user to access data located at a physical drive, your Windows PowerShell provider must
support a drive-qualified path. This path starts with the drive name followed by a colon (:), for
example, mydrive:\abc\bar.

### Defining a Provider-Qualified Path

To allow the Windows PowerShell runtime to initialize and uninitialize the provider, your Windows
PowerShell provider must support a provider-qualified path. For example,
FileSystem::\\\uncshare\abc\bar is the provider-qualified path for the filesystem provider furnished
by Windows PowerShell.

### Defining a Provider-Direct Path

To allow remote access to your Windows PowerShell provider, it should support a provider-direct path
to pass directly to the Windows PowerShell provider for the current location. For example, the
registry Windows PowerShell provider can use \\\server\regkeypath as a provider-direct path.

### Defining a Provider-Internal Path

To allow the provider cmdlet to access data using non-Windows PowerShell application programming
interfaces (APIs), your Windows PowerShell provider should support a provider-internal path. This
path is indicated after the "::" in the provider-qualified path. For example, the provider-internal
path for the filesystem Windows PowerShell provider is \\\uncshare\abc\bar.

## Changing Stored Data

When overriding methods that modify the underlying data store, always call the
[System.Management.Automation.Provider.Cmdletprovider.Writeitemobject*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.WriteItemObject)
method with the most up-to-date version of the item changed by that method. The provider
infrastructure determines if the item object needs to be passed to the pipeline, such as when the
user specifies the -PassThru parameter. If retrieving the most up-to-date item is a costly operation
(performance-wise,) you can test the Context.PassThru property to determine if you actually need to
write the resulting item.

## Choose a Base Class for Your Provider

Windows PowerShell provides a number of base classes that you can use to implement your own Windows
PowerShell provider. When designing a provider, choose the base class, described in this section,
that is most suited to your requirements.

Each Windows PowerShell provider base class makes available a set of cmdlets. This section describes
the cmdlets, but it does not describe their parameters.

Using the session state, the Windows PowerShell runtime makes several location cmdlets available to
certain Windows PowerShell providers, such as the `Get-Location`, `Set-Location`, `Pop-Location`,
and `Push-Location` cmdlets. You can use the `Get-Help` cmdlet to obtain information about these
location cmdlets.

### CmdletProvider Base Class

The
[System.Management.Automation.Provider.Cmdletprovider](/dotnet/api/System.Management.Automation.Provider.CmdletProvider)
class defines a basic Windows PowerShell provider. This class supports the provider declaration and
supplies a number of properties and methods that are available to all Windows PowerShell providers.
The class is invoked by the `Get-PSProvider` cmdlet to list all available providers for a session.
The implementation of this cmdlet is furnished by the session state.

> [!NOTE]
> Windows PowerShell providers are available to all Windows PowerShell language scopes.

### DriveCmdletProvider Base Class

The
[System.Management.Automation.Provider.Drivecmdletprovider](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider)
class defines a Windows PowerShell drive provider that supports operations for adding new drives,
removing existing drives, and initializing default drives. For example, the FileSystem provider
provided by Windows PowerShell initializes drives for all volumes that are mounted, such as hard
drives and CD/DVD device drives.

This class derives from the
[System.Management.Automation.Provider.Cmdletprovider](/dotnet/api/System.Management.Automation.Provider.CmdletProvider)
base class. The following table lists the cmdlets exposed by this class. In addition to those
listed, the `Get-PSDrive` cmdlet (exposed by session state) is a related cmdlet that is used to
retrieve available drives.

|      Cmdlet      |                             Definition                              |
| ---------------- | ------------------------------------------------------------------- |
| `New-PSDrive`    | Creates a new drive for the session, and streams drive information. |
| `Remove-PSDrive` | Removes a drive from the session.                                   |

### ItemCmdletProvider Base Class

The
[System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider)
class defines a Windows PowerShell item provider that performs operations on the individual items of
the data store, and it does not assume any container or navigation capabilities. This class derives
from the
[System.Management.Automation.Provider.Drivecmdletprovider](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider)
base class. The following table lists the cmdlets exposed by this class.

|     Cmdlet     |                                                                                                                                                            Definition                                                                                                                                                            |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Clear-Item`   | Clears the current content of items at the specified location, and replaces it with the "clear" value specified by the provider. This cmdlet does not pass an output object through the pipeline unless its `PassThru` parameter is specified.                                                                                   |
| `Get-Item`     | Retrieves items from the specified location, and streams the resultant objects.                                                                                                                                                                                                                                                  |
| `Invoke-Item`  | Invokes the default action for the item at the specified path.                                                                                                                                                                                                                                                                   |
| `Set-Item`     | Sets an item at the specified location with the indicated value. This cmdlet does not pass an output object through the pipeline unless its `PassThru` parameter is specified.                                                                                                                                                   |
| `Resolve-Path` | Resolves the wildcards for a Windows PowerShell path, and streams path information.                                                                                                                                                                                                                                              |
| `Test-Path`    | Tests for the specified path, and returns `true` if it exists and `false` otherwise. This cmdlet is implemented to support the `IsContainer` parameter for the [System.Management.Automation.Provider.Cmdletprovider.Writeitemobject*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.WriteItemObject) method. |

### ContainerCmdletProvider Base Class

The
[System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider)
class defines a Windows PowerShell container provider that exposes a container, for data store
items, to the user. Be aware that a Windows PowerShell container provider can be used only when
there is one container (no nested containers) with items in it. If there are nested containers, then
you must implement a Windows PowerShell navigation provider .

This class derives from the
[System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider)
base class. The following table defines the cmdlets implemented by this class.

|     Cmdlet      |                                                                        Definition                                                                        |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Copy-Item`     | Copies items from one location to another. This cmdlet does not pass an output object through the pipeline unless its `PassThru` parameter is specified. |
| `Get-Childitem` | Retrieves the child items at the specified location, and streams them as objects.                                                                        |
| `New-Item`      | Creates new items at the specified location, and streams the resultant object.                                                                           |
| `Remove-Item`   | Removes items from the specified location.                                                                                                               |
| `Rename-Item`   | Renames an item at the specified location. This cmdlet does not pass an output object through the pipeline unless its `PassThru` parameter is specified. |

### NavigationCmdletProvider Base Class

The
[System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider)
class defines a Windows PowerShell navigation provider that performs operations for items that use
more than one container. This class derives from the
[System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider)
base class. The following table list the cmdlets exposed by this class.

|    Cmdlet    |                                                                      Definition                                                                      |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| Combine-Path | Combines two paths into a single path, using a provider-specific delimiter between paths. This cmdlet streams strings.                               |
| `Move-Item`  | Moves items to the specified location. This cmdlet does not pass an output object through the pipeline unless its `PassThru` parameter is specified. |

A related cmdlet is the basic Parse-Path cmdlet furnished by Windows PowerShell. This cmdlet can be
used to parse a Windows PowerShell path to support the `Parent` parameter. It streams the parent
path string.

## Select Provider Interfaces to Support

In addition to deriving from one of the Windows PowerShell base classes, your Windows PowerShell
provider can support other functionality by deriving from one or more of the following provider
interfaces. This section defines those interfaces and the cmdlets supported by each. It does not
describe the parameters for the interface-supported cmdlets. Cmdlet parameter information is
available online using the `Get-Command` and `Get-Help` cmdlets.

### IContentCmdletProvider

The
[System.Management.Automation.Provider.Icontentcmdletprovider](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider)
interface defines a content provider that performs operations on the content of a data item. The
following table lists the cmdlets exposed by this interface.

|     Cmdlet      |                                                                                        Definition                                                                                        |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Add-Content`   | Appends the indicated value lengths to the contents of the specified item. This cmdlet does not pass an output object through the pipeline unless its `PassThru` parameter is specified. |
| `Clear-Content` | Sets the content of the specified item to the "clear" value. This cmdlet does not pass an output object through the pipeline unless its `PassThru` parameter is specified.               |
| `Get-Content`   | Retrieves the contents of the specified items and streams the resultant objects.                                                                                                         |
| `Set-Content`   | Replaces the existing content for the specified items. This cmdlet does not pass an output object through the pipeline unless its `PassThru` parameter is specified.                     |

### IPropertyCmdletProvider

The
[System.Management.Automation.Provider.Ipropertycmdletprovider](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider)
interface defines a property Windows PowerShell provider that performs operations on the properties
of items in the data store. The following table lists the cmdlets exposed by this interface.

> [!NOTE]
> The `Path` parameter on these cmdlets indicates a path to an item instead of identifying a
> property.

|        Cmdlet        |                                                                                   Definition                                                                                    |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Clear-ItemProperty` | Sets properties of the specified items to the "clear" value. This cmdlet does not pass an output object through the pipeline unless its `PassThru` parameter is specified.      |
| `Get-ItemProperty`   | Retrieves properties from the specified items and streams the resultant objects.                                                                                                |
| `Set-ItemProperty`   | Sets properties of the specified items with the indicated values. This cmdlet does not pass an output object through the pipeline unless its `PassThru` parameter is specified. |

### IDynamicPropertyCmdletProvider

The
[System.Management.Automation.Provider.Idynamicpropertycmdletprovider](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider)
interface, derived from
[System.Management.Automation.Provider.Ipropertycmdletprovider](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider),
defines a provider that specifies dynamic parameters for its supported cmdlets. This type of
provider handles operations for which properties can be defined at run time, for example, a new
property operation. Such operations are not possible on items having statically defined properties.
The following table lists the cmdlets exposed by this interface.

|        Cmdlet         |                                                                                Definition                                                                                |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `Copy-ItemProperty`   | Copies a property from the specified item to another item. This cmdlet does not pass an output object through the pipeline unless its `PassThru` parameter is specified. |
| `Move-ItemProperty`   | Moves a property from the specified item to another item. This cmdlet does not pass an output object through the pipeline unless its `PassThru` parameter is specified.  |
| `New-ItemProperty`    | Creates a property on the specified items and streams the resultant objects.                                                                                             |
| `Remove-ItemProperty` | Removes a property for the specified items.                                                                                                                              |
| `Rename-ItemProperty` | Renames a property of the specified items. This cmdlet does not pass an output object through the pipeline unless its `PassThru` parameter is specified.                 |

### ISecurityDescriptorCmdletProvider

The
[System.Management.Automation.Provider.Isecuritydescriptorcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ISecurityDescriptorCmdletProvider)
interface adds security descriptor functionality to a provider. This interface allows the user to
get and set security descriptor information for an item in the data store. The following table lists
the cmdlets exposed by this interface.

|  Cmdlet   |                                                                                                                                                                                                          Definition                                                                                                                                                                                                          |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Get-Acl` | Retrieves the information contained in an access control list (ACL), which is part of a security descriptor used to guard operating system resources, for example, a file or an object.                                                                                                                                                                                                                                      |
| `Set-Acl` | Sets the information for an ACL. It is in the form of an instance of [System.Security.Accesscontrol.Objectsecurity](/dotnet/api/System.Security.AccessControl.ObjectSecurity) on the item(s) designated for the specified path. This cmdlet can set information about files, keys, and subkeys in the registry, or any other provider item, if the Windows PowerShell provider supports the setting of security information. |

## See Also

[Creating Windows PowerShell Providers](./how-to-create-a-windows-powershell-provider.md)

[How Windows PowerShell Works](/previous-versions/ms714658(v=vs.85))

[Windows PowerShell SDK](../windows-powershell-reference.md)
