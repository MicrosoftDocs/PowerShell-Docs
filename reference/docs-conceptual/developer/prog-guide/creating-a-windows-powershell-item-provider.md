---
ms.date: 09/13/2016
ms.topic: reference
title: Creating a Windows PowerShell Item Provider
description: Creating a Windows PowerShell Item Provider
---
# Creating a Windows PowerShell Item Provider

This topic describes how to create a Windows PowerShell provider that can manipulate the data in a
data store. In this topic, the elements of data in the store are referred to as the "items" of the
data store. As a consequence, a provider that can manipulate the data in the store is referred to as
a Windows PowerShell item provider.

> [!NOTE]
> You can download the C# source file (AccessDBSampleProvider03.cs) for this provider using the
> Microsoft Windows Software Development Kit for Windows Vista and .NET Framework 3.0 Runtime
> Components. For download instructions, see
> [How to Install Windows PowerShell and Download the Windows PowerShell SDK](/powershell/scripting/developer/installing-the-windows-powershell-sdk).
> The downloaded source files are available in the **\<PowerShell Samples>** directory. For more
> information about other Windows PowerShell provider implementations, see
> [Designing Your Windows PowerShell Provider](./designing-your-windows-powershell-provider.md).

The Windows PowerShell item provider described in this topic gets items of data from an Access
database. In this case, an "item" is either a table in the Access database or a row in a table.

## Defining the Windows PowerShell Item Provider Class

A Windows PowerShell item provider must define a .NET class that derives from the
[System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider)
base class. The following is the class definition for the item provider described in this section.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample03/AccessDBProviderSample03.cs" range="34-36":::

Note that in this class definition, the
[System.Management.Automation.Provider.Cmdletproviderattribute](/dotnet/api/System.Management.Automation.Provider.CmdletProviderAttribute)
attribute includes two parameters. The first parameter specifies a user-friendly name for the
provider that is used by Windows PowerShell. The second parameter specifies the Windows PowerShell
specific capabilities that the provider exposes to the Windows PowerShell runtime during command
processing. For this provider, there are no added Windows PowerShell specific capabilities.

## Defining Base Functionality

As described in
[Design Your Windows PowerShell Provider](./designing-your-windows-powershell-provider.md), the
[System.Management.Automation.Provider.Drivecmdletprovider](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider)
class derives from several other classes that provided different provider functionality. A Windows
PowerShell item provider, therefore, must define all of the functionality provided by those classes.

For more information about how to implement functionality for adding session-specific initialization
information and for releasing resources used by the provider, see
[Creating a Basic Windows PowerShell Provider](./creating-a-basic-windows-powershell-provider.md).
However, most providers, including the provider described here, can use the default implementation
of this functionality that is provided by Windows PowerShell.

Before the Windows PowerShell item provider can manipulate the items in the store, it must implement
the methods of the
[System.Management.Automation.Provider.Drivecmdletprovider](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider)
base class to access to the data store. For more information about implementing this class, see
[Creating a Windows PowerShell Drive Provider](./creating-a-windows-powershell-drive-provider.md).

## Checking for Path Validity

When looking for an item of data, the Windows PowerShell runtime furnishes a Windows PowerShell path
to the provider, as defined in the "PSPath Concepts" section of
[How Windows PowerShell Works](/previous-versions/ms714658(v=vs.85)).
An Windows PowerShell item provider must verify the syntactic and semantic validity of any path
passed to it by implementing the
[System.Management.Automation.Provider.Itemcmdletprovider.Isvalidpath*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.IsValidPath)
method. This method returns `true` if the path is valid, and `false` otherwise. Be aware that the
implementation of this method should not verify the existence of the item at the path, but only that
the path is syntactically and semantically correct.

Here is the implementation of the
[System.Management.Automation.Provider.Itemcmdletprovider.Isvalidpath*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.IsValidPath)
method for this provider. Note that this implementation calls a NormalizePath helper method to
convert all separators in the path to a uniform one.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample03/AccessDBProviderSample03.cs" range="274-298":::

## Determining if an Item Exists

After verifying the path, the Windows PowerShell runtime must determine if an item of data exists at
that path. To support this type of query, the Windows PowerShell item provider implements the
[System.Management.Automation.Provider.Itemcmdletprovider.Itemexists*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExists)
method. This method returns `true` an item is found at the specified path and `false` (default)
otherwise.

