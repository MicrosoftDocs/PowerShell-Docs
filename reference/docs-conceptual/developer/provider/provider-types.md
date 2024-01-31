---
description: Provider types
ms.date: 08/21/2019
ms.topic: reference
title: Provider types
---

# Provider types

Providers define their basic functionality by changing how the provider cmdlets, provided by
PowerShell, perform their actions. For example, providers can use the default functionality of the
`Get-Item` cmdlet, or they can change how that cmdlet operates when retrieving items from the data
store. The provider functionality described in this document includes functionality defined by
overwriting methods from specific provider base classes and interfaces.

> [!NOTE]
> For provider features that are pre-defined by PowerShell, see [Provider capabilities][02].

## Drive-enabled providers

Drive-enabled providers specify the default drives available to the user and allow the user to add
or remove drives. In most cases, providers are drive-enabled providers because they require some
default drive to access the data store. However, when writing your own provider you might or might
not want to allow the user to create and remove drives.

To create a drive-enabled provider, your provider class must derive from the
[System.Management.Automation.Provider.DriveCmdletProvider][19] class or another class that derives
from that class. The **DriveCmdletProvider** class defines the following methods for implementing
the default drives of the provider and supporting the `New-PSDrive` and `Remove-PSDrive` cmdlets. In
most cases, to support a provider cmdlet you must overwrite the method that the PowerShell engine
calls to invoke the cmdlet, such as the `NewDrive` method for the `New-PSDrive` cmdlet, and
optionally you can overwrite a second method, such as `NewDriveDynamicParameters`, for adding
dynamic parameters to the cmdlet.

- The [InitializeDefaultDrives][20] method defines the default drives that are available to the user
  whenever the provider is used.

- The [NewDrive][21] and [NewDriveDynamicParameters][22] methods defines how your provider supports
  the `New-PSDrive` provider cmdlet. This cmdlet allows the user to create drives to access the data
  store.

- The [RemoveDrive][23] method defines how your provider supports the `Remove-PSDrive` provider
  cmdlet. This cmdlet allows the user to remove drives from the data store.

## Item-enabled providers

Item-enabled providers allow the user to get, set, or clear the items in the data store. An "item"
is an element of the data store that the user can access or manage independently. To create an
item-enabled provider, your provider class must derive from the
[System.Management.Automation.Provider.ItemCmdletProvider][51] class or another class that derives
from that class.

The **ItemCmdletProvider** class defines the following methods for implementing specific provider
cmdlets. In most cases, to support a provider cmdlet you must overwrite the method that the
PowerShell engine calls to invoke the cmdlet, such as the `ClearItem` method for the `Clear-Item`
cmdlet, and optionally you can overwrite a second method, such as `ClearItemDynamicParameters`, for
adding dynamic parameters to the cmdlet.

- The [ClearItem][52] and [ClearItemDynamicParameters][53] methods define how your provider supports
  the `Clear-Item` provider cmdlet. This cmdlet allows the user to remove of the value of an item in
  the data store.

- The [GetItem][55] and [GetItemDynamicParameters][56] methods define how your provider supports the
  `Get-Item` provider cmdlet. This cmdlet allows the user to retrieve data from the data store.

- The [SetItem][62] and [SetItemDynamicParameters][63] methods define how your provider supports the
  `Set-Item` provider cmdlet. This cmdlet allows the user to update the values of items in the data
  store.

- The [InvokeDefaultAction][57] and [InvokeDefaultActionDynamicParameters][58] methods define how
  your provider supports the `Invoke-Item` provider cmdlet. This cmdlet allows the user to perform
  the default action specified by the item.

- The [ItemExists][60] and [ItemExistsDynamicParameters][61] methods define how your provider
  supports the `Test-Path` provider cmdlet. This cmdlet allows the user to determine if all the
  elements of a path exist.

In addition to the methods used to implement provider cmdlets, the **ItemCmdletProvider** class also
defines the following methods:

- The [ExpandPath][54] method allows the user to use wildcards when specifying the provider path.

- The [IsValidPath][59] is used to determine if a path is syntactically and semantically valid for
  the provider.

## Container-enabled providers

Container-enabled providers allow the user to manage items that are containers. A container is a
group of child items under a common parent item. To create a container-enabled provider, your
provider class must derive from the
[System.Management.Automation.Provider.ContainerCmdletProvider][04] class or another class that
derives from that class.

