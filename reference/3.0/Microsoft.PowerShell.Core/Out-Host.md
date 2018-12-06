---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=113365
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

The **Out-Host** cmdlet sends output to the Windows PowerShell host for display.
The host displays the output at the command line.
Because **Out-Host** is the default, you do not need to specify it unless you want to use its parameters to change the display.

## EXAMPLES

### Example 1
```powershell
Get-Process | Out-Host -Paging
```

This command displays the processes on the system one page at a time.
It uses the `Get-Process` cmdlet to get the processes on the system.
The pipeline operator sends the results to `Out-Host` cmdlet, which displays them at the console.
The **Paging** parameter displays one page of data at a time.

### Example 2

```
PS> $a = Get-History
PS> Out-Host -InputObject $a
```

These commands display the session history at the command line.
The first command uses the Get-History cmdlet to get the session history, and then it stores the history in the $a variable.
The second command uses **Out-Host** to display the content of the $a variable, and it uses the **InputObject** parameter to specify the variable to **Out-Host**.

## PARAMETERS

### -InputObject

Specifies the objects that are written to the console.
Enter a variable that contains the objects, or type a command or expression that gets the objects.

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

Displays one page of output at a time, and waits for user input before displaying the remaining pages, much like the traditional "more" command.
By default, all of the output is displayed on a single page.
The page size is determined by the characteristics of the host.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](./About/about_CommonParameters.md).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object to **Out-Host**.

## OUTPUTS

### None

**Out-Host** does not generate any output.
However, the host might display the objects that **Out-Host** sends to it.

## NOTES

- The cmdlets that contain the Out verb (the Out cmdlets) do not format objects; they just render them and send them to the specified display destination. If you send an unformatted object to an Out cmdlet, the cmdlet sends it to a formatting cmdlet before rendering it.
- The Out cmdlets do not have parameters for names or file paths. To send data to an Out cmdlet, use a pipeline operator (|) to send the output of a Windows PowerShell command to the cmdlet. You can also store data in a variable and use the InputObject parameter to pass the data to the cmdlet. For help, see the examples.
- **Out-Host** sends data, but it does not emit any output objects. If you pipe the output of **Out-Host** to the Get-Member cmdlet, **Get-Member** reports that no objects have been specified.

- 

## RELATED LINKS

[Clear-Host](Functions/Clear-Host.md)

[Out-Default](Out-Default.md)

[Out-File](../Microsoft.PowerShell.Utility/Out-File.md)

[Out-Null](Out-Null.md)

[Out-Printer](../Microsoft.PowerShell.Utility/Out-Printer.md)

[Out-String](../Microsoft.PowerShell.Utility/Out-String.md)

[Write-Host](../Microsoft.PowerShell.Utility/Write-Host.md)