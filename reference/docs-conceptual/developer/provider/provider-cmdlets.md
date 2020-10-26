---
ms.date: 09/12/2016
ms.topic: reference
title: Provider cmdlets
description: Provider cmdlets
---
# Provider cmdlets

The cmdlets that the user can run to manage a data store are referred to as provider cmdlets. To support these cmdlets, you need to overwrite some of the methods defined by the base provider classes and interfaces.

## Provider Cmdlets

Here are the provider cmdlets that can be run by the user:

### PSDrive cmdlets

- `Get-PSDrive`: This cmdlet returns the Windows PowerShell drives in the current session. You do not need to overwrite any methods to support this cmdlet.

- `New-PSDrive`: This cmdlet allows the user to create Windows PowerShell drives to access the data store. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Drivecmdletprovider.Newdrive](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.NewDrive) and [System.Management.Automation.Provider.Drivecmdletprovider.Newdrivedynamicparameters](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.NewDriveDynamicParameters) methods.

- `Remove-PSDrive`: This cmdlet allows the user to remove Windows PowerShell drives that access the data store. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Drivecmdletprovider.Removedrive](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.RemoveDrive) method.

### Item cmdlets

- `Clear-Item`: This cmdlet allows the user to remove the value of an item in the data store. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Itemcmdletprovider.Clearitem](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ClearItem) and [System.Management.Automation.Provider.Itemcmdletprovider.Clearitemdynamicparameters](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ClearItemDynamicParameters) methods.

- `Copy-Item`: This cmdlet allows the user to copy an item from one location to another. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Containercmdletprovider.Copyitem](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem) and [System.Management.Automation.Provider.Containercmdletprovider.Copyitemdynamicparameters](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItemDynamicParameters) methods.

- `Get-Item`: This cmdlet allows the user to retrieve data from the data store. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Itemcmdletprovider.Getitem](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItem) and [System.Management.Automation.Provider.Itemcmdletprovider.Getitemdynamicparameters](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItemDynamicParameters) methods.

- `Get-ChildItem`: This cmdlet allows the user to retrieve the child items of the parent item. To support this cmdlet, overwrite the following methods:

  - [System.Management.Automation.Provider.Containercmdletprovider.Getchilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems)

  - [System.Management.Automation.Provider.Containercmdletprovider.Getchilditemsdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItemsDynamicParameters)

  - [System.Management.Automation.Provider.Containercmdletprovider.Getchildnames*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildNames)

  - [System.Management.Automation.Provider.Containercmdletprovider.Getchildnamesdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildNamesDynamicParameters)

- `Invoke-Item`: This cmdlet allows the user to perform the default action specified by the item. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Itemcmdletprovider.Invokedefaultaction](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.InvokeDefaultAction) and [System.Management.Automation.Provider.Itemcmdletprovider.Invokedefaultaction](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.InvokeDefaultAction) methods.

- `Move-Item`: This cmdlet allows the user to move an item from one location to another location. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Navigationcmdletprovider.Moveitem](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MoveItem) and [System.Management.Automation.Provider.Navigationcmdletprovider.Moveitemdynamicparameters](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MoveItemDynamicParameters)s methods.

- `New-ItemProperty`: This cmdlet allows the user to create a new item in the data store.

- `Remove-Item`: This cmdlet allows the user to remove items from the data store. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Containercmdletprovider.Removeitem](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItem) and [System.Management.Automation.Provider.Containercmdletprovider.Removeitemdynamicparameters](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItemDynamicParameters) methods.

- `Rename-Item`: This cmdlet allows the user to rename items in the data store. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Containercmdletprovider.Renameitem](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RenameItem) and [System.Management.Automation.Provider.Containercmdletprovider.Renameitemdynamicparameters](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RenameItemDynamicParameters) methods.

- `Set-Item`: This cmdlet allows the user to update the values of items in the data store. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Itemcmdletprovider.Setitem](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItem) and [System.Management.Automation.Provider.Itemcmdletprovider.Setitemdynamicparameters](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItemDynamicParameters) methods.

### Item content cmdlets

- `Add-Content`: This cmdlet allows the user to add content to an item.

- `Clear-Content`: This cmdlet allows the user to delete content from an item without deleting the item. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Icontentcmdletprovider.Clearcontent](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.ClearContent) and [System.Management.Automation.Provider.Icontentcmdletprovider.Clearcontentdynamicparameters](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.ClearContentDynamicParameters) methods.

