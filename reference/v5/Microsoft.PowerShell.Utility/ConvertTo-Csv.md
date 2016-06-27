---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293949
schema: 2.0.0
---

# ConvertTo-Csv
## SYNOPSIS
Converts objects into a series of comma-separated value (CSV) variable-length strings.

## SYNTAX

### Delimiter (Default)
```
ConvertTo-Csv [-InputObject] <PSObject> [[-Delimiter] <Char>] [-NoTypeInformation]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

### UseCulture
```
ConvertTo-Csv [-InputObject] <PSObject> [-UseCulture] [-NoTypeInformation]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The ConvertTo-CSV cmdlet returns a series of comma-separated (CSV) strings that represents the objects that you submit.
You can then use the ConvertFrom-CSV cmdlet to re-create objects from the CSV strings.
The resulting objects are CSV versions of the original objects that consist of string representations of the property values and no methods.

You can also use the T:Microsoft.PowerShell.Commands.Export-Csv and T:Microsoft.PowerShell.Commands.Import-Csv cmdlets to convert objects to CSV strings (and back).
Export-CSV is the same as ConvertTo-CSV, except that it saves the CSV strings in a file.

You can use the parameters of the ConvertTo-CSV cmdlet to specify a delimiter other than a comma or to direct ConvertTo-CSV to use the default delimiter for the current culture.

For more information, see Export-CSV, and see the Notes section.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-process powershell | convertto-csv
#TYPE System.Diagnostics.Process
"__NounName","Name","Handles","VM","WS","PM","NPM","Path","Company","CPU","FileVersion","ProductVersion","Description",
"Product","BasePriority","ExitCode","HasExited","ExitTime","Handle","HandleCount","Id","MachineName","MainWindowHandle"
,"MainWindowTitle","MainModule","MaxWorkingSet","MinWorkingSet","Modules","NonpagedSystemMemorySize","NonpagedSystemMem
orySize64","PagedMemorySize","PagedMemorySize64","PagedSystemMemorySize","PagedSystemMemorySize64","PeakPagedMemorySize
","PeakPagedMemorySize64","PeakWorkingSet","PeakWorkingSet64","PeakVirtualMemorySize","PeakVirtualMemorySize64","Priori
tyBoostEnabled","PriorityClass","PrivateMemorySize","PrivateMemorySize64","PrivilegedProcessorTime","ProcessName","Proc
essorAffinity","Responding","SessionId","StartInfo","StartTime","SynchronizingObject","Threads","TotalProcessorTime","U
serProcessorTime","VirtualMemorySize","VirtualMemorySize64","EnableRaisingEvents","StandardInput","StandardOutput","Sta
ndardError","WorkingSet","WorkingSet64","Site","Container"
"Process","powershell","216","597544960","60399616","63197184","21692","C:\WINDOWS\system32\WindowsPowerShell\v1.0\powe
rshell.exe","Microsoft Corporation","3.4788223","6.1.6587.1 (fbl_srv_powershell(nigels).070711-0102)","6.1.6587.1","Win
dows PowerShell","Microsoft® Windows® Operating System","8",,"False",,"860","216","5132",".","5636936","Windows PowerSh
ell 2.0 (04/17/2008 00:10:40)","System.Diagnostics.ProcessModule (powershell.exe)","1413120","204800","System.Diagnosti
cs.ProcessModuleCollection","21692","21692","63197184","63197184","320080","320080","63868928","63868928","60715008","6
0715008","598642688","598642688","True","Normal","63197184","63197184","00:00:00.2028013","powershell","15","True","1",
"System.Diagnostics.ProcessStartInfo","4/21/2008 3:49:19 PM",,"System.Diagnostics.ProcessThreadCollection","00:00:03.51
00225","00:00:03.3072212","597544960","597544960","False",,,,"60399616","60399616",,
```

This command converts a single process object to CSV format.
The command uses the Get-Process cmdlet to get the PowerShell process on the local computer.
It uses a pipeline operator (|) to send the command to the ConvertTo-CSV cmdlet, which converts it to a series of comma-separated strings.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>$date = get-date
PS C:\>convertto-csv -inputobject $date -delimiter ";" -notypeinformation
```

This example converts a date object to CSV format.

The first command uses the Get-Date cmdlet to get the current date.
It saves it in the $date variable.

The second command uses the ConvertTo-CSV cmdlet to convert the DateTime object in the $date variable to CSV format.
The command uses the InputObject parameter to specify the object to be converted.
It uses the Delimiter parameter to specify the delimiter that separates the object properties.
It uses the NoTypeInformation parameter to suppress the #TYPE string.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>get-eventlog -log "windows powershell" | convertto-csv -useculture
```

This command converts the Windows PowerShell event log on the local computer to a series of CSV strings.

The command uses the Get-EventLog cmdlet to get the events in the Windows PowerShell log.
A pipeline operator (|) sends the events to the ConvertTo-CSV cmdlet, which converts the events to CSV format.
The command uses the UseCulture parameter, which uses the list separator for the current culture as the delimiter.

## PARAMETERS

### -Delimiter
Specifies a delimiter to separate the property values.
The default is a comma (,).
Enter a character, such as a colon (:).

To specify a semicolon (;), enclose it in quotation marks.
Otherwise, it will be interpreted as the command delimiter.

```yaml
Type: Char
Parameter Sets: Delimiter
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationAction
To specify a semicolon (;), enclose it in quotation marks.
Otherwise, it will be interpreted as the command delimiter.

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
To specify a semicolon (;), enclose it in quotation marks.
Otherwise, it will be interpreted as the command delimiter.

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
Specifies the objects to export as CSV strings.
Enter a variable that contains the objects or type a command or expression that gets the objects.
You can also pipe objects to ConvertTo-CSV.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -NoTypeInformation
Omits the type information header from the output.
By default, the string in the output contains "#TYPE " followed by the fully-qualified name of the object type.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: NTI

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseCulture
Uses the list separator for the current culture as the data delimiter.
The default is a comma (,).

This parameter is very useful in scripts that are being distributed to users worldwide.
To find the list separator for a culture, use the following command: (Get-Culture).TextInfo.ListSeparator.

```yaml
Type: SwitchParameter
Parameter Sets: UseCulture
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.PSObject
You can pipe any object that has an Extended Type System (ETS) adapter to ConvertTo-CSV.

## OUTPUTS

### System.String
The CSV output is returned as a collection of strings.

## NOTES
In CSV format, each object is represented by a comma-separated list of its property value.
The property values are converted to strings (by using the ToString() method of the object), so they are generally represented by the name of the property value.
ConvertTo-CSV does not export the methods of the object.

The format of the resulting CSV strings is as follows:

-- The first string consists of '#TYPE ' followed by the fully-qualified name of the object type, such as #TYPE System.Diagnostics.Process. To suppress this string, use the NoTypeInformation parameter.
-- The next string represents the column headers. It contains a comma-separated list of the names of all the properties of the first object.
-- The remaining strings consist of comma-separated lists of the property values of each object.

When you submit multiple objects to ConvertTo-CSV, ConvertTo-CSV orders the strings based on the properties of the first object that you submit.
If the remaining objects do not have one of the specified properties, the property value of that object is null, as represented by two consecutive commas.
If the remaining objects have additional properties, those property values are ignored.

## RELATED LINKS

[ConvertFrom-Csv]()

[Export-Csv]()

[Import-Csv]()

