---
title: "Provider cmdlets | Microsoft Docs"
ms.custom: ""
ms.date: "09/12/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: d2465420-0970-4408-9ee5-260cf444cb67
caps.latest.revision: 8
---
# Provider cmdlets

The cmdlets that the user can run to manage a data store are referred to as provider cmdlets. To support these cmdlets, you need to overwrite some of the methods defined by the base provider classes and interfaces.

## Provider Cmdlets

Here are the provider cmdlets that can be run by the user:

### PSDrive cmdlets

- `Get-PSDrive`: This cmdlet returns the Windows PowerShell drives in the current session. You do not need to overwrite any methods to support this cmdlet.

- `New-PSDrive`: This cmdlet allows the user to create Windows PowerShell drives to access the data store. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Drivecmdletprovider.Newdrive%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.NewDrive%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Drivecmdletprovider.Newdrivedynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.NewDriveDynamicParameters%2A?displayProperty=fullName) methods.

- `Remove-PSDrive`: This cmdlet allows the user to remove Windows PowerShell drives that access the data store. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Drivecmdletprovider.Removedrive%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.RemoveDrive%2A?displayProperty=fullName) method.

### Item cmdlets

- `Clear-Item`: This cmdlet allows the user to remove the value of an item in the data store. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Itemcmdletprovider.Clearitem%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ClearItem%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Itemcmdletprovider.Clearitemdynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ClearItemDynamicParameters%2A?displayProperty=fullName) methods.

- `Copy-Item`: This cmdlet allows the user to copy an item from one location to another. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Containercmdletprovider.Copyitem%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Containercmdletprovider.Copyitemdynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItemDynamicParameters%2A?displayProperty=fullName) methods.

- `Get-Item`: This cmdlet allows the user to retrieve data from the data store. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Itemcmdletprovider.Getitem%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItem%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Itemcmdletprovider.Getitemdynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItemDynamicParameters%2A?displayProperty=fullName) methods.

- `Get-ChildItem`: This cmdlet allows the user to retrieve the child items of the parent item. To support this cmdlet, overwrite the following methods:

  - [System.Management.Automation.Provider.Containercmdletprovider.Getchilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems)

  - [System.Management.Automation.Provider.Containercmdletprovider.Getchilditemsdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItemsDynamicParameters)

  - [System.Management.Automation.Provider.Containercmdletprovider.Getchildnames*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildNames)

  - [System.Management.Automation.Provider.Containercmdletprovider.Getchildnamesdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildNamesDynamicParameters)

- `Invoke-Item`: This cmdlet allows the user to perform the default action specified by the item. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Itemcmdletprovider.Invokedefaultaction%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.InvokeDefaultAction%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Itemcmdletprovider.Invokedefaultaction%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.InvokeDefaultAction%2A?displayProperty=fullName) methods.

- `Move-Item`: This cmdlet allows the user to move an item from one location to another location. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Navigationcmdletprovider.Moveitem%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MoveItem%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Navigationcmdletprovider.Moveitemdynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MoveItemDynamicParameters%2A?displayProperty=fullName)s methods.

- `New-ItemProperty`: This cmdlet allows the user to create a new item in the data store.

- `Remove-Item`: This cmdlet allows the user to remove items from the data store. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Containercmdletprovider.Removeitem%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItem%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Containercmdletprovider.Removeitemdynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItemDynamicParameters%2A?displayProperty=fullName) methods.

- `Rename-Item`: This cmdlet allows the user to rename items in the data store. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Containercmdletprovider.Renameitem%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RenameItem%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Containercmdletprovider.Renameitemdynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RenameItemDynamicParameters%2A?displayProperty=fullName) methods.

- `Set-Item`: This cmdlet allows the user to update the values of items in the data store. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Itemcmdletprovider.Setitem%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItem%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Itemcmdletprovider.Setitemdynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItemDynamicParameters%2A?displayProperty=fullName) methods.

### Item content cmdlets

- `Add-Content`: This cmdlet allows the user to add content to an item.

- `Clear-Content`: This cmdlet allows the user to delete content from an item without deleting the item. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Icontentcmdletprovider.Clearcontent%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.ClearContent%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Icontentcmdletprovider.Clearcontentdynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.ClearContentDynamicParameters%2A?displayProperty=fullName) methods.

