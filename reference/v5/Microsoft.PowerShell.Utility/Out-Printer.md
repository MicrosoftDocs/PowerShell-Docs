---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293998
schema: 2.0.0
---

# Out-Printer
## SYNOPSIS
Sends output to a printer.

## SYNTAX

```
Out-Printer [[-Name] <String>] [-InputObject <PSObject>] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

## DESCRIPTION
The Out-Printer cmdlet sends output to the default printer or to an alternate printer, if one is specified.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-content $pshome\about_signing.help.txt | Out-Printer
```

This command prints the content of the about_Signing Help topic to the default printer.
This example shows you how to print a file, even though Out-Printer does not have a Path parameter.

The command uses the Get-Content cmdlet to get the contents of the Help topic.
The path includes $pshome, a built-in variable that stores the installation directory for Windows PowerShell.
A pipeline operator (|) passes the results to Out-Printer, which sends it to the default printer.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>"Hello, World" | out-printer -name "\\Server01\Prt-6B Color"
```

This command prints "Hello, World" to the "Prt-6B Color" printer on Server01.
This command uses the Name parameter to specify the alternate printer.
Because the parameter name is optional, you can omit it.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>$h = get-help -full get-wmiobject
PS C:\>out-printer -inputobject $h
```

These commands print the full version of the Help topic for Get-WmiObject.
The first command uses the Get-Help cmdlet to get the full version of the Help topic for Get-WmiObject and stores it in the $h variable.
The second command sends the content to the default printer.
It uses the InputObject parameter to pass the value of the $h variable to Out-Printer.

## PARAMETERS

### -InformationAction
@{Text=}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
@{Text=}

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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
Specifies the  alternate printer.
The parameter name ("Name") is optional.

```yaml
Type: String
Parameter Sets: (All)
Aliases: PrinterName

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.PSObject
You can pipe any object to Out-Printer.

## OUTPUTS

### None
Out-Printer does not return any objects.

## NOTES
You can also refer to Out-Printer by its built-in alias, "lp".
For more information, see about_Aliases.

The cmdlets that contain the Out verb (the Out cmdlets) do not format objects; they just render them and send them to the specified display destination.
If you send an unformatted object to an Out cmdlet, the cmdlet sends it to a formatting cmdlet before rendering it.

The Out cmdlets do not have parameters for names or file paths.
To send data to an Out cmdlet, use a pipeline operator (|) to send the output of a Windows PowerShell command to the cmdlet.
You can also store data in a variable and use the InputObject parameter to pass the data to the cmdlet.
For more information, see the examples.

Out-Printer sends data, but it does not emit any output objects.
If you pipe the output of Out-Printer to Get-Member, Get-Member reports that no objects have been specified.

## RELATED LINKS

[Out-Default]()

[Out-File]()

[Out-Host]()

[Out-Null]()

[Out-String]()

