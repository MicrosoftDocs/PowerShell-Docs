---
external help file: Microsoft.Management.Infrastructure.CimCmdlets.dll-Help.xml
Locale: en-US
Module Name: CimCmdlets
ms.date: 02/21/2019
online version: https://docs.microsoft.com/powershell/module/cimcmdlets/get-ciminstance?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-CimInstance
---

# Get-CimInstance

## SYNOPSIS
Gets the CIM instances of a class from a CIM server.

## SYNTAX

### ClassNameComputerSet (Default)

```
Get-CimInstance [-ClassName] <String> [-ComputerName <String[]>] [-KeyOnly] [-Namespace <String>]
 [-OperationTimeoutSec <UInt32>] [-QueryDialect <String>] [-Shallow] [-Filter <String>]
 [-Property <String[]>] [<CommonParameters>]
```

### ResourceUriSessionSet

```
Get-CimInstance -CimSession <CimSession[]> -ResourceUri <Uri> [-KeyOnly] [-Namespace <String>]
 [-OperationTimeoutSec <UInt32>] [-Shallow] [-Filter <String>] [-Property <String[]>]
 [<CommonParameters>]
```

### QuerySessionSet

```
Get-CimInstance -CimSession <CimSession[]> [-ResourceUri <Uri>] [-Namespace <String>]
 [-OperationTimeoutSec <UInt32>] -Query <String> [-QueryDialect <String>] [-Shallow]
 [<CommonParameters>]
```

### ClassNameSessionSet

```
Get-CimInstance -CimSession <CimSession[]> [-ClassName] <String> [-KeyOnly] [-Namespace <String>]
 [-OperationTimeoutSec <UInt32>] [-QueryDialect <String>] [-Shallow] [-Filter <String>]
 [-Property <String[]>] [<CommonParameters>]
```

### CimInstanceSessionSet

```
Get-CimInstance -CimSession <CimSession[]> [-ResourceUri <Uri>] [-OperationTimeoutSec <UInt32>]
 [-InputObject] <CimInstance> [<CommonParameters>]
```

### CimInstanceComputerSet

```
Get-CimInstance [-ResourceUri <Uri>] [-ComputerName <String[]>] [-OperationTimeoutSec <UInt32>]
 [-InputObject] <CimInstance> [<CommonParameters>]
```

### ResourceUriComputerSet

```
Get-CimInstance -ResourceUri <Uri> [-ComputerName <String[]>] [-KeyOnly] [-Namespace <String>]
 [-OperationTimeoutSec <UInt32>] [-Shallow] [-Filter <String>] [-Property <String[]>]
 [<CommonParameters>]
```

### QueryComputerSet

```
Get-CimInstance [-ResourceUri <Uri>] [-ComputerName <String[]>] [-Namespace <String>]
 [-OperationTimeoutSec <UInt32>] -Query <String> [-QueryDialect <String>] [-Shallow]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-CimInstance` cmdlet gets the CIM instances of a class from a CIM server. You can specify
either the class name or a query for this cmdlet. This cmdlet returns one or more CIM instance
objects representing a snapshot of the CIM instances present on the CIM server.

If the **InputObject** parameter is not specified, the cmdlet works in one of the following ways:

- If neither the **ComputerName** parameter nor the **CimSession** parameter is specified, then this
  cmdlet works on local Windows Management Instrumentation (WMI) using a Component Object Model
  (COM) session.
- If either the **ComputerName** parameter or the **CimSession** parameter is specified, then this
  cmdlet works against the CIM server specified by either the **ComputerName** parameter or the
  **CimSession** parameter.

If the **InputObject** parameter is specified, the cmdlet works in one of the following ways:

- If neither the **ComputerName** parameter nor the **CimSession** parameter is specified, then this
  cmdlet uses the CIM session or computer name from the input object.
- If the either the **ComputerName** parameter or the **CimSession** parameter is specified, then
  this cmdlet uses the either the CimSession parameter value or **ComputerName** parameter value.

## EXAMPLES

### Example 1: Get the CIM instances of a specified class

This example retrieves the CIM instances of a class named **Win32_Process**.

```powershell
Get-CimInstance -ClassName Win32_Process
```

### Example 2: Get a list of namespaces from a WMI server

This example retrieves a list of namespaces under the **Root** namespace on a WMI server.

```powershell
Get-CimInstance -Namespace root -ClassName __Namespace
```

### Example 3: Get instances of a class filtered by using a query

This example retrieves all the CIM instances that start with the letter **P** of a class named
**Win32_Process** using the query specified by a **Query** parameter.

```powershell
Get-CimInstance -Query "SELECT * from Win32_Process WHERE name LIKE 'P%'"
```

### Example 4: Get instances of a class filtered by using a class name and a filter expression