> [!IMPORTANT]
> Container-enabled providers can't access data stores that contain nested containers. If a child
> item of a container is another container, you must implement a navigation-enabled provider.

The **ContainerCmdletProvider** class defines the following methods for implementing specific
provider cmdlets. In most cases, to support a provider cmdlet you must overwrite the method that the
PowerShell engine calls to invoke the cmdlet, such as the `CopyItem` method for the `Copy-Item`
cmdlet, and optionally you can overwrite a second method, such as `CopyItemDynamicParameters`, for
adding dynamic parameters to the cmdlet.

- The [CopyItem][06] and [CopyItemDynamicParameters][07] methods define how your provider supports
  the `Copy-Item` provider cmdlet. This cmdlet allows the user to copy an item from one location to
  another.

- The [GetChildItems][08] and [GetChildItemsDynamicParameters][09] methods define how your provider
  supports the `Get-ChildItem` provider cmdlet. This cmdlet allows the user to retrieve the child
  items of the parent item.

- The [GetChildNames][10] and [GetChildNamesDynamicParameters][11] methods define how your provider
  supports the `Get-ChildItem` provider cmdlet if its `Name` parameter is specified.

- The [NewItem][13] and [NewItemDynamicParameters][14] methods define how your provider supports the
  `New-Item` provider cmdlet. This cmdlet allows the user to create new items in the data store.

- The [RemoveItem][15] and [RemoveItemDynamicParameters][16] methods define how your provider
  supports the `Remove-Item` provider cmdlet. This cmdlet allows the user to remove items from the
  data store.

- The [RenameItem][17] and [RenameItemDynamicParameters][18] methods define how your provider
  supports the `Rename-Item` provider cmdlet. This cmdlet allows the user to rename items in the
  data store.

In addition to the methods used to implement provider cmdlets, the **ContainerCmdletProvider** class
also defines the following methods:

- The [HasChildItems][12] method can be used by the provider class to determine whether an item has
  child items.

- The [ConvertPath][05] method can be used by the provider class to create a new provider-specific
  path from a specified path.

## Navigation-enabled providers

Navigation-enabled providers allow the user to move items in the data store. To create a
navigation-enabled provider, your provider class must derive from the
[System.Management.Automation.Provider.NavigationCmdletProvider][64]
class.

The **NavigationCmdletProvider** class defines the following methods for implementing specific
provider cmdlets. In most cases, to support a provider cmdlet you must overwrite the method that the
PowerShell engine calls to invoke the cmdlet, such as the `MoveItem` method for the `Move-Item`
cmdlet, and optionally you can overwrite a second method, such as `MoveItemDynamicParameters`, for
adding dynamic parameters to the cmdlet.

- The [MoveItem][69] and [MoveItemDynamicParameters][70] methods define how your provider supports
  the `Move-Item` provider cmdlet. This cmdlet allows the user to move an item from one location in
  the store to another location.

- The [MakePath][68] method defines how your provider supports the `Join-Path` provider cmdlet. This
  cmdlet allows the user to combine a parent and child path segment to create a provider-internal
  path.

In addition to the methods used to implement provider cmdlets, the **NavigationCmdletProvider**
class also defines the following methods:

- The [GetChildName][65] method extracts the name of the child node of a path.

- The [GetParentPath][66] method extracts the parent part of a path.

- The [IsItemContainer][67] method determines whether the item is a container item. In this context,
  a container is a group of child items under a common parent item.

- The [NormalizeRelativePath][71] method returns a path to an item that's relative to a specified
  base path.

## Content-enabled providers

Content-enabled providers allow the user to clear, get, or set the content of items in a data store.
For example, the FileSystem provider allows you to clear, get, and set the content of files in the
file system. To create a content enabled provider, your provider class must implement the methods of
the [System.Management.Automation.Provider.IContentCmdletProvider][24] interface.

The **IContentCmdletProvider** interface defines the following methods for implementing specific
provider cmdlets. In most cases, to support a provider cmdlet you must overwrite the method that the
PowerShell engine calls to invoke the cmdlet, such as the `ClearContent` method for the
`Clear-Content` cmdlet, and optionally you can overwrite a second method, such as
`ClearContentDynamicParameters`, for adding dynamic parameters to the cmdlet.

- The
  [ClearContent][25]
  and
  [ClearContentDynamicParameters][26]
  methods define how your provider supports the `Clear-Content` provider cmdlet. This cmdlet allows
  the user to delete the content of an item without deleting the item.

