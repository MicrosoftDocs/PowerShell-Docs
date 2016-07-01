---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Out Default
ms.technology:  powershell
external help file:  PSITPro4_Core.xml
online version:  http://go.microsoft.com/fwlink/p/?linkid=289600
schema:  2.0.0
---


# Out-Default
## SYNOPSIS
Sends the output to the default formatter and to the default output cmdlet.
## SYNTAX

```
Out-Default [-Transcript] [-InputObject <PSObject>] [<CommonParameters>]
```

## DESCRIPTION
The Out-Default cmdlet sends output to the default formatter and the default output cmdlet.
This cmdlet has no effect on the formatting or output of Windows PowerShell commands.
It is a placeholder that lets you write your own Out-Default function or cmdlet.
## EXAMPLES

### 1:
```

```

## PARAMETERS

### -InputObject
Accepts input to the cmdlet.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Transcript
{{Fill Transcript Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Format-Custom](http://technet.microsoft.com/library/hh849966.aspx)

[Format-List](http://technet.microsoft.com/library/hh849957.aspx)

[Format-Table](http://technet.microsoft.com/library/hh849892.aspx)

[Format-Wide](http://technet.microsoft.com/library/hh849918.aspx)

[about_Format.ps1.xml](http://technet.microsoft.com/library/hh847831.aspx)

