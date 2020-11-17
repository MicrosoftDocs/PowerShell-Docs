---
external help file: Microsoft.Management.Infrastructure.CimCmdlets.dll-Help.xml
Locale: en-US
Module Name: CimCmdlets
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/cimcmdlets/get-cimassociatedinstance?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-CimAssociatedInstance
---

# Get-CimAssociatedInstance

## SYNOPSIS
Retrieves the CIM instances that are connected to a specific CIM instance by an association.

## SYNTAX

### ComputerSet (Default)

```
Get-CimAssociatedInstance [[-Association] <String>] [-ResultClassName <String>]
 [-InputObject] <CimInstance> [-Namespace <String>] [-OperationTimeoutSec <UInt32>]
 [-ResourceUri <Uri>] [-ComputerName <String[]>] [-KeyOnly] [<CommonParameters>]
```

### SessionSet

```
Get-CimAssociatedInstance [[-Association] <String>] [-ResultClassName <String>]
 [-InputObject] <CimInstance> [-Namespace <String>] [-OperationTimeoutSec <UInt32>]
 [-ResourceUri <Uri>] -CimSession <CimSession[]> [-KeyOnly] [<CommonParameters>]
```

## DESCRIPTION

The `Get-CimAssociatedInstance` cmdlet retrieves the CIM instances connected to a specific CIM
instance, called the source instance, by an association.

In an association, each CIM instance has a named role and the same CIM instance can participate in
an association in different roles.

If the InputObject parameter is not specified, the cmdlet works in one of the following ways:

- If neither the **ComputerName** parameter nor the **CimSession** parameter is specified, then this
  cmdlet works on local Windows Management Instrumentation (WMI) using a Component Object Model
  (COM) session.
- If either the **ComputerName** parameter or the **CimSession** parameter is specified, then this
  cmdlet works against the CIM server specified by either the **ComputerName** parameter or the
  **CimSession** parameter.

## EXAMPLES

### Example 1: Get all the associated instances of a specific instance

```powershell
$disk = Get-CimInstance -ClassName Win32_LogicalDisk -KeyOnly
Get-CimAssociatedInstance -InputObject $disk[1]
```

This set of commands retrieves the instances of the class named Win32_LogicalDisk and stores the
information in a variable named `$disk` using the `Get-CimInstance` cmdlet. The first logical disk
instance in the variable is then used as the input object for the `Get-CimAssociatedInstance` cmdlet
to get all the associated CIM instances of the specified CIM instance.

### Example 2: Get all the associated instances of a specific type

```powershell
$disk = Get-CimInstance -ClassName Win32_LogicalDisk -KeyOnly
Get-CimAssociatedInstance -InputObject $disk[1] -ResultClass Win32_DiskPartition
```

This set of commands retrieves all the instances of the **Win32_LogicalDisk** class and stores
them in a variable named `$disk`. The first logical disk instance in the variable is then used as the
input object for the `Get-CimAssociatedInstance` cmdlet to get all the associated instances that are
associated through the specified association class **Win32_DiskPartition**.

### Example 3: Get all the associated instances through qualifier of a specific class

```powershell
$s = Get-CimInstance -Query "Select * from Win32_Service where name like 'Winmgmt'"
Get-CimClass -ClassName *Service* -Qualifier "Association"
$c.CimClasName
```

```Output
Win32_LoadOrderGroupServiceDependencies
Win32_DependentService
Win32_SystemServices
Win32_LoadOrderGroupServiceMembers
Win32_ServiceSpecificationService
```

```powershell
Get-CimAssociatedInstance -InputObject $s -Association Win32_DependentService
```

This set of commands retrieves the services that depend on WMI service and stores them in a variable
named `$s`. The association class name for the **Win32_DependentService** is retrieved using the
`Get-CimClass` cmdlet by specifying **Association** as the qualifier and is then passed with $s to
the `Get-CimAssociatedInstance` cmdlet to get all the associated instances of the retrieved
association class.

## PARAMETERS

### -Association

