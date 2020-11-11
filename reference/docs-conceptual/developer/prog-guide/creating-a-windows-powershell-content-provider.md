---
ms.date: 09/13/2016
ms.topic: reference
title: Creating a Windows PowerShell Content Provider
description: Creating a Windows PowerShell Content Provider
---
# Creating a Windows PowerShell Content Provider

This topic describes how to create a Windows PowerShell provider that enables the user to manipulate
the contents of the items in a data store. As a consequence, a provider that can manipulate the
contents of items is referred to as a Windows PowerShell content provider.

> [!NOTE]
> You can download the C# source file (AccessDBSampleProvider06.cs) for this provider using the
> Microsoft Windows Software Development Kit for Windows Vista and .NET Framework 3.0 Runtime
> Components. For download instructions, see
> [How to Install Windows PowerShell and Download the Windows PowerShell SDK](/powershell/scripting/developer/installing-the-windows-powershell-sdk).
> The downloaded source files are available in the **\<PowerShell Samples>** directory. For more
> information about other Windows PowerShell provider implementations, see
> [Designing Your Windows PowerShell Provider](./designing-your-windows-powershell-provider.md).

## Define the Windows PowerShell Content Provider Class

A Windows PowerShell content provider must create a .NET class that supports the
[System.Management.Automation.Provider.Icontentcmdletprovider](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider)
interface. Here is the class definition for the item provider described in this section.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample06/AccessDBProviderSample06.cs" range="32-33":::

Note that in this class definition, the
[System.Management.Automation.Provider.Cmdletproviderattribute](/dotnet/api/System.Management.Automation.Provider.CmdletProviderAttribute)
attribute includes two parameters. The first parameter specifies a user-friendly name for the
provider that is used by Windows PowerShell. The second parameter specifies the Windows PowerShell
specific capabilities that the provider exposes to the Windows PowerShell runtime during command
processing. For this provider, there are no added Windows PowerShell specific capabilities.

## Define Functionality of Base Class

As described in
[Design Your Windows PowerShell Provider](./designing-your-windows-powershell-provider.md), the
[System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider)
class derives from several other classes that provided different provider functionality. A Windows
PowerShell content provider, therefore, typically defines all of the functionality provided by those
classes.

For more information about how to implement functionality for adding session-specific initialization
information and for releasing resources that are used by the provider, see
[Creating a Basic Windows PowerShell Provider](./creating-a-basic-windows-powershell-provider.md).
However, most providers, including the provider described here, can use the default implementation
of this functionality that is provided by Windows PowerShell.

To access the data store, the provider must implement the methods of the
[System.Management.Automation.Provider.Drivecmdletprovider](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider)
base class. For more information about implementing these methods, see
[Creating a Windows PowerShell Drive Provider](./creating-a-windows-powershell-drive-provider.md).

To manipulate the items of a data store, such as getting, setting, and clearing items, the provider
must implement the methods provided by the
[System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider)
base class. For more information about implementing these methods, see
[Creating a Windows PowerShell Item Provider](./creating-a-windows-powershell-item-provider.md).

To work on multi-layer data stores, the provider must implement the methods provided by the
[System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider)
base class. For more information about implementing these methods, see
[Creating a Windows PowerShell Container Provider](./creating-a-windows-powershell-container-provider.md).

To support recursive commands, nested containers, and relative paths, the provider must implement
the
[System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider)
base class. In addition, this Windows PowerShell content provider can attaches
[System.Management.Automation.Provider.Icontentcmdletprovider](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider)
interface to the
[System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider)
base class, and must therefore implement the methods provided by that class. For more information,
see implementing those methods, see
[Implement a Navigation Windows PowerShell Provider](./creating-a-windows-powershell-navigation-provider.md).

## Implementing a Content Reader

To read content from an item, a provider must implements a content reader class that derives from
[System.Management.Automation.Provider.Icontentreader](/dotnet/api/System.Management.Automation.Provider.IContentReader).
The content reader for this provider allows access to the contents of a row in a data table. The
content reader class defines a **Read** method that retrieves the data from the indicated row and
returns a list representing that data, a **Seek** method that moves the content reader, a **Close**
method that closes the content reader, and a **Dispose** method.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample06/AccessDBProviderSample06.cs" range="2115-2241":::

## Implementing a Content Writer

To write content to an item, a provider must implement a content writer class derives from
[System.Management.Automation.Provider.Icontentwriter](/dotnet/api/System.Management.Automation.Provider.IContentWriter).
The content writer class defines a **Write** method that writes the specified row content, a
**Seek** method that moves the content writer, a **Close** method that closes the content writer,
and a **Dispose** method.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample06/AccessDBProviderSample06.cs" range="2250-2394":::

## Retrieving the Content Reader

To get content from an item, the provider must implement the
[System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentreader*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentReader)
to support the `Get-Content` cmdlet. This method returns the content reader for the item located at
the specified path. The reader object can then be opened to read the content.

