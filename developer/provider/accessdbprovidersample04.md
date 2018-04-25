---
title: "AccessDBProviderSample04 | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: ee3a7e56-7331-4f71-9ecb-7a59b8021c68
caps.latest.revision: 10
---
# AccessDBProviderSample04
This sample shows how to overwrite container methods to support calls to the Copy-Item, Get-ChildItem, New-Item, and Remove-Item cmdlets. These methods should be implemented when the data store contains items that are containers. A container is a group of child items under a common parent item. The provider class in this sample derives from the [System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider) class.

## Demonstrates

> [!IMPORTANT]
>  Your provider class will most likely derive from the [System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider)

 This sample demonstrates the following:

-   Declaring the `CmdletProvider` attribute.

-   Defining a provider class that derives from the [System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider) class.

-   Overwriting the [System.Management.Automation.Provider.Containercmdletprovider.Copyitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.CopyItem) method to change the behavior of the Copy-Item cmdlet which allows the user to copy items from one location to another. (This sample does not show how to add dynamic parameters to the Copy-Item cmdlet.)

-   Overwriting the [System.Management.Automation.Provider.Containercmdletprovider.Getchilditems*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItems) method to change the behavior of the Get-ChildItems cmdlet, which allows the user to retrieve the child items of the parent item. (This sample does not show how to add dynamic parameters to the Get-ChildItems cmdlet.)

-   Overwriting the [System.Management.Automation.Provider.Containercmdletprovider.Getchildnames*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.GetChildNames) method to change the behavior of the Get-ChildItems cmdlet when the `Name` parameter of the cmdlet is specified.

-   Overwriting the [System.Management.Automation.Provider.Containercmdletprovider.Newitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.NewItem) method to change the behavior of the New-Item cmdlet, which allows the user to add items to the data store. (This sample does not show how to add dynamic parameters to the New-Item cmdlet.)

-   Overwriting the [System.Management.Automation.Provider.Containercmdletprovider.Removeitem*](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItem) method to change the behavior of the Remove-Item cmdlet. (This sample does not show how to add dynamic parameters to the Remove-Item cmdlet.)

## Example
 This sample shows how to overwrite the methods needed to copy, create, and remove items, as well as methods for getting the child items of a parent item.

