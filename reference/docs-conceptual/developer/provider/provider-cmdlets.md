---
description: Provider cmdlets
ms.date: 09/12/2016
ms.topic: reference
title: Provider cmdlets
---
# Provider cmdlets

The cmdlets that the user can run to manage a data store are referred to as provider cmdlets.
To support these cmdlets, you need to overwrite some of the methods defined by the base provider classes and interfaces.

Here are the provider cmdlets that can be run by the user:

## PSDrive cmdlets

### `Get-PSDrive`

This cmdlet returns the PowerShell drives in the current session.
You do not need to overwrite any methods to support this cmdlet.

### `New-PSDrive`

This cmdlet allows the user to create PowerShell drives to access the data store.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.DriveCmdletProvider](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider) class:

- [Newdrive](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.NewDrive)
- [NewDriveDynamicParameters](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.NewDriveDynamicParameters)

### `Remove-PSDrive`

This cmdlet allows the user to remove PowerShell drives that access the data store.
To support this cmdlet, overwrite the [System.Management.Automation.Provider.DriveCmdletProvider.Removedrive](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.RemoveDrive) method.

## Item cmdlets

### `Clear-Item`

This cmdlet allows the user to remove the value of an item in the data store.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.ItemCmdletProvider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider) class:

- [Clearitem](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ClearItem)
- [ClearItemDynamicParameters](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ClearItemDynamicParameters)

### `Copy-Item`

This cmdlet allows the user to copy an item from one location to another.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.ContainerCmdletProvider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider) class:

- [Copyitem](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem)
- [CopyItemDynamicParameters](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItemDynamicParameters)

### `Get-Item`

This cmdlet allows the user to retrieve data from the data store.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.ItemCmdletProvider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider) class:

- [Getitem](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItem)
- [GetItemDynamicParameters](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItemDynamicParameters)

### `Get-ChildItem`

This cmdlet allows the user to retrieve the child items of the parent item.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.ContainerCmdletProvider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider) class:

- [GetChildItems](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems)
- [GetChildItemsDynamicParameters](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItemsDynamicParameters)
- [GetChildNames](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildNames)
- [GetChildNamesDynamicParameters](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildNamesDynamicParameters)

### `Invoke-Item`

This cmdlet allows the user to perform the default action specified by the item.
To support this cmdlet, overwrite the [System.Management.Automation.Provider.ItemCmdletProvider.InvokeDefaultAction](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.InvokeDefaultAction) method.

### `Move-Item`

This cmdlet allows the user to move an item from one location to another location.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider) class:

- [MoveItem](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MoveItem)
- [MoveItemDynamicParameters](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MoveItemDynamicParameters)

### `New-ItemProperty`

This cmdlet allows the user to create a new item in the data store.

### `Remove-Item`

This cmdlet allows the user to remove items from the data store.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.ContainerCmdletProvider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider) class:

- [RemoveItem](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItem)
- [RemoveItemDynamicParameters](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItemDynamicParameters)

### `Rename-Item`

This cmdlet allows the user to rename items in the data store.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.ContainerCmdletProvider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider) class:

- [RenameItem](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RenameItem)
- [RenameItemDynamicParameters](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RenameItemDynamicParameters)

### `Set-Item`

This cmdlet allows the user to update the values of items in the data store.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.ItemCmdletProvider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider) class:

- [SetItem](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItem)
- [SetItemDynamicParameters](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItemDynamicParameters)

## Item content cmdlets

### `Add-Content`

This cmdlet allows the user to add content to an item.

### `Clear-Content`

This cmdlet allows the user to delete content from an item without deleting the item.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.IContentCmdletProvider](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider) interface:

- [ClearContent](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.ClearContent)
- [ClearContentDynamicParameters](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.ClearContentDynamicParameters)

### `Get-Content`

This cmdlet allows the user to retrieve the content of an item.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.IContentCmdletProvider](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider) interface:

- [GetContentReader](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentReader)
- [GetContentReaderDynamicParameters](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentReaderDynamicParameters)

The [GetContentReader](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentReader) method returns an [System.Management.Automation.Provider.IContentReader](/dotnet/api/System.Management.Automation.Provider.IContentReader) interface that defines the methods used to read the content.

