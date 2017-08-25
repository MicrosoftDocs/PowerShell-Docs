---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
external help file:  Microsoft.Management.Infrastructure.CimCmdlets.dll-Help.xml
---

# New-CimInstance

## SYNOPSIS
Creates a CIM instance.

## SYNTAX

### ClassNameComputerSet (Default)
```
New-CimInstance [-ClassName] <String> [-Key <String[]>] [[-Property] <IDictionary>] [-Namespace <String>]
 [-OperationTimeoutSec <UInt32>] [-ComputerName <String[]>] [-ClientOnly] [-WhatIf] [-Confirm]
```

### ClassNameSessionSet
```
New-CimInstance [-ClassName] <String> [-Key <String[]>] [[-Property] <IDictionary>] [-Namespace <String>]
 [-OperationTimeoutSec <UInt32>] -CimSession <CimSession[]> [-ClientOnly] [-WhatIf] [-Confirm]
```

### ResourceUriSessionSet
```
New-CimInstance -ResourceUri <Uri> [-Key <String[]>] [[-Property] <IDictionary>] [-Namespace <String>]
 [-OperationTimeoutSec <UInt32>] -CimSession <CimSession[]> [-WhatIf] [-Confirm]
```

### ResourceUriComputerSet
```
New-CimInstance -ResourceUri <Uri> [-Key <String[]>] [[-Property] <IDictionary>] [-Namespace <String>]
 [-OperationTimeoutSec <UInt32>] [-ComputerName <String[]>] [-WhatIf] [-Confirm]
```

### CimClassSessionSet
```
New-CimInstance [-CimClass] <CimClass> [[-Property] <IDictionary>] [-OperationTimeoutSec <UInt32>]
 -CimSession <CimSession[]> [-ClientOnly] [-WhatIf] [-Confirm]
```

### CimClassComputerSet
```
New-CimInstance [-CimClass] <CimClass> [[-Property] <IDictionary>] [-OperationTimeoutSec <UInt32>]
 [-ComputerName <String[]>] [-ClientOnly] [-WhatIf] [-Confirm]
```

## DESCRIPTION
The New-CimInstance cmdlet creates an instance of a CIM class based on the class definition on either the local computer or a remote computer.

Use the Property parameter to set the initial values of the selected properties.

By default, the New-CimInstance cmdlet creates an instance on the local computer.

## EXAMPLES

### Example 1: Create an instance of a CIM class
```
PS C:\>New-CimInstance -ClassName Win32_Environment -Property @{Name="testvar";VariableValue="testvalue";UserName="domain\user"}
```

This command creates an instance of a CIM Class named win32_environment in the root/cimv2 namespace on the computer.

No client side validation is performed if the class does not exist, the properties are wrong, or if the server rejects the call.

If the instance is created successfully, then the New-CimInstance cmdlet outputs the newly created instance.

### Example 2: Create an instance of a CIM class using a class schema
```
PS C:\>$class = Get-CimClass -ClassName Win32_Environment



PS C:\>New-CimInstance -CimClass $class -Property @{Name="testvar";VariableValue="testvalue";UserName="Contoso\User1"}
```

This set of commands retrieves a CIM class object and stores it in a variable named $class using the Get-CimClass cmdlet.
The contents of the variable are then passed to the New-CimInstance cmdlet.

### Example 3: Create a dynamic instance on the client
```
PS C:\>$a = New-CimInstance -ClassName Win32_Process -Property @{Handle=0} -Key Handle -ClientOnly


PS C:\>Get-CimInstance -CimInstance $a


PS C:\>Invoke-CimMethod -CimInstance $a -MethodName GetOwner
```

This set of commands creates a dynamic instance of a CIM class named win32_Process on the client computer without getting the instance from the server.
This set of commands retrieves the dynamic instance and stores it in a variable named $a and passes the contents of the variable to the Get-CimInstance cmdlet.
The Get-CimInstance cmdlet then retrieves a particular single instance, and invokes the GetOwner method using the Invoke-CimMethod cmdlet.

This dynamic instance can be used to perform operations if the instance with this key exists on the server.

### Example 4: Create an instance for a CIM class of a specific namespace
```
PS C:\>$class = Get-CimClass -ClassName MSFT_Something -Namespace root/somewhere



PS C:\>New-CimInstance -CimClass $class -Property @{"Prop1"=1;"Prop2"="value"} -ClientOnly
```

This set of commands gets an instance of a CIM class named MSFT_Something in the namespace root/somewhere and stores it in a variable named $class using the Get-CimClass cmdlet.
The contents of the variable are then passed to the New-CimInstance cmdlet to create a new CIM instance and perform client side validations on the new instance.

