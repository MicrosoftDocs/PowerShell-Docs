---
ms.date: 09/13/2016
ms.topic: reference
title: Creating a Windows PowerShell Container Provider
description: Creating a Windows PowerShell Container Provider
---
# Creating a Windows PowerShell Container Provider

This topic describes how to create a Windows PowerShell provider that can work on multi-layer data
stores. For this type of data store, the top level of the store contains the root items and each
subsequent level is referred to as a node of child items. By allowing the user to work on these
child nodes, a user can interact hierarchically through the data store.

Providers that can work on multi-level data stores are referred to as Windows PowerShell container
providers. However, be aware that a Windows PowerShell container provider can be used only when
there is one container (no nested containers) with items in it. If there are nested containers, then
you must implement a Windows PowerShell navigation provider. For more information about implementing
Windows PowerShell navigation provider, see
[Creating a Windows PowerShell Navigation Provider](./creating-a-windows-powershell-navigation-provider.md).

> [!NOTE]
> You can download the C# source file (AccessDBSampleProvider04.cs) for this provider using the
> Microsoft Windows Software Development Kit for Windows Vista and .NET Framework 3.0 Runtime
> Components. For download instructions, see
> [How to Install Windows PowerShell and Download the Windows PowerShell SDK](/powershell/scripting/developer/installing-the-windows-powershell-sdk).
> The downloaded source files are available in the **\<PowerShell Samples>** directory. For more
> information about other Windows PowerShell provider implementations, see
> [Designing Your Windows PowerShell Provider](./designing-your-windows-powershell-provider.md).

The Windows PowerShell container provider described here defines the database as its single
container, with the tables and rows of the database defined as items of the container.

> [!CAUTION]
> Be aware that this design assumes a database that has a field with the name ID, and that the type
> of the field is LongInteger.

## Defining a Windows PowerShell Container Provider Class

A Windows PowerShell container provider must define a .NET class that derives from the
[System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider)
base class. Here is the class definition for the Windows PowerShell container provider described in
this section.

```csharp
[CmdletProvider("AccessDB", ProviderCapabilities.None)]
public class AccessDBProvider : ContainerCmdletProvider
```

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample04/AccessDBProviderSample04.cs" range="34-35":::

Notice that in this class definition, the
[System.Management.Automation.Provider.Cmdletproviderattribute](/dotnet/api/System.Management.Automation.Provider.CmdletProviderAttribute)
attribute includes two parameters. The first parameter specifies a user-friendly name for the
provider that is used by Windows PowerShell. The second parameter specifies the Windows PowerShell
specific capabilities that the provider exposes to the Windows PowerShell runtime during command
processing. For this provider, there are no Windows PowerShell specific capabilities that are added.

## Defining Base Functionality

As described in
[Designing Your Windows PowerShell Provider](./designing-your-windows-powershell-provider.md), the
[System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider)
class derives from several other classes that provided different provider functionality. A Windows
PowerShell container provider, therefore, needs to define all of the functionality provided by those
classes.

To implement functionality for adding session-specific initialization information and for releasing
resources that are used by the provider, see
[Creating a Basic Windows PowerShell Provider](./creating-a-basic-windows-powershell-provider.md).
However, most providers (including the provider described here) can use the default implementation
of this functionality that is provided by Windows PowerShell.

To get access to the data store, the provider must implement the methods of the
[System.Management.Automation.Provider.Drivecmdletprovider](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider)
base class. For more information about implementing these methods, see
[Creating an Windows PowerShell Drive Provider](./creating-a-windows-powershell-drive-provider.md).

To manipulate the items of a data store, such as getting, setting, and clearing items, the provider
must implement the methods provided by the
[System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider)
base class. For more information about implementing these methods, see
[Creating an Windows PowerShell Item Provider](./creating-a-windows-powershell-item-provider.md).

## Retrieving Child Items

