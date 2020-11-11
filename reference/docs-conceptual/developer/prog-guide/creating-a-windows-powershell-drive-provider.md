---
ms.date: 09/13/2016
ms.topic: reference
title: Creating a Windows PowerShell Drive Provider
description: Creating a Windows PowerShell Drive Provider
---
# Creating a Windows PowerShell Drive Provider

This topic describes how to create a Windows PowerShell drive provider that provides a way to access
a data store through a Windows PowerShell drive. This type of provider is also referred to as
Windows PowerShell drive providers. The Windows PowerShell drives used by the provider provide the
means to connect to the data store.

The Windows PowerShell drive provider described here provides access to a Microsoft Access database.
For this provider, the Windows PowerShell drive represents the database (it is possible to add any
number of drives to a drive provider), the top-level containers of the drive represent the tables in
the database, and the items of the containers represent the rows in the tables.

## Defining the Windows PowerShell Provider Class

Your drive provider must define a .NET class that derives from the
[System.Management.Automation.Provider.Drivecmdletprovider](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider)
base class. Here is the class definition for this drive provider:

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample02/AccessDBProviderSample02.cs" range="29-30":::

Notice that in this example, the
[System.Management.Automation.Provider.Cmdletproviderattribute](/dotnet/api/System.Management.Automation.Provider.CmdletProviderAttribute)
attribute specifies a user-friendly name for the provider and the Windows PowerShell specific
capabilities that the provider exposes to the Windows PowerShell runtime during command processing.
The possible values for the provider capabilities are defined by the
[System.Management.Automation.Provider.Providercapabilities](/dotnet/api/System.Management.Automation.Provider.ProviderCapabilities)
enumeration. This drive provider does not support any of these capabilities.

## Defining Base Functionality

As described in
[Design Your Windows PowerShell Provider](./designing-your-windows-powershell-provider.md), the
[System.Management.Automation.Provider.Drivecmdletprovider](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider)
class derives from the
[System.Management.Automation.Provider.Cmdletprovider](/dotnet/api/System.Management.Automation.Provider.CmdletProvider)
base class that defines the methods needed for initializing and uninitializing the provider. To
implement functionality for adding session-specific initialization information and for releasing
resources that are used by the provider, see
[Creating a Basic Windows PowerShell Provider](./creating-a-basic-windows-powershell-provider.md).
However, most providers (including the provider described here) can use the default implementation
of this functionality that is provided by Windows PowerShell.

## Creating Drive State Information

All Windows PowerShell providers are considered stateless, which means that your drive provider
needs to create any state information that is needed by the Windows PowerShell runtime when it calls
your provider.

For this drive provider, state information includes the connection to the database that is kept as
part of the drive information. Here is code that shows how this information is stored in the
[System.Management.Automation.PSDriveinfo](/dotnet/api/System.Management.Automation.PSDriveInfo)
object that describes the drive:

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample02/AccessDBProviderSample02.cs" range="130-151":::

## Creating a Drive

To allow the Windows PowerShell runtime to create a drive, the drive provider must implement the
[System.Management.Automation.Provider.Drivecmdletprovider.Newdrive*](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.NewDrive)
method. The following code shows the implementation of the
[System.Management.Automation.Provider.Drivecmdletprovider.Newdrive*](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.NewDrive)
method for this drive provider:

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample02/AccessDBProviderSample02.cs" range="42-84":::

Your override of this method should do the following:

- Verify that the
  [System.Management.Automation.PSDriveinfo.Root*](/dotnet/api/System.Management.Automation.PSDriveInfo.Root)
  member exists and that a connection to the data store can be made.
- Create a drive and populate the connection member, in support of the `New-PSDrive` cmdlet.
- Validate the
  [System.Management.Automation.PSDriveinfo](/dotnet/api/System.Management.Automation.PSDriveInfo)
  object for the proposed drive.
- Modify the
  [System.Management.Automation.PSDriveinfo](/dotnet/api/System.Management.Automation.PSDriveInfo)
  object that describes the drive with any required performance or reliability information, or
  provide extra data for callers using the drive.
- Handle failures using the
  [System.Management.Automation.Provider.Cmdletprovider.WriteError](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.WriteError)
  method and then return `null`.

  This method returns either the drive information that was passed to the method or a
  provider-specific version of it.

## Attaching Dynamic Parameters to NewDrive

The `New-PSDrive` cmdlet supported by your drive provider might require additional parameters. To
attach these dynamic parameters to the cmdlet, the provider implements the
[System.Management.Automation.Provider.Drivecmdletprovider.Newdrivedynamicparameters*](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.NewDriveDynamicParameters)
method. This method returns an object that has properties and fields with parsing attributes similar
to a cmdlet class or a
[System.Management.Automation.Runtimedefinedparameterdictionary](/dotnet/api/System.Management.Automation.RuntimeDefinedParameterDictionary)
object.

