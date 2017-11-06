---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
external help file:  Microsoft.Management.Infrastructure.CimCmdlets.dll-Help.xml
---

# Set-CimInstance

## SYNOPSIS
Modifies a CIM instance on a CIM server by calling the ModifyInstance method of the CIM class..

## SYNTAX

### CimInstanceComputerSet (Default)
```
Set-CimInstance [-ComputerName <String[]>] [-ResourceUri <Uri>] [-OperationTimeoutSec <UInt32>]
 [-InputObject] <CimInstance> [-Property <IDictionary>] [-PassThru] [-WhatIf] [-Confirm]
```

### QuerySessionSet
```
Set-CimInstance -CimSession <CimSession[]> [-Namespace <String>] [-OperationTimeoutSec <UInt32>]
 [-Query] <String> [-QueryDialect <String>] -Property <IDictionary> [-PassThru] [-WhatIf] [-Confirm]
```

### CimInstanceSessionSet
```
Set-CimInstance -CimSession <CimSession[]> [-ResourceUri <Uri>] [-OperationTimeoutSec <UInt32>]
 [-InputObject] <CimInstance> [-Property <IDictionary>] [-PassThru] [-WhatIf] [-Confirm]
```

### QueryComputerSet
```
Set-CimInstance [-ComputerName <String[]>] [-Namespace <String>] [-OperationTimeoutSec <UInt32>]
 [-Query] <String> [-QueryDialect <String>] -Property <IDictionary> [-PassThru] [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Set-CimInstance cmdlet modifies a CIM instance on a CIM server.

If the InputObject parameter is not specified, the cmdlet works in one of the following ways: 

--If neither the ComputerName parameter nor the CimSession parameter is specified, then this cmdlet works on local Windows Management Instrumentation (WMI) using a Component Object Model (COM) session. 
--If either the ComputerName parameter or the CimSession parameter is specified, then this cmdlet works against the CIM server specified by either the ComputerName parameter or the CimSession parameter.

If the InputObject parameter is specified, the cmdlet works in one of the following ways: 

--If neither the ComputerName parameter nor the CimSession parameter is specified, then this cmdlet uses the CIM session or computer name from the input object. 
--If the either the ComputerName parameter or the CimSession parameter is specified, then this cmdlet uses the either the CimSession parameter value or ComputerName parameter value.
Note: This is not very common.

## EXAMPLES

### Example 1: Set the CIM instance
```
PS C:\>Set-CimInstance -Query 'Select * from Win32_Environment where name LIKE "testvar%"' -Property @{VariableValue="abcd"}
```

This command sets the value of the VariableValue property to abcd using the Query parameter.
You can modify instances matching a Windows Management Instrumentation Query Language (WQL) query.

### Example 2: Set the CIM instance property using pipeline
```
PS C:\>Get-CimInstance -Query 'Select * from Win32_Environment where name LIKE "testvar%"' | Set-CimInstance -Property @{VariableValue="abcd"}
```

This command retrieves the CIM instance object filtered by the Query parameter using the Get-CimInstance cmdlet, and then passes the objects to the Set-CimInstance cmdlet, which modifies the value of VariableValue property to abcd.

### Example 3: Set the CIM instance property using input object
```
PS C:\>$x = Get-CimInstance -Query 'Select * from Win32_Environment where Name="testvar"'



PS C:\>Set-CimInstance -InputObject $x -Property @{VariableValue="somevalue"} -PassThru
```

This set of commands retrieves the CIM instance objects filtered by the Query parameter in to a variable ($x) using Get-CimInstance, and then passes the contents of the variable to the Set-CimInstance cmdlet.
Set-CimInstance then modifies the VariableValue property to somevalue.
Because the Passthru parameter is used, this set of commands returns a modified CIM instance object.

### Example 4: Set the CIM instance property
```
PS C:\>$x = Get-CimInstance -Query 'Select * from Win32_Environment where name="testvar"'



PS C:\>$x.VariableValue = "Change"



PS C:\>Set-CimInstance -CimInstance $x -PassThru
```

This set of commands retrieves the CIM instance object that is specified in the Query parameter into a variable ($x) using the Get-CimInstance cmdlet, and changes the VariableValue property value of the object to change.
The CIM instance object is then saved using the Set-CimInstance cmdlet.
Because the Passthru parameter is used, this set of commands returns a modified CIM instance object.

### Example 5: Show the list of CIM instances to modify using WhatIf
```
PS C:\>Set-CimInstance -Query 'Select * from Win32_Environment where name LIKE "testvar%"' -Property @{VariableValue="abcd"} -WhatIf
```

This command uses the common parameter WhatIf to specify that the modification should not be done, but only output what would happen if it were done.

### Example 6: Set the CIM instance after confirmation from the user
```
PS C:\>Set-CimInstance -Query 'Select * from Win32_Environment where name LIKE "testvar%"' -Property @{VariableValue="abcd"} -Confirm
```

This command uses the common parameter Confirm to specify that the modification should be done only after confirmation from the user.

### Example 7: Set the created CIM instance
```
PS C:\>$x = New-CimInstance -ClassName Win32_Environment -Property @{Name="testvar";UserName="domain\user"} -Keys Name,UserName -ClientOnly