- The [GetContentReader][27] and [GetContentReaderDynamicParameters][28] methods define how your
  provider supports the `Get-Content` provider cmdlet. This cmdlet allows the user to retrieve the
  content of an item. The `GetContentReader` method returns an
  [System.Management.Automation.Provider.IContentReader][31] interface that defines the methods used
  to read the content.

- The [GetContentWriter][29] and [GetContentWriterDynamicParameters][30] methods define how your
  provider supports the `Set-Content` provider cmdlet. This cmdlet allows the user to update the
  content of an item. The `GetContentWriter` method returns an
  [System.Management.Automation.Provider.IContentWriter][32] interface that defines the methods used
  to write the content.

## Property-enabled providers

Property-enabled providers allow the user to manage the properties of the items in the data store.
To create a property-enabled provider, your provider class must implement the methods of the
[System.Management.Automation.Provider.IPropertyCmdletProvider][44] and
[System.Management.Automation.Provider.IDynamicPropertyCmdletProvider][33] interfaces. In most
cases, to support a provider cmdlet you must overwrite the method that the PowerShell engine calls
to invoke the cmdlet, such as the `ClearProperty` method for the Clear-Property cmdlet, and
optionally you can overwrite a second method, such as `ClearPropertyDynamicParameters`, for adding
dynamic parameters to the cmdlet.

The **IPropertyCmdletProvider** interface defines the following methods for implementing specific
provider cmdlets:

- The [ClearProperty][45] and [ClearPropertyDynamicParameters][46] methods define how your provider
  supports the `Clear-ItemProperty` provider cmdlet. This cmdlet allows the user to delete the value
  of a property.

- The [GetProperty][47] and [GetPropertyDynamicParameters][48] methods define how your provider
  supports the `Get-ItemProperty` provider cmdlet. This cmdlet allows the user to retrieve the
  property of an item.

- The [SetProperty][49] and [SetPropertyDynamicParameters][50] methods define how your provider
  supports the `Set-ItemProperty` provider cmdlet. This cmdlet allows the user to update the
  properties of an item.

The **IDynamicPropertyCmdletProvider** interface defines the following methods for implementing
specific provider cmdlets:

- The [CopyProperty][34] and [CopyPropertyDynamicParameters][35] methods define how your provider
  supports the `Copy-ItemProperty` provider cmdlet. This cmdlet allows the user to copy a property
  and its value from one location to another.

- The [MoveProperty][36] and [MovePropertyDynamicParameters][37] methods define how your provider
  supports the `Move-ItemProperty` provider cmdlet. This cmdlet allows the user to move a property
  and its value from one location to another.

- The [NewProperty][38] and [NewPropertyDynamicParameters][39] methods define how your provider
  supports the `New-ItemProperty` provider cmdlet. This cmdlet allows the user to create a new
  property and set its value.

- The [RemoveProperty][40] and [RemovePropertyDynamicParameters][41] methods define how your
  provider supports the `Remove-ItemProperty` cmdlet. This cmdlet allows the user to delete a
  property and its value.

- The [RenameProperty][42] and [RenamePropertyDynamicParameters][43] methods define how your
  provider supports the `Rename-ItemProperty` cmdlet. This cmdlet allows the user to change the name
  of a property.

## See also

[about_Providers][01]

[Writing a Windows PowerShell Provider][03]

