---
ms.date: 09/13/2016
ms.topic: reference
title: AccessDBProviderSample03
description: AccessDBProviderSample03
---
# AccessDBProviderSample03

This sample shows how to overwrite the
[System.Management.Automation.Provider.Itemcmdletprovider.Getitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItem)
and
[System.Management.Automation.Provider.Itemcmdletprovider.Setitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItem)
methods to support calls to the `Get-Item` and `Set-Item` cmdlets. The provider class in this sample
derives from the
[System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider)
class.

## Demonstrates

> [!IMPORTANT]
> Your provider class will most likely derive from one of the following classes and possibly
> implement other provider interfaces:
>
> - [System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider) class.
> - [System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider) class. See [AccessDBProviderSample04](./accessdbprovidersample04.md).
> - [System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider) class. See [AccessDBProviderSample05](./accessdbprovidersample05.md).
>
> For more information about choosing which provider class to derive from based on provider
> features, see [Designing Your Windows PowerShell Provider](./provider-types.md).

This sample demonstrates the following:

- Declaring the `CmdletProvider` attribute.
- Defining a provider class that derives from the
  [System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider)
  class.
- Overwriting the
  [System.Management.Automation.Provider.Drivecmdletprovider.Newdrive*](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.NewDrive)
  method to change the behavior of the `New-PSDrive` cmdlet, allowing the user to create new drives.
  (This sample does not show how to add dynamic parameters to the `New-PSDrive` cmdlet.)
- Overwriting the
  [System.Management.Automation.Provider.Drivecmdletprovider.Removedrive*](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.RemoveDrive)
  method to support removing existing drives.
- Overwriting the
  [System.Management.Automation.Provider.Itemcmdletprovider.Getitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItem)
  method to change the behavior of the `Get-Item` cmdlet, allowing the user to retrieve items from
  the data store. (This sample does not show how to add dynamic parameters to the `Get-Item`
  cmdlet.)
- Overwriting the
  [System.Management.Automation.Provider.Itemcmdletprovider.Setitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItem)
  method to change the behavior of the `Set-Item` cmdlet, allowing the user to update the items in
  the data store. (This sample does not show how to add dynamic parameters to the `Get-Item`
  cmdlet.)
- Overwriting the
  [System.Management.Automation.Provider.Itemcmdletprovider.Itemexists*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExists)
  method to change the behavior of the `Test-Path` cmdlet. (This sample does not show how to add
  dynamic parameters to the `Test-Path` cmdlet.)
- Overwriting the
  [System.Management.Automation.Provider.Itemcmdletprovider.Isvalidpath*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.IsValidPath)
  method to determine if the provided path is valid.

## Example

This sample shows how to overwrite the methods needed to get and set items in a Microsoft Access
data base.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample03/AccessDBProviderSample03.cs" range="11-976":::

## See Also

[System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider)

[System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider)

[System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider)

[Designing Your Windows PowerShell Provider](./provider-types.md)
