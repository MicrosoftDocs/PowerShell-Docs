---
ms.date: 09/13/2016
ms.topic: reference
title: Writing an item provider
description: Writing an item provider
---
# Writing an item provider

This topic describes how to implement the methods of a Windows PowerShell provider that access and
manipulate items in the data store. To be able to access items, a provider must derive from the
[System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider)
class.

The provider in the examples in this topic uses an Access database as its data store. There are
several helper methods and classes that are used to interact with the database. For the complete
sample that includes the helper methods, see
[AccessDBProviderSample03](./accessdbprovidersample03.md)

For more information about Windows PowerShell providers, see
[Windows PowerShell Provider Overview](./windows-powershell-provider-overview.md).

## Implementing item methods

The
[System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider)
class exposes several methods that can be used to access and manipulate the items in a data store.
For a complete list of these methods, see
[ItemCmdletProvider Methods](/dotnet/api/system.management.automation.provider.itemcmdletprovider#methods).
In this example, we will implement four of these methods.
[System.Management.Automation.Provider.Itemcmdletprovider.Getitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItem)
gets an item at a specified path.
[System.Management.Automation.Provider.Itemcmdletprovider.Setitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItem)
sets the value of the specified item.
[System.Management.Automation.Provider.Itemcmdletprovider.Itemexists*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExists)
checks whether an item exists at the specified path.
[System.Management.Automation.Provider.Itemcmdletprovider.Isvalidpath*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.IsValidPath)
checks a path to see if it maps to a location in the data store.

> [!NOTE]
> This topic builds on the information in
> [Windows PowerShell Provider QuickStart](./windows-powershell-provider-quickstart.md). This topic
> does not cover the basics of how to set up a provider project, or how to implement the methods
> inherited from the
> [System.Management.Automation.Provider.Drivecmdletprovider](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider)
> class that create and remove drives.

### Declaring the provider class

Declare the provider to derive from the
[System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider)
class, and decorate it with the
[System.Management.Automation.Provider.Cmdletproviderattribute](/dotnet/api/System.Management.Automation.Provider.CmdletProviderAttribute).

```csharp
[CmdletProvider("AccessDB", ProviderCapabilities.None)]

   public class AccessDBProvider : ItemCmdletProvider
   {

  }

```

### Implementing GetItem

The
[System.Management.Automation.Provider.Itemcmdletprovider.Getitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItem)
is called by the PowerShell engine when a user calls the
[Microsoft.PowerShell.Commands.GetItemCommand](/dotnet/api/Microsoft.PowerShell.Commands.getitemcommand)
cmdlet on your provider. The method returns the item at the specified path. In the Access database
example, the method checks whether the item is the drive itself, a table in the database, or a row
in the database. The method sends the item to the PowerShell engine by calling the
[System.Management.Automation.Provider.Cmdletprovider.Writeitemobject*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.WriteItemObject)
method.

```csharp
protected override void GetItem(string path)
      {
          // check if the path represented is a drive
          if (PathIsDrive(path))
          {
              WriteItemObject(this.PSDriveInfo, path, true);
              return;
          }// if (PathIsDrive...

           // Get table name and row information from the path and do
           // necessary actions
           string tableName;
           int rowNumber;

           PathType type = GetNamesFromPath(path, out tableName, out rowNumber);

           if (type == PathType.Table)
           {
               DatabaseTableInfo table = GetTable(tableName);
               WriteItemObject(table, path, true);
           }
           else if (type == PathType.Row)
           {
               DatabaseRowInfo row = GetRow(tableName, rowNumber);
               WriteItemObject(row, path, false);
           }
           else
           {
               ThrowTerminatingInvalidPathException(path);
           }

       }
```

### Implementing SetItem

The
[System.Management.Automation.Provider.Itemcmdletprovider.Setitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItem)
method is called by the PowerShell engine calls when a user calls the
[Microsoft.PowerShell.Commands.SetItemCommand](/dotnet/api/Microsoft.PowerShell.Commands.setitemcommand)
cmdlet. It sets the value of the item at the specified path.

In the Access database example, it makes sense to set the value of an item only if that item is a
row, so the method throws
[NotSupportedException](/dotnet/api/system.notsupportedexception) when the
item is not a row.

```csharp
protected override void SetItem(string path, object values)
       {
           // Get type, table name and row number from the path specified
           string tableName;
           int rowNumber;

           PathType type = GetNamesFromPath(path, out tableName, out rowNumber);

           if (type != PathType.Row)
           {
               WriteError(new ErrorRecord(new NotSupportedException(
                     "SetNotSupported"), "",
                  ErrorCategory.InvalidOperation, path));

               return;
           }

           // Get in-memory representation of table
           OdbcDataAdapter da = GetAdapterForTable(tableName);

           if (da == null)
           {
               return;
           }
           DataSet ds = GetDataSetForTable(da, tableName);
           DataTable table = GetDataTable(ds, tableName);

           if (rowNumber >= table.Rows.Count)
           {
               // The specified row number has to be available. If not
               // NewItem has to be used to add a new row
               throw new ArgumentException("Row specified is not available");
           } // if (rowNum...

           string[] colValues = (values as string).Split(',');

           // set the specified row
           DataRow row = table.Rows[rowNumber];

           for (int i = 0; i < colValues.Length; i++)
           {
               row[i] = colValues[i];
           }

           // Update the table
           if (ShouldProcess(path, "SetItem"))
           {
               da.Update(ds, tableName);
           }

       }
```

### Implementing ItemExists

The
[System.Management.Automation.Provider.Itemcmdletprovider.Itemexists*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExists)
method is called by the PowerShell engine when a user calls the
[Microsoft.PowerShell.Commands.TestPathCommand](/dotnet/api/Microsoft.PowerShell.Commands.Testpathcommand)
cmdlet. The method determines whether there is an item at the specified path. If the item does
exist, the method passes it back to the PowerShell engine by calling
[System.Management.Automation.Provider.Cmdletprovider.Writeitemobject*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.WriteItemObject).

```csharp
protected override bool ItemExists(string path)
       {
           // check if the path represented is a drive
           if (PathIsDrive(path))
           {
               return true;
           }

           // Obtain type, table name and row number from path
           string tableName;
           int rowNumber;

           PathType type = GetNamesFromPath(path, out tableName, out rowNumber);

           DatabaseTableInfo table = GetTable(tableName);

           if (type == PathType.Table)
           {
               // if specified path represents a table then DatabaseTableInfo
               // object for the same should exist
               if (table != null)
               {
                   return true;
               }
           }
           else if (type == PathType.Row)
           {
               // if specified path represents a row then DatabaseTableInfo should
               // exist for the table and then specified row number must be within
               // the maximum row count in the table
               if (table != null && rowNumber < table.RowCount)
               {
                   return true;
               }
           }

           return false;

       }
```

### Implementing IsValidPath

The
[System.Management.Automation.Provider.Itemcmdletprovider.Isvalidpath*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.IsValidPath)
method checks whether the specified path is syntactically valid for the current provider. It does
not check whether an item exists at the path.

```csharp
protected override bool IsValidPath(string path)
       {
           bool result = true;

           // check if the path is null or empty
           if (String.IsNullOrEmpty(path))
           {
               result = false;
           }

           // convert all separators in the path to a uniform one
           path = NormalizePath(path);

           // split the path into individual chunks
           string[] pathChunks = path.Split(pathSeparator.ToCharArray());

           foreach (string pathChunk in pathChunks)
           {
               if (pathChunk.Length == 0)
               {
                   result = false;
               }
           }
           return result;
       }
```

## Next steps

A typical real-world provider is capable of supporting items that contain other items, and of moving
items from one path to another within the drive. For an example of a provider that supports
containers, see [Writing a container provider](./writing-a-container-provider.md). For an example of
a provider that supports moving items, see
[Writing a navigation provider](./writing-a-navigation-provider.md).

## See Also

[Writing a container provider](./writing-a-container-provider.md)

[Writing a navigation provider](./writing-a-navigation-provider.md)

[Windows PowerShell Provider Overview](./windows-powershell-provider-overview.md)
