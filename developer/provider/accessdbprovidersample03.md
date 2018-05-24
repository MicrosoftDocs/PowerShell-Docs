---
title: "AccessDBProviderSample03 | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 9e576199-49c7-4355-9686-f9ed40c64a5f
caps.latest.revision: 10
---
# AccessDBProviderSample03
This sample shows how to overwrite the [System.Management.Automation.Provider.Itemcmdletprovider.Getitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItem) and [System.Management.Automation.Provider.Itemcmdletprovider.Setitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItem) methods to support calls to the Get-Item and Set-Item cmdlets. The provider class in this sample derives from the [System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider) class.

## Demonstrates

> [!IMPORTANT]
>  Your provider class will most likely derive from one of the following classes and possibly implement other provider interfaces:
>
>  -   [System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider) class.
> -   [System.Management.Automation.Provider.Containercmdletprovider](/dotnet/api/System.Management.Automation.Provider.ContainerCmdletProvider) class. See [AccessDBProviderSample04](./accessdbprovidersample04.md).
> -   [System.Management.Automation.Provider.Navigationcmdletprovider](/dotnet/api/System.Management.Automation.Provider.NavigationCmdletProvider) class. See [AccessDBProviderSample05](./accessdbprovidersample05.md).
>
>  For more information about choosing which provider class to derive from based on provider features, see [Designing Your Windows PowerShell Provider](./provider-types.md).

 This sample demonstrates the following:

-   Declaring the `CmdletProvider` attribute.

-   Defining a provider class that derives from the [System.Management.Automation.Provider.Itemcmdletprovider](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider) class.

-   Overwriting the [System.Management.Automation.Provider.Drivecmdletprovider.Newdrive*](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.NewDrive) method to change the behavior of the New-PSDrive cmdlet, allowing the user to create new drives. (This sample does not show how to add dynamic parameters to the New-PSDrive cmdlet.)

-   Overwriting the [System.Management.Automation.Provider.Drivecmdletprovider.Removedrive*](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.RemoveDrive) method to support removing existing drives.

-   Overwriting the [System.Management.Automation.Provider.Itemcmdletprovider.Getitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.GetItem) method to change the behavior of the Get-Item cmdlet, allowing the user to retrieve items from the data store. (This sample does not show how to add dynamic parameters to the Get-Item cmdlet.)

-   Overwriting the [System.Management.Automation.Provider.Itemcmdletprovider.Setitem*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.SetItem) method to change the behavior of the Set-Item cmdlet, allowing the user to update the items in the data store. (This sample does not show how to add dynamic parameters to the Get-Item cmdlet.)

-   Overwriting the [System.Management.Automation.Provider.Itemcmdletprovider.Itemexists*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.ItemExists) method to change the behavior of the Test-Path cmdlet. (This sample does not show how to add dynamic parameters to the Test-Path cmdlet.)

-   Overwriting the [System.Management.Automation.Provider.Itemcmdletprovider.Isvalidpath*](/dotnet/api/System.Management.Automation.Provider.ItemCmdletProvider.IsValidPath) method to determine if the provided path is valid.

## Example
 This sample shows how to overwrite the methods needed to get and set items in a Microsoft Access data base.

