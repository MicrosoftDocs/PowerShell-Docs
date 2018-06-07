---
title: "Provider types | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: e523a8e1-42e4-4633-887f-fb74b3464561
caps.latest.revision: 12
---
# Provider types

Providers define their basic functionality by changing how the provider cmdlets (provided by Windows PowerShell) perform their actions. For example, providers can use the default functionality of the `Get-Item` cmdlet, or they can change how that cmdlet operates when retrieving items from the data store. The provider functionality described in this topic includes functionality defined by overwriting methods from specific provider base classes and interfaces.

> [!NOTE]
> For provider features that are pre-defined by Windows PowerShell, see [Provider capabilities](https://msdn.microsoft.com/en-us/864e4807-554a-4016-80ea-bf643a090fc6).

## Drive-Enabled Providers

- The [System.Management.Automation.Provider.Drivecmdletprovider.Initializedefaultdrives*](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.InitializeDefaultDrives) method defines the default drives that are available to the user whenever the provider is used.

- The [System.Management.Automation.Provider.Drivecmdletprovider.Newdrive*](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.NewDrive) and [System.Management.Automation.Provider.Drivecmdletprovider.Newdrivedynamicparameters*](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.NewDriveDynamicParameters) methods defines how your provider supports the `New-PSDrive` provider cmdlet. This cmdlet allows the user to create drives to access the data store.

- The [System.Management.Automation.Provider.Drivecmdletprovider.Removedrive*](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.RemoveDrive) method defines how your provider supports the `Remove-PSDrive` provider cmdlet. This cmdlet allows the user to remove drives from the data store.

## Item-Enabled Providers

- The [System.Management.Automation.Provider.Itemcmdletprovider.Clearitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ClearItem) and [System.Management.Automation.Provider.Itemcmdletprovider.Clearitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ClearItemDynamicParameters) methods define how your provider supports the `Clear-Item` provider cmdlet. This cmdlet allows the user to remove of the value of an item in the data store.

- The [System.Management.Automation.Provider.Itemcmdletprovider.Getitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItem) and [System.Management.Automation.Provider.Itemcmdletprovider.Getitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItemDynamicParameters) methods define how your provider supports the `Get-Item` provider cmdlet. This cmdlet allows the user to retrieve data from the data store.

- The [System.Management.Automation.Provider.Itemcmdletprovider.Setitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItem) and [System.Management.Automation.Provider.Itemcmdletprovider.Setitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItemDynamicParameters) methods define how your provider supports the `Set-Item` provider cmdlet. This cmdlet allows the user to update the values of items in the data store.

- The [System.Management.Automation.Provider.Itemcmdletprovider.Invokedefaultaction*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.InvokeDefaultAction) and [System.Management.Automation.Provider.Itemcmdletprovider.Invokedefaultaction*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.InvokeDefaultAction) methods define how your provider supports the `Invoke-Item` provider cmdlet. This cmdlet allows the user to perform the default action specified by the item.

- The [System.Management.Automation.Provider.Itemcmdletprovider.Itemexists*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExists) and [System.Management.Automation.Provider.Itemcmdletprovider.Itemexistsdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExistsDynamicParameters) methods define how your provider supports the `Test-Path` provider cmdlet. This cmdlet allows the user to determine if all the elements of a path exist.

  In addition to the methods used to implement provider cmdlets, the [System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider) class also defines the following methods:

- The [System.Management.Automation.Provider.Itemcmdletprovider.Expandpath*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ExpandPath) method allows the user to use wildcards when specifying the provider path.

- The [System.Management.Automation.Provider.Itemcmdletprovider.Isvalidpath*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.IsValidPath) is used to determine if a path is syntactically and semantically valid for the provider.

## Container-Enabled Providers

- The [System.Management.Automation.Provider.Containercmdletprovider.Copyitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem) and [System.Management.Automation.Provider.Containercmdletprovider.Copyitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItemDynamicParameters) methods define how your provider supports the `Copy-Item` provider cmdlet. This cmdlet allows the user to copy an item from one location to another.

- The [System.Management.Automation.Provider.Containercmdletprovider.Getchilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems) and [System.Management.Automation.Provider.Containercmdletprovider.Getchilditemsdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItemsDynamicParameters) methods define how your provider supports the `Get-ChildItem` provider cmdlet. This cmdlet allows the user to retrieve the child items of the parent item.

- The [System.Management.Automation.Provider.Containercmdletprovider.Getchildnames*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildNames) and [System.Management.Automation.Provider.Containercmdletprovider.Getchildnamesdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildNamesDynamicParameters) methods define how your provider supports the `Get-ChildItem` provider cmdlet if its `Name` parameter is specified.

- The [System.Management.Automation.Provider.Containercmdletprovider.Newitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.NewItem) and [System.Management.Automation.Provider.Containercmdletprovider.Newitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.NewItemDynamicParameters) methods define how your provider supports the `New-Item` provider cmdlet. This cmdlet allows the user to create new items in the data store.

- The [System.Management.Automation.Provider.Containercmdletprovider.Removeitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItem) and [System.Management.Automation.Provider.Containercmdletprovider.Removeitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItemDynamicParameters) methods define how your provider supports the `Remove-Item` provider cmdlet. This cmdlet allows the user to remove items from the data store.

- The [System.Management.Automation.Provider.Containercmdletprovider.Renameitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RenameItem) and [System.Management.Automation.Provider.Containercmdletprovider.Renameitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RenameItemDynamicParameters) methods define how your provider supports the `Rename-Item` provider cmdlet. This cmdlet allows the user to rename items in the data store.

  In addition to the methods used to implement provider cmdlets, the [System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider) class also defines the following methods:

- The [System.Management.Automation.Provider.Containercmdletprovider.Haschilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.HasChildItems) method can be used by the provider class to determine whether an item has child items.

- The [System.Management.Automation.Provider.Containercmdletprovider.Convertpath*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.ConvertPath) method can be used by the provider class to create a new provider-specific path from a specified path.

## Navigation-Enabled Providers

- The [System.Management.Automation.Provider.Navigationcmdletprovider.Moveitem*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MoveItem) and [System.Management.Automation.Provider.Navigationcmdletprovider.Moveitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MoveItemDynamicParameters) methods define how your provider supports the `Move-Item` provider cmdlet. This cmdlet allows the user to move an item from one location in the store to another location.

- The [System.Management.Automation.Provider.Navigationcmdletprovider.Makepath*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MakePath) method defines how your provider supports the `Join-Path` provider cmdlet. This cmdlet allows the user to combine a parent and child path segment to create a provider-internal path.

  In addition to the methods used to implement provider cmdlets, the [System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider) class also defines the following methods:

- The [System.Management.Automation.Provider.Navigationcmdletprovider.Getchildname*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.GetChildName) method extracts the name of the child node of a path.

- The [System.Management.Automation.Provider.Navigationcmdletprovider.Getparentpath*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.GetParentPath) method extracts the parent part of a path.

- The [System.Management.Automation.Provider.Navigationcmdletprovider.Isitemcontainer*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.IsItemContainer) method determines whether the item is a container item. In this context, a container is a group of child items under a common parent item.

- The [System.Management.Automation.Provider.Navigationcmdletprovider.Normalizerelativepath*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.NormalizeRelativePath) method returns a path to an item that is relative to a specified base path.

## Content-Enabled Providers

- The [System.Management.Automation.Provider.Icontentcmdletprovider.Clearcontent*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.ClearContent) and [System.Management.Automation.Provider.Icontentcmdletprovider.Clearcontentdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.ClearContentDynamicParameters) methods define how your provider supports the `Clear-Content` provider cmdlet. This cmdlet allows the user to delete the content of an item without deleting the item.

- The [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentreader*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentReader) and [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentreaderdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentReaderDynamicParameters) methods define how your provider supports the `Get-Content` provider cmdlet. This cmdlet allows the user to retrieve the content of an item. The [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentreader*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentReader) method returns an [System.Management.Automation.Provider.Icontentreader](/dotnet/api/System.Management.Automation.Provider.IContentReader) interface that defines the methods used to read the content.

- The [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentwriter*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriter) and [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentwriterdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriterDynamicParameters) methods define how your provider supports the `Set-Content` provider cmdlet. This cmdlet allows the user to update the content of an item. The [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentwriter*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriter) method returns an [System.Management.Automation.Provider.Icontentwriter](/dotnet/api/System.Management.Automation.Provider.IContentWriter) interface that defines the methods used to write the content.

## Property-Enabled Providers

- The [System.Management.Automation.Provider.Ipropertycmdletprovider.Clearproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.ClearProperty) and [System.Management.Automation.Provider.Ipropertycmdletprovider.Clearpropertydynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.ClearPropertyDynamicParameters) methods define how your provider supports the `Clear-ItemProperty` provider cmdlet. This cmdlet allows the user to delete the value of a property.

- The [System.Management.Automation.Provider.Ipropertycmdletprovider.Getproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.GetProperty) and [System.Management.Automation.Provider.Ipropertycmdletprovider.Getpropertydynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.GetPropertyDynamicParameters) methods define how your provider supports the `Get-ItemProperty` provider cmdlet. This cmdlet allows the user to retrieve the property of an item.

- The [System.Management.Automation.Provider.Ipropertycmdletprovider.Setproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.SetProperty) and [System.Management.Automation.Provider.Ipropertycmdletprovider.Setpropertydynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.SetPropertyDynamicParameters) methods define how your provider supports the `Set-ItemProperty` provider cmdlet. This cmdlet allows the user to update the properties of an item.

  The [System.Management.Automation.Provider.Idynamicpropertycmdletprovider](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider) interface defines the following methods for implementing specific provider cmdlets:

- The [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Copyproperty*](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.CopyProperty) and [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Copypropertydynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.CopyPropertyDynamicParameters) methods define how your provider supports the `Copy-ItemProperty` provider cmdlet. This cmdlet allows the user to copy a property and its value from one location to another.

- The [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Moveproperty*](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.MoveProperty) and [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Movepropertydynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.MovePropertyDynamicParameters) methods define how your provider supports the `Move-ItemProperty` provider cmdlet. This cmdlet allows the user to move a property and its value from one location to another.

- The [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Newproperty*](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.NewProperty) and [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Newpropertydynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.NewPropertyDynamicParameters) methods define how your provider supports the `New-ItemProperty` provider cmdlet. This cmdlet allows the user to create a new property and set its value.

- The [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Removeproperty*](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RemoveProperty) and [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Removepropertydynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RemovePropertyDynamicParameters) methods define how your provider supports the `Remove-ItemProperty` cmdlet. This cmdlet allows the user to delete a property and its value.

- The [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Renameproperty*](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RenameProperty) and [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Renamepropertydynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RenamePropertyDynamicParameters) methods define how your provider supports the `Rename-ItemProperty` cmdlet. This cmdlet allows the user to change the name of a property.

## See Also

 [Writing a Windows PowerShell Provider](./writing-a-windows-powershell-provider.md)