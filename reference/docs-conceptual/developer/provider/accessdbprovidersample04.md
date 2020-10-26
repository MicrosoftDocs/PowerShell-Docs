---
ms.date: 09/13/2016
ms.topic: reference
title: AccessDBProviderSample04
description: AccessDBProviderSample04
---
# AccessDBProviderSample04

This sample shows how to overwrite container methods to support calls to the `Copy-Item`,
`Get-ChildItem`, `New-Item`, and `Remove-Item` cmdlets. These methods should be implemented when the
data store contains items that are containers. A container is a group of child items under a common
parent item. The provider class in this sample derives from the
[System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider)
class.

## Demonstrates

> [!IMPORTANT]
> Your provider class will most likely derive from the
> [System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider)

This sample demonstrates the following:

- Declaring the `CmdletProvider` attribute.
- Defining a provider class that derives from the
  [System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider)
  class.
- Overwriting the
  [System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem)
  method to change the behavior of the `Copy-Item` cmdlet which allows the user to copy items from
  one location to another. (This sample does not show how to add dynamic parameters to the
  `Copy-Item` cmdlet.)
- Overwriting the
  [System.Management.Automation.Provider.Containercmdletprovider.Getchilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems)
  method to change the behavior of the Get-ChildItems cmdlet, which allows the user to retrieve the
  child items of the parent item. (This sample does not show how to add dynamic parameters to the
  Get-ChildItems cmdlet.)
- Overwriting the
  [System.Management.Automation.Provider.Containercmdletprovider.Getchildnames*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildNames)
  method to change the behavior of the Get-ChildItems cmdlet when the `Name` parameter of the cmdlet
  is specified.
- Overwriting the
  [System.Management.Automation.Provider.Containercmdletprovider.Newitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.NewItem)
  method to change the behavior of the `New-Item` cmdlet, which allows the user to add items to the
  data store. (This sample does not show how to add dynamic parameters to the `New-Item` cmdlet.)
- Overwriting the
  [System.Management.Automation.Provider.Containercmdletprovider.Removeitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItem)
  method to change the behavior of the `Remove-Item` cmdlet. (This sample does not show how to add
  dynamic parameters to the `Remove-Item` cmdlet.)

## Example

This sample shows how to overwrite the methods needed to copy, create, and remove items, as well as
methods for getting the child items of a parent item.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample04/AccessDBProviderSample04.cs" range="11-1635":::

## See Also

[System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider)

[System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider)

[System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider)

[Designing Your Windows PowerShell Provider](./provider-types.md)
