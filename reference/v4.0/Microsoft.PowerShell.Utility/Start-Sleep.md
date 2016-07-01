---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Start Sleep
ms.technology:  powershell
external help file:  PSITPro4_Utility.xml
online version:  http://go.microsoft.com/fwlink/p/?linkid=294018
schema:  2.0.0
---


# Start-Sleep
## SYNOPSIS
Suspends the activity in a script or session for the specified period of time.
## SYNTAX

### Seconds (Default)
```
Start-Sleep [-Seconds] <Int32> [<CommonParameters>]
```

### Milliseconds
```
Start-Sleep -Milliseconds <Int32> [<CommonParameters>]
```

## DESCRIPTION
The Start-Sleep cmdlet suspends the activity in a script or session for the specified period of time.
You can use it for many tasks, such as waiting for an operation to complete or pausing before repeating an operation.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Start-Sleep -s 15
```

This command makes all commands in the session sleep for 15 seconds.
### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>Start-Sleep -m 500
```

This command makes all the commands in the session sleep for one-half of a second (500 milliseconds).
## PARAMETERS

### -Milliseconds
Specifies how long the resource sleeps in milliseconds.
The parameter can be abbreviated as "-m".

```yaml
Type: Int32
Parameter Sets: Milliseconds
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Seconds
Specifies how long the resource sleeps in seconds.
You can omit the parameter name ("Seconds"), or you can abbreviate it as "-s".

```yaml
Type: Int32
Parameter Sets: Seconds
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### System.Int32
You can pipe the number of seconds to Start-Sleep.
## OUTPUTS

### None
This cmdlet does not return any output.
## NOTES
* You can also refer to Start-Sleep by its built-in alias, "sleep". For more information, see about_Aliases.

*
## RELATED LINKS