<!-- TODO!!!: review snippet reference  [!CODE [PSSample_Provider03#AccessDBProviderSample03All](PSSample_Provider03#AccessDBProviderSample03All)]  -->

```csharp
namespace Microsoft.Samples.PowerShell.Providers
{
  using System;
  using System.Collections.ObjectModel;
  using System.Data;
  using System.Data.Odbc;
  using System.Diagnostics;
  using System.Globalization;
  using System.IO;
  using System.Management.Automation;
  using System.Management.Automation.Provider;
  using System.Text;
  using System.Text.RegularExpressions;

  #region AccessDBProvider

  /// <summary>
  /// This sample implements a Windows PowerShell provider class
  /// that acts upon an Access database.
  /// </summary>
  /// <remarks>
  /// This example demonstartes implementions of the item
  /// overloads.
  /// </remarks>
  [CmdletProvider("AccessDB", ProviderCapabilities.None)]
  public class AccessDBProvider : ItemCmdletProvider
  {
    #region Private Properties

    /// <summary>
    /// The characters used to determine if a name is valid.
    /// </summary>
    private static string pattern = @"^[a-z]+[0-9]*_*$";

    /// <summary>
    /// The separator used in path statements.
    /// </summary>
    private string pathSeparator = "\\";

    /// <summary>
    /// The type of data pointed to by the path.
    /// </summary>
    private enum PathType
    {
      /// <summary>
      /// The path points to a database.
      /// </summary>
      Database,

      /// <summary>
      /// The path points to a table in the database.
      /// </summary>
      Table,

      /// <summary>
      /// The path points to a row in a table.
      /// </summary>
      Row,

      /// <summary>
      /// The path is not valid.
      /// </summary>The path is not valid.
      Invalid
    }

    #endregion Private Properties

    #region Drive Manipulation

    /// <summary>
    /// The Windows PowerShell engine calls this method when the
    /// New-PSDrive cmdlet is run and the path to this provider is
    /// specified. Create a new drive. This method creates a connection
    /// to the database file and sets the Connection property in the
    /// PSDriveInfo object.
    /// </summary>
    /// <param name="drive">
    /// Information describing the drive to create.
    /// </param>
    /// <returns>An accessDBPSDriveInfo object that represents
    /// the new drive.</returns>
    protected override PSDriveInfo NewDrive(PSDriveInfo drive)
    {
      // Check to see if drive object is null.
      if (drive == null)
      {
        WriteError(new ErrorRecord(
                   new ArgumentNullException("drive"),
                   "NullDrive",
                   ErrorCategory.InvalidArgument,
                   null));
        return null;
      }

      // Check to see if drive root is not null or empty
      // and if it is an existing file.
      if (String.IsNullOrEmpty(drive.Root) || (File.Exists(drive.Root) == false))
      {
        WriteError(new ErrorRecord(
                   new ArgumentException("drive.Root"),
                   "NoRoot",
                   ErrorCategory.InvalidArgument,
                   drive));
        return null;
      }

      // Create a new drive and create an ODBC connection to the new drive.
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
    /// The Windows PowerShell engine calls this method when the
    /// Remove-PSDrive cmdlet is run and the path to this provider is
    /// specified. This method closes the ODBC connection of the drive.
    /// </summary>
    /// <param name="drive">The drive to remove.</param>
    /// <returns>An accessDBPSDriveInfo object that represents
    /// the removed drive.</returns>
    protected override PSDriveInfo RemoveDrive(PSDriveInfo drive)
    {
      // Check to see if drive object is null.
      if (drive == null)
      {
        WriteError(new ErrorRecord(
                   new ArgumentNullException("drive"),
                   "NullDrive",
                   ErrorCategory.InvalidArgument,
                   drive));
        return null;
      }

      // Close ODBC connection to the drive.
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
    /// The Windows PowerShell engine calls this method when the
    /// Get-Item cmdlet is run and the path to this provider is
    /// specified. This method retrieves an item using the specified path.
    /// </summary>
    /// <param name="path">The path to the item to be return.</param>
    protected override void GetItem(string path)
    {
      // Check to see if the path represents a valid drive.
      if (this.PathIsDrive(path))
      {
        WriteItemObject(this.PSDriveInfo, path, true);
        return;
      } // End if(PathIsDrive...).

      // Get the table name and row information from the path and do
      // the necessary actions.
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
    /// The Windows PowerShell engine calls this method when the
    /// Set-Item cmdlet is run and the path to this provider is
    /// specified. This method sets the columns of a row using the
    /// data specified by the values parameter.
    /// </summary>
    /// <param name="path">Specifies the path to the row to be updated.</param>
    /// <param name="values">Comma separated string of values.</param>
    protected override void SetItem(string path, object values)
    {
      // Retrieve the type, table name, and row number from the path parameter.
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

      // Get in-memory representation of table
      OdbcDataAdapter da = this.GetAdapterForTable(tableName);
      if (da == null)
      {
        return;
      }

      DataSet ds = this.GetDataSetForTable(da, tableName);
      DataTable table = this.GetDataTable(ds, tableName);

      if (rowNumber >= table.Rows.Count)
      {
        // The specified row number has to be available. If it is not
        // available NewItem has to be used to add a new row.
        throw new ArgumentException("Row specified is not available");
      } // End if (rowNum...).

      string[] colValues = (values as string).Split(',');

      // Set the data of the specified row.
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
    } // End SetItem method.

    /// <summary>
    /// Tests to see if the specified item exists.
    /// </summary>
    /// <param name="path">The path to the item to verify.</param>
    /// <returns>True if the item is found.</returns>
    protected override bool ItemExists(string path)
    {
      // Check if the path represented is a drive
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
        // If the specified path represents a table, then the DatabaseTableInfo
        // object should exist.
        if (table != null)
        {
          return true;
        }
      }
      else if (type == PathType.Row)
      {
        // If the specified path represents a row, then the DatabaseTableInfo
        // should exist for the table and the row number must be within
        // the maximum row count in the table
        if (table != null && rowNumber < table.RowCount)
        {
          return true;
        }
      }

      return false;
    } // End ItemExists method.

    /// <summary>
    /// Tests to see if the specified path is syntactically valid.
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

      // Convert all separators in the path to a uniform one.
      path = this.NormalizePath(path);

      // Split the path into individual chunks.
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

    #region Helper Methods

    /// <summary>
    /// Checks to see if a given path is actually a drive name.
    /// </summary>
    /// <param name="path">The path to check.</param>
    /// <returns>
    /// True if the path given represents a drive, otherwise false
    /// is returned.
    /// </returns>
    private bool PathIsDrive(string path)
    {
      // Remove the drive name and first path separator.  If the
      // path is reduced to nothing, it is a drive. Also, if it is
      // just a drive then there will not be any path separators.
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
    /// Breaks up the path into individual elements.
    /// </summary>
    /// <param name="path">The path to split.</param>
    /// <returns>An array of path segments.</returns>
    private string[] ChunkPath(string path)
    {
      // Normalize the path before splitting
      string normalPath = this.NormalizePath(path);

      // Return the path with the drive name and first path
      // separator character removed, split by the path separator.
      string pathNoDrive = normalPath.Replace(
                                 this.PSDriveInfo.Root + this.pathSeparator,
                                 string.Empty);
      return pathNoDrive.Split(this.pathSeparator.ToCharArray());
    } // End ChunkPath method.

    /// <summary>
    /// Modifies the path ensuring that the correct path separator
    /// character is used.
    /// </summary>
    /// <param name="path">Path to normanlize.</param>
    /// <returns>Normanlized path.</returns>
    private string NormalizePath(string path)
    {
      string result = path;

      if (!String.IsNullOrEmpty(path))
      {
        result = path.Replace("/", this.pathSeparator);
      }

      return result;
    } // NormalizePath

    /// <summary>
    /// Chunks the path and returns the table name and the row number
    /// from the path.
    /// </summary>
    /// <param name="path">Path to chunk and obtain information</param>
    /// <param name="tableName">Name of the table as represented in the
    /// path.</param>
    /// <param name="rowNumber">Row number obtained from the path.</param>
    /// <returns>The type of data pointed to by the path.</returns>
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

      // Chunks the path into parts.
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
      } // End switch(pathChunks...) statement.

      return retVal;
    } // End GetNamesFromPath method.

    /// <summary>
    /// Throws an argument exception stating that the specified path does
    /// not represent either a table or a row.
    /// </summary>
    /// <param name="path">path which is invalid</param>
    private void ThrowTerminatingInvalidPathException(string path)
    {
      StringBuilder message = new StringBuilder("Path must represent either a table or a row :");
      message.Append(path);

      throw new ArgumentException(message.ToString());
    }

    /// <summary>
    /// Retrieves the list of tables from the database.
    /// </summary>
    /// <returns>
    /// Collection of DatabaseTableInfo objects, each object representing
    /// information about one database table.
    /// </returns>
    private Collection<DatabaseTableInfo> GetTables()
    {
      Collection<DatabaseTableInfo> results =
                  new Collection<DatabaseTableInfo>();

      // Using the ODBC connection to the database, get the schema of tables.
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

        // Create a DatabaseTableInfo object representing the table
        DatabaseTableInfo table =
                      new DatabaseTableInfo(dr, tableName, count, columns);

        results.Add(table);
      } // End foreach (DataRow...) statement.

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
        } // foreach (DataRow...
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
    /// <param name="tableName">The table from which to retrieve
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
    /// Obtain a data adapter for the specified table.
    /// </summary>
    /// <param name="tableName">Name of the table to obtain the
    /// adapter for.</param>
    /// <returns>Adapter object for the specified table.</returns>
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
        // using data sets.
        string sql = "Select * from " + tableName;
        da = new OdbcDataAdapter(new OdbcCommand(sql, connection));

        // Create an ODBC command builder object. This will create sql
        // commands automatically for a single table, thus
        // eliminating the need to create new sql statements for
        // every operation to be done.
        OdbcCommandBuilder cmd = new OdbcCommandBuilder(da);

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
    /// for the specified adapter.
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
      // adapter.FillSchema(ds, SchemaType.Source);
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
    /// the table</returns>
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

      // If the row is not valid, write an appropriate error else return the
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
    /// number.</param>
    /// <returns>Integer value that represents the row number.</returns>
    /// <remarks>If there is an exception, -1 is returned.</remarks>
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
    /// <returns>Boolean value that indicates true if the table name is valid.</returns>
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
      // Using ODBC connection to the database get the schema of tables.
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
    } // End TableIsPresent method

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
   /// Contains the data of a row in the database.
   /// </summary>
   private DataRow data;

   /// <summary>
   /// Contains the name of a table.
   /// </summary>
   private string name;

   /// <summary>
   /// Contains the number of rows in a table.
   /// </summary>
   private int rowCount;

   /// <summary>
   /// Contains the column definitions for a table.
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
    /// Gets or sets row from the "tables" schema.
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
    /// Contains the definition of the data of a row.
    /// </summary>
    private DataRow data;

    /// <summary>
    /// Contains the location of the row in a table.
    /// </summary>
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
    } // End DatabaseRowInfo constructor.

    /// <summary>
    /// Gets or sets the row data information.
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
    /// ODBC connection information.
    /// </summary>
    private OdbcConnection connection;

    /// <summary>
    /// Initializes a new instance of the AccessDBPSDriveInfo class. This
    /// constructor takes one argument.
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