This example retrieves all the CIM instances that start with the letter **P** of a class named
**Win32_Process** using the Filter parameter.

```powershell
Get-CimInstance -ClassName Win32_Process -Filter "Name like 'P%'"
```

### Example 5: Get the CIM instances with only key properties filled in

This example creates a new CIM instance in memory for a class named **Win32_Process** with
the key property `@{ "Handle"=0 }` and stores it in a variable named `$x`. The variable is passed as
a CIM instance to the `Get-CimInstance` cmdlet to get a particular instance.

```powershell
$x = New-CimInstance -ClassName Win32_Process -Namespace root\cimv2 -Property @{ "Handle"=0 } -Key Handle -ClientOnly
Get-CimInstance -CimInstance $x
```

### Example 6: Retrieve CIM instances and reuse them

This example gets the CIM instances of a class named **Win32_Process** and stores them in
the variables `$x` and `$y`. The variable `$x` is then formatted in a table containing only the
**Name** and **KernelModeTime** properties, the table set to **AutoSize**.

```powershell
$x,$y = Get-CimInstance -ClassName Win32_Process
$x | Format-Table -Property Name,KernelModeTime -AutoSize
```

```Output
Name                 KernelModeTime
----                 --------------
System Idle Process 157238797968750
```

### Example 7: Get CIM instances from remote computer

This example retrieves the CIM instances of a class named **Win32_ComputerSystem** from the remote
computers named **Server01** and **Server02**.

```powershell
Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName Server01,Server02
```

### Example 8: Getting only the key properties, instead of all properties

This example retrieves only the key properties, which reduces the size of the object and network
traffic.

```powershell
$x = Get-CimInstance -Class Win32_Process -KeyOnly
$x | Invoke-CimMethod -MethodName GetOwner
```

### Example 9: Getting only a subset of properties, instead of all properties

This example retrieves only a subset of properties, which reduces the size of the object and network
traffic.

```powershell
Get-CimInstance -Class Win32_Process -Property Name,KernelModeTime
$x = Get-CimInstance -Class Win32_Process -Property Name,KernelModeTime
$x | Invoke-CimMethod -MethodName GetOwner
```

The instance retrieved with the **Property** parameter can be used to perform other CIM operations,
for example `Set-CimInstance` or `Invoke-CimMethod`.

### Example 10: Get the CIM instance using CIM session

This example creates a CIM session on the computers named **Server01** and **Server02** using the
`New-CimSession` cmdlet and stores the session information in a variable named `$s`. The contents of
the variable are then passed to `Get-CimInstance` by using the **CimSession** parameter, to get the
CIM instances of the class named **Win32_ComputerSystem**.

```powershell
$s = New-CimSession -ComputerName Server01,Server02
Get-CimInstance -ClassName Win32_ComputerSystem -CimSession $s
```

## PARAMETERS

### -CimSession

Specifies the CIM session to use for this cmdlet. Enter a variable that contains the CIM session or
a command that creates or gets the CIM session, such as the `New-CimSession` or `Get-CimSession`
cmdlets. For more information, see [about_CimSession](../Microsoft.PowerShell.Core/About/about_CimSession.md).

```yaml
Type: Microsoft.Management.Infrastructure.CimSession[]
Parameter Sets: ResourceUriSessionSet, QuerySessionSet, ClassNameSessionSet, CimInstanceSessionSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ClassName

Specifies the name of the CIM class for which to retrieve the CIM instances. You can use tab
completion to browse the list of classes, because PowerShell gets a list of classes from the local
WMI server to provide a list of class names.

```yaml
Type: System.String
Parameter Sets: ClassNameComputerSet, ClassNameSessionSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ComputerName

Specifies computer on which you want to run the CIM operation. You can specify a fully qualified
domain name (FQDN), a NetBIOS name, or an IP address. If you do not specify this parameter, the
cmdlet performs the operation on the local computer using Component Object Model (COM).

If you specify this parameter, the cmdlet creates a temporary session to the specified computer
using the WsMan protocol.

If multiple operations are being performed on the same computer, connect using a CIM session for
better performance.

```yaml
Type: System.String[]
Parameter Sets: ClassNameComputerSet, CimInstanceComputerSet, ResourceUriComputerSet, QueryComputerSet
Aliases: CN, ServerName

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Filter

Specifies a where clause to use as a filter. Specify the clause in either the **WQL** or the **CQL**
query language. Do not include the `WHERE` keyword in the value of the parameter.

```yaml
Type: System.String
Parameter Sets: ClassNameComputerSet, ResourceUriSessionSet, ClassNameSessionSet, ResourceUriComputerSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InputObject

Specifies a CIM instance object to use as input.

