---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294019
schema: 2.0.0
---

# Tee-Object
## SYNOPSIS
Saves command output in a file or variable and also sends it down the pipeline.

## SYNTAX

### File (Default)
```
Tee-Object [-InputObject <PSObject>] [-FilePath] <String> [-Append] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

### LiteralFile
```
Tee-Object [-InputObject <PSObject>] -LiteralPath <String> [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

### Variable
```
Tee-Object [-InputObject <PSObject>] -Variable <String> [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

## DESCRIPTION
The Tee-Object cmdlet redirects output, that is, it sends the output of a command in two directions (like the letter "T").
It stores the output in a file or variable and also sends it down the pipeline.
If Tee-Object is the last command in the pipeline, the command output is displayed at the prompt.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-process | tee-object -filepath C:\Test1\testfile2.txt

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)    Id ProcessName
-------  ------    -----      ----- -----   ------    -- -----------
83       4     2300       4520    39     0.30    4032 00THotkey
272      6     1400       3944    34     0.06    3088 alg
81       3      804       3284    21     2.45     148 ApntEx
81       4     2008       5808    38     0.75    3684 Apoint
...
```

This command gets a list of the processes running on the computer and sends the result to a file.
Because a second path is not specified, the processes are also displayed in the console.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-process notepad | tee-object -variable proc | select-object processname,handles

ProcessName                              Handles
-----------                              -------
notepad                                  43
notepad                                  37
notepad                                  38
notepad                                  38
```

This command gets a list of the processes running on the computer and sends the result to a variable named "proc".
It then pipes the resulting objects along to Select-Object, which selects the ProcessName and Handles property.
Note that the $proc variable includes the default information returned by Get-Process.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>get-childitem -path D: -file -system -recurse | tee-object -file c:\test\AllSystemFiles.txt -append | out-file c:\test\NewSystemFiles.txt
```

This command saves a list of system files in a two log files, a cumulative file and a current file.

The command uses the Get-ChildItem cmdlet to do a recursive search for system files on the D: drive.
A pipeline operator (|) sends the list to Tee-Object, which appends the list to the AllSystemFiles.txt file and passes the list down the pipeline to the Out-File cmdlet, which saves the list in the NewSystemFiles.txt file.

## PARAMETERS

### -Append
Appends the output to the specified file.
Without this parameter, the new content replaces any existing content in the file without warning.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: File
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
Saves the object in the specified file.
Wildcard characters are permitted, but must resolve to a single file.

```yaml
Type: String
Parameter Sets: File
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationAction
This parameter is introduced in Windows PowerShell 3.0.

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
This parameter is introduced in Windows PowerShell 3.0.

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
Specifies the object to be saved and displayed.
Enter a variable that contains the objects or type a command or expression that gets the objects.
You can also pipe an object to Tee-Object.

When you use the InputObject parameter with Tee-Object, instead of piping command results to Tee-Object, the InputObject value-even if the value is a collection that is the result of a command, such as -InputObject (Get-Process)-is treated as a single object.
Because InputObject cannot return individual properties from an array or collection of objects, it is recommended that if you use Tee-Object to perform operations on a collection of objects for those objects that have specific values in defined properties, you use Tee-Object in the pipeline, as shown in the examples in this topic.

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

### -Variable
Saves the object in the specified variable.
Enter a variable name without the preceding dollar sign ($).

```yaml
Type: String
Parameter Sets: Variable
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath
Saves the object in the specified file.
Unlike FilePath, the value of the LiteralPath parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: LiteralFile
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.PSObject
You can pipe objects to Tee-Object.

## OUTPUTS

### System.Management.Automation.PSObject
Tee-Object returns the object that it redirects.

## NOTES
You can also use the Out-File cmdlet or the redirection operator, both of which save the output in a file but do not send it down the pipeline.

Tee-Object uses Unicode encoding when it writes to files.
As a result, the output might not be formatted properly in files with a different encoding.
To specify the encoding, use the Out-File cmdlet.

## RELATED LINKS

[Select-Object]()

[about_Redirection]()

