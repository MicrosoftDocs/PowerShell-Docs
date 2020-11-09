---
ms.date: 09/13/2016
ms.topic: reference
title: Creating a Windows PowerShell Property Provider
description: Creating a Windows PowerShell Property Provider
---
# Creating a Windows PowerShell Property Provider

This topic describes how to create a provider that enables the user to manipulate the properties of
items in a data store. As a consequence, this type of provider is referred to as a Windows
PowerShell property provider. For example, the Registry provider provided by Windows PowerShell
handles registry key values as properties of the registry key item. This type of provider must add
the
[System.Management.Automation.Provider.Ipropertycmdletprovider](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider)
interface to the implementation of the .NET class.

> [!NOTE]
> Windows PowerShell provides a template file that you can use to develop a Windows PowerShell
> provider. The TemplateProvider.cs file is available on the Microsoft Windows Software Development
> Kit for Windows Vista and .NET Framework 3.0 Runtime Components. For download instructions, see
> [How to Install Windows PowerShell and Download the Windows PowerShell SDK](/powershell/scripting/developer/installing-the-windows-powershell-sdk).
> The downloaded template is available in the **\<PowerShell Samples>** directory. You should make a
> copy of this file and use the copy for creating a new Windows PowerShell provider, removing any
> functionality that you do not need. For more information about other Windows PowerShell provider
> implementations, see
> [Designing Your Windows PowerShell Provider](./designing-your-windows-powershell-provider.md).

> [!CAUTION]
> The methods of your property provider should write any objects using the
> [System.Management.Automation.Provider.Cmdletprovider.Writepropertyobject*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.WritePropertyObject)
> method.

## Defining the Windows PowerShell provider