Specifies the name of the association class. If you do not specify this parameter, the cmdlet
returns all existing association objects of any type.

For example, if class A is associated with class B through two associations, AB1 and AB2, then this
parameter can be used to specify the type of association, either AB1 or AB2.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CimSession

Runs the command using the specified CIM session. Enter a variable that contains the CIM session, or
a command that creates or gets the CIM session, such as `New-CimSession` or `Get-CimSession`. For
more information, see [about_CimSession](../Microsoft.PowerShell.Core/About/about_CimSession.md).

```yaml
Type: Microsoft.Management.Infrastructure.CimSession[]
Parameter Sets: SessionSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ComputerName

Specifies the name of the computer on which you want to run the CIM operation. You can specify a
fully qualified domain name (FQDN) or a NetBIOS name.

If you specify this parameter, the cmdlet creates a temporary session to the specified computer
using the WsMan protocol.

If you do not specify this parameter, the cmdlet performs the operation on the local computer using
Component Object Model (COM).

If multiple operations are being performed on the same computer, connecting using a CIM session
gives better performance.

```yaml
Type: System.String[]
Parameter Sets: ComputerSet
Aliases: CN, ServerName

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the input to this cmdlet. You can use this parameter, or you can pipe the input to this
cmdlet.

```yaml
Type: Microsoft.Management.Infrastructure.CimInstance
Parameter Sets: (All)
Aliases: CimInstance

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -KeyOnly

Returns objects with only key properties populated. This reduces the amount of data that is
transferred over the network.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Namespace

Specifies the namespace for the CIM operation. The default namespace is root/cimv2.

> [!NOTE]
> You can use tab completion to browse the list of namespaces, because PowerShell gets a
> list of namespaces from the local WMI server to provide the list of namespaces.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OperationTimeoutSec

Specifies the amount of time that the cmdlet waits for a response from the computer. By default, the
value of this parameter is 0, which means that the cmdlet uses the default timeout value for the
server.

If the **OperationTimeoutSec** parameter is set to a value less than the robust connection retry
timeout of 3 minutes, network failures that last more than the value of the **OperationTimeoutSec**
parameter are not recoverable, because the operation on the server times out before the client can
reconnect.

```yaml
Type: System.UInt32
Parameter Sets: (All)
Aliases: OT

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ResourceUri

Specifies the resource uniform resource identifier (URI) of the resource class or instance. The URI
is used to identify a specific type of resource, such as disks or processes, on a computer.

A URI consists of a prefix and a path to a resource. For example:

- `http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/Win32_LogicalDisk`
- `http://intel.com/wbem/wscim/1/amt-schema/1/AMT_GeneralSettings`

By default, if you do not specify this parameter, the DMTF standard resource URI
`http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/` is used and the class name is appended to it.

**ResourceURI** can only be used with CIM sessions created using the WSMan protocol, or when
specifying the **ComputerName** parameter, which creates a CIM session using WSMan. If you specify
this parameter without specifying the **ComputerName** parameter, or if you specify a CIM session
created using DCOM protocol, you get an error, because the DCOM protocol does not support the
**ResourceURI** parameter.

If both the **ResourceUri** parameter and the **Filter** parameter are specified, the **Filter**
parameter is ignored.

```yaml
Type: System.Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResultClassName

Specifies the class name of the associated instances. A CIM instance can be associated with one or
more CIM instances. All associated CIM instances are returned if you do not specify the result class
name.

By default, the value of this parameter is null, and all associated CIM instances are returned.

You can filter the association results to match a specific class name. Filtering happens on the
server. If this parameter is not specified, `Get-CIMAssociatedInstance` returns all existing
associations. For example, if class A is associated with classes B, C and D, then this parameter can
be used to restrict the output to a specific type (B, C or D).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

This cmdlet accepts no input objects.

## OUTPUTS

### System.Object

This cmdlet returns an object.

## NOTES

## RELATED LINKS

[Get-CimClass](get-cimclass.md)

[Get-CimInstance](get-ciminstance.md)