<!-- TODO: review snippet reference  [!CODE [PSSample_Provider04#AccessDBProviderSample04All](PSSample_Provider04#AccessDBProviderSample04All)]  -->

```csharp
namespace Microsoft.Samples.PowerShell.Providers
{
  using System;
  using System.Collections.ObjectModel;
  using System.Data;
  using System.Data.Odbc;
  using System.Data.OleDb;
  using System.Diagnostics;
  using System.Globalization;
  using System.IO;
  using System.Management.Automation;
  using System.Management.Automation.Provider;
  using System.Text;
  using System.Text.RegularExpressions;

  #region AccessDBProvider

  /// <summary>
  /// A Windows PowerShell Provider that acts upon an Access database.
  /// </summary>
  /// <remarks>This provider implements Drive and Item methods.</remarks>
  [CmdletProvider("AccessDB", ProviderCapabilities.None)]
  public class AccessDBProvider : ContainerCmdletProvider
  {
    #region Private Properties

    /// <summary>
    /// Characters used to valid table names.
    /// </summary>
    private static string pattern = @"^[a-z]+[0-9]*_*$";

    /// <summary>
    /// The valid path separator character.
    /// </summary>
    private string pathSeparator = "\\";

    /// <summary>
    /// Defines the types of paths to items.
    /// </summary>
    private enum PathType
    {
      /// <summary>
      /// Path to a database.
      /// </summary>
      Database,

      /// <summary>
      /// Path to a table item.
      /// </summary>
      Table,

      /// <summary>
      /// Path to a row item.
      /// </summary>
      Row,

      /// <summary>
      /// A path to an item that is not a database, table, or row.
      /// </summary>
      Invalid
    }

    #endregion Private Properties

    #region Drive Manipulation

    /// <summary>
    /// The Windows PowerShell engine calls this method when the New-Drive
    /// cmdlet is run. This provider creates a connection to the database
    /// file and sets the Connection property in the PSDriveInfo.
    /// </summary>
    /// <param name="drive">
    /// Information describing the drive to create.
    /// </param>
    /// <returns>An object that describes the new drive.</returns>
    protected override PSDriveInfo NewDrive(PSDriveInfo drive)
    {
      // Check to see if the drive object is null.
      if (drive == null)
      {
        WriteError(new ErrorRecord(
                                   new ArgumentNullException("drive"),
                                   "NullDrive",
                                   ErrorCategory.InvalidArgument,
                                   null));

        return null;
      }

      // Check to see if the drive root is not null or empty
      // and if its an existing file.
      if (String.IsNullOrEmpty(drive.Root) || (File.Exists(drive.Root) == false))
      {
        WriteError(new ErrorRecord(
                                   new ArgumentException("drive.Root"),
                                   "NoRoot",
                                   ErrorCategory.InvalidArgument,
                                   drive));

        return null;
      }

      // Create a new drive and create an ODBC connection to the new drive
      AccessDBPSDriveInfo accessDBPSDriveInfo = new AccessDBPSDriveInfo(drive);

      OdbcConnectionStringBuilder builder = new OdbcConnectionStringBuilder();

      builder.Driver = "Microsoft Access Driver (*.mdb)";
      builder.Add("DBQ", drive.Root);

      OdbcConnection conn = new OdbcConnection(builder.ConnectionString);
      conn.Open();
      accessDBPSDriveInfo.Connection = conn;

      return accessDBPSDriveInfo;
    } // End NewDrive method.

    /// <summary>
    /// The Windows PowerShell engine calls this method when the Remove-Drive
    /// cmdlet is run. This provider removes a drive from the Access database.
    /// </summary>
    /// <param name="drive">The drive to remove.</param>
    /// <returns>The drive to be removed.</returns>
    protected override PSDriveInfo RemoveDrive(PSDriveInfo drive)
    {
      // Check to see if the drive object is null.
      if (drive == null)
      {
        WriteError(new ErrorRecord(
                                   new ArgumentNullException("drive"),
                                   "NullDrive",
                                   ErrorCategory.InvalidArgument,
                                   drive));

        return null;
      }

      // Close the ODBC connection to the drive.
      AccessDBPSDriveInfo accessDBPSDriveInfo = drive as AccessDBPSDriveInfo;

      if (accessDBPSDriveInfo == null)
      {
        return null;
      }

      accessDBPSDriveInfo.Connection.Close();
      return accessDBPSDriveInfo;
    } // End RemoveDrive method.

    #endregion Drive Manipulation

    #region Item Methods

    /// <summary>
    /// The Windows PowerShell engine calls this method when the Get-Item
    /// cmdlet is run.
    /// </summary>
    /// <param name="path">The path to the item to return.</param>
    protected override void GetItem(string path)
    {
      // Check to see if the supplied path is a drive.
      if (this.PathIsDrive(path))
      {
        WriteItemObject(this.PSDriveInfo, path, true);
        return;
      } // End if (PathIsDrive...) block.

      // Get the table name and row information from the path and do
      // necessary actions.
      string tableName;
      int rowNumber;

      PathType type = this.GetNamesFromPath(path, out tableName, out rowNumber);

      if (type == PathType.Table)
      {
        DatabaseTableInfo table = this.GetTable(tableName);
        WriteItemObject(table, path, true);
      }
      else if (type == PathType.Row)
      {
        DatabaseRowInfo row = this.GetRow(tableName, rowNumber);
        WriteItemObject(row, path, false);
      }
      else
      {
        this.ThrowTerminatingInvalidPathException(path);
      }
    } // End GetItem method.

    /// <summary>
    /// The Windows PowerShell engine calls this method when the Set-Item
    /// cmdlet is run. This provider sets the content of a row of data
    /// specified by the supplied path parameter.
    /// </summary>
    /// <param name="path">Specifies the path to the row whose columns
    /// will be updated.</param>
    /// <param name="values">Comma separated string of values</param>
    protected override void SetItem(string path, object values)
    {
      // Get type, table name and row number from the path specified
      string tableName;
      int rowNumber;

      PathType type = this.GetNamesFromPath(path, out tableName, out rowNumber);

      if (type != PathType.Row)
      {
        WriteError(new ErrorRecord(
                                   new NotSupportedException("SetNotSupported"),
                                   string.Empty,
                                   ErrorCategory.InvalidOperation,
                                   path));
        return;
      }

      // Get the in-memory representation of the table.
      OdbcDataAdapter da = this.GetAdapterForTable(tableName);

      if (da == null)
      {
        return;
      }

      DataSet ds = this.GetDataSetForTable(da, tableName);
      DataTable table = this.GetDataTable(ds, tableName);

      if (rowNumber >= table.Rows.Count)
      {
        // The specified row number has to be available. If not
        // NewItem has to be used to add a new row
        throw new ArgumentException("Row specified is not available");
      } // End if (rowNum...) block.

      string[] colValues = (values as string).Split(',');

      // Set the specified row
      DataRow row = table.Rows[rowNumber];

      for (int i = 0; i < colValues.Length; i++)
      {
        row[i] = colValues[i];
      }

      // Update the table.
      if (ShouldProcess(path, "SetItem"))
      {
        da.Update(ds, tableName);
      }
    } // End the SetItem method.

    /// <summary>
    /// Test to see if the specified item exists.
    /// </summary>
    /// <param name="path">The path to the item to verify.</param>
    /// <returns>True if the item is found.</returns>
    protected override bool ItemExists(string path)
    {
      // Check to see if the path represented is a drive.
      if (this.PathIsDrive(path))
      {
        return true;
      }

      // Obtain type, table name, and row number from path.
      string tableName;
      int rowNumber;

      PathType type = this.GetNamesFromPath(path, out tableName, out rowNumber);

      DatabaseTableInfo table = this.GetTable(tableName);

      if (type == PathType.Table)
      {
        // If the specified path represents a table, then a DatabaseTableInfo
        // object for the table should exist.
        if (table != null)
        {
          return true;
        }
      }
      else if (type == PathType.Row)
      {
        // If the specified path represents a row, then a DatabaseTableInfo
        // object should exist for the table and the specified row number
        // must be within the maximum row count in the table.
        if (table != null && rowNumber < table.RowCount)
        {
          return true;
        }
      }

      return false;
    } // End ItemExists method.

    /// <summary>
    /// Test to see if the specified path is syntactically valid.
    /// </summary>
    /// <param name="path">The path to validate.</param>
    /// <returns>True if the specified path is valid.</returns>
    protected override bool IsValidPath(string path)
    {
      bool result = true;

      // Check to see if the path is null or empty.
      if (String.IsNullOrEmpty(path))
      {
        result = false;
      }

      // Convert all separators in the path to a uniform chracter.
      path = this.NormalizePath(path);

      // Separate the path into individual chunks.
      string[] pathChunks = path.Split(this.pathSeparator.ToCharArray());

      foreach (string pathChunk in pathChunks)
      {
        if (pathChunk.Length == 0)
        {
          result = false;
        }
      }

      return result;
    } // End IsValidPath method.

    #endregion Item Overloads

    #region Container Overloads

    /// <summary>
    /// The Windows PowerShell engine calls this method when the Get-ChildItem
    /// cmdlet is run. This provider returns either the tables in the database
    /// or the rows of the table.
    /// </summary>
    /// <param name="path">The path to the parent item.</param>
    /// <param name="recurse">A Boolean value that indicates true to return all
    /// child items recursively.
    /// </param>
    protected override void GetChildItems(string path, bool recurse)
    {
      // If the path represented is a drive then the children in the path are
      // tables. Hence all tables in the drive represented will have to be
      // returned.
      if (this.PathIsDrive(path))
      {
        foreach (DatabaseTableInfo table in this.GetTables())
        {
          WriteItemObject(table, path, true);

          // If the specified item exists and recurse has been set, then
          // all child items within it have to be obtained as well.
          if (this.ItemExists(path) && recurse)
          {
            this.GetChildItems(path + this.pathSeparator + table.Name, recurse);
          }
        } // End foreach (DatabaseTableInfo...) block.
      }
      else
      {
        // Get the table name, row number and type of path from the
        // path specified
        string tableName;
        int rowNumber;

        PathType type = this.GetNamesFromPath(path, out tableName, out rowNumber);

        if (type == PathType.Table)
        {
          // Obtain all the rows within the table.
          foreach (DatabaseRowInfo row in this.GetRows(tableName))
          {
            WriteItemObject(
                            row,
                            path + this.pathSeparator + row.RowNumber,
                            false);
          } // End foreach (DatabaseRowInfo...) block.
        }
        else if (type == PathType.Row)
        {
          // In this case the user has directly specified a row, hence
          // just give that particular row
          DatabaseRowInfo row = this.GetRow(tableName, rowNumber);
          WriteItemObject(
                          row,
                          path + this.pathSeparator + row.RowNumber,
                          false);
        }
        else
        {
          // In this case, the path specified is not valid.
          this.ThrowTerminatingInvalidPathException(path);
        }
      } // End else block.
    } // End GetChildItems method.

    /// <summary>
    /// Returns the names of all the child items.
    /// </summary>
    /// <param name="path">The root path.</param>
    /// <param name="returnContainers">Parameter not used.</param>
    protected override void GetChildNames(
                                          string path,
                                          ReturnContainers returnContainers)
    {
      // If the path represented is a drive, then the child items are
      // tables. Get the names of all the tables in the drive.
      if (this.PathIsDrive(path))
      {
        foreach (DatabaseTableInfo table in this.GetTables())
        {
          WriteItemObject(table.Name, path, true);
        } // End foreach (DatabaseTableInfo...) block.
      }
      else
      {
        // Get type, table name and row number from path specified
        string tableName;
        int rowNumber;

        PathType type = this.GetNamesFromPath(path, out tableName, out rowNumber);

        if (type == PathType.Table)
        {
          // Get all the rows in the table and then write out the
          // row numbers.
          foreach (DatabaseRowInfo row in this.GetRows(tableName))
          {
            WriteItemObject(row.RowNumber, path, false);
          } // End foreach (DatabaseRowInfo...) block.
        }
        else if (type == PathType.Row)
        {
          // In this case the user has directly specified a row, hence
          // just give that particular row.
          DatabaseRowInfo row = this.GetRow(tableName, rowNumber);
          WriteItemObject(row.RowNumber, path, false);
        }
        else
        {
          this.ThrowTerminatingInvalidPathException(path);
        }
      } // End else block.
    } // End GetChildNames method.

    /// <summary>
    /// Determines if the specified path has child items.
    /// </summary>
    /// <param name="path">The path to examine.</param>
    /// <returns>
    /// True if the specified path has child items.
    /// </returns>
    protected override bool HasChildItems(string path)
    {
      if (this.PathIsDrive(path))
      {
        return true;
      }

      return this.ChunkPath(path).Length == 1;
    } // End HasChildItems method.

    /// <summary>
    /// The Windows PowerShell engine calls this method when the New-Item
    /// cmdlet is run. This method creates a new item at the specified path.
    /// </summary>
    /// <param name="path">The path to the new item.</param>
    /// <param name="type">The type of object to create. A "Table" object
    /// for creating a new table and a "Row" object for creating a new row
    /// in a table.
    /// </param>
    /// <param name="newItemValue">
    /// Object for creating a new instance at the specified path. For
    /// creating a "Table" the object parameter is ignored and for creating
    /// a "Row" the object must be of type string, which will contain comma
    /// separated values of the rows to insert.
    /// </param>
    protected override void NewItem(
                                    string path,
                                    string type,
                                    object newItemValue)
    {
      string tableName;
      int rowNumber;

      PathType pt = this.GetNamesFromPath(path, out tableName, out rowNumber);

      if (pt == PathType.Invalid)
      {
        this.ThrowTerminatingInvalidPathException(path);
      }

      // Check to see if the type is either "table" or "row", if not throw an
      // exception
      if (!String.Equals(type, "table", StringComparison.OrdinalIgnoreCase)
               && !String.Equals(type, "row", StringComparison.OrdinalIgnoreCase))
      {
        WriteError(new ErrorRecord(
                            new ArgumentException("Type must be either a table or row"),
                            "CannotCreateSpecifiedObject",
                            ErrorCategory.InvalidArgument,
                            path));

        throw new ArgumentException("This provider can only create items of type \"table\" or \"row\"");
      }

      // The path type is the type of path of the container. So if a drive
      // is specified, then a table can be created under it and if a table
      // is specified, then a row can be created under it. For the sake of
      // completeness, if a row is specified and if the row specified by
      // the path does not exist, a new row is created. However, the row
      // number may not match as the row numbers only get incremented based
      // on the number of rows.
      if (this.PathIsDrive(path))
      {
        if (String.Equals(type, "table", StringComparison.OrdinalIgnoreCase))
        {
          // Execute command using ODBC connection to create a table.
          try
          {
            // Create the table using an sql statement
            string newTableName = newItemValue.ToString();

            if (!this.TableNameIsValid(newTableName))
            {
              return;
            }

            string sql = "create table " + newTableName + " (ID INT)";

            // Create the table using the Odbc connection from the
            // drive.
            AccessDBPSDriveInfo di = this.PSDriveInfo as AccessDBPSDriveInfo;

            if (di == null)
            {
              return;
            }

            OdbcConnection connection = di.Connection;

            if (ShouldProcess(newTableName, "create"))
            {
              OdbcCommand cmd = new OdbcCommand(sql, connection);
              cmd.ExecuteScalar();
            }
          }
          catch (Exception ex)
          {
            WriteError(new ErrorRecord(
                                       ex,
                                       "CannotCreateSpecifiedTable",
                                       ErrorCategory.InvalidOperation,
                                       path));
          }
        }
        else if (String.Equals(type, "row", StringComparison.OrdinalIgnoreCase))
        {
          throw new
          ArgumentException("A row cannot be created under a database, specify a path that represents a Table");
        }
      }
      else
      {
        if (String.Equals(type, "table", StringComparison.OrdinalIgnoreCase))
        {
          if (rowNumber < 0)
          {
            throw new
            ArgumentException("A table cannot be created within another table, specify a path that represents a database");
          }
          else
          {
            throw new
            ArgumentException("A table cannot be created inside a row, specify a path that represents a database");
          }
        }
        else if (String.Equals(type, "row", StringComparison.OrdinalIgnoreCase))
        {
          // The user is required to specify the values to be inserted
          // into the table in a single string separated by commas
          string value = newItemValue as string;

          if (String.IsNullOrEmpty(value))
          {
            throw new
            ArgumentException("Value argument must have comma separated values of each column in a row");
          }

          string[] rowValues = value.Split(',');
          OdbcDataAdapter da = this.GetAdapterForTable(tableName);

          if (da == null)
          {
            return;
          }

          DataSet ds = this.GetDataSetForTable(da, tableName);
          DataTable table = this.GetDataTable(ds, tableName);

          if (rowValues.Length != table.Columns.Count)
          {
            string message = String.Format(
                                          CultureInfo.CurrentCulture,
                                          "The table has {0} columns and the value specified must have so many comma separated values",
                                          table.Columns.Count);

            throw new ArgumentException(message);
          }

          if (!Force && (rowNumber >= 0 && rowNumber < table.Rows.Count))
          {
            string message = String.Format(
                                            CultureInfo.CurrentCulture,
                                            "The row {0} already exists. To create a new row specify row number as {1}, or specify path to a table, or use the -Force parameter",
                                            rowNumber,
                                            table.Rows.Count);

            throw new ArgumentException(message);
          }

          if (rowNumber > table.Rows.Count)
          {
            string message = String.Format(
                                           CultureInfo.CurrentCulture,
                                           "To create a new row specify row number as {0}, or specify path to a table",
                                           table.Rows.Count);

            throw new ArgumentException(message);
          }

          // Create a new row and update the row with the input
          // provided by the user
          DataRow row = table.NewRow();
          for (int i = 0; i < rowValues.Length; i++)
          {
            row[i] = rowValues[i];
          }

          table.Rows.Add(row);

          if (ShouldProcess(tableName, "update rows"))
          {
            // Update the table from memory back to the data source.
            da.Update(ds, tableName);
          }
        } // End else if (String...) block.
      } // End else block.
    } // End NewItem method.

    /// <summary>
    /// The Windows PowerShell engine calls this method when the Copy-Item
    /// cmdlet is run. This method copies an item at the specified path to
    /// the location specified.
    /// </summary>
    /// <param name="path">
    /// Path to the item to copy.
    /// </param>
    /// <param name="copyPath">
    /// Path to the item to copy to.
    /// </param>
    /// <param name="recurse">
    /// Tells the provider to recurse subcontainers when copying.
    /// </param>
    protected override void CopyItem(string path, string copyPath, bool recurse)
    {
      string tableName, copyTableName;
      int rowNumber, copyRowNumber;

      PathType type = this.GetNamesFromPath(path, out tableName, out rowNumber);
      PathType copyType = this.GetNamesFromPath(copyPath, out copyTableName, out copyRowNumber);

      if (type == PathType.Invalid)
      {
        this.ThrowTerminatingInvalidPathException(path);
      }

      if (type == PathType.Invalid)
      {
        this.ThrowTerminatingInvalidPathException(copyPath);
      }

      // Get the table and the table to copy to.
      OdbcDataAdapter da = this.GetAdapterForTable(tableName);
      if (da == null)
      {
        return;
      }

      DataSet ds = this.GetDataSetForTable(da, tableName);
      DataTable table = this.GetDataTable(ds, tableName);

      OdbcDataAdapter cda = this.GetAdapterForTable(copyTableName);
      if (cda == null)
      {
        return;
      }

      DataSet cds = this.GetDataSetForTable(cda, copyTableName);
      DataTable copyTable = this.GetDataTable(cds, copyTableName);

      // If the source represents a table.
      if (type == PathType.Table)
      {
        // If copyPath does not represent a table.
        if (copyType != PathType.Table)
        {
          ArgumentException e = new ArgumentException("Table can only be copied on to another table location");
          WriteError(new ErrorRecord(
                                     e,
                                     "PathNotValid",
                                     ErrorCategory.InvalidArgument,
                                     copyPath));

          throw e;
        }

        // If the table already exists then force parameter should be set
        // to force a copy.
        if (!Force && this.GetTable(copyTableName) != null)
        {
          throw new ArgumentException("Specified path already exists");
        }

        for (int i = 0; i < table.Rows.Count; i++)
        {
          DataRow row = table.Rows[i];
          DataRow copyRow = copyTable.NewRow();

          copyRow.ItemArray = row.ItemArray;
          copyTable.Rows.Add(copyRow);
        }
      }
      else
      {
        if (copyType == PathType.Row)
        {
          if (!Force && (copyRowNumber < copyTable.Rows.Count))
          {
            throw new ArgumentException("Specified path already exists.");
          }

          DataRow row = table.Rows[rowNumber];
          DataRow copyRow = null;

          if (copyRowNumber < copyTable.Rows.Count)
          {
            // Copy to an existing row.
            copyRow = copyTable.Rows[copyRowNumber];
            copyRow.ItemArray = row.ItemArray;
            copyRow[0] = this.GetNextID(copyTable);
          }
          else if (copyRowNumber == copyTable.Rows.Count)
          {
            // Copy to the next row in the table that will
            // be created.
            copyRow = copyTable.NewRow();
            copyRow.ItemArray = row.ItemArray;
            copyRow[0] = this.GetNextID(copyTable);
            copyTable.Rows.Add(copyRow);
          }
          else
          {
            // Attempting to copy to a nonexistent row or a row
            // that cannot be created now - throw an exception.
            string message = String.Format(
                                           CultureInfo.CurrentCulture,
                                           "The item cannot be specified to the copied row. Specify row number as {0}, or specify a path to the table.",
                                           table.Rows.Count);

            throw new ArgumentException(message);
          }
        }
        else
        {
          // Destination path specified represents a table,
          // create a new row and copy the item
          DataRow copyRow = copyTable.NewRow();
          copyRow.ItemArray = table.Rows[rowNumber].ItemArray;
          copyRow[0] = this.GetNextID(copyTable);
          copyTable.Rows.Add(copyRow);
        }
      }

      if (ShouldProcess(copyTableName, "CopyItems"))
      {
        cda.Update(cds, copyTableName);
      }
    } // End CopyItem method.

    /// <summary>
    /// The Windows PowerShell engine calls this method when the Remove-Item
    /// cmdlet is run. This method removes (deletes) the item at the specified
    /// path.
    /// </summary>
    /// <param name="path">The path to the item to remove.</param>
    /// <param name="recurse">
    /// True if all children in a subtree should be removed, false if only
    /// the item at the specified path should be removed. Is applicable
    /// only for container (table) items. Its ignored otherwise (even if
    /// specified).
    /// </param>
    /// <remarks>
    /// There are no elements in this store which are hidden from the user.
    /// Hence this method will not check for the presence of the Force
    /// parameter
    /// </remarks>
    protected override void RemoveItem(string path, bool recurse)
    {
      string tableName;
      int rowNumber = 0;

      PathType type = this.GetNamesFromPath(path, out tableName, out rowNumber);

      if (type == PathType.Table)
      {
        // If recurse flag has been specified, delete all the rows as well.
        if (recurse)
        {
          OdbcDataAdapter da = this.GetAdapterForTable(tableName);
          if (da == null)
          {
            return;
          }

          DataSet ds = this.GetDataSetForTable(da, tableName);
          DataTable table = this.GetDataTable(ds, tableName);

          for (int i = 0; i < table.Rows.Count; i++)
          {
            table.Rows[i].Delete();
          }

          if (ShouldProcess(path, "RemoveItem"))
          {
            da.Update(ds, tableName);
            this.RemoveTable(tableName);
          }
        }
        else
        {
          // Remove the table.
          if (ShouldProcess(path, "RemoveItem"))
          {
            this.RemoveTable(tableName);
          }
        }
      }
      else if (type == PathType.Row)
      {
        OdbcDataAdapter da = this.GetAdapterForTable(tableName);
        if (da == null)
        {
          return;
        }

        DataSet ds = this.GetDataSetForTable(da, tableName);
        DataTable table = this.GetDataTable(ds, tableName);

        table.Rows[rowNumber].Delete();

        if (ShouldProcess(path, "RemoveItem"))
        {
          da.Update(ds, tableName);
        }
      }
      else
      {
        this.ThrowTerminatingInvalidPathException(path);
      }
    } // End RemoveItem method.

    #endregion Container Overloads

    #region Helper Methods

    /// <summary>
    /// Checks if a given path is actually a drive name.
    /// </summary>
    /// <param name="path">The path to check.</param>
    /// <returns>
    /// True if the path given represents a drive, false otherwise.
    /// </returns>
    private bool PathIsDrive(string path)
    {
      // Remove the drive name and first path separator.  If the
      // path is reduced to nothing, it is a drive. Also if its
      // just a drive then there wont be any path separators
      if (String.IsNullOrEmpty(
                      path.Replace(this.PSDriveInfo.Root, string.Empty)) ||
                      String.IsNullOrEmpty(
                      path.Replace(this.PSDriveInfo.Root + this.pathSeparator, string.Empty)))
      {
        return true;
      }
      else
      {
        return false;
      }
    } // End PathIsDrive method.

    /// <summary>
    /// Separates the path into individual elements.
    /// </summary>
    /// <param name="path">The path to split.</param>
    /// <returns>An array of path segments.</returns>
    private string[] ChunkPath(string path)
    {
      // Normalize the path before splitting.
      string normalPath = this.NormalizePath(path);

      // Return the path with the drive name and first path
      // separator character removed, split by the path separator.
      string pathNoDrive = normalPath.Replace(
                                  this.PSDriveInfo.Root + this.pathSeparator,
                                  string.Empty);

      return pathNoDrive.Split(this.pathSeparator.ToCharArray());
    } // End ChunkPath method.

    /// <summary>
    /// Makes sure that the correct path separator character is used.
    /// </summary>
    /// <param name="path">The path to be checked.</param>
    /// <returns>The path with the correct separator.</returns>
    private string NormalizePath(string path)
    {
      string result = path;

      if (!String.IsNullOrEmpty(path))
      {
        result = path.Replace("/", this.pathSeparator);
      }

      return result;
    } // End NormalizePath method.

    /// <summary>
    /// Chunks the path and returns the table name and the row number
    /// from the path.
    /// </summary>
    /// <param name="path">Path to chunk and to obtain information from.</param>
    /// <param name="tableName">Name of the table as represented in the
    /// path.</param>
    /// <param name="rowNumber">Row number obtained from the path.</param>
    /// <returns>what the path represents</returns>
    private PathType GetNamesFromPath(string path, out string tableName, out int rowNumber)
    {
      PathType retVal = PathType.Invalid;
      rowNumber = -1;
      tableName = null;

      // Check to see if the path specified is a drive.
      if (this.PathIsDrive(path))
      {
        return PathType.Database;
      }

      // Chunk the path into parts.
      string[] pathChunks = this.ChunkPath(path);

      switch (pathChunks.Length)
      {
        case 1:
              {
                string name = pathChunks[0];

                if (this.TableNameIsValid(name))
                {
                  tableName = name;
                  retVal = PathType.Table;
                }
              }

              break;

        case 2:
              {
                string name = pathChunks[0];
                if (this.TableNameIsValid(name))
                {
                  tableName = name;
                }

                int number = this.SafeConvertRowNumber(pathChunks[1]);

                if (number >= 0)
                {
                  rowNumber = number;
                  retVal = PathType.Row;
                }
                else
                {
                  WriteError(new ErrorRecord(
                               new ArgumentException("Row number is not valid"),
                               "RowNumberNotValid",
                               ErrorCategory.InvalidArgument,
                               path));
                }
              }

              break;

        default:
              {
                WriteError(new ErrorRecord(
                           new ArgumentException("The path supplied has too many segments"),
                           "PathNotValid",
                           ErrorCategory.InvalidArgument,
                           path));
              }

              break;
      } // End switch(pathChunks...) block.

      return retVal;
    } // End GetNamesFromPath method.

    /// <summary>
    /// Throws an argument exception stating that the specified path does
    /// not represent either a table or a row.
    /// </summary>
    /// <param name="path">Path that is not valid.</param>
    private void ThrowTerminatingInvalidPathException(string path)
    {
      StringBuilder message = new StringBuilder("Path must represent either a table or a row :");
      message.Append(path);

      throw new ArgumentException(message.ToString());
    }

    /// <summary>
    /// Retrieve the list of tables from the database.
    /// </summary>
    /// <returns>
    /// Collection of DatabaseTableInfo objects, each object representing
    /// information about one database table
    /// </returns>
    private Collection<DatabaseTableInfo> GetTables()
    {
      Collection<DatabaseTableInfo> results = new Collection<DatabaseTableInfo>();

      // Using ODBC connection to the database and get the schema of tables.
      AccessDBPSDriveInfo di = this.PSDriveInfo as AccessDBPSDriveInfo;

      if (di == null)
      {
        return null;
      }

      OdbcConnection connection = di.Connection;
      DataTable dt = connection.GetSchema("Tables");
      int count;

      // Iterate through all rows in the schema and create DatabaseTableInfo
      // objects which represents a table.
      foreach (DataRow dr in dt.Rows)
      {
        string tableName = dr["TABLE_NAME"] as string;
        DataColumnCollection columns = null;

        // Find the number of rows in the table.
        try
        {
          string cmd = "Select count(*) from \"" + tableName + "\"";
          OdbcCommand command = new OdbcCommand(cmd, connection);

          count = (int)command.ExecuteScalar();
        }
        catch
        {
          count = 0;
        }

        // Create a DatabaseTableInfo object representing the table.
        DatabaseTableInfo table =
                       new DatabaseTableInfo(dr, tableName, count, columns);

        results.Add(table);
      } // End foreach (DataRow...) block.

      return results;
    } // End GetTables method.

    /// <summary>
    /// Return row information from a specified table.
    /// </summary>
    /// <param name="tableName">The name of the database table from
    /// which to retrieve rows.</param>
    /// <returns>Collection of row information objects.</returns>
    private Collection<DatabaseRowInfo> GetRows(string tableName)
    {
      Collection<DatabaseRowInfo> results =
                 new Collection<DatabaseRowInfo>();

      // Obtain rows in the table and add it to the collection.
      try
      {
        OdbcDataAdapter da = this.GetAdapterForTable(tableName);

        if (da == null)
        {
          return null;
        }

        DataSet ds = this.GetDataSetForTable(da, tableName);
        DataTable table = this.GetDataTable(ds, tableName);

        int i = 0;
        foreach (DataRow row in table.Rows)
        {
          results.Add(new DatabaseRowInfo(row, i.ToString(CultureInfo.CurrentCulture)));
          i++;
        } // End foreach (DataRow...) block.
      }
      catch (Exception e)
      {
        WriteError(new ErrorRecord(
                                   e,
                                   "CannotAccessSpecifiedRows",
                                   ErrorCategory.InvalidOperation,
                                   tableName));
      }

      return results;
    } // End GetRows method.

    /// <summary>
    /// Retrieve information about a single table.
    /// </summary>
    /// <param name="tableName">The table for which to retrieve
    /// data.</param>
    /// <returns>Table information.</returns>
    private DatabaseTableInfo GetTable(string tableName)
    {
      foreach (DatabaseTableInfo table in this.GetTables())
      {
        if (String.Equals(tableName, table.Name, StringComparison.OrdinalIgnoreCase))
        {
          return table;
        }
      }

      return null;
    } // End GetTable method.

    /// <summary>
    /// Removes the specified table from the database
    /// </summary>
    /// <param name="tableName">Name of the table to remove</param>
    private void RemoveTable(string tableName)
    {
      // Validate if tablename is valid and if table is present.
      if (String.IsNullOrEmpty(tableName) || !this.TableNameIsValid(tableName) || !this.TableIsPresent(tableName))
      {
        return;
      }

      // Execute command using ODBC connection to remove a table.
      try
      {
        // Delete the table using an sql statement.
        string sql = "drop table " + tableName;

        AccessDBPSDriveInfo di = this.PSDriveInfo as AccessDBPSDriveInfo;

        if (di == null)
        {
          return;
        }

        OdbcConnection connection = di.Connection;

        OdbcCommand cmd = new OdbcCommand(sql, connection);
        cmd.ExecuteScalar();
      }
      catch (Exception ex)
      {
        WriteError(new ErrorRecord(
                                   ex,
                                   "CannotRemoveSpecifiedTable",
                                   ErrorCategory.InvalidOperation,
                                   null));
      }
     } // End RemoveTable method.

    /// <summary>
    /// Obtain a data adapter for the specified Table.
    /// </summary>
    /// <param name="tableName">Name of the table to obtain the
    /// adapter for</param>
    /// <returns>Adapter object for the specified table</returns>
    /// <remarks>An adapter serves as a bridge between a DataSet (in memory
    /// representation of table) and the data source</remarks>
    private OdbcDataAdapter GetAdapterForTable(string tableName)
    {
      OdbcDataAdapter da = null;
      AccessDBPSDriveInfo di = this.PSDriveInfo as AccessDBPSDriveInfo;

      if (di == null || !this.TableNameIsValid(tableName) || !this.TableIsPresent(tableName))
      {
        return null;
      }

      OdbcConnection connection = di.Connection;

      try
      {
        // Create an ODBC data adapter. This can be used to update the
        // data source with the records that will be created here
        // using data sets
        string sql = "Select * from " + tableName;
        da = new OdbcDataAdapter(new OdbcCommand(sql, connection));

        // Create an ODBC command builder object. This will create sql
        // commands automatically for a single table, thus
        // eliminating the need to create new sql statements for
        // every operation to be done.
        OdbcCommandBuilder cmd = new OdbcCommandBuilder(da);

        // Set the delete cmd for the table here.
        sql = "Delete from " + tableName + " where ID = ?";
        da.DeleteCommand = new OdbcCommand(sql, connection);

        // Specify a DeleteCommand parameter based on the "ID"
        // column.
        da.DeleteCommand.Parameters.Add(new OdbcParameter());
        da.DeleteCommand.Parameters[0].SourceColumn = "ID";

        // Create an InsertCommand based on the sql string
        // Insert into "tablename" values (?,?,?)" where
        // ? represents a column in the table. Note that
        // the number of ? will be equal to the number of
        // columnds
        DataSet ds = new DataSet();

        da.FillSchema(ds, SchemaType.Source);
        ds.Locale = CultureInfo.InvariantCulture;

        sql = "Insert into " + tableName + " values ( ";
        for (int i = 0; i < ds.Tables["Table"].Columns.Count; i++)
        {
          sql += "?, ";
        }

        sql = sql.Substring(0, sql.Length - 2);
        sql += ")";
        da.InsertCommand = new OdbcCommand(sql, connection);

        // Create parameters for the InsertCommand based on the
        // captions of each column
        for (int i = 0; i < ds.Tables["Table"].Columns.Count; i++)
        {
          da.InsertCommand.Parameters.Add(new OdbcParameter());
          da.InsertCommand.Parameters[i].SourceColumn =
                         ds.Tables["Table"].Columns[i].Caption;
        }

        // Open the connection if its not already open
        if (connection.State != ConnectionState.Open)
        {
          connection.Open();
        }
      }
      catch (Exception e)
      {
        WriteError(new ErrorRecord(
                                   e,
                                   "CannotAccessSpecifiedTable",
                                   ErrorCategory.InvalidOperation,
                                  tableName));
      }

      return da;
    } // End GetAdapterForTable method.

    /// <summary>
    /// Gets the DataSet (in memory representation) for the table
    /// for the specified adapter
    /// </summary>
    /// <param name="adapter">Adapter to be used for obtaining
    /// the table</param>
    /// <param name="tableName">Name of the table for which a
    /// DataSet is required</param>
    /// <returns>The DataSet with the filled in schema</returns>
    private DataSet GetDataSetForTable(OdbcDataAdapter adapter, string tableName)
    {
      // Create a dataset object which will provide an in-memory
      // representation of the data being worked upon in the
      // data source.
      DataSet ds = new DataSet();

      // Create a table named "Table" which will contain the same
      // schema as in the data source.
      adapter.Fill(ds, tableName);
      ds.Locale = CultureInfo.InvariantCulture;

      return ds;
    } // End GetDataSetForTable method.

    /// <summary>
    /// Get the DataTable object which can be used to operate on
    /// for the specified table in the data source.
    /// </summary>
    /// <param name="ds">DataSet object which contains the tables
    /// schema</param>
    /// <param name="tableName">Name of the table</param>
    /// <returns>Corresponding DataTable object representing
    /// the table.</returns>
    private DataTable GetDataTable(DataSet ds, string tableName)
    {
      DataTable table = ds.Tables[tableName];
      table.Locale = CultureInfo.InvariantCulture;

      return table;
    } // End GetDataTable method.

    /// <summary>
    /// Retrieves a single row from the named table.
    /// </summary>
    /// <param name="tableName">The table that contains the
    /// numbered row.</param>
    /// <param name="row">The index of the row to return.</param>
    /// <returns>The specified table row.</returns>
    private DatabaseRowInfo GetRow(string tableName, int row)
    {
      Collection<DatabaseRowInfo> di = this.GetRows(tableName);

      // If the row is invalid write an appropriate error else return the
      // corresponding row information.
      if (row < di.Count && row >= 0)
      {
        return di[row];
      }
      else
      {
        WriteError(new ErrorRecord(
                  new ItemNotFoundException(),
                  "RowNotFound",
                  ErrorCategory.ObjectNotFound,
                  row.ToString(CultureInfo.CurrentCulture)));
      }

      return null;
    } // End GetRow method.

    /// <summary>
    /// Method to safely convert a string representation of a row number
    /// into its Int32 equivalent.
    /// </summary>
    /// <param name="rowNumberAsStr">String representation of the row
    /// number</param>
    /// <returns>The integer equivalint row number.</returns>
    /// <remarks>If there is an exception, -1 is returned</remarks>
    private int SafeConvertRowNumber(string rowNumberAsStr)
    {
      int rowNumber = -1;
      try
      {
        rowNumber = Convert.ToInt32(rowNumberAsStr, CultureInfo.CurrentCulture);
      }
      catch (FormatException fe)
      {
        WriteError(new ErrorRecord(
                                   fe,
                                   "RowStringFormatNotValid",
                                   ErrorCategory.InvalidData,
                                   rowNumberAsStr));
      }
      catch (OverflowException oe)
      {
        WriteError(new ErrorRecord(
                                   oe,
                                   "RowStringConversionToNumberFailed",
                                   ErrorCategory.InvalidData,
                                   rowNumberAsStr));
      }

      return rowNumber;
    } // End SafeConvertRowNumber method.

    /// <summary>
    /// Check to see if a table name is valid.
    /// </summary>
    /// <param name="tableName">Table name to validate</param>
    /// <returns>True if the table name is valid.</returns>
    /// <remarks>Helps to check for SQL injection attacks</remarks>
    private bool TableNameIsValid(string tableName)
    {
      Regex exp = new Regex(pattern, RegexOptions.Compiled | RegexOptions.IgnoreCase);

      if (exp.IsMatch(tableName))
      {
        return true;
      }

      WriteError(new ErrorRecord(
                                 new ArgumentException("Table name not valid"),
                                 "TableNameNotValid",
                                 ErrorCategory.InvalidArgument,
                                 tableName));
      return false;
    } // End TableNameIsValid method.

    /// <summary>
    /// Checks to see if the specified table is present in the
    /// database
    /// </summary>
    /// <param name="tableName">Name of the table to check</param>
    /// <returns>true, if table is present, false otherwise</returns>
    private bool TableIsPresent(string tableName)
    {
      // Using ODBC connection to the database and get the schema of tables
      AccessDBPSDriveInfo di = this.PSDriveInfo as AccessDBPSDriveInfo;
      if (di == null)
      {
        return false;
      }

      OdbcConnection connection = di.Connection;
      DataTable dt = connection.GetSchema("Tables");

      // Check to see if the specified tableName is available
      // in the list of tables present in the database.
      foreach (DataRow dr in dt.Rows)
      {
        string name = dr["TABLE_NAME"] as string;
        if (name.Equals(tableName, StringComparison.OrdinalIgnoreCase))
        {
          return true;
        }
      }

      WriteError(new ErrorRecord(
                 new ArgumentException("Specified Table is not present in database"),
                 "TableNotAvailable",
                 ErrorCategory.InvalidArgument,
                 tableName));

      return false;
    } // End TableIsPresent method.

    /// <summary>
    /// Gets the next available ID in the table
    /// </summary>
    /// <param name="table">DataTable object representing the table to
    /// search for ID</param>
    /// <returns>next available id</returns>
    private int GetNextID(DataTable table)
    {
      int big = 0;
      int id = 0;

      for (int i = 0; i < table.Rows.Count; i++)
      {
        DataRow row = table.Rows[i];

        object o = row["ID"];

        if (o.GetType().Name.Equals("Int16"))
        {
          id = (int)(short)o;
        }
        else
        {
          id = (int)o;
        }

        if (big < id)
        {
          big = id;
        }
      }

      big++;
      return big;
    } // End GetNextId method.
    #endregion Helper Methods
  }

  #endregion AccessDBProvider

  #region Helper Classes

  #region DatabaseTableInfo

  /// <summary>
  /// Contains information specific to the database table.
  /// Similar to the DirectoryInfo class.
  /// </summary>
  public class DatabaseTableInfo
  {
    /// <summary>
    /// Data about a row in a table.
    /// </summary>
    private DataRow data;

    /// <summary>
    /// The name of a table in the database.
    /// </summary>
    private string name;

    /// <summary>
    /// The number of rows in a table.
    /// </summary>
    private int rowCount;

    /// <summary>
    /// Data about the columns in a table.
    /// </summary>
    private DataColumnCollection columns;

    /// <summary>
    /// Initializes a new instance of the DatabaseTableInfo class.
    /// </summary>
    /// <param name="row">The row definition.</param>
    /// <param name="name">The table name.</param>
    /// <param name="rowCount">The number of rows in the table.</param>
    /// <param name="columns">Information on the column tables.</param>
    public DatabaseTableInfo(
                             DataRow row,
                             string name,
                             int rowCount,
                             DataColumnCollection columns)
    {
        this.Name = name;
        this.Data = row;
        this.RowCount = rowCount;
        this.Columns = columns;
    } // End DatabaseTableInfo constructor.

    /// <summary>
    /// Gets or sets the row data from the "tables" schema.
    /// </summary>
    public DataRow Data
    {
      get
      {
        return this.data;
      }

      set
      {
        this.data = value;
      }
    }

    /// <summary>
    /// Gets or sets the table name.
    /// </summary>
    public string Name
    {
      get
      {
        return this.name;
      }

      set
      {
        this.name = value;
      }
    }

    /// <summary>
    /// Gets or sets the number of rows in the table.
    /// </summary>
    public int RowCount
    {
      get
      {
        return this.rowCount;
      }

      set
      {
        this.rowCount = value;
      }
    }

    /// <summary>
    /// Gets or sets the column definitions for the table.
    /// </summary>
    public DataColumnCollection Columns
    {
      get
      {
        return this.columns;
      }

      set
      {
         this.columns = value;
      }
    }
  } // End DatabaseTableInfo class.

  #endregion DatabaseTableInfo

  #region DatabaseRowInfo

  /// <summary>
  /// Contains information specific to an individual table row.
  /// Analogous to the FileInfo class.
  /// </summary>
  public class DatabaseRowInfo
  {
    /// <summary>
    /// Gets or sets data information.
    /// </summary>
    public DataRow Data
    {
          get
          {
              return this.data;
          }

          set
          {
              this.data = value;
          }
      }

      private DataRow data;

      /// <summary>
      /// Gets or sets the row index.
      /// </summary>
      public string RowNumber
      {
          get
          {
              return this.rowNumber;
          }

          set
          {
              this.rowNumber = value;
          }
      }

      private string rowNumber;

      /// <summary>
      /// Initializes a new instance of the DatabaseRowInfo class.
      /// </summary>
      /// <param name="row">The row information.</param>
      /// <param name="name">The row index.</param>
      public DatabaseRowInfo(DataRow row, string name)
      {
          this.RowNumber = name;
          this.Data = row;
      } // DatabaseRowInfo
  } // class DatabaseRowInfo

  #endregion DatabaseRowInfo

  #region AccessDBPSDriveInfo

  /// <summary>
  /// Any state associated with the drive should be held here.
  /// In this case, it's the connection to the database.
  /// </summary>
  internal class AccessDBPSDriveInfo : PSDriveInfo
  {
    /// <summary>
    /// Describes the ODBC connection.
    /// </summary>
    private OdbcConnection connection;

    /// <summary>
    /// Initializes a new instance of the AccessDBPSDriveInfo class.
    /// </summary>
    /// <param name="driveInfo">Drive provided by this provider</param>
    public AccessDBPSDriveInfo(PSDriveInfo driveInfo)
        : base(driveInfo)
    {
    }

    /// <summary>
    /// Gets or sets the ODBC connection information.
    /// </summary>
    public OdbcConnection Connection
    {
      get { return this.connection; }
      set { this.connection = value; }
    }
  } // End AccessDBPSDriveInfo class.

  #endregion AccessDBPSDriveInfo

  #endregion Helper Classes
}
```

## See Also
 [System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider)
 [System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider)
 [System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider)
 [Designing Your Windows PowerShell Provider](./provider-types.md)
