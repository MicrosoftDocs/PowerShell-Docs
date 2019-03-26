---
ms.date:  03/25/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=289601
external help file:  System.Management.Automation.dll-Help.xml
title:  Out-Host
---
# Out-Host

## SYNOPSIS
Sends output to the command line.

## SYNTAX

```
Out-Host [-Paging] [-InputObject <PSObject>] [<CommonParameters>]
```

## DESCRIPTION

The `Out-Host` cmdlet sends output to the PowerShell host for display. The host displays the output
at the command line. Because `Out-Host` is the default, you do not have to specify it unless you
want to use its parameters to change the display.

## EXAMPLES

### Example 1: Display system processes one page at a time

```powershell
Get-Process | Out-Host -Paging
```

This command displays the processes on the system one page at a time. It uses the `Get-Process`
cmdlet to get the processes on the system. The pipeline operator sends the results to `Out-Host`
cmdlet, which displays them at the console. The **Paging** parameter displays one page of data at a
time.

### Example 2: Display session history

```powershell
$a = Get-History
Out-Host -InputObject $a
```

The first command uses the `Get-History` cmdlet to get the session history, and then it stores the
history in the `$a` variable.

The second command uses `Out-Host` to display the content of the `$a` variable, and it uses the **InputObject** parameter to specify the variable to `Out-Host`.

## PARAMETERS

### -InputObject

Specifies the objects that are written to the console. Enter a variable that contains the objects,
or type a command or expression that gets the objects.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Paging

Indicates that this cmdlet displays one page of output at a time, and waits for user input before it
displays the remaining pages, much like the traditional **more** command. By default, all of the
output is displayed on a single page. The page size is determined by the characteristics of the
host.

> [!NOTE]
> The **Paging** parameter is not supported by the PowerShell ISE host.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object to this cmdlet.

## OUTPUTS

### None

This cmdlet does not generate any output. However, the host might display the objects that
`Out-Host` sends to it.

## NOTES

The **Paging** parameter is not supported by all PowerShell hosts. For example, when you try to
use the **Paging** parameter in the PowerShell ISE, you see the following error: `out-lineoutput : The method or operation is not implemented.`

The cmdlets that contain the **Out** verb (the `Out-*` cmdlets) do not format objects. They just
render objects and send them to the specified display destination. If you send an unformatted object
to an `Out-*` cmdlet, the cmdlet sends it to a formatting cmdlet before rendering it.

The `Out-*` cmdlets do not have parameters for names or file paths. To send data to an `Out-*`
cmdlet, use a pipeline operator (|) to send the output of a PowerShell command to the cmdlet. You
can also store data in a variable and use the **InputObject** parameter to pass the data to the
cmdlet.

`Out-Host` sends data, but it does not emit any output objects. If you pipe the output of `Out-Host`
to the `Get-Member` cmdlet, `Get-Member` reports that no objects have been specified.

## RELATED LINKS

[Clear-Host](Functions/Clear-Host.md)

[Out-Default](Out-Default.md)

[Out-File](../Microsoft.PowerShell.Utility/Out-File.md)

[Out-Null](Out-Null.md)

[Out-Printer](../Microsoft.PowerShell.Utility/Out-Printer.md)

[Out-String](../Microsoft.PowerShell.Utility/Out-String.md)

[Write-Host](../Microsoft.PowerShell.Utility/Write-Host.md)