---
external help file: PSITPro5_Utility.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293999
schema: 2.0.0
---

# Out-String
## SYNOPSIS
Sends objects to the host as a series of strings.

## SYNTAX

```
Out-String [-InputObject <PSObject>] [-Stream] [-Width <Int32>]
```

## DESCRIPTION
The Out-String cmdlet converts the objects that Windows PowerShell manages into an array of strings.
By default, Out-String accumulates the strings and returns them as a single string, but you can use the stream parameter to direct Out-String to return one string at a time.
This cmdlet lets you search and manipulate string output as you would in traditional shells when object manipulation is less convenient.

## EXAMPLES

### Example 1: Output text to the console as a string
```
PS C:\>Get-Content C:\test1\testfile2.txt | Out-String
```

This command sends the content of the Testfile2.txt file to the console as a single string.
It uses the Get-Content cmdlet to get the content of the file.
The pipeline operator (|) sends the content to Out-String, which sends the content to the console as a string.

### Example 2: Get the current culture and convert the data to strings.
```
The first command uses the Get-Culture cmdlet to get the regional settings. The pipeline operator (|) sends the result to the Select-Object cmdlet, which selects all properties (*) of the culture object that Get-Culture returned. The command then stores the results in the $C variable.
PS C:\>$C = Get-Culture | Select-Object *

The second command uses the Out-String cmdlet to convert the CultureInfo object to a series of strings (one string for each property). It uses the InputObject parameter to pass the $C variable to Out-String. The Width parameter is set to 100 characters per line to prevent truncation.
PS C:\>Out-String -InputObject $C -Width 100
```

These commands get the regional settings for the current user and convert the data to strings.

### Example 3: Working with objects
```
PS C:\>Get-Alias | Out-String -Stream | Select-String "Get-Command"
```

This example demonstrates the difference between working with objects and working with strings.
The command displays aliases that include the phrase Get-Command.
It uses the Get-Alias cmdlet to get a set of AliasInfo objects (one for each alias in the current session).

The pipeline operator (|) sends the output of the Get-Alias cmdlet to the Out-String cmdlet, which converts the objects to a series of strings.
It uses the Stream parameter of Out-String to send each string individually, instead of concatenating them into a single string.
Another pipeline operator sends the strings to the Select-String cmdlet, which selects the strings that include Get-Command anywhere in the string.

If you omit the Stream parameter, the command displays all of the aliases, because Select-String finds Get-Command in the single string that Out-String returns, and the formatter displays the string as a table.

## PARAMETERS

### -InputObject
Specifies the objects to be written to a string.
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

### -Stream
Sends the strings for each object separately.
By default, the strings for each object are accumulated and sent as a single string.

To use the Stream parameter, type -Stream or its alias, ost.

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

### -Width
Specifies the number of characters in each line of output.
Any additional characters are truncated, not wrapped.
If you omit this parameter, the width is determined by the characteristics of the host program.
The default value for the Windows PowerShell console is 80 (characters).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.PSObject
You can pipe objects to Out-String.

## OUTPUTS

### System.String
Out-String returns the string that it creates from the input object.

## NOTES
* The cmdlets that contain the Out verb (the Out cmdlets) do not format objects; they just render them and send them to the specified display destination. If you send an unformatted object to an Out cmdlet, the cmdlet sends it to a formatting cmdlet before rendering it.
* The Out cmdlets do not have parameters that take names or file paths. To send data to an Out cmdlet, use a pipeline operator (|) to send the output of a Windows PowerShell command to the cmdlet. You can also store data in a variable and use the InputObject parameter to pass the data to the cmdlet.

*

## RELATED LINKS

[Out-Default](9848a107-ddc0-40a1-b759-5ac181c1d0cf)

[Out-File](13d09dc8-2398-4d73-9449-1d01eb4e7808)

[Out-GridView](70915a86-d753-464e-8349-cba02316154c)

[Out-Host](d572e893-ef19-42e6-8d00-2e90fa013750)

[Out-Null](75391ca1-066e-402f-92c8-a41095d2854c)

[Out-Printer](22e377d5-b533-442f-987e-b3166bddcd6b)

