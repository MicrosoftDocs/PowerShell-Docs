---
external help file: Microsoft.Management.Infrastructure.CimCmdlets.dll-Help.xml
Locale: en-US
Module Name: CimCmdlets
ms.date: 01/21/2020
online version: https://docs.microsoft.com/powershell/module/cimcmdlets/invoke-cimmethod?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Invoke-CimMethod
---

# Invoke-CimMethod

## SYNOPSIS
Invokes a method of a CIM class.

## SYNTAX

### ClassNameComputerSet (Default)

```
Invoke-CimMethod [-ClassName] <String> [-ComputerName <String[]>] [[-Arguments] <IDictionary>]
 [-MethodName] <String> [-Namespace <String>] [-OperationTimeoutSec <UInt32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### ClassNameSessionSet

```
Invoke-CimMethod [-ClassName] <String> -CimSession <CimSession[]> [[-Arguments] <IDictionary>]
 [-MethodName] <String> [-Namespace <String>] [-OperationTimeoutSec <UInt32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### ResourceUriComputerSet

```
Invoke-CimMethod -ResourceUri <Uri> [-ComputerName <String[]>] [[-Arguments] <IDictionary>]
 [-MethodName] <String> [-Namespace <String>] [-OperationTimeoutSec <UInt32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### CimInstanceSessionSet

```
Invoke-CimMethod [-ResourceUri <Uri>] [-InputObject] <CimInstance> -CimSession <CimSession[]>
 [[-Arguments] <IDictionary>] [-MethodName] <String> [-OperationTimeoutSec <UInt32>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### CimInstanceComputerSet

```
Invoke-CimMethod [-ResourceUri <Uri>] [-InputObject] <CimInstance> [-ComputerName <String[]>]
 [[-Arguments] <IDictionary>] [-MethodName] <String> [-OperationTimeoutSec <UInt32>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### ResourceUriSessionSet

```
Invoke-CimMethod -ResourceUri <Uri> -CimSession <CimSession[]> [[-Arguments] <IDictionary>]
 [-MethodName] <String> [-Namespace <String>] [-OperationTimeoutSec <UInt32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### CimClassComputerSet

```
Invoke-CimMethod [-CimClass] <CimClass> [-ComputerName <String[]>] [[-Arguments] <IDictionary>]
 [-MethodName] <String> [-OperationTimeoutSec <UInt32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### CimClassSessionSet

```
Invoke-CimMethod [-CimClass] <CimClass> -CimSession <CimSession[]> [[-Arguments] <IDictionary>]
 [-MethodName] <String> [-OperationTimeoutSec <UInt32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### QueryComputerSet

```
Invoke-CimMethod -Query <String> [-QueryDialect <String>] [-ComputerName <String[]>]
 [[-Arguments] <IDictionary>] [-MethodName] <String> [-Namespace <String>]
 [-OperationTimeoutSec <UInt32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### QuerySessionSet

```
Invoke-CimMethod -Query <String> [-QueryDialect <String>] -CimSession <CimSession[]>
 [[-Arguments] <IDictionary>] [-MethodName] <String> [-Namespace <String>]
 [-OperationTimeoutSec <UInt32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Invoke-CimMethod` cmdlet invokes a method of a CIM class or CIM instance using the name-value
pairs specified by the **Arguments** parameter.

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
  this cmdlet uses the either the **CimSession** parameter value or **ComputerName** parameter
  value. This is not a common scenario.

## EXAMPLES

### Example 1: Invoke a method

This example invokes the **Terminate** method of the **Win32_Process** class.

```powershell
Invoke-CimMethod -Query 'select * from Win32_Process where name like "notepad%"' -MethodName "Terminate"
```

### Example 2: Invoke a method using CIM instance object

This example retrieves the CIM instance object and stores it in a variable named `$x` using the
`Get-CimInstance` cmdlet. The contents of the variable are then used as the **InputObject** for the
`Invoke-CimMethod` cmdlet. The **GetOwner** method is invoked for the **CimInstance**.

```powershell
$x = Get-CimInstance -Query 'Select * from Win32_Process where name like "notepad%"'
Invoke-CimMethod -InputObject $x -MethodName GetOwner
```

### Example 3: Invoke a static method using arguments

This example invokes the **Create** method named using the **Arguments** parameter.

```powershell
Invoke-CimMethod -ClassName Win32_Process -MethodName "Create" -Arguments @{
  CommandLine = 'notepad.exe'; CurrentDirectory = "C:\windows\system32"
}
```

### Example 4: Client-side validation

This example performs client-side validation for the **xyz** method by passing a **CimClass** object
to `Invoke-CimMethod`.

```powershell
$c = Get-CimClass -ClassName Win32_Process
Invoke-CimMethod -CimClass $c -MethodName "xyz" -Arguments @{ CommandLine = 'notepad.exe' }
```

## PARAMETERS

### -Arguments

Specifies the parameters to pass to the called method. Specify the values for this parameter as
name-value pairs, stored in a hash table. The order of the values entered isn't important.

```yaml
Type: System.Collections.IDictionary
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CimClass

Specifies a CIM class object that represents a CIM class definition on the server. Use this
parameter when invoking a static method of a class.

You can use the `Get-CimClass` cmdlet to retrieve a class definition from the server.

Using this parameter results in better client side schema validations.

```yaml
Type: Microsoft.Management.Infrastructure.CimClass
Parameter Sets: CimClassComputerSet, CimClassSessionSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -CimSession

Runs the command using the specified CIM session. Enter a variable that contains the CIM session, or
a command that creates or gets the CIM session, such as the `New-CimSession` or `Get-CimSession`
cmdlets. For more information, see
[about_CimSession](../Microsoft.PowerShell.Core/About/about_CimSession.md).

```yaml
Type: Microsoft.Management.Infrastructure.CimSession[]
Parameter Sets: ClassNameSessionSet, CimInstanceSessionSet, CimClassSessionSet, QuerySessionSet, ResourceUriSessionSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ClassName

Specifies the name of the CIM class for which to perform the operation. This parameter is only used
for static methods. You can use tab completion to browse the list of classes, because PowerShell
gets a list of classes from the local WMI server to provide a list of class names.

```yaml
Type: System.String
Parameter Sets: ClassNameComputerSet, ClassNameSessionSet
Aliases: Class

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ComputerName

Specifies the name of the computer on which you want to run the CIM operation. You can specify a
fully qualified domain name (FQDN), a NetBIOS name, or an IP address.

When using this parameter, the cmdlet creates a temporary session to the specified computer using
the WsMan protocol. Otherwise, the cmdlet performs the operation on the local computer using
Component Object Model (COM).

Connect using a CIM session for better performance when multiple operations are being performed on
the same computer.

```yaml
Type: System.String[]
Parameter Sets: ClassNameComputerSet, ResourceUriComputerSet, CimClassComputerSet, CimInstanceComputerSet, QueryComputerSet
Aliases: CN, ServerName

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InputObject

Specifies a CIM instance object to use as input to invoke a method. This parameter can only be used
to invoke instance methods. To invoke class static methods, use the **Class** parameter or the
**CimClass** parameter.

```yaml
Type: Microsoft.Management.Infrastructure.CimInstance
Parameter Sets: CimInstanceComputerSet, CimInstanceSessionSet
Aliases: CimInstance

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -MethodName

Specifies the name of the CIM method to invoke. This parameter is mandatory and cannot be null or
empty. To invoke static method of a CIM class use the **ClassName** or the **CimClass** parameter.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Name

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Namespace

Specifies the namespace for the CIM operation. The default namespace is **root/cimv2**. You can use
tab completion to browse the list of namespaces, because PowerShell gets a list of namespaces from
the local WMI server to provide the list of namespaces.

```yaml
Type: System.String
Parameter Sets: ClassNameComputerSet, ClassNameSessionSet, ResourceUriComputerSet, ResourceUriSessionSet, QuerySessionSet, QueryComputerSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OperationTimeoutSec

Specifies the amount of time that the cmdlet waits for a response from the computer. By default, the
value is 0, which means that the cmdlet uses the default timeout value for the server.

If the **OperationTimeoutSec** parameter is set to a value less than the default connection retry
timeout of 3 minutes, network failures that last more than the value of the **OperationTimeoutSec**
parameter are not recoverable.

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

Specifies a query to run on the CIM server. A method is invoked on the instances received as a
result of the query. You can specify the query dialect using the **QueryDialect** parameter.

If the value specified contains double quotes (`"`), single quotes (`'`), or a backslash (`\`), you
must escape those characters by prefixing them with the backslash (`\`) character. If the value
specified uses the WQL LIKE operator, then you must escape the following characters by enclosing
them in square brackets (`[]`): percent (`%`), underscore (`_`), or opening square bracket (`[`).

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
are: **WQL** or **CQL**.

The default value is **WQL**.

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

Specifies the resource uniform resource identifier (URI) of the resource class or instance.
The URI is used to identify a specific type of resource, such as disks or processes, on a computer.

A URI consists of a prefix and a path to a resource. For example:

`http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/Win32_LogicalDisk`

`http://intel.com/wbem/wscim/1/amt-schema/1/AMT_GeneralSettings`

By default, if you do not specify this parameter, the DMTF standard resource URI
`http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/` is used and the class name is appended to it.

**ResourceURI** can only be used with CIM sessions created using the WSMan protocol, or when
specifying the **ComputerName** parameter, which creates a CIM session using WSMan.

When you specify this parameter without specifying the **ComputerName** parameter, or when you
specify a CIM session created using DCOM protocol, you get an error. The DCOM protocol does not
support the **ResourceURI** parameter.

If both the **ResourceUri** parameter and the **Filter** parameter are specified, the **Filter**
parameter is ignored.

```yaml
Type: System.Uri
Parameter Sets: CimInstanceComputerSet, CimInstanceSessionSet
Aliases:

Required: True (ResourceUriSessionSet, ResourceUriComputerSet), False (CimInstanceSessionSet, CimInstanceComputerSet)
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
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### CIM class

This cmdlet accepts a CIM class as an input object.

### CIM instance

This cmdlet accepts a CIM instance as an input object.

## OUTPUTS

### System.Management.Automation.PSCustomObject

This cmdlet returns an object.

## NOTES

## RELATED LINKS

[Get-CimClass](get-cimclass.md)

[Get-CimInstance](get-ciminstance.md)

[Get-CimSession](Get-CimSession.md)

[New-CimSession](New-CimSession.md)