This drive provider does not override this method. However, the following code shows the default
implementation of this method:

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testprovidernewdrivedynamicparameters](Msh_samplestestcmdlets#testprovidernewdrivedynamicparameters)]  -->

## Removing a Drive

To close the database connection, the drive provider must implement the
[System.Management.Automation.Provider.Drivecmdletprovider.Removedrive*](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.RemoveDrive)
method. This method closes the connection to the drive after cleaning up any provider-specific
information.

The following code shows the implementation of the
[System.Management.Automation.Provider.Drivecmdletprovider.Removedrive*](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.RemoveDrive)
method for this drive provider:

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample02/AccessDBProviderSample02.cs" range="91-116":::

If the drive can be removed, the method should return the information passed to the method through
the `drive` parameter. If the drive cannot be removed, the method should write an exception and then
return `null`. If your provider does not override this method, the default implementation of this
method just returns the drive information passed as input.

## Initializing Default Drives

Your drive provider implements the
[System.Management.Automation.Provider.Drivecmdletprovider.Initializedefaultdrives*](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.InitializeDefaultDrives)
method to mount drives. For example, the Active Directory provider might mount a drive for the
default naming context if the computer is joined to a domain.

This method returns a collection of drive information about the initialized drives, or an empty
collection. The call to this method is made after the Windows PowerShell runtime calls the
[System.Management.Automation.Provider.Cmdletprovider.Start*](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.Start)
method to initialize the provider.

This drive provider does not override the
[System.Management.Automation.Provider.Drivecmdletprovider.Initializedefaultdrives*](/dotnet/api/System.Management.Automation.Provider.DriveCmdletProvider.InitializeDefaultDrives)
method. However, the following code shows the default implementation, which returns an empty drive
collection:

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplestestcmdlets#testproviderinitializedefaultdrives](Msh_samplestestcmdlets#testproviderinitializedefaultdrives)]  -->

#### Things to Remember About Implementing InitializeDefaultDrives

All drive providers should mount a root drive to help the user with discoverability. The root drive
might list locations that serve as roots for other mounted drives. For example, the Active Directory
provider might create a drive that lists the naming contexts found in the `namingContext` attributes
on the root Distributed System Environment (DSE). This helps users discover mount points for other
drives.

## Code Sample

For complete sample code, see
[AccessDbProviderSample02 Code Sample](./accessdbprovidersample02-code-sample.md).

## Testing the Windows PowerShell Drive Provider

When your Windows PowerShell provider has been registered with Windows PowerShell, you can test it
by running the supported cmdlets on the command line, including any cmdlets made available by
derivation. Let's test the sample drive provider.

1. Run the `Get-PSProvider` cmdlet to retrieve the list of providers to ensure that the AccessDB drive provider is present:

   **PS> `Get-PSProvider`**

   The following output appears:

   ```Output
   Name                 Capabilities                  Drives
   ----                 ------------                  ------
   AccessDB             None                          {}
   Alias                ShouldProcess                 {Alias}
   Environment          ShouldProcess                 {Env}
   FileSystem           Filter, ShouldProcess         {C, Z}
   Function             ShouldProcess                 {function}
   Registry             ShouldProcess                 {HKLM, HKCU}
   ```

2. Ensure that a database server name (DSN) exists for the database by accessing the **Data
   Sources** portion of the **Administrative Tools** for the operating system. In the **User DSN**
   table, double-click **MS Access Database** and add the drive path `C:\ps\northwind.mdb`.

3. Create a new drive using the sample drive provider:

   ```powershell
   new-psdrive -name mydb -root c:\ps\northwind.mdb -psprovider AccessDb`
   ```

   The following output appears:

   ```Output
   Name     Provider     Root                   CurrentLocation
   ----     --------     ----                   ---------------
   mydb     AccessDB     c:\ps\northwind.mdb
   ```

4. Validate the connection. Because the connection is defined as a member of the drive, you can
   check it using the Get-PDDrive cmdlet.

   > [!NOTE]
   > The user cannot yet interact with the provider as a drive, as the provider needs container
   > functionality for that interaction. For more information, see
   > [Creating a Windows PowerShell Container Provider](./creating-a-windows-powershell-container-provider.md).

   **PS> (get-psdrive mydb).connection**

   The following output appears:

   ```Output
   ConnectionString  : Driver={Microsoft Access Driver (*.mdb)};DBQ=c:\ps\northwind.mdb
   ConnectionTimeout : 15
   Database          : c:\ps\northwind
   DataSource        : ACCESS
   ServerVersion     : 04.00.0000
   Driver            : odbcjt32.dll
   State             : Open
   Site              :
   Container         :
   ```

5. Remove the drive and exit the shell:

   ```powershell
   PS> remove-psdrive mydb
   PS> exit
   ```

## See Also

[Creating Windows PowerShell Providers](./how-to-create-a-windows-powershell-provider.md)

[Design Your Windows PowerShell Provider](./designing-your-windows-powershell-provider.md)

[Creating a Basic Windows PowerShell Provider](./creating-a-basic-windows-powershell-provider.md)
