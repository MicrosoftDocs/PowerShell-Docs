---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821801
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Get-Runspace
---

# Get-Runspace

## SYNOPSIS
Gets active runspaces within a Windows PowerShell host process.

## SYNTAX

### NameParameterSet (Default)
```
Get-Runspace [[-Name] <String[]>] [<CommonParameters>]
```

### IdParameterSet
```
Get-Runspace [-Id] <Int32[]> [<CommonParameters>]
```

### InstanceIdParameterSet
```
Get-Runspace [-InstanceId] <Guid[]> [<CommonParameters>]
```

## DESCRIPTION
The **Get-Runspace** cmdlet gets active runspaces in a Windows PowerShell host process.

## EXAMPLES

### Example 1: Get runspaces 
```powershell
PS C:\> Get-Runspace
```

```Output
 Id Name            ComputerName    Type          State         Availability
 -- ----            ------------    ----          -----         ------------
  1 Runspace1       localhost       Local         Opened        Busy
  2 Runspace2       localhost       Local         Opened        Available
  3 Runspace3       localhost       Local         Opened        Available
```

### Example 2: Get runspace by Id
```powershell
PS C:\> Get-Runspace -Id 2
```

```Output
 Id Name            ComputerName    Type          State         Availability
 -- ----            ------------    ----          -----         ------------
  2 Runspace2       localhost       Local         Opened        Available
```

### Example 3: Get runspace by Name
```powershell
PS C:\> Get-Runspace -Name Runspace1
```

```Output
 Id Name            ComputerName    Type          State         Availability
 -- ----            ------------    ----          -----         ------------
  1 Runspace1       localhost       Local         Opened        Busy
```

### Example 4: Get runspace by InstanceId
```powershell
PS C:\> $activeRunspace = Get-Runspace -Name Runspace1

PS C:\> Get-Runspace -InstanceId $activeRunspace.InstanceId
```

```Output
 Id Name            ComputerName    Type          State         Availability
 -- ----            ------------    ----          -----         ------------
  1 Runspace1       localhost       Local         Opened        Busy
```

In this example, we identify an available runspace using the `Name` parameter and we store the return object to a new 
variable named `$activeRunspace`.  The second example, we call `Get-Runspace` with the `InstanceId` parameter and pass 
in the `$activeRunspace` variable but we specify the `InstanceId` property on our reuturn object.

## PARAMETERS

### -Id
Specifies the Id of a runspace

```yaml
Type: Int32[]
Parameter Sets: IdParameterSet
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceId
Specifies the instance ID GUID of a running job.

```yaml
Type: Guid[]
Parameter Sets: InstanceIdParameterSet
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies the Name of a runspace

```yaml
Type: String[]
Parameter Sets: NameParameterSet
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.Runspaces.Runspace
You can pipe the results of a `Get-Runspace` command to `Debug-Runspace`.

## NOTES

## RELATED LINKS

[Debug-Runspace](Debug-Runspace.md)