Here is the implementation of
[System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentreader*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentReader)
for this method for this provider.

```csharp
public IContentReader GetContentReader(string path)
{
    string tableName;
    int rowNumber;

    PathType type = GetNamesFromPath(path, out tableName, out rowNumber);

    if (type == PathType.Invalid)
    {
        ThrowTerminatingInvalidPathException(path);
    }
    else if (type == PathType.Row)
    {
        throw new InvalidOperationException("contents can be obtained only for tables");
    }

    return new AccessDBContentReader(path, this);
} // GetContentReader
```

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample06/AccessDBProviderSample06.cs" range="1829-1846":::

#### Things to Remember About Implementing GetContentReader

The following conditions may apply to an implementation of
[System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentreader*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentReader):

- When defining the provider class, a Windows PowerShell content provider might declare provider
  capabilities of ExpandWildcards, Filter, Include, or Exclude, from the
  [System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
  enumeration. In these cases, the implementation of the
  [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentreader*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentReader)
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

## Attaching Dynamic Parameters to the Get-Content Cmdlet

The `Get-Content` cmdlet might require additional parameters that are specified dynamically at
runtime. To provide these dynamic parameters, the Windows PowerShell content provider must implement
the
[System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentreaderdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentReaderDynamicParameters)
method. This method retrieves dynamic parameters for the item at the indicated path and returns an
object that has properties and fields with parsing attributes similar to a cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object. The Windows PowerShell runtime uses the returned object to add the parameters to the cmdlet.

This Windows PowerShell container provider does not implement this method. However, the following
code is the default implementation of this method.

```csharp
public object GetContentReaderDynamicParameters(string path)
{
    return null;
}
```

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample06/AccessDBProviderSample06.cs" range="1853-1856":::

## Retrieving the Content Writer

To write content to an item, the provider must implement the
[System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentwriter*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriter)
to support the `Set-Content` and `Add-Content` cmdlets. This method returns the content writer for
the item located at the specified path.

Here is the implementation of
[System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentwriter*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriter)
for this method.

```csharp
public IContentWriter GetContentWriter(string path)
{
    string tableName;
    int rowNumber;

    PathType type = GetNamesFromPath(path, out tableName, out rowNumber);

    if (type == PathType.Invalid)
    {
        ThrowTerminatingInvalidPathException(path);
    }
    else if (type == PathType.Row)
    {
        throw new InvalidOperationException("contents can be added only to tables");
    }

    return new AccessDBContentWriter(path, this);
}
```

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample06/AccessDBProviderSample06.cs" range="1863-1880":::

#### Things to Remember About Implementing GetContentWriter

The following conditions may apply to your implementation of
[System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentwriter*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriter):

- When defining the provider class, a Windows PowerShell content provider might declare provider
  capabilities of ExpandWildcards, Filter, Include, or Exclude, from the
  [System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
  enumeration. In these cases, the implementation of the
  [System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentwriter*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriter)
  method must ensure that the path passed to the method meets the requirements of the specified
  capabilities. To do this, the method should access the appropriate property, for example, the
  [System.Management.Automation.Provider.Cmdletprovider.Exclude*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Exclude)
  and
  [System.Management.Automation.Provider.Cmdletprovider.Include*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Include)
  properties.

- By default, overrides of this method should not retrieve a writer for objects that are hidden from
  the user unless the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property is set to `true`. An error should be written if the path represents an item that is
  hidden from the user and
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  is set to `false`.

## Attaching Dynamic Parameters to the Add-Content and Set-Content Cmdlets

The `Add-Content` and `Set-Content` cmdlets might require additional dynamic parameters that are
added a runtime. To provide these dynamic parameters, the Windows PowerShell content provider must
implement the
[System.Management.Automation.Provider.Icontentcmdletprovider.Getcontentwriterdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriterDynamicParameters)
method to handle these parameters. This method retrieves dynamic parameters for the item at the
indicated path and returns an object that has properties and fields with parsing attributes similar
to a cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object. The Windows PowerShell runtime uses the returned object to add the parameters to the
cmdlets.

This Windows PowerShell container provider does not implement this method. However, the following
code is the default implementation of this method.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample06/AccessDBProviderSample06.cs" range="1887-1890":::

## Clearing Content

Your content provider implements the
[System.Management.Automation.Provider.Icontentcmdletprovider.Clearcontent*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.ClearContent)
method in support of the `Clear-Content` cmdlet. This method removes the contents of the item at the
specified path, but leaves the item intact.

Here is the implementation of the
[System.Management.Automation.Provider.Icontentcmdletprovider.Clearcontent*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.ClearContent)
method for this provider.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample06/AccessDBProviderSample06.cs" range="1775-1812":::

#### Things to Remember About Implementing ClearContent

The following conditions may apply to an implementation of
[System.Management.Automation.Provider.Icontentcmdletprovider.Clearcontent*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.ClearContent):

- When defining the provider class, a Windows PowerShell content provider might declare provider
  capabilities of ExpandWildcards, Filter, Include, or Exclude, from the
  [System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
  enumeration. In these cases, the implementation of the
  [System.Management.Automation.Provider.Icontentcmdletprovider.Clearcontent*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.ClearContent)
  method must ensure that the path passed to the method meets the requirements of the specified
  capabilities. To do this, the method should access the appropriate property, for example, the
  [System.Management.Automation.Provider.Cmdletprovider.Exclude*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Exclude)
  and
  [System.Management.Automation.Provider.Cmdletprovider.Include*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Include)
  properties.

- By default, overrides of this method should not clear the contents of objects that are hidden from
  the user unless the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property is set to `true`. An error should be written if the path represents an item that is
  hidden from the user and
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  is set to `false`.

- Your implementation of the
  [System.Management.Automation.Provider.Icontentcmdletprovider.Clearcontent*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.ClearContent)
  method should call
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  and verify its return value before making any changes to the data store. This method is used to
  confirm execution of an operation when a change is made to the data store, such as clearing
  content. The
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  method sends the name of the resource to be changed to the user, with the Windows PowerShell
  runtime handling any command-line settings or preference variables in determining what should be
  displayed.

  After the call to
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  returns `true`, the
  [System.Management.Automation.Provider.Icontentcmdletprovider.Clearcontent*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.ClearContent)
  method should call the
  [System.Management.Automation.Provider.Cmdletprovider.ShouldContinue](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldContinue)
  method. This method sends a message to the user to allow feedback to verify if the operation
  should be continued. The call to
  [System.Management.Automation.Provider.Cmdletprovider.ShouldContinue](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldContinue)
  allows an additional check for potentially dangerous system modifications.

## Attaching Dynamic Parameters to the Clear-Content Cmdlet

The `Clear-Content` cmdlet might require additional dynamic parameters that are added at runtime. To
provide these dynamic parameters, the Windows PowerShell content provider must implement the
[System.Management.Automation.Provider.Icontentcmdletprovider.Clearcontentdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.IContentCmdletProvider.ClearContentDynamicParameters)
method to handle these parameters. This method retrieves the parameters for the item at the
indicated path. This method retrieves dynamic parameters for the item at the indicated path and
returns an object that has properties and fields with parsing attributes similar to a cmdlet class
or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object. The Windows PowerShell runtime uses the returned object to add the parameters to the cmdlet.

This Windows PowerShell container provider does not implement this method. However, the following code is the default implementation of this method.

```csharp
public object ClearContentDynamicParameters(string path)
{
    return null;
}
```

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample06/AccessDBProviderSample06.cs" range="1819-1822":::

## Code Sample

For complete sample code, see [AccessDbProviderSample06 Code Sample](./accessdbprovidersample06-code-sample.md).

## Defining Object Types and Formatting

When writing a provider, it may be necessary to add members to existing objects or define new
objects. When this is done, you must create a Types file that Windows PowerShell can use to identify
the members of the object and a Format file that defines how the object is displayed. For more
information, see
[Extending Object Types and Formatting](/previous-versions/ms714665(v=vs.85)).

## Building the Windows PowerShell Provider

See [How to Register Cmdlets, Providers, and Host Applications](/previous-versions/ms714644(v=vs.85)).

## Testing the Windows PowerShell Provider

When your Windows PowerShell provider has been registered with Windows PowerShell, you can test it
by running the supported cmdlets on the command line. For example, test the sample content provider.

Use the `Get-Content` cmdlet to retrieve the contents of specified item in the database table at the
path specified by the `Path` parameter. The `ReadCount` parameter specifies the number of items for
the defined content reader to read (default 1). With the following command entry, the cmdlet
retrieves two rows (items) from the table and displays their contents. Note that the following
example output uses a fictitious Access database.

```powershell
Get-Content -Path mydb:\Customers -ReadCount 2
```

```Output
ID        : 1
FirstName : Eric
LastName  : Gruber
Email     : ericgruber@fabrikam.com
Title     : President
Company   : Fabrikam
WorkPhone : (425) 555-0100
Address   : 4567 Main Street
City      : Buffalo
State     : NY
Zip       : 98052
Country   : USA
ID        : 2
FirstName : Eva
LastName  : Corets
Email     : evacorets@cohowinery.com
Title     : Sales Representative
Company   : Coho Winery
WorkPhone : (360) 555-0100
Address   : 8910 Main Street
City      : Cabmerlot
State     : WA
Zip       : 98089
Country   : USA
```

## See Also

[Creating Windows PowerShell providers](./how-to-create-a-windows-powershell-provider.md)

[Design Your Windows PowerShell provider](./designing-your-windows-powershell-provider.md)

[Extending Object Types and Formatting](/previous-versions//ms714665(v=vs.85))

[Implement a Navigation Windows PowerShell provider](./creating-a-windows-powershell-navigation-provider.md)

[How to Register Cmdlets, Providers, and Host Applications](/previous-versions/ms714644(v=vs.85))

[Windows PowerShell SDK](../windows-powershell-reference.md)

[Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)
