---
ms.date: 09/13/2016
ms.topic: reference
title: Creating a Basic Windows PowerShell Provider
description: Creating a Basic Windows PowerShell Provider
---
# Creating a Basic Windows PowerShell Provider

This topic is the starting point for learning how to create a Windows PowerShell provider. The basic
provider described here provides methods for starting and stopping the provider, and although this
provider does not provide a means to access a data store or to get or set the data in the data
store, it does provide the basic functionality that is required by all providers.

As mentioned previously, the basic provider described here implements methods for starting and
stopping the provider. The Windows PowerShell runtime calls these methods to initialize and
uninitialize the provider.

> [!NOTE]
> You can find a sample of this provider in the AccessDBSampleProvider01.cs file provided by Windows
> PowerShell.

## Defining the Windows PowerShell Provider Class

The first step in creating a Windows PowerShell provider is to define its .NET class. This basic
provider defines a class called `AccessDBProvider` that derives from the
[System.Management.Automation.Provider.Cmdletprovider](/dotnet/api/System.Management.Automation.Provider.CmdletProvider)
base class.

It is recommended that you place your provider classes in a `Providers` namespace of your API
namespace, for example, xxx.PowerShell.Providers. This provider uses the
`Microsoft.Samples.PowerShell.Provider` namespace, in which all Windows PowerShell provider samples
run.

> [!NOTE]
> The class for a Windows PowerShell provider must be explicitly marked as public. Classes not
> marked as public will default to internal and will not be found by the Windows PowerShell runtime.

Here is the class definition for this basic provider:

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample01/AccessDBProviderSample01.cs" range="23-24":::

Right before the class definition, you must declare the
[System.Management.Automation.Provider.Cmdletproviderattribute](/dotnet/api/System.Management.Automation.Provider.CmdletProviderAttribute)
attribute, with the syntax [CmdletProvider()].

You can set attribute keywords to further declare the class if necessary. Notice that the
[System.Management.Automation.Provider.Cmdletproviderattribute](/dotnet/api/System.Management.Automation.Provider.CmdletProviderAttribute)
attribute declared here includes two parameters. The first attribute parameter specifies the
default-friendly name for the provider, which the user can modify later. The second parameter
specifies the Windows PowerShell-defined capabilities that the provider exposes to the Windows
PowerShell runtime during command processing. The possible values for the provider capabilities are
defined by the
[System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
enumeration. Because this is a base provider, it supports no capabilities.

> [!NOTE]
> The fully qualified name of the Windows PowerShell provider includes the assembly name and other
> attributes determined by Windows PowerShell upon registration of the provider.

## Defining Provider-Specific State Information

The
[System.Management.Automation.Provider.Cmdletprovider](/dotnet/api/System.Management.Automation.Provider.CmdletProvider)
base class and all derived classes are considered stateless because the Windows PowerShell runtime
creates provider instances only as required. Therefore, if your provider requires full control and
state maintenance for provider-specific data, it must derive a class from the
[System.Management.Automation.Providerinfo](/dotnet/api/System.Management.Automation.ProviderInfo)
class. Your derived class should define the members necessary to maintain the state so that the
provider-specific data can be accessed when the Windows PowerShell runtime calls the
[System.Management.Automation.Provider.Cmdletprovider.Start*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Start)
method to initialize the provider.

A Windows PowerShell provider can also maintain connection-based state. For more information about
maintaining connection state, see
[Creating a PowerShell Drive Provider](./creating-a-windows-powershell-drive-provider.md).

## Initializing the Provider

To initialize the provider, the Windows PowerShell runtime calls the
[System.Management.Automation.Provider.Cmdletprovider.Start*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Start)
method when Windows PowerShell is started. For the most part, your provider can use the default
implementation of this method, which simply returns the
[System.Management.Automation.Providerinfo](/dotnet/api/System.Management.Automation.ProviderInfo)
object that describes your provider. However, in the case where you want to add additional
initialization information, you should implement your own
[System.Management.Automation.Provider.Cmdletprovider.Start*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Start)
method that returns a modified version of the
[System.Management.Automation.Providerinfo](/dotnet/api/System.Management.Automation.ProviderInfo)
object that is passed to your provider. In general, this method should return the provided
[System.Management.Automation.Providerinfo](/dotnet/api/System.Management.Automation.ProviderInfo)
object passed to it or a modified
[System.Management.Automation.Providerinfo](/dotnet/api/System.Management.Automation.ProviderInfo)
object that contains other initialization information.

This basic provider does not override this method. However, the following code shows the default implementation of this method:

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplesaccessdbprov01#accessdbprov01ProviderStart](Msh_samplesaccessdbprov01#accessdbprov01ProviderStart)]  -->

The provider can maintain the state of provider-specific information as described in
[Defining Provider-specific Data State](#defining-provider-specific-state-information). In this
case, your implementation must override the
[System.Management.Automation.Provider.Cmdletprovider.Start*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Start)
method to return an instance of the derived class.

## Start Dynamic Parameters

Your provider implementation of the
[System.Management.Automation.Provider.Cmdletprovider.Start*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Start)
method might require additional parameters. In this case, the provider should override the
[System.Management.Automation.Provider.Cmdletprovider.Startdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.StartDynamicParameters)
method and return an object that has properties and fields with parsing attributes similar to a
cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object.

This basic provider does not override this method. However, the following code shows the default implementation of this method:

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplesaccessdbprov01#accessdbprov01ProviderDynamicParameters](Msh_samplesaccessdbprov01#accessdbprov01ProviderDynamicParameters)]  -->

## Uninitializing the Provider

To free resources that the Windows PowerShell provider uses, your provider should implement its own
[System.Management.Automation.Provider.Cmdletprovider.Stop*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Stop)
method. This method is called by the Windows PowerShell runtime to uninitialize the provider at the
close of a session.

This basic provider does not override this method. However, the following code shows the default
implementation of this method:

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplesaccessdbprov01#accessdbprov01ProviderStop](Msh_samplesaccessdbprov01#accessdbprov01ProviderStop)]  -->

## Code Sample

For complete sample code, see
[AccessDbProviderSample01 Code Sample](./accessdbprovidersample01-code-sample.md).

## Testing the Windows PowerShell Provider

Once your Windows PowerShell provider has been registered with Windows PowerShell, you can test it
by running the supported cmdlets on the command line. For this basic provider, run the new shell and
use the `Get-PSProvider` cmdlet to retrieve the list of providers and ensure that the AccessDb
provider is present.

```powershell
Get-PSProvider
```

The following output appears:

```Output
Name                 Capabilities                  Drives
----                 ------------                  ------
AccessDb             None                          {}
Alias                ShouldProcess                 {Alias}
Environment          ShouldProcess                 {Env}
FileSystem           Filter, ShouldProcess         {C, Z}
Function             ShouldProcess                 {function}
Registry             ShouldProcess                 {HKLM, HKCU}
```

## See Also

[Creating Windows PowerShell Providers](./how-to-create-a-windows-powershell-provider.md)

[Designing Your Windows PowerShell Provider](./designing-your-windows-powershell-provider.md)