Here is the implementation of the
[System.Management.Automation.Provider.Itemcmdletprovider.Itemexists*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExists)
method for this provider. Note that this method calls the PathIsDrive, ChunkPath, and GetTable
helper methods, and uses a provider defined DatabaseTableInfo object.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample03/AccessDBProviderSample03.cs" range="229-267":::

#### Things to Remember About Implementing ItemExists

The following conditions may apply to your implementation of
[System.Management.Automation.Provider.Itemcmdletprovider.Itemexists*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExists):

- When defining the provider class, a Windows PowerShell item provider might declare provider
  capabilities of ExpandWildcards, Filter, Include, or Exclude, from the
  [System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
  enumeration. In these cases, the implementation of the
  [System.Management.Automation.Provider.Itemcmdletprovider.Itemexists*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExists)
  method must ensure that the path passed to the method meets the requirements of the specified
  capabilities. To do this, the method should access the appropriate property, for example, the
  [System.Management.Automation.Provider.Cmdletprovider.Exclude*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Exclude)
  and
  [System.Management.Automation.Provider.Cmdletprovider.Include*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Include)
  properties.

- The implementation of this method should handle any form of access to the item that might make the
  item visible to the user. For example, if a user has write access to a file through the FileSystem
  provider (supplied by Windows PowerShell), but not read access, the file still exists and
  [System.Management.Automation.Provider.Itemcmdletprovider.Itemexists*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExists)
  returns `true`. Your implementation might require checking a parent item to see if the child item
  can be enumerated.

## Attaching Dynamic Parameters to the Test-Path Cmdlet

Sometimes the `Test-Path` cmdlet that calls
[System.Management.Automation.Provider.Itemcmdletprovider.Itemexists*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExists)
requires additional parameters that are specified dynamically at runtime. To provide these dynamic
parameters the Windows PowerShell item provider must implement the
[System.Management.Automation.Provider.Itemcmdletprovider.Itemexistsdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExistsDynamicParameters)
method. This method retrieves the dynamic parameters for the item at the indicated path and returns
an object that has properties and fields with parsing attributes similar to a cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object. The Windows PowerShell runtime uses the returned object to add the parameters to the
`Test-Path` cmdlet.

This Windows PowerShell item provider does not implement this method. However, the following code is the default implementation of this method.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testprovideritemexistdynamicparameters](Msh_samplestestcmdlets#testprovideritemexistdynamicparameters)]  -->

## Retrieving an Item

To retrieve an item, the Windows PowerShell item provider must override
[System.Management.Automation.Provider.Itemcmdletprovider.Getitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItem)
method to support calls from the `Get-Item` cmdlet. This method writes the item using the
[System.Management.Automation.Provider.Cmdletprovider.Writeitemobject*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.WriteItemObject)
method.

Here is the implementation of the [System.Management.Automation.Provider.Itemcmdletprovider.Getitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItem) method for this provider. Note that this method uses the GetTable and GetRow helper methods to retrieve items that are either tables in the Access database or rows in a data table.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample03/AccessDBProviderSample03.cs" range="132-163":::

#### Things to Remember About Implementing GetItem

The following conditions may apply to an implementation of
[System.Management.Automation.Provider.Itemcmdletprovider.Getitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItem):

- When defining the provider class, a Windows PowerShell item provider might declare provider
  capabilities of ExpandWildcards, Filter, Include, or Exclude, from the
  [System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
  enumeration. In these cases, the implementation of
  [System.Management.Automation.Provider.Itemcmdletprovider.Getitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItem)
  must ensure that the path passed to the method meets those requirements. To do this, the method
  should access the appropriate property, for example, the
  [System.Management.Automation.Provider.Cmdletprovider.Exclude*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Exclude)
  and
  [System.Management.Automation.Provider.Cmdletprovider.Include*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Include)
  properties.

- By default, overrides of this method should not retrieve objects that are generally hidden from
  the user unless the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property is set to `true`. For example, the
  [System.Management.Automation.Provider.Itemcmdletprovider.Getitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItem)
  method for the FileSystem provider checks the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property before it attempts to call
  [System.Management.Automation.Provider.Cmdletprovider.Writeitemobject*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.WriteItemObject)
  for hidden or system files.

## Attaching Dynamic Parameters to the Get-Item Cmdlet

Sometimes the `Get-Item` cmdlet requires additional parameters that are specified dynamically at
runtime. To provide these dynamic parameters the Windows PowerShell item provider must implement the
[System.Management.Automation.Provider.Itemcmdletprovider.Getitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItemDynamicParameters)
method. This method retrieves the dynamic parameters for the item at the indicated path and returns
an object that has properties and fields with parsing attributes similar to a cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object. The Windows PowerShell runtime uses the returned object to add the parameters to the
`Get-Item` cmdlet.

This provider does not implement this method. However, the following code is the default implementation of this method.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testprovidergetitemdynamicparameters](Msh_samplestestcmdlets#testprovidergetitemdynamicparameters)]  -->

## Setting an Item

To set an item, the Windows PowerShell item provider must override the
[System.Management.Automation.Provider.Itemcmdletprovider.Setitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItem)
method to support calls from the `Set-Item` cmdlet. This method sets the value of the item at the
specified path.

This provider does not provide an override for the  [System.Management.Automation.Provider.Itemcmdletprovider.Setitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItem) method. However, the following is the default implementation of this method.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testprovidersetitem](Msh_samplestestcmdlets#testprovidersetitem)]  -->

#### Things to Remember About Implementing SetItem

The following conditions may apply to your implementation of
[System.Management.Automation.Provider.Itemcmdletprovider.Setitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItem):

- When defining the provider class, a Windows PowerShell item provider might declare provider
  capabilities of ExpandWildcards, Filter, Include, or Exclude, from the
  [System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
  enumeration. In these cases, the implementation of
  [System.Management.Automation.Provider.Itemcmdletprovider.Setitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItem)
  must ensure that the path passed to the method meets those requirements. To do this, the method
  should access the appropriate property, for example, the
  [System.Management.Automation.Provider.Cmdletprovider.Exclude*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Exclude)
  and
  [System.Management.Automation.Provider.Cmdletprovider.Include*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Include)
  properties.

- By default, overrides of this method should not set or write objects that are hidden from the user
  unless the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property is set to `true`. An error should be sent to the
  [System.Management.Automation.Provider.Cmdletprovider.WriteError](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.WriteError)
  method if the path represents a hidden item and
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  is set to `false`.

- Your implementation of the
  [System.Management.Automation.Provider.Itemcmdletprovider.Setitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItem)
  method should call
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  and verify its return value before making any changes to the data store. This method is used to
  confirm execution of an operation when a change is made to the data store, for example, deleting
  files. The
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  method sends the name of the resource to be changed to the user, with the Windows PowerShell
  runtime taking into account any command-line settings or preference variables in determining what
  should be displayed.

  After the call to
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  returns `true`, the
  [System.Management.Automation.Provider.Itemcmdletprovider.Setitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItem)
  method should call the
  [System.Management.Automation.Provider.Cmdletprovider.ShouldContinue](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldContinue)
  method. This method sends a message to the user to allow feedback to verify if the operation
  should be continued. The call to
  [System.Management.Automation.Provider.Cmdletprovider.ShouldContinue](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldContinue)
  allows an additional check for potentially dangerous system modifications.

## Retrieving Dynamic Parameters for SetItem

Sometimes the `Set-Item` cmdlet requires additional parameters that are specified dynamically at
runtime. To provide these dynamic parameters the Windows PowerShell item provider must implement the
[System.Management.Automation.Provider.Itemcmdletprovider.Setitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItemDynamicParameters)
method. This method retrieves the dynamic parameters for the item at the indicated path and returns
an object that has properties and fields with parsing attributes similar to a cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object. The Windows PowerShell runtime uses the returned object to add the parameters to the
`Set-Item` cmdlet.

This provider does not implement this method. However, the following code is the default implementation of this method.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testprovidersetitemdynamicparameters](Msh_samplestestcmdlets#testprovidersetitemdynamicparameters)]  -->

## Clearing an Item

To clear an item, the Windows PowerShell item provider implements the
[System.Management.Automation.Provider.Itemcmdletprovider.Clearitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ClearItem)
method to support calls from the `Clear-Item` cmdlet. This method erases the data item at the
specified path.

This provider does not implement this method. However, the following code is the default implementation of this method.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testproviderclearitem](Msh_samplestestcmdlets#testproviderclearitem)]  -->

#### Things to Remember About Implementing ClearItem

The following conditions may apply to an implementation of
[System.Management.Automation.Provider.Itemcmdletprovider.Clearitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ClearItem):

- When defining the provider class, a Windows PowerShell item provider might declare provider
  capabilities of ExpandWildcards, Filter, Include, or Exclude, from the
  [System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
  enumeration. In these cases, the implementation of
  [System.Management.Automation.Provider.Itemcmdletprovider.Clearitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ClearItem)
  must ensure that the path passed to the method meets those requirements. To do this, the method
  should access the appropriate property, for example, the
  [System.Management.Automation.Provider.Cmdletprovider.Exclude*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Exclude)
  and
  [System.Management.Automation.Provider.Cmdletprovider.Include*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Include)
  properties.

- By default, overrides of this method should not set or write objects that are hidden from the user
  unless the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property is set to `true`. An error should be sent to the
  [System.Management.Automation.Provider.Cmdletprovider.WriteError](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.WriteError)
  method if the path represents an item that is hidden from the user and
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  is set to `false`.

- Your implementation of the
  [System.Management.Automation.Provider.Itemcmdletprovider.Setitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItem)
  method should call
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  and verify its return value before making any changes to the data store. This method is used to
  confirm execution of an operation when a change is made to the data store, for example, deleting
  files. The
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  method sends the name of the resource to be changed to the user, with the Windows PowerShell
  runtime and handle any command-line settings or preference variables in determining what should be
  displayed.

  After the call to
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  returns `true`, the
  [System.Management.Automation.Provider.Itemcmdletprovider.Setitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItem)
  method should call the
  [System.Management.Automation.Provider.Cmdletprovider.ShouldContinue](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldContinue)
  method. This method sends a message to the user to allow feedback to verify if the operation
  should be continued. The call to
  [System.Management.Automation.Provider.Cmdletprovider.ShouldContinue](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldContinue)
  allows an additional check for potentially dangerous system modifications.

## Retrieve Dynamic Parameters for ClearItem

Sometimes the `Clear-Item` cmdlet requires additional parameters that are specified dynamically at
runtime. To provide these dynamic parameters the Windows PowerShell item provider must implement the
[System.Management.Automation.Provider.Itemcmdletprovider.Clearitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ClearItemDynamicParameters)
method. This method retrieves the dynamic parameters for the item at the indicated path and returns
an object that has properties and fields with parsing attributes similar to a cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object. The Windows PowerShell runtime uses the returned object to add the parameters to the
`Clear-Item` cmdlet.

This item provider does not implement this method. However, the following code is the default implementation of this method.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testproviderclearitemdynamicparameters](Msh_samplestestcmdlets#testproviderclearitemdynamicparameters)]  -->

## Performing a Default Action for an Item

A Windows PowerShell item provider can implement the
[System.Management.Automation.Provider.Itemcmdletprovider.Invokedefaultaction*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.InvokeDefaultAction)
method to support calls from the `Invoke-Item` cmdlet, which allows the provider to perform a
default action for the item at the specified path. For example, the FileSystem provider might use
this method to call ShellExecute for a specific item.

This provider does not implement this method. However, the following code is the default implementation of this method.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testproviderinvokedefaultaction](Msh_samplestestcmdlets#testproviderinvokedefaultaction)]  -->

#### Things to Remember About Implementing InvokeDefaultAction

The following conditions may apply to an implementation of
[System.Management.Automation.Provider.Itemcmdletprovider.Invokedefaultaction*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.InvokeDefaultAction):

- When defining the provider class, a Windows PowerShell item provider might declare provider
  capabilities of ExpandWildcards, Filter, Include, or Exclude, from the
  [System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
  enumeration. In these cases, the implementation of
  [System.Management.Automation.Provider.Itemcmdletprovider.Invokedefaultaction*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.InvokeDefaultAction)
  must ensure that the path passed to the method meets those requirements. To do this, the method
  should access the appropriate property, for example, the
  [System.Management.Automation.Provider.Cmdletprovider.Exclude*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Exclude)
  and
  [System.Management.Automation.Provider.Cmdletprovider.Include*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Include)
  properties.

- By default, overrides of this method should not set or write objects hidden from the user unless
  the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property is set to `true`. An error should be sent to the
  [System.Management.Automation.Provider.Cmdletprovider.WriteError](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.WriteError)
  method if the path represents an item that is hidden from the user and
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  is set to `false`.

## Retrieve Dynamic Parameters for InvokeDefaultAction

Sometimes the `Invoke-Item` cmdlet requires additional parameters that are specified dynamically at
runtime. To provide these dynamic parameters the Windows PowerShell item provider must implement the
[System.Management.Automation.Provider.Itemcmdletprovider.Invokedefaultactiondynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.InvokeDefaultActionDynamicParameters)
method. This method retrieves the dynamic parameters for the item at the indicated path and returns
an object that has properties and fields with parsing attributes similar to a cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object. The Windows PowerShell runtime uses the returned object to add the dynamic parameters to the
`Invoke-Item` cmdlet.

This item provider does not implement this method. However, the following code is the default
implementation of this method.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testproviderinvokedefaultactiondynamicparameters](Msh_samplestestcmdlets#testproviderinvokedefaultactiondynamicparameters)]  -->

## Implementing Helper Methods and Classes

This item provider implements several helper methods and classes that are used by the public
override methods defined by Windows PowerShell. The code for these helper methods and classes are
shown in the [Code Sample](#code-sample) section.

### NormalizePath Method

This item provider implements a NormalizePath helper method to ensure that the path has a consistent
format. The format specified uses a backslash (\\) as a separator.

### PathIsDrive Method

This item provider implements a PathIsDrive helper method to determine if the specified path is
actually the drive name.

### ChunkPath Method

This item provider implements a ChunkPath helper method that breaks up the specified path so that
the provider can identify its individual elements. It returns an array composed of the path
elements.

### GetTable Method

This item provider implements the GetTables helper method that returns a DatabaseTableInfo object
that represents information about the table specified in the call.

### GetRow Method

The
[System.Management.Automation.Provider.Itemcmdletprovider.Getitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItem)
method of this item provider calls the GetRows helper method. This helper method retrieves a
DatabaseRowInfo object that represents information about the specified row in the table.

### DatabaseTableInfo Class

This item provider defines a DatabaseTableInfo class that represents a collection of information in
a data table in the database. This class is similar to the
[System.IO.Directoryinfo](/dotnet/api/System.IO.DirectoryInfo) class.

The sample item provider defines a DatabaseTableInfo.GetTables method that returns a collection of
table information objects defining the tables in the database. This method includes a try/catch
block to ensure that any database error shows up as a row with zero entries.

### DatabaseRowInfo Class

This item provider defines the DatabaseRowInfo helper class that represents a row in a table of the
database. This class is similar to the [System.IO.FileInfo](/dotnet/api/System.IO.FileInfo) class.

The sample provider defines a DatabaseRowInfo.GetRows method to return a collection of row
information objects for the specified table. This method includes a try/catch block to trap
exceptions. Any errors will result in no row information.

## Code Sample

For complete sample code, see [AccessDbProviderSample03 Code Sample](./accessdbprovidersample03-code-sample.md).

## Defining Object Types and Formatting

When writing a provider, it may be necessary to add members to existing objects or define new
objects. When finished, create a Types file that Windows PowerShell can use to identify the members
of the object and a Format file that defines how the object is displayed. For more information about
, see
[Extending Object Types and Formatting](/previous-versions/ms714665(v=vs.85)).

## Building the Windows PowerShell provider

See [How to Register Cmdlets, Providers, and Host Applications](/previous-versions/ms714644(v=vs.85)).

## Testing the Windows PowerShell provider

When this Windows PowerShell item provider is registered with Windows PowerShell, you can only test
the basic and drive functionality of the provider. To test the manipulation of items, you must also
implement container functionality described in
[Implementing a Container Windows PowerShell Provider](./creating-a-windows-powershell-container-provider.md).

## See Also

[Windows PowerShell SDK](../windows-powershell-reference.md)

[Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)

[Creating Windows PowerShell Providers](./how-to-create-a-windows-powershell-provider.md)

[Designing Your Windows PowerShell provider](./designing-your-windows-powershell-provider.md)

[Extending Object Types and Formatting](/previous-versions/ms714665(v=vs.85))

[How Windows PowerShell Works](/previous-versions/ms714658(v=vs.85))

[Creating a Container Windows PowerShell provider](./creating-a-windows-powershell-container-provider.md)

[Creating a Drive Windows PowerShell provider](./creating-a-windows-powershell-drive-provider.md)

[How to Register Cmdlets, Providers, and Host Applications](/previous-versions/ms714644(v=vs.85))