To retrieve a child item, the Windows PowerShell container provider must override the
[System.Management.Automation.Provider.Containercmdletprovider.Getchilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems)
method to support calls from the `Get-ChildItem` cmdlet. This method retrieves child items from the
data store and writes them to the pipeline as objects. If the `recurse` parameter of the cmdlet is
specified, the method retrieves all children regardless of what level they are at. If the `recurse`
parameter is not specified, the method retrieves only a single level of children.

Here is the implementation of the
[System.Management.Automation.Provider.Containercmdletprovider.Getchilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems)
method for this provider. Notice that this method retrieves the child items in all database tables
when the path indicates the Access database, and retrieves the child items from the rows of that
table if the path indicates a data table.

```csharp
protected override void GetChildItems(string path, bool recurse)
{
    // If path represented is a drive then the children in the path are
    // tables. Hence all tables in the drive represented will have to be
    // returned
    if (PathIsDrive(path))
    {
        foreach (DatabaseTableInfo table in GetTables())
        {
            WriteItemObject(table, path, true);

            // if the specified item exists and recurse has been set then
            // all child items within it have to be obtained as well
            if (ItemExists(path) && recurse)
            {
                GetChildItems(path + pathSeparator + table.Name, recurse);
            }
        } // foreach (DatabaseTableInfo...
    } // if (PathIsDrive...
    else
    {
        // Get the table name, row number and type of path from the
        // path specified
        string tableName;
        int rowNumber;

        PathType type = GetNamesFromPath(path, out tableName, out rowNumber);

        if (type == PathType.Table)
        {
            // Obtain all the rows within the table
            foreach (DatabaseRowInfo row in GetRows(tableName))
            {
                WriteItemObject(row, path + pathSeparator + row.RowNumber,
                        false);
            } // foreach (DatabaseRowInfo...
        }
        else if (type == PathType.Row)
        {
            // In this case the user has directly specified a row, hence
            // just give that particular row
            DatabaseRowInfo row = GetRow(tableName, rowNumber);
            WriteItemObject(row, path + pathSeparator + row.RowNumber,
                        false);
        }
        else
        {
            // In this case, the path specified is not valid
            ThrowTerminatingInvalidPathException(path);
        }
    } // else
} // GetChildItems
```

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample04/AccessDBProviderSample04.cs" range="311-362":::

#### Things to Remember About Implementing GetChildItems

The following conditions may apply to your implementation of
[System.Management.Automation.Provider.Containercmdletprovider.Getchilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems):

