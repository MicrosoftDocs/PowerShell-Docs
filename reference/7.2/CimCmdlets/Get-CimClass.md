---
external help file: Microsoft.Management.Infrastructure.CimCmdlets.dll-Help.xml
Locale: en-US
Module Name: CimCmdlets
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/cimcmdlets/get-cimclass?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-CimClass
---

# Get-CimClass

## SYNOPSIS
Gets a list of CIM classes in a specific namespace.

## SYNTAX

### ComputerSet (Default)

```
Get-CimClass [[-ClassName] <String>] [[-Namespace] <String>] [-OperationTimeoutSec <UInt32>]
 [-ComputerName <String[]>] [-MethodName <String>] [-PropertyName <String>]
 [-QualifierName <String>] [<CommonParameters>]
```

### SessionSet

```
Get-CimClass [[-ClassName] <String>] [[-Namespace] <String>] [-OperationTimeoutSec <UInt32>]
 -CimSession <CimSession[]> [-MethodName <String>] [-PropertyName <String>]
 [-QualifierName <String>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-CimClass` cmdlet retrieves a list of CIM classes in a specific namespace. If there is no
class name supplied, then the cmdlet returns all the classes in the namespace. Unlike a CIM
instance, CIM classes do not contain the CIM session or computer name from which they are retrieved.

## EXAMPLES

### Example 1: Get all the class definitions

This example gets all the class definitions under the namespace **root/cimv2**.

```powershell
Get-CimClass
```

### Example 2: Get the classes with a specific name

This example gets the classes that contain the word **disk** in their names.

```powershell
Get-CimClass -ClassName *disk*
```

### Example 3: Get the classes with a specific method name

This example gets the classes that start with the name **Win32** and have a method name that starts
with **Term**.

```powershell
Get-CimClass -ClassName Win32* -MethodName Term*
```

### Example 4: Get the classes with a specific property name

This example gets the classes that start with the name **Win32** and have a property named
**Handle**.

```powershell
Get-CimClass -ClassName Win32* -PropertyName Handle
```

### Example 5: Get the classes with a specific qualifier name

This example gets the classes that start with the name **Win32**, contain the word **Disk** in their
names and have the specified qualifier **Association**.

```powershell
Get-CimClass -ClassName Win32*Disk* -QualifierName Association
```

### Example 6: Get the class definitions from a specific namespace

This example gets the class definitions that contain the word **Net** in their names from the
specified namespace **root/standardCimv2**.

```powershell
Get-CimClass -Namespace root/standardCimv2 -ClassName *Net*
```

### Example 7: Get the class definitions from a remote server

This example gets the class definitions that contain the word **disk** in their names from the
specified remote servers **Server01** and **Server02**.

```powershell
Get-CimClass -ClassName *disk* -ComputerName Server01, Server02
```

### Example 8: Get the classes by using a CIM session

```powershell
$s = New-CimSession -ComputerName Server01, Server02
Get-CimClass -ClassName *disk* -CimSession $s
```

This set of commands creates a session with multiple computers and stores it into a variable `$s`
using the `New-CimSession` cmdlet, and then gets the classes using the `Get-CimClass` cmdlet.

## PARAMETERS

### -CimSession

Runs the cmdlet in a remote session or on a remote computer. Enter a computer name or a session
object, such as the output of a `New-CimSession` or `Get-CimSession` cmdlet. The default is the
current session on the local computer.

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

### -ClassName

Specifies the name of the CIM class for which to perform the operation. You can use tab completion
to browse the list of classes, because PowerShell gets a list of classes from the local WMI server
to provide a list of class names.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -ComputerName

Specifies the computer on which you want to run the CIM operation. You can specify a fully qualified
domain name (FQDN) a NetBIOS name, or an IP address.

If you specify this parameter, the cmdlet creates a temporary session to the specified computer
using the WsMan protocol.

If you do not specify this parameter, the cmdlet performs the operation on the local computer using
Component Object Model (COM).

If multiple operations are being performed on the same computer, using a CIM session gives better
performance.

```yaml
Type: System.String[]
Parameter Sets: ComputerSet
Aliases: CN, ServerName

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MethodName

Finds the classes that have a method matching this name. You can use wildcard characters with this
parameter.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Namespace

Specifies the namespace for CIM operation. The default namespace is **root/cimv2**. You can use tab
completion to browse the list of namespaces, because PowerShell gets a list of namespaces from the
local WMI server to provide the list of namespaces.

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

### -PropertyName

Finds the classes which have a property matching this name. You can use wildcard characters with
this parameter.

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

### -QualifierName

Filters the classes by class level qualifier name. You can use wildcard characters with this
parameter.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
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

### Microsoft.Management.Infrastructure.CimClass

This cmdlet returns a CIM class object.

## NOTES

## RELATED LINKS

[New-CimSession](New-CimSession.md)

