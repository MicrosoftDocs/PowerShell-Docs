---
ms.date: 09/13/2016
ms.topic: reference
title: AccessDBProviderSample05
description: AccessDBProviderSample05
---
# AccessDBProviderSample05

This sample shows how to overwrite container methods to support calls to the `Move-Item` and
`Join-Path` cmdlets. These methods should be implemented when the user needs to move items within a
container and if the data store contains nested containers. The provider class in this sample
derives from the
[System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider)
class.

## Demonstrates

> [!IMPORTANT]
> Your provider class will most likely derive from one of the following classes and possibly
> implement other provider interfaces:
>
> - [System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider) class. See [AccessDBProviderSample03](./accessdbprovidersample03.md).
> - [System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider) class. See [AccessDBProviderSample04](./accessdbprovidersample04.md).
> - [System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider) class.
>
> For more information about choosing which provider class to derive from based on provider
> features, see [Designing Your Windows PowerShell Provider](./provider-types.md).

This sample demonstrates the following:

- Declaring the `CmdletProvider` attribute.

- Defining a provider class that derives from the
  [System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider)
  class.

- Overwriting the
  [System.Management.Automation.Provider.Navigationcmdletprovider.Moveitem*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MoveItem)
  method to change the behavior of the `Move-Item` cmdlet, allowing the user to move items from one
  location to another. (This sample does not show how to add dynamic parameters to the `Move-Item`
  cmdlet.)

- Overwriting the
  [System.Management.Automation.Provider.Navigationcmdletprovider.Makepath*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MakePath)
  method to change the behavior of the `Join-Path` cmdlet.

- Overwriting the
  [System.Management.Automation.Provider.Navigationcmdletprovider.Isitemcontainer*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.IsItemContainer)
  method.

- Overwriting the
  [System.Management.Automation.Provider.Navigationcmdletprovider.Getchildname*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.GetChildName)
  method.

- Overwriting the
  [System.Management.Automation.Provider.Navigationcmdletprovider.Getparentpath*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.GetParentPath)
  method.

- Overwriting the
  [System.Management.Automation.Provider.Navigationcmdletprovider.Normalizerelativepath*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.NormalizeRelativePath)
  method.

## Example

This sample shows how to overwrite the methods needed to move items in a Microsoft Access data base.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample05/AccessDBProviderSample05.cs" range="11-1960":::

## See Also

[System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider)

[System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider)

[System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider)

[Designing Your Windows PowerShell Provider](./provider-types.md)
