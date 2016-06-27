---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293996
schema: 2.0.0
---

# Out-File
## SYNOPSIS
Sends output to a file.

## SYNTAX

### ByPath (Default)
```
Out-File [-FilePath] <String> [[-Encoding] <String>] [-Append] [-Force] [-NoClobber] [-Width <Int32>]
 [-NoNewline] [-InputObject <PSObject>] [-InformationAction <ActionPreference>] [-InformationVariable <String>]
 [-WhatIf] [-Confirm]
```

### ByLiteralPath
```
Out-File -LiteralPath <String> [[-Encoding] <String>] [-Append] [-Force] [-NoClobber] [-Width <Int32>]
 [-NoNewline] [-InputObject <PSObject>] [-InformationAction <ActionPreference>] [-InformationVariable <String>]
 [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Out-File cmdlet sends output to a file.
You can use this cmdlet instead of the redirection operator (\>) when you need to use its parameters.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-process | out-file -filepath C:\Test1\process.txt
```

This command sends a list of processes on the computer to the Process.txt file.
If the file does not exist, Out-File creates it.
Because the name of the FilePath parameter is optional, you can omit it and submit the equivalent command "get-process | outfile C:\Test1\process.txt".

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-process | out-file C:\Test1\process.txt -noclobber

Out-File : File C:\Test1\process.txt already exists and NoClobber was specified.
At line:1 char:23
+ get-process | out-file  <<<< process.txt -noclobber
```

This command also sends a list of processes to the Process.txt file, but it uses the NoClobber parameter, which prevents an existing file from being overwritten.
The output shows the error message that appears when NoClobber is used with an existing file.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>$a = get-process
PS C:\>out-file -filepath C:\Test1\process.txt -inputobject $a -encoding ASCII -width 50
```

These commands send a list of processes on the computer to the Process.txt file.
The text is encoded in ASCII format so that it can be read by search programs like Findstr and Grep.
By default, Out-File uses Unicode format.

The first command gets the list of processes and stores them in the $a variable.
The second command uses the Out-File cmdlet to send the list to the Process.txt file.

The command uses the InputObject parameter to specify that the input is in the $a variable.
It uses the Encoding parameter to convert the output to ASCII format.
It uses the Width parameter to limit each line in the file to 50 characters.
Because the lines of output are truncated at 50 characters, the rightmost column in the process table is omitted.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>set-location hklm:\software
PS C:\>get-acl mycompany\mykey | out-file -filepath c:\ps\acl.txt
PS C:\>get-acl mycompany\mykey | out-file -filepath filesystem::acl.txt
```

These commands show how to use the Out-File cmdlet when you are not in a FileSystem drive.

The first command sets the current location to the HKLM:\Software registry key.

The second and third commands have the same effect.
They use the Get-Acl cmdlet to get the security descriptor of the MyKey registry subkey (HKLM\Software\MyCompany\MyKey).
A pipeline operator passes the result to the Out-File cmdlet, which sends it to the Acl.txt file.

Because Out-File is not supported by the Windows PowerShell Registry provider, you must specify either the file system drive name, such as "c:", or the name of the provider followed by two colons, "FileSystem::", in the value of the FilePath parameter.
The second and third commands demonstrate these methods.

## PARAMETERS

### -Append
Adds the output to the end of an existing file, instead of replacing the file contents.

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

### -Encoding
Specifies the type of character encoding used in the file.
Valid values are "Unicode", "UTF7", "UTF8", "UTF32", "ASCII", "BigEndianUnicode", "Default", and "OEM".
"Unicode" is the default.

"Default" uses the encoding of the system's current ANSI code page.

"OEM" uses the current original equipment manufacturer code page identifier for the operating system.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: unknown, string, unicode, bigendianunicode, utf8, utf7, utf32, ascii, default, oem

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
Specifies the path to the output file.

```yaml
Type: String
Parameter Sets: ByPath
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Allows the cmdlet to overwrite an existing read-only file.
Even using the Force parameter, the cmdlet cannot override security restrictions.

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
Specifies the objects to be written to the file.
Enter a variable that contains the objects or type a command or expression that gets the objects.

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

### -NoClobber
Will not overwrite (replace the contents) of an existing file.
By default, if a file exists in the specified path, Out-File overwrites the file without warning.
If both Append and NoClobber are used, the output is appended to the existing file.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: NoOverwrite

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Width
Specifies the number of characters in each line of output.
Any additional characters are truncated, not wrapped.
If you omit this parameter, the width is determined by the characteristics of the host.
The default for the Windows PowerShell console is 80 (characters).

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

### -LiteralPath
Specifies the path to the output file.
Unlike FilePath, the value of the LiteralPath parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: ByLiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoNewline
{{Fill NoNewline Description}}

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

## INPUTS

### System.Management.Automation.PSObject
You can pipe any object to Out-File.

## OUTPUTS

### None
Out-File does not generate any output.

## NOTES
The Out cmdlets do not format objects; they just render them and send them to the specified display destination.
If you send an unformatted object to an Out cmdlet, the cmdlet sends it to a formatting cmdlet before rendering it.

The Out cmdlets do not have parameters for names or file paths.
To send data to a cmdlet that contains the Out verb (an Out cmdlet), use a pipeline operator (|) to send the output of a Windows PowerShell command to the cmdlet.
You can also store data in a variable and use the InputObject parameter to pass the data to the cmdlet.
For help, see the examples.

Out-File sends data, but it does not emit any output objects.
If you pipe the output of Out-File to Get-Member, Get-Member reports that no objects have been specified.

## RELATED LINKS

[Out-Default]()

[Out-Host]()

[Out-Null]()

[Out-Printer]()

[Out-String]()

[Tee-Object]()

