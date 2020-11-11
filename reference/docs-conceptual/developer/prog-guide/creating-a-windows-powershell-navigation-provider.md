---
ms.date: 09/13/2016
ms.topic: reference
title: Creating a Windows PowerShell Navigation Provider
description: Creating a Windows PowerShell Navigation Provider
---
# Creating a Windows PowerShell Navigation Provider

This topic describes how to create a Windows PowerShell navigation provider that can navigate the
data store. This type of provider supports recursive commands, nested containers, and relative
paths.

> [!NOTE]
> You can download the C# source file (AccessDBSampleProvider05.cs) for this provider using the
> Microsoft Windows Software Development Kit for Windows Vista and .NET Framework 3.0 Runtime
> Components. For download instructions, see
> [How to Install Windows PowerShell and Download the Windows PowerShell SDK](/powershell/scripting/developer/installing-the-windows-powershell-sdk).
> The downloaded source files are available in the **\<PowerShell Samples>** directory. For more
> information about other Windows PowerShell provider implementations, see
> [Designing Your Windows PowerShell Provider](./designing-your-windows-powershell-provider.md).

The provider described here enables the user handle an Access database as a drive so that the user
can navigate to the data tables in the database. When creating your own navigation provider, you can
implement methods that can make drive-qualified paths required for navigation, normalize relative
paths, move items of the data store, as well as methods that get child names, get the parent path of
an item, and test to identify if an item is a container.

> [!CAUTION]
> Be aware that this design assumes a database that has a field with the name ID, and that the type
> of the field is LongInteger.

## Define the Windows PowerShell provider

A Windows PowerShell navigation provider must create a .NET class that derives from the
[System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider)
base class. Here is the class definition for the navigation provider described in this section.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample05/AccessDBProviderSample05.cs" range="31-32":::

Note that in this provider, the
[System.Management.Automation.Provider.Cmdletproviderattribute](/dotnet/api/System.Management.Automation.Provider.CmdletProviderAttribute)
attribute includes two parameters. The first parameter specifies a user-friendly name for the
provider that is used by Windows PowerShell. The second parameter specifies the Windows PowerShell
specific capabilities that the provider exposes to the Windows PowerShell runtime during command
processing. For this provider, there are no Windows PowerShell specific capabilities that are added.

## Defining Base Functionality

As described in [Design Your PS Provider](./designing-your-windows-powershell-provider.md), the
[System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider)
base class derives from several other classes that provided different provider functionality. A
Windows PowerShell navigation provider, therefore, must define all of the functionality provided by
those classes.

To implement functionality for adding session-specific initialization information and for releasing
resources that are used by the provider, see
[Creating a Basic PS Provider](./creating-a-basic-windows-powershell-provider.md). However, most
providers (including the provider described here) can use the default implementation of this
functionality provided by Windows PowerShell.

To get access to the data store through a Windows PowerShell drive, you must implement the methods
of the
[System.Management.Automation.Provider.Drivecmdletprovider](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider)
base class. For more information about implementing these methods, see
[Creating a Windows PowerShell Drive Provider](./creating-a-windows-powershell-drive-provider.md).

To manipulate the items of a data store, such as getting, setting, and clearing items, the provider
must implement the methods provided by the
[System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider)
base class. For more information about implementing these methods, see
[Creating an Windows PowerShell Item Provider](./creating-a-windows-powershell-item-provider.md).

To get to the child items, or their names, of the data store, as well as methods that create, copy,
rename, and remove items, you must implement the methods provided by the
[System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider)
base class. For more information about implementing these methods, see
[Creating a Windows PowerShell Container Provider](./creating-a-windows-powershell-container-provider.md).

## Creating a Windows PowerShell Path

Windows PowerShell navigation provider use a provider-internal Windows PowerShell path to navigate
the items of the data store. To create a provider-internal path the provider must implement the
[System.Management.Automation.Provider.Navigationcmdletprovider.Makepath*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MakePath)
method to supports calls from the Combine-Path cmdlet. This method combines a parent and child path
into a provider-internal path, using a provider-specific path separator between the parent and child
paths.

The default implementation takes paths with "/" or "\\" as the path separator, normalizes the path
separator to "\\", combines the parent and child path parts with the separator between them, and
then returns a string that contains the combined paths.

