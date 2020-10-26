---
ms.date: 09/13/2016
ms.topic: reference
title: AccessDBProviderSample06
description: AccessDBProviderSample06
---
# AccessDBProviderSample06

This sample shows how to overwrite content methods to support calls to the `Clear-Content`,
`Get-Content`, and `Set-Content` cmdlets. These methods should be implemented when the user needs to
manage the content of the items in the data store. The provider class in this sample derives from
the
[System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider)
class, and it implements the
[System.Management.Automation.Provider.Icontentcmdletprovider](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider)
interface.

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
  class and that declares the
  [System.Management.Automation.Provider.Icontentcmdletprovider](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider)
  interface.
- Overwriting the
  [System.Management.Automation.Provider.Icontentcmdletprovider.Clearcontent*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.ClearContent)
  method to change the behavior of the `Clear-Content` cmdlet, allowing the user to remove the
  content from an item. (This sample does not show how to add dynamic parameters to the
  `Clear-Content` cmdlet.)
- Overwriting the
  [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentreader*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentReader)
  method to change the behavior of the `Get-Content` cmdlet, allowing the user to retrieve the
  content of an item. (This sample does not show how to add dynamic parameters to the `Get-Content`
  cmdlet.).
- Overwriting the
  [Microsoft.PowerShell.Commands.Filesystemprovider.Getcontentwriter*](/dotnet/api/Microsoft.PowerShell.Commands.FileSystemProvider.GetContentWriter)
  method to change the behavior of the `Set-Content` cmdlet, allowing the user to update the content
  of an item. (This sample does not show how to add dynamic parameters to the `Set-Content` cmdlet.)

## Example

This sample shows how to overwrite the methods needed to clear, get, and set the content of items in
a Microsoft Access data base.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample06/AccessDBProviderSample06.cs" range="11-2399":::

## See Also

[System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider)

[System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider)

[System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider)

[Designing Your Windows PowerShell Provider](./provider-types.md)