PS C:\>Set-CimInstance -CimInstance $x -Property @{VariableValue="somevalue"} -PassThru
```

This set of commands creates a CIM instance with the specified properties using the New-CimInstance cmdlet, and retrieves its contents in to a variable ($x).
The variable is then passed to the Set-CimInstance cmdlet, which modifies the value of VariableValue property to somevalue.
Because the Passthru parameter is used, this set of commands returns a modified CIM instance object.

## PARAMETERS

### -CimSession
Runs the cmdlets on a remote computer.
Enter a computer name or a session object, such as the output of a New-CimSession or Get-CimSession cmdlet.

```yaml
Type: CimSession[]
Parameter Sets: QuerySessionSet, CimInstanceSessionSet
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ComputerName
Specifies the name of the computer on which you want to run the CIM operation.
You can specify a fully qualified domain name (FQDN) or a NetBIOS name.

If you do not specify this parameter, the cmdlet performs the operation on the local computer using Component Object Model (COM).

If you specify this parameter, the cmdlet creates a temporary session to the specified computer using the WsMan protocol.

If multiple operations are being performed on the same computer, connecting using a CIM session gives better performance.

```yaml
Type: String[]
Parameter Sets: CimInstanceComputerSet
Aliases: CN, ServerName

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String[]
Parameter Sets: QueryComputerSet
Aliases: CN, ServerName

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies a CIM instance object to use as input.

```yaml
Type: CimInstance
Parameter Sets: CimInstanceComputerSet, CimInstanceSessionSet
Aliases: CimInstance

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Namespace
Specifies the namespace for the CIM operation.

The default namespace is root/cimv2. 
NOTE: You can use tab completion to browse the list of namespaces, because wps_2 gets a list of namespaces from the local WMI server to provide the list of namespaces.

```yaml
Type: String
Parameter Sets: QuerySessionSet, QueryComputerSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OperationTimeoutSec
Specifies the amount of time that the cmdlet waits for a response from the computer.

By default, the value of this parameter is 0, which means that the cmdlet uses the default timeout value for the server.

If the OperationTimeoutSec parameter is set to a value less than the robust connection retry timeout of 3 minutes, network failures that last more than the value of the OperationTimeoutSec parameter are not recoverable, because the operation on the server times out before the client can reconnect.

```yaml
Type: UInt32
Parameter Sets: (All)
Aliases: OT

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
passthru

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Property
Specifies the properties of the CIM instance as a hash table (using name-value pairs).
Only the properties specified using this parameter are changed.
Other properties of the CIM instance are not changed.

```yaml
Type: IDictionary
Parameter Sets: CimInstanceComputerSet, CimInstanceSessionSet
Aliases: Arguments

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

```yaml
Type: IDictionary
Parameter Sets: QuerySessionSet, QueryComputerSet
Aliases: Arguments

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Query
Specifies a query to run on the CIM server to retrieve CIM instances on which to run the cmdlet.
You can specify the query dialect using the QueryDialect parameter.

If the value specified contains double quotes ("), single quotes ('), or a backslash (\\), you must escape those characters by prefixing them with the backslash (\\) character.
If the value specified uses the WQL LIKE operator, then you must escape the following characters by enclosing them in square brackets (\[\]): percent (%), underscore (_), or opening square bracket (\[).

```yaml
Type: String
Parameter Sets: QuerySessionSet, QueryComputerSet
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -QueryDialect
Specifies the query language used for the Query parameter.
psdx_paramvalues WQL or CQL.

The default value is WQL.

```yaml
Type: String
Parameter Sets: QuerySessionSet, QueryComputerSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ResourceUri
Specifies the resource uniform resource identifier (URI) of the resource class or instance.
The URI is used to identify a specific type of resource, such as disks or processes, on a computer.

A URI consists of a prefix and a path to a resource.
For example: 

 HYPERLINK "http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/Win32_LogicalDisk" http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/Win32_LogicalDisk
 HYPERLINK "http://intel.com/wbem/wscim/1/amt-schema/1/AMT_GeneralSettings" http://intel.com/wbem/wscim/1/amt-schema/1/AMT_GeneralSettings


                        
By default, if you do not specify this parameter, the DMTF standard resource URI http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/ is used and the class name is appended to it.

ResourceURI can only be used with CIM sessions created using the WSMan protocol, or when specifying the ComputerName parameter, which creates a CIM session using WSMan.
If you specify this parameter without specifying the ComputerName parameter, or if you specify a CIM session created using DCOM protocol, you will get an error, because the DCOM protocol does not support the ResourceURI parameter.

If both the ResourceUri parameter and the Filter parameter are specified, the Filter parameter is ignored.

```yaml
Type: Uri
Parameter Sets: CimInstanceComputerSet, CimInstanceSessionSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm
psdx_confirmdesc

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
psdx_whatifdesc

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### Microsoft.Management.Infrastructure.CimInstance

## OUTPUTS

### Microsoft.Management.Infrastructure.CimInstance
When the Passthru parameter is specified, this cmdlet returns a modified CIM instance object.

## NOTES

## RELATED LINKS

[Get-CimInstance](get-ciminstance.md)

[New-CimInstance](New-CimInstance.md)

[Remove-CimInstance](remove-ciminstance.md)