A property provider must create a .NET class that supports the
[System.Management.Automation.Provider.Ipropertycmdletprovider](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider)
interface. Here is the default class declaration from the TemplateProvider.cs file provided by
Windows PowerShell.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testcmdletspropertyproviderclassdeclaration](Msh_samplestestcmdlets#testcmdletspropertyproviderclassdeclaration)]  -->

## Defining Base Functionality

The
[System.Management.Automation.Provider.Ipropertycmdletprovider](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider)
interface can be attached to any of the provider base classes, with the exception of the
[System.Management.Automation.Provider.Drivecmdletprovider](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider)
class. Add the base functionality that is required by the base class you are using. For more
information about base classes, see
[Designing Your Windows PowerShell Provider](./designing-your-windows-powershell-provider.md).

## Retrieving Properties

To retrieve properties, the provider must implement the
[System.Management.Automation.Provider.Ipropertycmdletprovider.Getproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.GetProperty)
method to support calls from the `Get-ItemProperty` cmdlet. This method retrieves the properties of
the item located at the specified provider-internal path (fully-qualified).

The `providerSpecificPickList` parameter indicates which properties to retrieve. If this parameter
is `null` or empty, the method should retrieve all properties. In addition,
[System.Management.Automation.Provider.Ipropertycmdletprovider.Getproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.GetProperty)
writes an instance of a
[System.Management.Automation.PSObject](/dotnet/api/System.Management.Automation.PSObject) object
that represents a property bag of the retrieved properties. The method should return nothing.

It is recommended that the implementation of
[System.Management.Automation.Provider.Ipropertycmdletprovider.Getproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.GetProperty)
supports the wildcard expansion of property names for each element in the pick list. To do this, use
the
[System.Management.Automation.Wildcardpattern](/dotnet/api/System.Management.Automation.WildcardPattern)
class to perform the wildcard pattern matching.

Here is the default implementation of
[System.Management.Automation.Provider.Ipropertycmdletprovider.Getproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.GetProperty)
from the TemplateProvider.cs file provided by Windows PowerShell.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testcmdletspropertyprovidergetproperty](Msh_samplestestcmdlets#testcmdletspropertyprovidergetproperty)]  -->

#### Things to Remember About Implementing GetProperty

The following conditions may apply to your implementation of
[System.Management.Automation.Provider.Ipropertycmdletprovider.Getproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.GetProperty):

- When defining the provider class, a Windows PowerShell property provider might declare provider
  capabilities of ExpandWildcards, Filter, Include, or Exclude, from the
  [System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
  enumeration. In these cases, the implementation of the
  [System.Management.Automation.Provider.Ipropertycmdletprovider.Getproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.GetProperty)
  method needs to ensure that the path passed to the method meets the requirements of the specified
  capabilities. To do this, the method should access the appropriate property, for example, the
  [System.Management.Automation.Provider.Cmdletprovider.Exclude*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Exclude)
  and
  [System.Management.Automation.Provider.Cmdletprovider.Include*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Include)
  properties.

- By default, overrides of this method should not retrieve a reader for objects that are hidden from
  the user unless the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property is set to `true`. An error should be written if the path represents an item that is
  hidden from the user and
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  is set to `false`.

## Attaching Dynamic Parameters to the Get-ItemProperty Cmdlet

The `Get-ItemProperty` cmdlet might require additional parameters that are specified dynamically at
runtime. To provide these dynamic parameters, the Windows PowerShell property provider must
implement the
[System.Management.Automation.Provider.Ipropertycmdletprovider.Getpropertydynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.GetPropertyDynamicParameters)
method. The `path` parameter indicates a fully-qualified provider-internal path, while the
`providerSpecificPickList` parameter specifies the provider-specific properties entered on the
command line. This parameter might be `null` or empty if the properties are piped to the cmdlet. In
this case, this method returns an object that has properties and fields with parsing attributes
similar to a cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object. The Windows PowerShell runtime uses the returned object to add the parameters to the cmdlet.

Here is the default implementation of
[System.Management.Automation.Provider.Ipropertycmdletprovider.Getpropertydynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.GetPropertyDynamicParameters)
from the TemplateProvider.cs file provided by Windows PowerShell.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testcmdletspropertyprovidergetpropertydynamicparameters](Msh_samplestestcmdlets#testcmdletspropertyprovidergetpropertydynamicparameters)]  -->

## Setting Properties

To set properties, the Windows PowerShell property provider must implement the
[System.Management.Automation.Provider.Ipropertycmdletprovider.Setproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.SetProperty)
method to support calls from the `Set-ItemProperty` cmdlet. This method sets one or more properties
of the item at the specified path, and overwrites the supplied properties as required.
[System.Management.Automation.Provider.Ipropertycmdletprovider.Setproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.SetProperty)
also writes an instance of a
[System.Management.Automation.PSObject](/dotnet/api/System.Management.Automation.PSObject) object
that represents a property bag of the updated properties.

Here is the default implementation of
[System.Management.Automation.Provider.Ipropertycmdletprovider.Setproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.SetProperty)
from the TemplateProvider.cs file provided by Windows PowerShell.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testcmdletspropertyprovidersetproperty](Msh_samplestestcmdlets#testcmdletspropertyprovidersetproperty)]  -->

#### Things to Remember About Implementing Set-ItemProperty

The following conditions may apply to an implementation of
[System.Management.Automation.Provider.Ipropertycmdletprovider.Setproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.SetProperty):

- When defining the provider class, a Windows PowerShell property provider might declare provider
  capabilities of ExpandWildcards, Filter, Include, or Exclude, from the
  [System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
  enumeration. In these cases, the implementation of the
  [System.Management.Automation.Provider.Ipropertycmdletprovider.Setproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.SetProperty)
  method must ensure that the path passed to the method meets the requirements of the specified
  capabilities. To do this, the method should access the appropriate property, for example, the
  [System.Management.Automation.Provider.Cmdletprovider.Exclude*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Exclude)
  and
  [System.Management.Automation.Provider.Cmdletprovider.Include*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Include)
  properties.

- By default, overrides of this method should not retrieve a reader for objects that are hidden from
  the user unless the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property is set to `true`. An error should be written if the path represents an item that is
  hidden from the user and
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  is set to `false`.

- Your implementation of the
  [System.Management.Automation.Provider.Ipropertycmdletprovider.Setproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.SetProperty)
  method should call
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  and verify its return value before making any changes to the data store. This method is used to
  confirm execution of an operation when a change is made to system state, for example, renaming
  files.
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  sends the name of the resource to be changed to the user, with the Windows PowerShell runtime and
  handling any command-line settings or preference variables in determining what should be
  displayed.

  After the call to
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  returns `true`, if potentially dangerous system modifications can be made, the
  [System.Management.Automation.Provider.Ipropertycmdletprovider.Setproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.SetProperty)
  method should call the
  [System.Management.Automation.Provider.Cmdletprovider.ShouldContinue](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldContinue)
  method. This method sends a confirmation message to the user to allow additional feedback to
  indicate that the operation should be continued.

## Attaching Dynamic Parameters for the Set-ItemProperty Cmdlet

The `Set-ItemProperty` cmdlet might require additional parameters that are specified dynamically at
runtime. To provide these dynamic parameters, the Windows PowerShell property provider must
implement the
[System.Management.Automation.Provider.Ipropertycmdletprovider.Setpropertydynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.SetPropertyDynamicParameters)
method. This method returns an object that has properties and fields with parsing attributes similar
to a cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object. The `null` value can be returned if no dynamic parameters are to be added.

Here is the default implementation of [System.Management.Automation.Provider.Ipropertycmdletprovider.Getpropertydynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.GetPropertyDynamicParameters) from the TemplateProvider.cs file provided by Windows PowerShell.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testcmdletspropertyprovidersetpropertydynamicparameters](Msh_samplestestcmdlets#testcmdletspropertyprovidersetpropertydynamicparameters)]  -->

## Clearing Properties

To clear properties, the Windows PowerShell property provider must implement the
[System.Management.Automation.Provider.Ipropertycmdletprovider.Clearproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.ClearProperty)
method to support calls from the `Clear-ItemProperty` cmdlet. This method sets one or more
properties for the item located at the specified path.

Here is the default implementation of
[System.Management.Automation.Provider.Ipropertycmdletprovider.Clearproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.ClearProperty)
from the TemplateProvider.cs file provided by Windows PowerShell.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testcmdletspropertyproviderclearproperty](Msh_samplestestcmdlets#testcmdletspropertyproviderclearproperty)]  -->

#### Thing to Remember About Implementing ClearProperty

The following conditions may apply to your implementation of
[System.Management.Automation.Provider.Ipropertycmdletprovider.Clearproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.ClearProperty):

- When defining the provider class, a Windows PowerShell property provider might declare provider
  capabilities of ExpandWildcards, Filter, Include, or Exclude, from the
  [System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
  enumeration. In these cases, the implementation of the
  [System.Management.Automation.Provider.Ipropertycmdletprovider.Clearproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.ClearProperty)
  method needs to ensure that the path passed to the method meets the requirements of the specified
  capabilities. To do this, the method should access the appropriate property, for example, the
  [System.Management.Automation.Provider.Cmdletprovider.Exclude*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Exclude)
  and
  [System.Management.Automation.Provider.Cmdletprovider.Include*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Include)
  properties.

- By default, overrides of this method should not retrieve a reader for objects that are hidden from
  the user unless the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property is set to `true`. An error should be written if the path represents an item that is
  hidden from the user and
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  is set to `false`.

- Your implementation of the
  [System.Management.Automation.Provider.Ipropertycmdletprovider.Clearproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.ClearProperty)
  method should call
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  and verify its return value before making any changes to the data store. This method is used to
  confirm execution of an operation before a change is made to system state, such as clearing
  content.
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  sends the name of the resource to be changed to the user, with the Windows PowerShell runtime
  taking into account any command line settings or preference variables in determining what should
  be displayed.

  After the call to
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  returns `true`, if potentially dangerous system modifications can be made, the
  [System.Management.Automation.Provider.Ipropertycmdletprovider.Clearproperty*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.ClearProperty)
  method should call the
  [System.Management.Automation.Provider.Cmdletprovider.ShouldContinue](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldContinue)
  method. This method sends a confirmation message to the user to allow additional feedback to
  indicate that the potentially dangerous operation should be continued.

## Attaching Dynamic Parameters to the Clear-ItemProperty Cmdlet

The `Clear-ItemProperty` cmdlet might require additional parameters that are specified dynamically
at runtime. To provide these dynamic parameters, the Windows PowerShell property provider must
implement the
[System.Management.Automation.Provider.Ipropertycmdletprovider.Clearpropertydynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.ClearPropertyDynamicParameters)
method. This method returns an object that has properties and fields with parsing attributes similar
to a cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object. The `null` value can be returned if no dynamic parameters are to be added.

Here is the default implementation of
[System.Management.Automation.Provider.Ipropertycmdletprovider.Clearpropertydynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IPropertyCmdletProvider.ClearPropertyDynamicParameters)
from the TemplateProvider.cs file provided by Windows PowerShell.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testcmdletspropertyproviderclearpropertydynamicparameters](Msh_samplestestcmdlets#testcmdletspropertyproviderclearpropertydynamicparameters)]  -->

## Building the Windows PowerShell provider

See [How to Register Cmdlets, Providers, and Host Applications](/previous-versions//ms714644(v=vs.85)).

## See Also

[Windows PowerShell provider](./designing-your-windows-powershell-provider.md)

[Design Your Windows PowerShell provider](./designing-your-windows-powershell-provider.md)

[Extending Object Types and Formatting](/previous-versions//ms714665(v=vs.85))

[How to Register Cmdlets, Providers, and Host Applications](/previous-versions//ms714644(v=vs.85))
