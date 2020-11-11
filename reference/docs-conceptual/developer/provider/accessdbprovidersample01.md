---
ms.date: 09/13/2016
ms.topic: reference
title: AccessDBProviderSample01
description: AccessDBProviderSample01
---
# AccessDBProviderSample01

This sample shows how to declare a provider class that derives directly from the
[System.Management.Automation.Provider.Cmdletprovider](/dotnet/api/System.Management.Automation.Provider.CmdletProvider)
class. It is included here only for completeness.

## Demonstrates

> [!IMPORTANT]
> Your provider class will most likely derive from one of the following classes and possibly
> implement other provider interfaces:
>
> - [System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider) class. See [AccessDBProviderSample03](./accessdbprovidersample03.md).
> - [System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider) class. See [AccessDBProviderSample04](./accessdbprovidersample04.md).
> - [System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider) class. See [AccessDBProviderSample05](./accessdbprovidersample05.md).
>
> For more information about choosing which provider class to derive from based on provider
> features, see [Designing Your Windows PowerShell Provider](./provider-types.md).

This sample demonstrates the following:

- Declaring the `CmdletProvider` attribute.

- Defining a provider class that derives directly from the
  [System.Management.Automation.Provider.Cmdletprovider](/dotnet/api/System.Management.Automation.Provider.CmdletProvider)
  class.

## Example

This sample shows how to define a provider class and how to declare the `CmdletProvider` attribute.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample01/AccessDBProviderSample01.cs" range="11-30":::

## See Also

[System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider)

[System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider)

[System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider)

[Designing Your Windows PowerShell Provider](./provider-types.md)