- `Get-Content`: This cmdlet allows the user to retrieve the content of an item. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentreader](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentReader) and [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentreaderdynamicparameters](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentReaderDynamicParameters) methods. The [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentreader*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentReader) method returns an [System.Management.Automation.Provider.Icontentreader](/dotnet/api/System.Management.Automation.Provider.IContentReader) interface that defines the methods used to read the content.

- `Set-Content`: This cmdlet allows the user to update the content of an item. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentwriter](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriter) and [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentwriterdynamicparameters](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriterDynamicParameters) methods. The [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentwriter*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriter) method returns an [System.Management.Automation.Provider.Icontentwriter](/dotnet/api/System.Management.Automation.Provider.IContentWriter) interface that defines the methods used to write the content.

### Item property cmdlets

- `Clear-ItemProperty`: This cmdlet allows the user to delete the value of a property. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Ipropertycmdletprovider.Clearproperty](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.ClearProperty) and [System.Management.Automation.Provider.Ipropertycmdletprovider.Clearpropertydynamicparameters](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.ClearPropertyDynamicParameters) methods.

- `Copy-ItemProperty`: This cmdlet allows the user to copy a property and its value from one location to another. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Copyproperty](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.CopyProperty) and [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Copypropertydynamicparameters](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.CopyPropertyDynamicParameters) methods.

- `Get-ItemProperty`: This cmdlet retrieves the properties of an item. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Ipropertycmdletprovider.Getproperty](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.GetProperty) and [System.Management.Automation.Provider.Ipropertycmdletprovider.Getpropertydynamicparameters](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.GetPropertyDynamicParameters) methods.

- `Move-ItemProperty`: This cmdlet allows the user to move a property and its value from one location to another. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Moveproperty](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.MoveProperty) and [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Movepropertydynamicparameters](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.MovePropertyDynamicParameters) methods.

- `New-ItemProperty`: This cmdlet allows the user to create a new property and set its value. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Newproperty](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.NewProperty) and [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Newpropertydynamicparameters](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.NewPropertyDynamicParameters) methods.

- `Remove-ItemProperty`: This cmdlet allows the user to delete a property and its value. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Removeproperty](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RemoveProperty) and [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Removepropertydynamicparameters](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RemovePropertyDynamicParameters) methods.

- `Rename-ItemProperty`: This cmdlet allows the user to change the name of a property. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Renameproperty](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RenameProperty) and [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Renamepropertydynamicparameters](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RenamePropertyDynamicParameters) methods.

- `Set-ItemProperty`: This cmdlet allows the user to update the properties of an item. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Ipropertycmdletprovider.Setproperty](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.SetProperty) and [System.Management.Automation.Provider.Ipropertycmdletprovider.Setpropertydynamicparameters](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.SetPropertyDynamicParameters) methods.

### Location cmdlets

- `Get-Location`: Retrieves information about the current working location. You do not need to overwrite any methods to support this cmdlet.

- `Pop-Location`: This cmdlet changes the current location to the location most recently pushed onto the stack. You do not need to overwrite any methods to support this cmdlet.

- `Push-Location`: This cmdlet adds the current location to the top of a list of locations (a "stack"). You do not need to overwrite any methods to support this cmdlet.

- `Set-Location`: This cmdlet sets the current working location to a specified location. You do not need to overwrite any methods to support this cmdlet.

### Path cmdlets

- `Join-Path`: This cmdlet allows the user to combine a parent and child path segment to create a provider-internal path. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Navigationcmdletprovider.Makepath](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MakePath) method.

- `Convert-Path`: This cmdlet converts a path from a Windows PowerShell path to a Windows PowerShell provider path.

- `Split-Path`: Returns the specified part of a path.

- `Resolve-Path`: Resolves the wildcard characters in a path, and displays the path contents.

- `Test-Path`: This cmdlet determines whether all elements of a path exist. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Itemcmdletprovider.Itemexists](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExists) and [System.Management.Automation.Provider.Itemcmdletprovider.Itemexistsdynamicparameters](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExistsDynamicParameters) methods.

### PSProvider cmdlets

- `Get-PSProvider`: This cmdlet returns information about the providers available in the session. You do not need to overwrite any methods to support this cmdlet.