### `Set-Content`

This cmdlet allows the user to update the content of an item.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.IContentCmdletProvider](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider) interface:

- [GetContentWriter](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriter)
- [GetContentWriterDynamicParameters](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriterDynamicParameters)

The [GetContentWriter](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriter) method returns an [System.Management.Automation.Provider.IContentWriter](/dotnet/api/System.Management.Automation.Provider.IContentWriter) interface that defines the methods used to write the content.

## Item property cmdlets

### `Clear-ItemProperty`

This cmdlet allows the user to delete the value of a property.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.IPropertyCmdletProvider](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider) interface:

- [ClearProperty](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.ClearProperty)
- [ClearPropertyDynamicParameters](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.ClearPropertyDynamicParameters)

### `Copy-ItemProperty`

This cmdlet allows the user to copy a property and its value from one location to another.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.IDynamicPropertyCmdletProvider](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider) interface:

- [CopyProperty](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.CopyProperty)
- [CopyPropertyDynamicParameters](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.CopyPropertyDynamicParameters)

### `Get-ItemProperty`

This cmdlet retrieves the properties of an item.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.IPropertyCmdletProvider](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider) interface:

- [GetProperty](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.GetProperty)
- [GetPropertyDynamicParameters](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.GetPropertyDynamicParameters)

### `Move-ItemProperty`

This cmdlet allows the user to move a property and its value from one location to another.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.IDynamicPropertyCmdletProvider](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider) interface:

- [MoveProperty](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.MoveProperty)
- [MovePropertyDynamicParameters](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.MovePropertyDynamicParameters)

### `New-ItemProperty`

This cmdlet allows the user to create a new property and set its value.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.IDynamicPropertyCmdletProvider](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider) interface:

- [NewProperty](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.NewProperty)
- [NewPropertyDynamicParameters](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.NewPropertyDynamicParameters)

### `Remove-ItemProperty`

This cmdlet allows the user to delete a property and its value.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.IDynamicPropertyCmdletProvider](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider) interface:

- [RemoveProperty](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RemoveProperty)
- [RemovePropertyDynamicParameters](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RemovePropertyDynamicParameters)

### `Rename-ItemProperty`

This cmdlet allows the user to change the name of a property.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.IDynamicPropertyCmdletProvider](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider) interface:

- [RenameProperty](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RenameProperty)
- [RenamePropertyDynamicParameters](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RenamePropertyDynamicParameters)

### `Set-ItemProperty`

This cmdlet allows the user to update the properties of an item.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.IPropertyCmdletProvider](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider) interface:

- [SetProperty](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.SetProperty)
- [SetPropertyDynamicParameters](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.SetPropertyDynamicParameters)

## Location cmdlets

### `Get-Location`

Retrieves information about the current working location.
You do not need to overwrite any methods to support this cmdlet.

### `Pop-Location`

This cmdlet changes the current location to the location most recently pushed onto the stack.
You do not need to overwrite any methods to support this cmdlet.

### `Push-Location`

This cmdlet adds the current location to the top of a list of locations (a "stack").
You do not need to overwrite any methods to support this cmdlet.

### `Set-Location`

This cmdlet sets the current working location to a specified location.
You do not need to overwrite any methods to support this cmdlet.

## Path cmdlets

### `Join-Path`

This cmdlet allows the user to combine a parent and child path segment to create a provider-internal path.
To support this cmdlet, overwrite the [System.Management.Automation.Provider.NavigationCmdletProvider.MakePath](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MakePath) method.

### `Convert-Path`

This cmdlet converts a path from a PowerShell path to a PowerShell provider path.

### `Split-Path`

Returns the specified part of a path.

### `Resolve-Path`

Resolves the wildcard characters in a path, and displays the path contents.

### `Test-Path`

This cmdlet determines whether all elements of a path exist.
To support this cmdlet, overwrite the following methods of [System.Management.Automation.Provider.ItemCmdletProvider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider) class:

- [ItemExists](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExists)
- [ItemExistsDynamicParameters](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExistsDynamicParameters)

## PSProvider cmdlets

### `Get-PSProvider`

This cmdlet returns information about the providers available in the session.
You do not need to overwrite any methods to support this cmdlet.