- When defining the provider class, a Windows PowerShell container provider might declare provider
  capabilities of ExpandWildcards, Filter, Include, or Exclude, from the
  [System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
  enumeration. In these cases, the implementation of the
  [System.Management.Automation.Provider.Containercmdletprovider.Getchilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems)
  method needs to ensure that the path passed to the method meets the requirements of the specified
  capabilities. To do this, the method should access the appropriate property, for example, the
  [System.Management.Automation.Provider.Cmdletprovider.Exclude*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Exclude)
  and
  [System.Management.Automation.Provider.Cmdletprovider.Include*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Include)
  properties.

- The implementation of this method should take into account any form of access to the item that
  might make the item visible to the user. For example, if a user has write access to a file through
  the FileSystem provider (supplied by Windows PowerShell), but not read access, the file still
  exists and
  [System.Management.Automation.Provider.Itemcmdletprovider.Itemexists*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExists)
  returns `true`. Your implementation might require the checking of a parent item to see if the
  child can be enumerated.

- When writing multiple items, the
  [System.Management.Automation.Provider.Containercmdletprovider.Getchilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems)
  method can take some time. You can design your provider to write the items using the
  [System.Management.Automation.Provider.Cmdletprovider.Writeitemobject*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.WriteItemObject)
  method one at a time. Using this technique will present the items to the user in a stream.

- Your implementation of
  [System.Management.Automation.Provider.Containercmdletprovider.Getchilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems)
  is responsible for preventing infinite recursion when there are circular links, and the like. An
  appropriate terminating exception should be thrown to reflect such a condition.

## Attaching Dynamic Parameters to the Get-ChildItem Cmdlet

Sometimes the `Get-ChildItem` cmdlet that calls
[System.Management.Automation.Provider.Containercmdletprovider.Getchilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems)
requires additional parameters that are specified dynamically at runtime. To provide these dynamic
parameters, the Windows PowerShell container provider must implement the
[System.Management.Automation.Provider.Containercmdletprovider.Getchilditemsdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItemsDynamicParameters)
method. This method retrieves dynamic parameters for the item at the indicated path and returns an
object that has properties and fields with parsing attributes similar to a cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object. The Windows PowerShell runtime uses the returned object to add the parameters to the
`Get-ChildItem` cmdlet.

This Windows PowerShell container provider does not implement this method. However, the following
code is the default implementation of this method.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testprovidergetchilditemsdynamicparameters](Msh_samplestestcmdlets#testprovidergetchilditemsdynamicparameters)]  -->

## Retrieving Child Item Names

To retrieve the names of child items, the Windows PowerShell container provider must override the
[System.Management.Automation.Provider.Containercmdletprovider.Getchildnames*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildNames)
method to support calls from the `Get-ChildItem` cmdlet when its `Name` parameter is specified. This
method retrieves the names of the child items for the specified path or child item names for all
containers if the `returnAllContainers` parameter of the cmdlet is specified. A child name is the
leaf portion of a path. For example, the child name for the path c:\windows\system32\abc.dll is
"abc.dll". The child name for the directory c:\windows\system32 is "system32".

Here is the implementation of the
[System.Management.Automation.Provider.Containercmdletprovider.Getchildnames*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildNames)
method for this provider. Notice that the method retrieves table names if the specified path
indicates the Access database (drive) and row numbers if the path indicates a table.

```csharp
protected override void GetChildNames(string path,
                            ReturnContainers returnContainers)
{
    // If the path represented is a drive, then the child items are
    // tables. get the names of all the tables in the drive.
    if (PathIsDrive(path))
    {
        foreach (DatabaseTableInfo table in GetTables())
        {
            WriteItemObject(table.Name, path, true);
        } // foreach (DatabaseTableInfo...
    } // if (PathIsDrive...
    else
    {
        // Get type, table name and row number from path specified
        string tableName;
        int rowNumber;

        PathType type = GetNamesFromPath(path, out tableName, out rowNumber);

        if (type == PathType.Table)
        {
            // Get all the rows in the table and then write out the
            // row numbers.
            foreach (DatabaseRowInfo row in GetRows(tableName))
            {
                WriteItemObject(row.RowNumber, path, false);
            } // foreach (DatabaseRowInfo...
        }
        else if (type == PathType.Row)
        {
            // In this case the user has directly specified a row, hence
            // just give that particular row
            DatabaseRowInfo row = GetRow(tableName, rowNumber);

            WriteItemObject(row.RowNumber, path, false);
        }
        else
        {
            ThrowTerminatingInvalidPathException(path);
        }
    } // else
} // GetChildNames
```

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample04/AccessDBProviderSample04.cs" range="369-411":::

#### Things to Remember About Implementing GetChildNames

The following conditions may apply to your implementation of
[System.Management.Automation.Provider.Containercmdletprovider.Getchilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems):

- When defining the provider class, a Windows PowerShell container provider might declare provider
  capabilities of ExpandWildcards, Filter, Include, or Exclude, from the
  [System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
  enumeration. In these cases, the implementation of the
  [System.Management.Automation.Provider.Containercmdletprovider.Getchilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems)
  method needs to ensure that the path passed to the method meets the requirements of the specified
  capabilities. To do this, the method should access the appropriate property, for example, the
  [System.Management.Automation.Provider.Cmdletprovider.Exclude*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Exclude)
  and
  [System.Management.Automation.Provider.Cmdletprovider.Include*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Include)
  properties.

  > [!NOTE]
  > An exception to this rule occurs when the `returnAllContainers` parameter of the cmdlet is
  > specified. In this case, the method should retrieve any child name for a container, even if it
  > does not match the values of the
  > [System.Management.Automation.Provider.Cmdletprovider.Filter*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Filter),
  > [System.Management.Automation.Provider.Cmdletprovider.Include*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Include),
  > or
  > [System.Management.Automation.Provider.Cmdletprovider.Exclude*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Exclude)
  > properties.

- By default, overrides of this method should not retrieve names of objects that are generally
  hidden from the user unless the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property is specified. If the specified path indicates a container, the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property is not required.

- Your implementation of
  [System.Management.Automation.Provider.Containercmdletprovider.Getchildnames*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildNames)
  is responsible for preventing infinite recursion when there are circular links, and the like. An
  appropriate terminating exception should be thrown to reflect such a condition.

## Attaching Dynamic Parameters to the Get-ChildItem Cmdlet (Name)

Sometimes the `Get-ChildItem` cmdlet (with the `Name` parameter) requires additional parameters that
are specified dynamically at runtime. To provide these dynamic parameters, the Windows PowerShell
container provider must implement the
[System.Management.Automation.Provider.Containercmdletprovider.Getchildnamesdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildNamesDynamicParameters)
method. This method retrieves the dynamic parameters for the item at the indicated path and returns
an object that has properties and fields with parsing attributes similar to a cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object. The Windows PowerShell runtime uses the returned object to add the parameters to the
`Get-ChildItem` cmdlet.

This provider does not implement this method. However, the following code is the default
implementation of this method.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testprovidergetchildnamesdynamicparameters](Msh_samplestestcmdlets#testprovidergetchildnamesdynamicparameters)]  -->

## Renaming Items

To rename an item, a Windows PowerShell container provider must override the
[System.Management.Automation.Provider.Containercmdletprovider.Renameitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RenameItem)
method to support calls from the `Rename-Item` cmdlet. This method changes the name of the item at
the specified path to the new name provided. The new name must always be relative to the parent item
(container).

This provider does not override the
[System.Management.Automation.Provider.Containercmdletprovider.Renameitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RenameItem)
method. However, the following is the default implementation.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testproviderrenameitem](Msh_samplestestcmdlets#testproviderrenameitem)]  -->

#### Things to Remember About Implementing RenameItem

The following conditions may apply to your implementation of
[System.Management.Automation.Provider.Containercmdletprovider.Renameitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RenameItem):

- When defining the provider class, a Windows PowerShell container provider might declare provider
  capabilities of ExpandWildcards, Filter, Include, or Exclude, from the
  [System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
  enumeration. In these cases, the implementation of the
  [System.Management.Automation.Provider.Containercmdletprovider.Getchilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems)
  method needs to ensure that the path passed to the method meets the requirements of the specified
  capabilities. To do this, the method should access the appropriate property, for example, the
  [System.Management.Automation.Provider.Cmdletprovider.Exclude*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Exclude)
  and
  [System.Management.Automation.Provider.Cmdletprovider.Include*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Include)
  properties.

- The
  [System.Management.Automation.Provider.Containercmdletprovider.Renameitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RenameItem)
  method is intended for the modification of the name of an item only, and not for move operations.
  Your implementation of the method should write an error if the `newName` parameter contains path
  separators, or might otherwise cause the item to change its parent location.

- By default, overrides of this method should not rename objects unless the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property is specified. If the specified path indicates a container, the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property is not required.

- Your implementation of the
  [System.Management.Automation.Provider.Containercmdletprovider.Renameitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RenameItem)
  method should call
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  and check its return value before making any changes to the data store. This method is used to
  confirm execution of an operation when a change is made to system state, for example, renaming
  files.
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  sends the name of the resource to be changed to the user, with the Windows PowerShell runtime
  taking into account any command line settings or preference variables in determining what should
  be displayed.

  After the call to
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  returns `true`, the
  [System.Management.Automation.Provider.Containercmdletprovider.Renameitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RenameItem)
  method should call the
  [System.Management.Automation.Provider.Cmdletprovider.ShouldContinue](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldContinue)
  method. This method sends a message a confirmation message to the user to allow additional
  feedback to say if the operation should be continued. A provider should call
  [System.Management.Automation.Provider.Cmdletprovider.ShouldContinue](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldContinue)
  as an additional check for potentially dangerous system modifications.

## Attaching Dynamic Parameters to the Rename-Item Cmdlet

Sometimes the `Rename-Item` cmdlet requires additional parameters that are specified dynamically at
runtime. To provide these dynamic parameters, Windows PowerShell container provider must implement
the
[System.Management.Automation.Provider.Containercmdletprovider.Renameitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RenameItemDynamicParameters)
method. This method retrieves the parameters for the item at the indicated path and returns an
object that has properties and fields with parsing attributes similar to a cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object. The Windows PowerShell runtime uses the returned object to add the parameters to the
`Rename-Item` cmdlet.

This container provider does not implement this method. However, the following code is the default
implementation of this method.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testproviderrenameitemdynamicparameters](Msh_samplestestcmdlets#testproviderrenameitemdynamicparameters)]  -->

## Creating New Items

To create new items, a container provider must implement the
[System.Management.Automation.Provider.Containercmdletprovider.Newitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.NewItem)
method to support calls from the `New-Item` cmdlet. This method creates a data item located at the
specified path. The `type` parameter of the cmdlet contains the provider-defined type for the new
item. For example, the FileSystem provider uses a `type` parameter with a value of "file" or
"directory". The `newItemValue` parameter of the cmdlet specifies a provider-specific value for the
new item.

Here is the implementation of the
[System.Management.Automation.Provider.Containercmdletprovider.Newitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.NewItem)
method for this provider.

```csharp
protected override void NewItem( string path, string type, object newItemValue )
{
    // Create the new item here after
    // performing necessary validations
    //
    // WriteItemObject(newItemValue, path, false);

    // Example
    //
    // if (ShouldProcess(path, "new item"))
    // {
    //      // Create a new item and then call WriteObject
    //      WriteObject(newItemValue, path, false);
    // }

} // NewItem
```

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample04/AccessDBProviderSample04.cs" range="939-955":::

#### Things to Remember About Implementing NewItem

The following conditions may apply to your implementation of
[System.Management.Automation.Provider.Containercmdletprovider.Newitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.NewItem):

- The
  [System.Management.Automation.Provider.Containercmdletprovider.Newitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.NewItem)
  method should perform a case-insensitive comparison of the string passed in the `type` parameter.
  It should also allow for least ambiguous matches. For example, for the types "file" and
  "directory", only the first letter is required to disambiguate. If the `type` parameter indicates
  a type your provider cannot create, the
  [System.Management.Automation.Provider.Containercmdletprovider.Newitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.NewItem)
  method should write an ArgumentException with a message indicating the types the provider can
  create.

- For the `newItemValue` parameter, the implementation of the
  [System.Management.Automation.Provider.Containercmdletprovider.Newitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.NewItem)
  method is recommended to accept strings at a minimum. It should also accept the type of object
  that is retrieved by the
  [System.Management.Automation.Provider.Itemcmdletprovider.Getitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItem)
  method for the same path. The
  [System.Management.Automation.Provider.Containercmdletprovider.Newitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.NewItem)
  method can use the
  [System.Management.Automation.Languageprimitives.Convertto*](/dotnet/api/System.Management.Automation.LanguagePrimitives.ConvertTo)
  method to convert types to the desired type.

- Your implementation of the
  [System.Management.Automation.Provider.Containercmdletprovider.Newitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.NewItem)
  method should call
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  and check its return value before making any changes to the data store. After the call to
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  returns true, the
  [System.Management.Automation.Provider.Containercmdletprovider.Newitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.NewItem)
  method should call the
  [System.Management.Automation.Provider.Cmdletprovider.ShouldContinue](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldContinue)
  method as an additional check for potentially dangerous system modifications.

## Attaching Dynamic Parameters to the New-Item Cmdlet

Sometimes the `New-Item` cmdlet requires additional parameters that are specified dynamically at
runtime. To provide these dynamic parameters, the container provider must implement the
[System.Management.Automation.Provider.Containercmdletprovider.Newitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.NewItemDynamicParameters)
method. This method retrieves the parameters for the item at the indicated path and returns an
object that has properties and fields with parsing attributes similar to a cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object. The Windows PowerShell runtime uses the returned object to add the parameters to the
`New-Item` cmdlet.

This provider does not implement this method. However, the following code is the default implementation of this method.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testprovidernewitemdynamicparameters](Msh_samplestestcmdlets#testprovidernewitemdynamicparameters)]  -->

## Removing Items

To remove items, the Windows PowerShell provider must override the
[System.Management.Automation.Provider.Containercmdletprovider.Removeitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItem)
method to support calls from the `Remove-Item` cmdlet. This method deletes an item from the data
store at the specified path. If the `recurse` parameter of the `Remove-Item` cmdlet is set to
`true`, the method removes all child items regardless of their level. If the parameter is set to
`false`, the method removes only a single item at the specified path.

This provider does not support item removal. However, the following code is the default
implementation of
[System.Management.Automation.Provider.Containercmdletprovider.Removeitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItem).

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testproviderremoveitem](Msh_samplestestcmdlets#testproviderremoveitem)]  -->

#### Things to Remember About Implementing RemoveItem

The following conditions may apply to your implementation of
[System.Management.Automation.Provider.Containercmdletprovider.Newitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.NewItem):

- When defining the provider class, a Windows PowerShell container provider might declare provider
  capabilities of ExpandWildcards, Filter, Include, or Exclude, from the
  [System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
  enumeration. In these cases, the implementation of the
  [System.Management.Automation.Provider.Containercmdletprovider.Getchilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems)
  method needs to ensure that the path passed to the method meets the requirements of the specified
  capabilities. To do this, the method should access the appropriate property, for example, the
  [System.Management.Automation.Provider.Cmdletprovider.Exclude*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Exclude)
  and
  [System.Management.Automation.Provider.Cmdletprovider.Include*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Include)
  properties.

- By default, overrides of this method should not remove objects unless the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property is set to true. If the specified path indicates a container, the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property is not required.

- Your implementation of
  [System.Management.Automation.Provider.Containercmdletprovider.Removeitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItem)
  is responsible for preventing infinite recursion when there are circular links, and the like. An
  appropriate terminating exception should be thrown to reflect such a condition.

- Your implementation of the
  [System.Management.Automation.Provider.Containercmdletprovider.Removeitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItem)
  method should call
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  and check its return value before making any changes to the data store. After the call to
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  returns `true`, the
  [System.Management.Automation.Provider.Containercmdletprovider.Removeitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItem)
  method should call the
  [System.Management.Automation.Provider.Cmdletprovider.ShouldContinue](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldContinue)
  method as an additional check for potentially dangerous system modifications.

## Attaching Dynamic Parameters to the Remove-Item Cmdlet

Sometimes the `Remove-Item` cmdlet requires additional parameters that are specified dynamically at
runtime. To provide these dynamic parameters, the container provider must implement the
[System.Management.Automation.Provider.Containercmdletprovider.Removeitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItemDynamicParameters)
method to handle these parameters. This method retrieves the dynamic parameters for the item at the
indicated path and returns an object that has properties and fields with parsing attributes similar
to a cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object. The Windows PowerShell runtime uses the returned object to add the parameters to the
`Remove-Item` cmdlet.

This container provider does not implement this method. However, the following code is the default
implementation of
[System.Management.Automation.Provider.Containercmdletprovider.Removeitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItemDynamicParameters).

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testproviderremoveitemdynamicparameters](Msh_samplestestcmdlets#testproviderremoveitemdynamicparameters)]  -->

## Querying for Child Items

To check to see if child items exist at the specified path, the Windows PowerShell container
provider must override the
[System.Management.Automation.Provider.Containercmdletprovider.Haschilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.HasChildItems)
method. This method returns `true` if the item has children, and `false` otherwise. For a null or
empty path, the method considers any items in the data store to be children and returns `true`.

Here is the override for the
[System.Management.Automation.Provider.Containercmdletprovider.Haschilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.HasChildItems)
method. If there are more than two path parts created by the ChunkPath helper method, the method
returns `false`, since only a database container and a table container are defined. For more
information about this helper method, see the ChunkPath method is discussed in
[Creating a Windows PowerShell Item Provider](./creating-a-windows-powershell-item-provider.md).

```csharp
protected override bool HasChildItems( string path )
{
    return false;
} // HasChildItems
```

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample04/AccessDBProviderSample04.cs" range="1094-1097":::

#### Things to Remember About Implementing HasChildItems

The following conditions may apply to your implementation of
[System.Management.Automation.Provider.Containercmdletprovider.Haschilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.HasChildItems):

- If the container provider exposes a root that contains interesting mount points, the
  implementation of the
  [System.Management.Automation.Provider.Containercmdletprovider.Haschilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.HasChildItems)
  method should return `true` when a null or an empty string is passed in for the path.

## Copying Items

To copy items, the container provider must implement the
[System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem)
method to support calls from the `Copy-Item` cmdlet. This method copies a data item from the
location indicated by the `path` parameter of the cmdlet to the location indicated by the `copyPath`
parameter. If the `recurse` parameter is specified, the method copies all sub-containers. If the
parameter is not specified, the method copies only a single level of items.

This provider does not implement this method. However, the following code is the default implementation of [System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem).

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testprovidercopyitem](Msh_samplestestcmdlets#testprovidercopyitem)]  -->

#### Things to Remember About Implementing CopyItem

The following conditions may apply to your implementation of
[System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem):

- When defining the provider class, a Windows PowerShell container provider might declare provider
  capabilities of ExpandWildcards, Filter, Include, or Exclude, from the
  [System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
  enumeration. In these cases, the implementation of the
  [System.Management.Automation.Provider.Containercmdletprovider.Getchilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems)
  method needs to ensure that the path passed to the method meets the requirements of the specified
  capabilities. To do this, the method should access the appropriate property, for example, the
  [System.Management.Automation.Provider.Cmdletprovider.Exclude*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Exclude)
  and
  [System.Management.Automation.Provider.Cmdletprovider.Include*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Include)
  properties.

- By default, overrides of this method should not copy objects over existing objects unless the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property is set to `true`. For example, the FileSystem provider will not copy c:\temp\abc.txt over
  an existing c:\abc.txt file unless the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property is set to `true`. If the path specified in the `copyPath` parameter exists and indicates
  a container, the
  [System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
  property is not required. In this case,
  [System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem)
  should copy the item indicated by the `path` parameter to the container indicated by the
  `copyPath` parameter as a child.

- Your implementation of
  [System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem)
  is responsible for preventing infinite recursion when there are circular links, and the like. An
  appropriate terminating exception should be thrown to reflect such a condition.

- Your implementation of the
  [System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem)
  method should call
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  and check its return value before making any changes to the data store. After the call to
  [System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
  returns true, the
  [System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem)
  method should call the
  [System.Management.Automation.Provider.Cmdletprovider.ShouldContinue](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldContinue)
  method as an additional check for potentially dangerous system modifications. For more information
  about calling these methods, see [Rename Items](#renaming-items).

## Attaching Dynamic Parameters to the Copy-Item Cmdlet

Sometimes the `Copy-Item` cmdlet requires additional parameters that are specified dynamically at
runtime. To provide these dynamic parameters, the Windows PowerShell container provider must
implement the
[System.Management.Automation.Provider.Containercmdletprovider.Copyitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItemDynamicParameters)
method to handle these parameters. This method retrieves the parameters for the item at the
indicated path and returns an object that has properties and fields with parsing attributes similar
to a cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object. The Windows PowerShell runtime uses the returned object to add the parameters to the
`Copy-Item` cmdlet.

This provider does not implement this method. However, the following code is the default
implementation of
[System.Management.Automation.Provider.Containercmdletprovider.Copyitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItemDynamicParameters).

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testprovidercopyitemdynamicparameters](Msh_samplestestcmdlets#testprovidercopyitemdynamicparameters)]  -->

## Code Sample

For complete sample code, see
[AccessDbProviderSample04 Code Sample](./accessdbprovidersample04-code-sample.md).

## Building the Windows PowerShell Provider

See [How to Register Cmdlets, Providers, and Host Applications](/previous-versions/ms714644(v=vs.85)).

## Testing the Windows PowerShell Provider

When your Windows PowerShell provider has been registered with Windows PowerShell, you can test it
by running the supported cmdlets on the command line. Be aware that the following example output
uses a fictitious Access database.

1. Run the `Get-ChildItem` cmdlet to retrieve the list of child items from a Customers table in the
   Access database.

   ```powershell
   Get-ChildItem mydb:customers
   ```

   The following output appears.

   ```output
   PSPath        : AccessDB::customers
   PSDrive       : mydb
   PSProvider    : System.Management.Automation.ProviderInfo
   PSIsContainer : True
   Data          : System.Data.DataRow
   Name          : Customers
   RowCount      : 91
   Columns       :
   ```

2. Run the `Get-ChildItem` cmdlet again to retrieve the data of a table.

   ```powershell
   (Get-ChildItem mydb:customers).data
   ```

   The following output appears.

   ```output
   TABLE_CAT   : c:\PS\northwind
   TABLE_SCHEM :
   TABLE_NAME  : Customers
   TABLE_TYPE  : TABLE
   REMARKS     :
   ```

3. Now use the `Get-Item` cmdlet to retrieve the items at row 0 in the data table.

   ```powershell
   Get-Item mydb:\customers\0
   ```

   The following output appears.

   ```output
   PSPath        : AccessDB::customers\0
   PSDrive       : mydb
   PSProvider    : System.Management.Automation.ProviderInfo
   PSIsContainer : False
   Data          : System.Data.DataRow
   RowNumber     : 0
   ```

4. Reuse `Get-Item` to retrieve the data for the items in row 0.

   ```powershell
   (Get-Item mydb:\customers\0).data
   ```

   The following output appears.

   ```output
   CustomerID   : 1234
   CompanyName  : Fabrikam
   ContactName  : Eric Gruber
   ContactTitle : President
   Address      : 4567 Main Street
   City         : Buffalo
   Region       : NY
   PostalCode   : 98052
   Country      : USA
   Phone        : (425) 555-0100
   Fax          : (425) 555-0101
   ```

5. Now use the `New-Item` cmdlet to add a row to an existing table. The `Path` parameter specifies
   the full path to the row, and must indicate a row number that is greater than the existing number
   of rows in the table. The `Type` parameter indicates "row" to specify that type of item to add.
   Finally, the `Value` parameter specifies a comma-delimited list of column values for the row.

   ```powershell
   New-Item -Path mydb:\Customers\3 -ItemType "row" -Value "3,CustomerFirstName,CustomerLastName,CustomerEmailAddress,CustomerTitle,CustomerCompany,CustomerPhone, CustomerAddress,CustomerCity,CustomerState,CustomerZip,CustomerCountry"
   ```

6. Verify the correctness of the new item operation as follows.

   ```none
   PS mydb:\> cd Customers
   PS mydb:\Customers> (Get-Item 3).data
   ```

   The following output appears.

   ```output
   ID        : 3
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
   ```

## See Also

[Creating Windows PowerShell Providers](./how-to-create-a-windows-powershell-provider.md)

[Designing Your Windows PowerShell Provider](./designing-your-windows-powershell-provider.md)

[Implementing an Item Windows PowerShell Provider](./creating-a-windows-powershell-item-provider.md)

[Implementing a Navigation Windows PowerShell Provider](./creating-a-windows-powershell-navigation-provider.md)

[How to Register Cmdlets, Providers, and Host Applications](/previous-versions/ms714644(v=vs.85))

[Windows PowerShell SDK](../windows-powershell-reference.md)

[Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)