If you are already working with a CIM instance object, you can use this parameter to pass the CIM
instance object in order to get the latest snapshot from the CIM server. When you pass a CIM
instance object as an input, `Get-CimInstance` returns the object from server using a get CIM
operation, instead of an enumerate or query operation. Using a get CIM operation is more efficient
than retrieving all instances and then filtering them.

If the CIM class does not implement the get operation, then specifying the **InputObject** parameter
returns an error.

```yaml
Type: Microsoft.Management.Infrastructure.CimInstance
Parameter Sets: CimInstanceSessionSet, CimInstanceComputerSet
Aliases: CimInstance

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -KeyOnly

Indicates that only objects with key properties populated are returned. Specifying the **KeyOnly**
parameter reduces the amount of data transferred over the network.

Use the **KeyOnly** parameter to return only a small portion of the object, which can be used for other
operations, such as the `Set-CimInstance` or `Get-CimAssociatedInstance` cmdlets.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: ClassNameComputerSet, ResourceUriSessionSet, ClassNameSessionSet, ResourceUriComputerSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Namespace

Specifies the namespace of CIM class.

The default namespace is **root/cimv2**. You can use tab completion to browse the list of
namespaces, because PowerShell gets a list of namespaces from the local WMI server to provide the
list of namespaces.

```yaml
Type: System.String
Parameter Sets: ClassNameComputerSet, ResourceUriSessionSet, QuerySessionSet, ClassNameSessionSet, ResourceUriComputerSet, QueryComputerSet
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
Accept pipeline input: False
Accept wildcard characters: False
```

### -Property

Specifies a set of instance properties to retrieve. Use this parameter when you need to reduce the
size of the object returned, either in memory or over the network. The object returned also contains
the key properties even if you have not listed them using the **Property** parameter. Other
properties of the class are present but they are not populated.

```yaml
Type: System.String[]
Parameter Sets: ClassNameComputerSet, ResourceUriSessionSet, ClassNameSessionSet, ResourceUriComputerSet
Aliases: SelectProperties

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Query

Specifies a query to run on the CIM server. If the value specified contains double quotes `"`,
single quotes `'`, or a backslash `\`, you must escape those characters by prefixing them with the
backslash character. If the value specified uses the WQL **LIKE** operator, then you must escape
the following characters by enclosing them in square brackets `[]`: percent `%`, underscore `_`,
or opening square bracket `[`.

You cannot use a metadata query to retrieve a list of classes or an event query. To retrieve a list
of classes, use the `Get-CimClass` cmdlet. To retrieve an event query, use the
`Register-CimIndicationEvent` cmdlet.

You can specify the query dialect using the **QueryDialect** parameter.

```yaml
Type: System.String
Parameter Sets: QuerySessionSet, QueryComputerSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -QueryDialect

Specifies the query language used for the Query parameter. The acceptable values for this parameter
are: **WQL** or **CQL**. The default value is **WQL**.

```yaml
Type: System.String
Parameter Sets: ClassNameComputerSet, QuerySessionSet, ClassNameSessionSet, QueryComputerSet
Aliases:

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
created using DCOM protocol, you will get an error, because the DCOM protocol does not support the
**ResourceURI** parameter.

If both the **ResourceUri** parameter and the **Filter** parameter are specified, the **Filter**
parameter is ignored.

```yaml
Type: System.Uri
Parameter Sets: ResourceUriSessionSet, ResourceUriComputerSet, QuerySessionSet, QueryComputerSet, CimInstanceSessionSet, CimInstanceComputerSet
Aliases:

Required: True (ResourceUriSessionSet, ResourceUriComputerSet), False (QuerySessionSet, QueryComputerSet, CimInstanceSessionSet, CimInstanceComputerSet)
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Shallow

Indicates that the instances of a class are returned without including the instances of any child
classes. By default, the cmdlet returns the instances of a class and its child classes.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: ClassNameComputerSet, ResourceUriSessionSet, QuerySessionSet, ClassNameSessionSet, ResourceUriComputerSet, QueryComputerSet
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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### CIM Instance

This cmdlet accepts an input objects specified with the InputObject parameter.

## OUTPUTS

### CIM Instance

This cmdlet returns one or more CIM instance objects representing a snapshot of the CIM instances on
the CIM server.

## NOTES

## RELATED LINKS

[Format-Table](../microsoft.powershell.utility/format-table.md)

[Get-CimAssociatedInstance](Get-CimAssociatedInstance.md)

[Get-CimClass](Get-CimClass.md)

[Invoke-CimMethod](invoke-cimmethod.md)

[New-CimInstance](New-CimInstance.md)

[Register-CimIndicationEvent](Register-CimIndicationEvent.md)

[Remove-CimInstance](remove-ciminstance.md)

[Set-CimInstance](Set-CimInstance.md)