If you want to validate the instance, for example, to make sure Prop1 and Prop2 actually exist and that the keys are marked correctly, use the CimClass parameter instead of the ClassName parameter.

You cannot use the ComputerName or CimSession parameter with the ClientOnly parameter.

## PARAMETERS

### -CimClass
Specifies a CIM class object that represents the type of the instance.

You can use the Get-CimClass cmdlet to retrieve the class declaration from a computer.

Using this parameter results in better client side schema validations.

```yaml
Type: CimClass
Parameter Sets: CimClassSessionSet, CimClassComputerSet
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -CimSession
Runs the command using the specified CIM session.
Enter a variable that contains the CIM session, or a command that creates or gets the CIM session, such as the New-CimSession or Get-CimSession cmdlets.
For more information, see about_CimSessions.

```yaml
Type: CimSession[]
Parameter Sets: ClassNameSessionSet, ResourceUriSessionSet, CimClassSessionSet
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ClassName
Specifies the name of the CIM class of which the operation creates an instance. 
NOTE: You can use tab completion to browse the list of classes, because wps_2 gets a list of classes from the local WMI server to provide a list of class names.

```yaml
Type: String
Parameter Sets: ClassNameComputerSet, ClassNameSessionSet
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ClientOnly
Indicates that the instance is only created in wps_1 without going to the CIM server.
You can use this parameter to create an in-memory CIM instance for use in subsequent wps_2 operations.

```yaml
Type: SwitchParameter
Parameter Sets: ClassNameComputerSet, ClassNameSessionSet, CimClassSessionSet, CimClassComputerSet
Aliases: Local

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
Specifies the name of the computer on which you want to run the CIM operation.
You can specify a fully qualified domain name (FQDN), a NetBIOS name, or an IP address.

If you specify this parameter, the cmdlet creates a temporary session to the specified computer using the Ws-Man protocol.

If you do not specify this parameter, the cmdlet performs the operation on the local computer using Component Object Model (COM).

If multiple operations are being performed on the same computer, connecting using a CIM session gives better performance.

```yaml
Type: String[]
Parameter Sets: ClassNameComputerSet, ResourceUriComputerSet, CimClassComputerSet
Aliases: CN, ServerName

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Key
Specifies the properties that are used as keys.
CimSession and ComputerName cannot be used when Key is specified.

```yaml
Type: String[]
Parameter Sets: ClassNameComputerSet, ClassNameSessionSet, ResourceUriSessionSet, ResourceUriComputerSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Namespace
Specifies the namespace of the class for the new instance.

The default namespace is root/cimv2. 
NOTE: You can use tab completion to browse the list of namespaces, because wps_2 gets a list of namespaces from the local WMI server to provide the list of namespaces.

```yaml
Type: String
Parameter Sets: ClassNameComputerSet, ClassNameSessionSet, ResourceUriSessionSet, ResourceUriComputerSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OperationTimeoutSec
Specifies the amount of time that the cmdlet waits for a response from the CIM server.

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

### -Property
Specifies the properties of the CIM instance using a hash table (name-value pairs).

If you specify the CimClass parameter, then the New-CimInstance cmdlet performs a property validation on the client to make sure that the properties specified are consistent with the class declaration on the server.
If the CimClass parameter is not specified, then the property validation is done on the server.

```yaml
Type: IDictionary
Parameter Sets: (All)
Aliases: Arguments

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ResourceUri
Specifies the resource uniform resource identifier (URI) of the resource class or instance.
The URI is used to identify a specific type of resource, such as disks or processes, on a computer.

A URI consists of a prefix and a path to a resource.
For example: 

http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/Win32_LogicalDisk
http://intel.com/wbem/wscim/1/amt-schema/1/AMT_GeneralSettings


                        
By default, if you do not specify this parameter, the DMTF standard resource URI http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/ is used and the class name is appended to it.

ResourceURI can only be used with CIM sessions created using the WSMan protocol, or when specifying the ComputerName parameter, which creates a CIM session using WSMan.
If you specify this parameter without specifying the ComputerName parameter, or if you specify a CIM session created using DCOM protocol, you will get an error, because the DCOM protocol does not support the ResourceURI parameter.

If both the ResourceUri parameter and the Filter parameter are specified, the Filter parameter is ignored.

```yaml
Type: Uri
Parameter Sets: ResourceUriSessionSet, ResourceUriComputerSet
Aliases: 

Required: True
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

### None
This cmdlet accepts no input objects.

## OUTPUTS

### System.Object
This cmdlet returns an object that contains the CIM instance information.

## NOTES

## RELATED LINKS

[Get-CimClass](get-cimclass.md)

[Get-CimInstance](get-ciminstance.md)

[Remove-CimInstance](remove-ciminstance.md)

[Set-CimInstance](Set-CimInstance.md)