<!-- link references -->
[01]: /powershell/module/microsoft.powershell.core/about/about_providers
[02]: /previous-versions//ee126189(v=vs.85)
[03]: writing-a-windows-powershell-provider.md
[04]: xref:System.Management.Automation.Provider.ContainerCmdletProvider
[05]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.ConvertPath*
[06]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem*
[07]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.CopyItemDynamicParameters*
[08]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems*
[09]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItemsDynamicParameters*
[10]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.GetChildNames*
[11]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.GetChildNamesDynamicParameters*
[12]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.HasChildItems*
[13]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.NewItem*
[14]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.NewItemDynamicParameters*
[15]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItem*
[16]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItemDynamicParameters*
[17]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.RenameItem*
[18]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.RenameItemDynamicParameters*
[19]: xref:System.Management.Automation.Provider.DriveCmdletProvider
[20]: xref:System.Management.Automation.Provider.DriveCmdletProvider.InitializeDefaultDrives
[21]: xref:System.Management.Automation.Provider.DriveCmdletProvider.NewDrive*
[22]: xref:System.Management.Automation.Provider.DriveCmdletProvider.NewDriveDynamicParameters*
[23]: xref:System.Management.Automation.Provider.DriveCmdletProvider.RemoveDrive*
[24]: xref:System.Management.Automation.Provider.IContentCmdletProvider
[25]: xref:System.Management.Automation.Provider.IContentCmdletProvider.ClearContent*
[26]: xref:System.Management.Automation.Provider.IContentCmdletProvider.ClearContentDynamicParameters*
[27]: xref:System.Management.Automation.Provider.IContentCmdletProvider.GetContentReader*
[28]: xref:System.Management.Automation.Provider.IContentCmdletProvider.GetContentReaderDynamicParameters*
[29]: xref:System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriter*
[30]: xref:System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriterDynamicParameters*
[31]: xref:System.Management.Automation.Provider.IContentReader
[32]: xref:System.Management.Automation.Provider.IContentWriter
[33]: xref:System.Management.Automation.Provider.IDynamicPropertyCmdletProvider
[34]: xref:System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.CopyProperty*
[35]: xref:System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.CopyPropertyDynamicParameters*
[36]: xref:System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.MoveProperty*
[37]: xref:System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.MovePropertyDynamicParameters*
[38]: xref:System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.NewProperty*
[39]: xref:System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.NewPropertyDynamicParameters*
[40]: xref:System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RemoveProperty*
[41]: xref:System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RemovePropertyDynamicParameters*
[42]: xref:System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RenameProperty*
[43]: xref:System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RenamePropertyDynamicParameters*
[44]: xref:System.Management.Automation.Provider.IPropertyCmdletProvider
[45]: xref:System.Management.Automation.Provider.IPropertyCmdletProvider.ClearProperty*
[46]: xref:System.Management.Automation.Provider.IPropertyCmdletProvider.ClearPropertyDynamicParameters*
[47]: xref:System.Management.Automation.Provider.IPropertyCmdletProvider.GetProperty*
[48]: xref:System.Management.Automation.Provider.IPropertyCmdletProvider.GetPropertyDynamicParameters*
[49]: xref:System.Management.Automation.Provider.IPropertyCmdletProvider.SetProperty*
[50]: xref:System.Management.Automation.Provider.IPropertyCmdletProvider.SetPropertyDynamicParameters*
[51]: xref:System.Management.Automation.Provider.ItemCmdletProvider
[52]: xref:System.Management.Automation.Provider.ItemCmdletProvider.ClearItem*
[53]: xref:System.Management.Automation.Provider.ItemCmdletProvider.ClearItemDynamicParameters*
[54]: xref:System.Management.Automation.Provider.ItemCmdletProvider.ExpandPath*
[55]: xref:System.Management.Automation.Provider.ItemCmdletProvider.GetItem*
[56]: xref:System.Management.Automation.Provider.ItemCmdletProvider.GetItemDynamicParameters*
[57]: xref:System.Management.Automation.Provider.ItemCmdletProvider.InvokeDefaultAction*
[58]: xref:System.Management.Automation.Provider.ItemCmdletProvider.InvokeDefaultActionDynamicParameters*
[59]: xref:System.Management.Automation.Provider.ItemCmdletProvider.IsValidPath*
[60]: xref:System.Management.Automation.Provider.ItemCmdletProvider.ItemExists*
[61]: xref:System.Management.Automation.Provider.ItemCmdletProvider.ItemExistsDynamicParameters*
[62]: xref:System.Management.Automation.Provider.ItemCmdletProvider.SetItem*
[63]: xref:System.Management.Automation.Provider.ItemCmdletProvider.SetItemDynamicParameters*
[64]: xref:System.Management.Automation.Provider.NavigationCmdletProvider
[65]: xref:System.Management.Automation.Provider.NavigationCmdletProvider.GetChildName*
[66]: xref:System.Management.Automation.Provider.NavigationCmdletProvider.GetParentPath*
[67]: xref:System.Management.Automation.Provider.NavigationCmdletProvider.IsItemContainer*
[68]: xref:System.Management.Automation.Provider.NavigationCmdletProvider.MakePath*
[69]: xref:System.Management.Automation.Provider.NavigationCmdletProvider.MoveItem*
[70]: xref:System.Management.Automation.Provider.NavigationCmdletProvider.MoveItemDynamicParameters*
[71]: xref:System.Management.Automation.Provider.NavigationCmdletProvider.NormalizeRelativePath*