This navigation provider does not implement this method. However, the following code is the default
implementation of the
[System.Management.Automation.Provider.Navigationcmdletprovider.Makepath*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MakePath)
method.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testprovidermakepath](Msh_samplestestcmdlets#testprovidermakepath)]  -->

#### Things to Remember About Implementing MakePath

The following conditions may apply to your implementation of
[System.Management.Automation.Provider.Navigationcmdletprovider.Makepath*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MakePath):

- Your implementation of the
  [System.Management.Automation.Provider.Navigationcmdletprovider.Makepath*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MakePath)
  method should not validate the path as a legal fully-qualified path in the provider namespace. Be
  aware that each parameter can only represent a part of a path, and the combined parts might not
  generate a fully-qualified path. For example, the
  [System.Management.Automation.Provider.Navigationcmdletprovider.Makepath*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MakePath)
  method for the filesystem provider might receive "windows\system32" in the `parent` parameter and
  "abc.dll" in the `child` parameter. The method joins these values with the "\\" separator and
  returns "windows\system32\abc.dll", which is not a fully-qualified file system path.

  > [!IMPORTANT]
  > The path parts provided in the call to
  > [System.Management.Automation.Provider.Navigationcmdletprovider.Makepath*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MakePath)
  > might contain characters not allowed in the provider namespace. These characters are most likely
  > used for wildcard expansion and the implementation of this method should not remove them.

## Retrieving the Parent Path

Windows PowerShell navigation providers implement the
[System.Management.Automation.Provider.Navigationcmdletprovider.Getparentpath*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.GetParentPath)
method to retrieve the parent part of the indicated full or partial provider-specific path. The
method removes the child part of the path and returns the parent path part. The `root` parameter
specifies the fully-qualified path to the root of a drive. This parameter can be null or empty if a
mounted drive is not in use for the retrieval operation. If a root is specified, the method must
return a path to a container in the same tree as the root.

The sample navigation provider does not override this method, but uses the default implementation.
It accepts paths that use both "/" and "\\" as path separators. It first normalizes the path to have
only "\\" separators, then splits the parent path off at the last "\\" and returns the parent path.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testprovidergetparentpath](Msh_samplestestcmdlets#testprovidergetparentpath)]  -->

#### To Remember About Implementing GetParentPath

Your implementation of the
[System.Management.Automation.Provider.Navigationcmdletprovider.Getparentpath*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.GetParentPath)
method should split the path lexically on the path separator for the provider namespace. For
example, the filesystem provider uses this method to look for the last "\\" and returns everything
to the left of the separator.

## Retrieve the Child Path Name

Your navigation provider implements the
[System.Management.Automation.Provider.Navigationcmdletprovider.Getchildname*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.GetChildName)
method to retrieve the name (leaf element) of the child of the item located at the indicated full or
partial provider-specific path.

The sample navigation provider does not override this method. The default implementation is shown
below. It accepts paths that use both "/" and "\\" as path separators. It first normalizes the path
to have only "\\" separators, then splits the parent path off at the last "\\" and returns the name
of the child path part.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testprovidergetchildname](Msh_samplestestcmdlets#testprovidergetchildname)]  -->

#### Things to Remember About Implementing GetChildName

Your implementation of the
[System.Management.Automation.Provider.Navigationcmdletprovider.Getchildname*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.GetChildName)
method should split the path lexically on the path separator. If the supplied path contains no path
separators, the method should return the path unmodified.

> [!IMPORTANT]
> The path provided in the call to this method might contain characters that are illegal in the
> provider namespace. These characters are most likely used for wildcard expansion or regular
> expression matching, and the implementation of this method should not remove them.

## Determining if an Item is a Container

The navigation provider can implement the
[System.Management.Automation.Provider.Navigationcmdletprovider.Isitemcontainer*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.IsItemContainer)
method to determine if the specified path indicates a container. It returns true if the path
represents a container, and false otherwise. The user needs this method to be able to use the
`Test-Path` cmdlet for the supplied path.

The following code shows the
[System.Management.Automation.Provider.Navigationcmdletprovider.Isitemcontainer*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.IsItemContainer)
implementation in our sample navigation provider. The method verifies that the specified path is
correct and if the table exists, and returns true if the path indicates a container.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample05/AccessDBProviderSample05.cs" range="847-872":::

#### Things to Remember About Implementing IsItemContainer

Your navigation provider .NET class might declare provider capabilities of ExpandWildcards, Filter,
Include, or Exclude, from the
[System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
enumeration. In this case, the implementation of
[System.Management.Automation.Provider.Navigationcmdletprovider.Isitemcontainer*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.IsItemContainer)
needs to ensure that the path passed meets requirements. To do this, the method should access the
appropriate property, for example, the
[System.Management.Automation.Provider.Cmdletprovider.Exclude*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Exclude)
property.

## Moving an Item

In support of the `Move-Item` cmdlet, your navigation provider implements the
[System.Management.Automation.Provider.Navigationcmdletprovider.Moveitem*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MoveItem)
method. This method moves the item specified by the `path` parameter to the container at the path
supplied in the `destination` parameter.

The sample navigation provider does not override the [System.Management.Automation.Provider.Navigationcmdletprovider.Moveitem*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MoveItem) method. The following is the default implementation.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testprovidermoveitem](Msh_samplestestcmdlets#testprovidermoveitem)]  -->

#### Things to Remember About Implementing MoveItem

Your navigation provider .NET class might declare provider capabilities of ExpandWildcards, Filter,
Include, or Exclude, from the
[System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
enumeration. In this case, the implementation of
[System.Management.Automation.Provider.Navigationcmdletprovider.Moveitem*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MoveItem)
must ensure that the path passed meets requirements. To do this, the method should access the
appropriate property, for example, the **CmdletProvider.Exclude** property.

By default, overrides of this method should not move objects over existing objects unless the
[System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
property is set to `true`. For example, the filesystem provider will not copy c:\temp\abc.txt over
an existing c:\bar.txt file unless the
[System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
property is set to `true`. If the path specified in the `destination` parameter exists and is a
container, the
[System.Management.Automation.Provider.Cmdletprovider.Force*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Force)
property is not required. In this case,
[System.Management.Automation.Provider.Navigationcmdletprovider.Moveitem*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MoveItem)
should move the item indicated by the `path` parameter to the container indicated by the
`destination` parameter as a child.

Your implementation of the
[System.Management.Automation.Provider.Navigationcmdletprovider.Moveitem*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MoveItem)
method should call
[System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
and check its return value before making any changes to the data store. This method is used to
confirm execution of an operation when a change is made to system state, for example, deleting
files.
[System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
sends the name of the resource to be changed to the user, with the Windows PowerShell runtime taking
into account any command line settings or preference variables in determining what should be
displayed to the user.

After the call to
[System.Management.Automation.Provider.Cmdletprovider.ShouldProcess](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldProcess)
returns `true`, the
[System.Management.Automation.Provider.Navigationcmdletprovider.Moveitem*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MoveItem)
method should call the
[System.Management.Automation.Provider.Cmdletprovider.ShouldContinue](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldContinue)
method. This method sends a message to the user to allow feedback to say if the operation should be
continued. Your provider should call
[System.Management.Automation.Provider.Cmdletprovider.ShouldContinue](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.ShouldContinue)
as an additional check for potentially dangerous system modifications.

## Attaching Dynamic Parameters to the Move-Item Cmdlet

Sometimes the `Move-Item` cmdlet requires additional parameters that are provided dynamically at
runtime. To provide these dynamic parameters, the navigation provider must implement the
[System.Management.Automation.Provider.Navigationcmdletprovider.Moveitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MoveItemDynamicParameters)
method to get the required parameter values from the item at the indicated path, and return an
object that has properties and fields with parsing attributes similar to a cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object.

This navigation provider does not implement this method. However, the following code is the default
implementation of
[System.Management.Automation.Provider.Navigationcmdletprovider.Moveitemdynamicparameters*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.MoveItemDynamicParameters).

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testprovidermoveitemdynamicparameters](Msh_samplestestcmdlets#testprovidermoveitemdynamicparameters)]  -->

## Normalizing a Relative Path

Your navigation provider implements the
[System.Management.Automation.Provider.Navigationcmdletprovider.Normalizerelativepath*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.NormalizeRelativePath)
method to normalize the fully-qualified path indicated in the `path` parameter as being relative to
the path specified by the `basePath` parameter. The method returns a string representation of the
normalized path. It writes an error if the `path` parameter specifies a nonexistent path.

The sample navigation provider does not override this method. The following is the default implementation.

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testprovidernormalizepath](Msh_samplestestcmdlets#testprovidernormalizepath)]  -->

#### Things to Remember About Implementing NormalizeRelativePath

Your implementation of
[System.Management.Automation.Provider.Navigationcmdletprovider.Normalizerelativepath*](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider.NormalizeRelativePath)
should parse the `path` parameter, but it does not have to use purely syntactical parsing. You are
encouraged to design this method to use the path to look up the path information in the data store
and create a path that matches the casing and standardized path syntax.

## Code Sample

For complete sample code, see [AccessDbProviderSample05 Code Sample](./accessdbprovidersample05-code-sample.md).

## Defining Object Types and Formatting

It is possible for a provider to add members to existing objects or define new objects. For more
information,
see[Extending Object Types and Formatting](/previous-versions/ms714665(v=vs.85)).

## Building the Windows PowerShell provider

For more information, see
[How to Register Cmdlets, Providers, and Host Applications](/previous-versions/ms714644(v=vs.85)).

## Testing the Windows PowerShell provider

When your Windows PowerShell provider has been registered with Windows PowerShell, you can test it
by running the supported cmdlets on the command line, including cmdlets made available by
derivation. This example will test the sample navigation provider.

1. Run your new shell and use the `Set-Location` cmdlet to set the path to indicate the Access
   database.

   ```powershell
   Set-Location mydb:
   ```

2. Now run the `Get-Childitem` cmdlet to retrieve a list of the database items, which are the
   available database tables. For each table, this cmdlet also retrieves the number of table rows.

   ```powershell
   Get-ChildItem | Format-Table rowcount,name -AutoSize
   ```

   ```Output
   RowCount   Name
   --------   ----
        180   MSysAccessObjects
          0   MSysACEs
          1   MSysCmdbars
          0   MSysIMEXColumns
          0   MSysIMEXSpecs
          0   MSysObjects
          0   MSysQueries
          7   MSysRelationships
          8   Categories
         91   Customers
          9   Employees
       2155   Order Details
        830   Orders
         77   Products
          3   Shippers
         29   Suppliers
   ```

3. Use the `Set-Location` cmdlet again to set the location of the Employees data table.

   ```powershell
   Set-Location Employees
   ```

4. Let's now use the `Get-Location` cmdlet to retrieve the path to the Employees table.

   ```powershell
   Get-Location
   ```

   ```Output
   Path
   ----
   mydb:\Employees
   ```

5. Now use the `Get-Childitem` cmdlet piped to the `Format-Table` cmdlet. This set of cmdlets
   retrieves the items for the Employees data table, which are the table rows. They are formatted as
   specified by the `Format-Table` cmdlet.

   ```powershell
   Get-ChildItem | Format-Table rownumber,psiscontainer,data -AutoSize
   ```

   ```Output
   RowNumber   PSIsContainer   Data
   ---------   --------------   ----
   0           False            System.Data.DataRow
   1           False            System.Data.DataRow
   2           False            System.Data.DataRow
   3           False            System.Data.DataRow
   4           False            System.Data.DataRow
   5           False            System.Data.DataRow
   6           False            System.Data.DataRow
   7           False            System.Data.DataRow
   8           False            System.Data.DataRow
   ```

6. You can now run the `Get-Item` cmdlet to retrieve the items for row 0 of the Employees data
   table.

   ```powershell
   Get-Item 0
   ```

   ```Output
   PSPath        : AccessDB::C:\PS\Northwind.mdb\Employees\0
   PSParentPath  : AccessDB::C:\PS\Northwind.mdb\Employees
   PSChildName   : 0
   PSDrive       : mydb
   PSProvider    : System.Management.Automation.ProviderInfo
   PSIsContainer : False
   Data           : System.Data.DataRow
   RowNumber      : 0
   ```

7. Use the `Get-Item` cmdlet again to retrieve the employee data for the items in row 0.

   ```powershell
   (Get-Item 0).data
   ```

   ```Output
   EmployeeID      : 1
   LastName        : Davis
   FirstName       : Sara
   Title           : Sales Representative
   TitleOfCourtesy : Ms.
   BirthDate       : 12/8/1968 12:00:00 AM
   HireDate        : 5/1/1992 12:00:00 AM
   Address         : 4567 Main Street
                     Apt. 2A
   City            : Buffalo
   Region          : NY
   PostalCode      : 98052
   Country         : USA
   HomePhone       : (206) 555-9857
   Extension       : 5467
   Photo           : EmpID1.bmp
   Notes           : Education includes a BA in psychology from
                     Colorado State University. She also completed "The
                     Art of the Cold Call."  Nancy is a member of
                     Toastmasters International.
   ReportsTo       : 2
   ```

## See Also

[Creating Windows PowerShell providers](./how-to-create-a-windows-powershell-provider.md)

[Design Your Windows PowerShell provider](./designing-your-windows-powershell-provider.md)

[Extending Object Types and Formatting](/previous-versions/ms714665(v=vs.85))

[Implement a Container Windows PowerShell provider](./creating-a-windows-powershell-container-provider.md)

[How to Register Cmdlets, Providers, and Host Applications](/previous-versions/ms714644(v=vs.85))

[Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)
