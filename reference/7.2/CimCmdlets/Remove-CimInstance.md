---
external help file: Microsoft.Management.Infrastructure.CimCmdlets.dll-Help.xml
Locale: en-US
Module Name: CimCmdlets
ms.date: 05/15/2019
online version: https://docs.microsoft.com/powershell/module/cimcmdlets/remove-ciminstance?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Remove-CimInstance
---
# Remove-CimInstance

## SYNOPSIS
Removes a CIM instance from a computer.

## SYNTAX

### CimInstanceComputerSet (Default)

```
Remove-CimInstance [-ResourceUri <Uri>] [-ComputerName <String[]>] [-OperationTimeoutSec <UInt32>]
 [-InputObject] <CimInstance> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### CimInstanceSessionSet

```
Remove-CimInstance -CimSession <CimSession[]> [-ResourceUri <Uri>] [-OperationTimeoutSec <UInt32>]
 [-InputObject] <CimInstance> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### QuerySessionSet

```
Remove-CimInstance -CimSession <CimSession[]> [[-Namespace] <String>]
 [-OperationTimeoutSec <UInt32>] [-Query] <String> [-QueryDialect <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### QueryComputerSet

```
Remove-CimInstance [-ComputerName <String[]>] [[-Namespace] <String>]
 [-OperationTimeoutSec <UInt32>] [-Query] <String> [-QueryDialect <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

This cmdlet removes a CIM instance from a CIM server. You can specify the CIM instance to remove by
using either a CIM instance object retrieved by the `Get-CimInstance` cmdlet, or by specifying a
query.

If the **InputObject** parameter is not specified, the cmdlet works in one of the following ways:

- If neither the **ComputerName** parameter nor the **CimSession** parameter is specified, then this
  cmdlet works on local Windows Management Instrumentation (WMI) using a Component Object Model
  (COM) session.
- If either the **ComputerName** parameter or the **CimSession** parameter is specified, then this
  cmdlet works against the CIM server specified by either the **ComputerName** parameter or the
  **CimSession** parameter.

## EXAMPLES

### Example 1: Remove the CIM instance

This example use the **Query** parameter to remove CIM instances from the class named
**Win32_Environment** that start with the character string **testvar** .

```powershell
Remove-CimInstance -Query 'Select * from Win32_Environment where name LIKE "testvar%"'
```

### Example 2: Remove the CIM instance using CIM instance object

This example retrieves the CIM instance objects filtered by the **Query** parameter and stores them
in variable named `$var` using the `Get-CimInstance` cmdlet. The contents of the variable are then
passed to the `Remove-CimInstance` cmdlet, which removes the CIM instances.

```powershell
notepad.exe
$var = Get-CimInstance -Query 'Select * from Win32_Process where name LIKE "notepad%"'
Remove-CimInstance -InputObject $var
```

## PARAMETERS

### -CimSession

Runs the command using the specified CIM session. Enter a variable that contains the CIM session, or
a command that creates or gets the CIM session, such as the `New-CimSession` or `Get-CimSession`
cmdlets. For more information, see
[about_CimSession](../Microsoft.PowerShell.Core/About/about_CimSession.md).

```yaml
Type: Microsoft.Management.Infrastructure.CimSession[]
Parameter Sets: CimInstanceSessionSet, QuerySessionSet
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
Parameter Sets: CimInstanceComputerSet, QueryComputerSet
Aliases: CN, ServerName

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies a CIM instance object to be removed from the CIM server. The object passed to the cmdlet
is not changed, only the instance in the CIM server is removed.

```yaml
Type: Microsoft.Management.Infrastructure.CimInstance
Parameter Sets: CimInstanceComputerSet, CimInstanceSessionSet
Aliases: CimInstance

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Namespace

Specifies the namespace for the CIM operation. The default namespace is **root/cimv2**. You can use
tab completion to browse the list of namespaces, because PowerShell gets a list of namespaces from
the local WMI server to provide the list of namespaces.

```yaml
Type: System.String
Parameter Sets: QuerySessionSet, QueryComputerSet
Aliases:

Required: False
Position: 2
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

### -Query

Specifies a query to run on the CIM server. You can specify the query dialect using the
**QueryDialect** parameter.

If the value specified contains double quotes (`"`), single quotes (`'`), or a backslash (`\`), you
must escape those characters by prefixing them with the backslash (`\`) character. If the value
specified uses the WQL LIKE operator, then you must escape the following characters by enclosing
them in square brackets (`[]`): percent (`%`), underscore (`_`), or opening square bracket (`[`).

```yaml
Type: System.String
Parameter Sets: QuerySessionSet, QueryComputerSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -QueryDialect

Specifies the query language used for the Query parameter. The acceptable values for this parameter
are: **WQL** or **CQL**. The default value is **WQL**.

```yaml
Type: System.String
Parameter Sets: QuerySessionSet, QueryComputerSet
Aliases:

Required: False
Position: Named
Default value: WQL
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

ResourceURI can only be used with CIM sessions created using the WSMan protocol, or when specifying
the ComputerName parameter, which creates a CIM session using WSMan. If you specify this parameter
without specifying the ComputerName parameter, or if you specify a CIM session created using DCOM
protocol, you get an error, because the DCOM protocol does not support the ResourceURI parameter.

If both the **ResourceUri** parameter and the **Filter** parameter are specified, the **Filter**
parameter is ignored.

```yaml
Type: System.Uri
Parameter Sets: CimInstanceComputerSet, CimInstanceSessionSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
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

### None

This cmdlet produces no outputs.

## NOTES

## RELATED LINKS

[New-CimInstance](New-CimInstance.md)

[Get-CimInstance](get-ciminstance.md)

[Set-CimInstance](Set-CimInstance.md)

