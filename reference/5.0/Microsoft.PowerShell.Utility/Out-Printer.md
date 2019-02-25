---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821841
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Out-Printer
---
# Out-Printer

## SYNOPSIS
Sends output to a printer.

## SYNTAX

```
Out-Printer [[-Name] <String>] [-InputObject <PSObject>] [<CommonParameters>]
```

## DESCRIPTION

The **Out-Printer** cmdlet sends output to the default printer or to an alternate printer, if one is specified.

## EXAMPLES

### Example 1: Print the content of a help topic to the default printer

```
PS C:\> Get-Content $pshome\about_signing.help.txt | Out-Printer
```

This command prints the content of the about_Signing Help topic to the default printer.
This example shows you how to print a file, even though **Out-Printer** does not have a *Path* parameter.

The command uses the Get-Content cmdlet to get the contents of the Help topic.
The path includes $pshome, a built-in variable that stores the installation directory for Windows PowerShell.
A pipeline operator (|) passes the results to **Out-Printer**, which sends it to the default printer.

### Example 2: Print text to an alternative printer

```
PS C:\> "Hello, World" | Out-Printer -Name "\\Server01\Prt-6B Color"
```

This command prints Hello, World to the Prt-6B Color printer on Server01.
This command uses the *Name* parameter to specify the alternate printer.
Because the parameter name is optional, you can omit it.

### Example 3: Print the full version of a help topic to the default printer

```
PS C:\> $H = Get-Help -Full Get-WmiObject
PS C:\> Out-Printer -InputObject $H
```

These commands print the full version of the Help topic for Get-WmiObject.
The first command uses the Get-Help cmdlet to get the full version of the Help topic for **Get-WmiObject** and stores it in the $H variable.
The second command sends the content to the default printer.
It uses the InputObject parameter to pass the value of the $H variable to **Out-Printer**.

## PARAMETERS

### -InputObject

Specifies the objects to be sent to the printer.
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

### -Name

Specifies the alternate printer.
The parameter name *Name* is optional.

```yaml
Type: String
Parameter Sets: (All)
Aliases: PrinterName

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object to **Out-Printer**.

## OUTPUTS

### None

**Out-Printer** does not return any objects.

## NOTES

* You can also refer to **Out-Printer** by its built-in alias, **lp**. For more information, see about_Aliases.

  The cmdlets that contain the Out verb do not format objects; they just render them and send them to the specified display destination.
If you send an unformatted object to an Out cmdlet, the cmdlet sends it to a formatting cmdlet before rendering it.

  The Out cmdlets do not have parameters for names or file paths.
To send data to an Out cmdlet, use a pipeline operator (|) to send the output of a Windows PowerShell command to the cmdlet.
You can also store data in a variable and use the *InputObject* parameter to pass the data to the cmdlet.
For more information, see the examples.

  **Out-Printer** sends data, but it does not emit any output objects.
If you pipe the output of **Out-Printer** to Get-Member, **Get-Member** reports that no objects have been specified.

*

## RELATED LINKS

[Out-Default](../Microsoft.PowerShell.Core/Out-Default.md)

[Out-File](Out-File.md)

[Out-Host](../Microsoft.PowerShell.Core/Out-Host.md)

[Out-Null](../Microsoft.PowerShell.Core/Out-Null.md)

[Out-String](Out-String.md)