- `Get-Content`: This cmdlet allows the user to retrieve the content of an item. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentreader%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentReader%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentreaderdynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentReaderDynamicParameters%2A?displayProperty=fullName) methods. The [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentreader*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentReader) method returns an [System.Management.Automation.Provider.Icontentreader](/dotnet/api/System.Management.Automation.Provider.IContentReader) interface that defines the methods used to read the content.

- `Set-Content`: This cmdlet allows the user to update the content of an item. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentwriter%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriter%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentwriterdynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriterDynamicParameters%2A?displayProperty=fullName) methods. The [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentwriter*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriter) method returns an [System.Management.Automation.Provider.Icontentwriter](/dotnet/api/System.Management.Automation.Provider.IContentWriter) interface that defines the methods used to write the content.

### Item property cmdlets

- `Clear-ItemProperty`: This cmdlet allows the user to delete the value of a property. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Ipropertycmdletprovider.Clearproperty%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.ClearProperty%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Ipropertycmdletprovider.Clearpropertydynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.ClearPropertyDynamicParameters%2A?displayProperty=fullName) methods.

- `Copy-ItemProperty`: This cmdlet allows the user to copy a property and its value from one location to another. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Copyproperty%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.CopyProperty%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Copypropertydynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.CopyPropertyDynamicParameters%2A?displayProperty=fullName) methods.

- `Get-ItemProperty`: This cmdlet retrieves the properties of an item. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Ipropertycmdletprovider.Getproperty%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.GetProperty%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Ipropertycmdletprovider.Getpropertydynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.GetPropertyDynamicParameters%2A?displayProperty=fullName) methods.

- `Move-ItemProperty`: This cmdlet allows the user to move a property and its value from one location to another. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Moveproperty%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.MoveProperty%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Movepropertydynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.MovePropertyDynamicParameters%2A?displayProperty=fullName) methods.

- `New-ItemProperty`: This cmdlet allows the user to create a new property and set its value. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Newproperty%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.NewProperty%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Newpropertydynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.NewPropertyDynamicParameters%2A?displayProperty=fullName) methods.

- `Remove-ItemProperty`: This cmdlet allows the user to delete a property and its value. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Removeproperty%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RemoveProperty%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Removepropertydynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RemovePropertyDynamicParameters%2A?displayProperty=fullName) methods.

- `Rename-ItemProperty`: This cmdlet allows the user to change the name of a property. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Renameproperty%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RenameProperty%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Idynamicpropertycmdletprovider.Renamepropertydynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RenamePropertyDynamicParameters%2A?displayProperty=fullName) methods.

- `Set-ItemProperty`: This cmdlet allows the user to update the properties of an item. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Ipropertycmdletprovider.Setproperty%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.SetProperty%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Ipropertycmdletprovider.Setpropertydynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.SetPropertyDynamicParameters%2A?displayProperty=fullName) methods.

### Location cmdlets

- `Get-Location`: Retrieves information about the current working location. You do not need to overwrite any methods to support this cmdlet.

- `Pop-Location`: This cmdlet changes the current location to the location most recently pushed onto the stack. You do not need to overwrite any methods to support this cmdlet.

- `Push-Location`: This cmdlet adds the current location to the top of a list of locations (a "stack"). You do not need to overwrite any methods to support this cmdlet.

- `Set-Location`: This cmdlet sets the current working location to a specified location. You do not need to overwrite any methods to support this cmdlet.

### Path cmdlets

- `Join-Path`: This cmdlet allows the user to combine a parent and child path segment to create a provider-internal path. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Navigationcmdletprovider.Makepath%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MakePath%2A?displayProperty=fullName) method.

- `Convert-Path`: This cmdlet converts a path from a Windows PowerShell path to a Windows PowerShell provider path.

- `Split-Path`: Returns the specified part of a path.

- `Resolve-Path`: Resolves the wildcard characters in a path, and displays the path contents.

- `Test-Path`: This cmdlet determines whether all elements of a path exist. To support this cmdlet, overwrite the [System.Management.Automation.Provider.Itemcmdletprovider.Itemexists%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExists%2A?displayProperty=fullName) and [System.Management.Automation.Provider.Itemcmdletprovider.Itemexistsdynamicparameters%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExistsDynamicParameters%2A?displayProperty=fullName) methods.

### PSProvider cmdlets

- `Get-PSProvider`: This cmdlet returns information about the providers available in the session. You do not need to overwrite any methods to support this cmdlet.