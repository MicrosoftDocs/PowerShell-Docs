---
external help file: PSITPro5_Utility.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294019
schema: 2.0.0
---

# Tee-Object
## SYNOPSIS
Saves command output in a file or variable and also sends it down the pipeline.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Tee-Object [-FilePath] <String> [-Append] [-InputObject <PSObject>]
```

### UNNAMED_PARAMETER_SET_2
```
Tee-Object [-InputObject <PSObject>] -LiteralPath <String>
```

### UNNAMED_PARAMETER_SET_3
```
Tee-Object [-InputObject <PSObject>] -Variable <String>
```

## DESCRIPTION
The Tee-Object cmdlet redirects output, that is, it sends the output of a command in two directions (like the letter T).
It stores the output in a file or variable and also sends it down the pipeline.
If Tee-Object is the last command in the pipeline, the command output is displayed at the prompt.

## EXAMPLES

### Example 1: Output processes to a file and to the console
```
PS C:\>Get-Process | Tee-Object -FilePath "C:\Test1\testfile2.txt"
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

### Example 2: Output processes to a variable and Select-Object
```
PS C:\>Get-Process notepad | Tee-Object -Variable proc | Select-Object processname,handles
ProcessName                              Handles
-----------                              -------
notepad                                  43
notepad                                  37
notepad                                  38
notepad                                  38
```

This command gets a list of the processes running on the computer and sends the result to a variable named proc.
It then pipes the resulting objects along to Select-Object, which selects the ProcessName and Handles property.
Note that the $proc variable includes the default information returned by Get-Process.

### Example 3: Output system files to two log files
```
PS C:\>Get-ChildItem -Path D: -File -System -Recurse | Tee-Object -FilePath "c:\test\AllSystemFiles.txt" -Append | Out-File c:\test\NewSystemFiles.txt
```

This command saves a list of system files in a two log files, a cumulative file and a current file.

The command uses the Get-ChildItem cmdlet to do a recursive search for system files on the D: drive.
A pipeline operator (|) sends the list to Tee-Object, which appends the list to the AllSystemFiles.txt file and passes the list down the pipeline to the Out-File cmdlet, which saves the list in the NewSystemFiles.txt file.

## PARAMETERS

### -Append
Appends the output to the specified file.
Without this parameter, the new content replaces any existing content in the file without warning.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1
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
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies the object to be saved and displayed.
Enter a variable that contains the objects or type a command or expression that gets the objects.
You can also pipe an object to Tee-Object.

When you use the InputObject parameter with Tee-Object, instead of piping command results to Tee-Object, the InputObject value-even if the value is a collection that is the result of a command, such as InputObject (Get-Process)-is treated as a single object.
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
Parameter Sets: UNNAMED_PARAMETER_SET_3
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
Parameter Sets: UNNAMED_PARAMETER_SET_2
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
* You can also use the Out-File cmdlet or the redirection operator, both of which save the output in a file but do not send it down the pipeline.
* Tee-Object uses Unicode encoding when it writes to files. As a result, the output might not be formatted properly in files with a different encoding. To specify the encoding, use the Out-File cmdlet.

## RELATED LINKS

[Compare-Object](bdc20eac-bff6-44bc-b130-1a986c79fb78)

[ForEach-Object](bea187c1-37b5-4fc7-9422-d29820643a4d)

[Group-Object](494af40a-1315-420f-8bd6-932006576dac)

[Measure-Object](f40a7de5-95a8-47a8-bb7c-8b2a4cdd2daf)

[New-Object](1d5cac3b-9cd0-4efe-be3e-1ee8d4675f51)

[Select-Object](2f182056-7955-4b77-9c58-64ab4a680074)

[Sort-Object](52c4a447-238d-43b4-8d3f-6aee5864b905)

[Where-Object](6a70160b-cf62-48df-ae5b-0a9b173013b4)

[about_Redirection](3f416f82-e815-439a-965c-68f1ee2e7a2b)

