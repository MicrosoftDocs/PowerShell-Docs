---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294008
schema: 2.0.0
---

# Select-String
## SYNOPSIS
Finds text in strings and files.

## SYNTAX

### File (Default)
```
Select-String [-Pattern] <String[]> [-Path] <String[]> [-SimpleMatch] [-CaseSensitive] [-Quiet] [-List]
 [-Include <String[]>] [-Exclude <String[]>] [-NotMatch] [-AllMatches] [-Encoding <String>]
 [-Context <Int32[]>] [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

### Object
```
Select-String -InputObject <PSObject> [-Pattern] <String[]> [-SimpleMatch] [-CaseSensitive] [-Quiet] [-List]
 [-Include <String[]>] [-Exclude <String[]>] [-NotMatch] [-AllMatches] [-Encoding <String>]
 [-Context <Int32[]>] [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

### LiteralFile
```
Select-String [-Pattern] <String[]> -LiteralPath <String[]> [-SimpleMatch] [-CaseSensitive] [-Quiet] [-List]
 [-Include <String[]>] [-Exclude <String[]>] [-NotMatch] [-AllMatches] [-Encoding <String>]
 [-Context <Int32[]>] [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The Select-String cmdlet searches for text and text patterns in input strings and files.
You can use it like Grep in UNIX and Findstr in Windows.
You can type "Select-String" or its alias, "sls".

Select-String is based on lines of text.
By default, Select-String finds the first match in each line and, for each match, it displays the file name, line number, and all text in the line containing the match.
However, you can direct it to detect multiple matches per line, display text before and after the match, or display only a Boolean value (true or false) that indicates whether a match is found.

Select-String uses regular expression matching, but it can also perform a simple match that searches the input for the text that you specify.

Select-String can display all of the text matches or stop after the first match in each input file.
It can also display all text that does not match the specified pattern.
You can also specify that Select-String should expect a particular character encoding, such as when you are searching files of Unicode text.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>"Hello","HELLO" | select-string -pattern "HELLO" -casesensitive
```

This command performs a case-sensitive match of the text that was piped to the Select-String command.

As a result, Select-String finds only "HELLO", because "Hello" does not match.

Because each of the quoted strings is treated as a line, without the CaseSensitive parameter, Select-String would recognize both of the strings as matches.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>select-string -path *.xml -pattern "the the"
```

This command searches through all files with the .xml file name extension in the current directory and displays the lines in those files that include the string "the the".

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>select-string -path $pshome\en-US\*.txt -pattern "@"
```

This command searches the Windows PowerShell conceptual Help files (about_*.txt) for information about the use of the at sign (@).

To indicate the path, this command uses the value of the $pshome automatic variable, which stores the path to the Windows PowerShell installation directory.
In this example, the command searches the en-US subdirectory, which contains the English (US) language Help files for Windows PowerShell.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>function search-help
{
   $pshelp = "$pshome\es\about_*.txt", "$pshome\en-US\*dll-help.xml"
   select-string -path $pshelp -pattern $args[0]
}
```

This simple function uses the Select-String cmdlet to search the Windows PowerShell Help files for a particular string.
In this example, the function searches the "en-US" subdirectory for English-United States language files.

To use the function to find a string, such as "psdrive", type search-help psdrive.

To use this function in any Windows PowerShell console, change the path to point to the Windows PowerShell Help files on your system, and then paste the function in your Windows PowerShell profile.

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>$events = get-eventlog -logname application -newest 100
PS C:\>$events | select-string -inputobject {$_.message} -pattern "failed"
```

This example searches for the string "failed" in the 100 newest events in the Application log in Event Viewer.

The first command uses the Get-EventLog cmdlet to get the 100 most recent events from the Application event log.
Then it stores the events in the $events variable.

The second command uses a pipeline operator (|) to send the objects in the $events variable to Select-String.
It uses the InputObject parameter to represent the input from the $events variable.
The value of the InputObject parameter is the Message property of each object as it travels through the pipeline.
The current object is represented by the $_ symbol.

As each event arrives in the pipeline, Select-String searches the value of its Message property for the "failed" string, and then displays any lines that include a match.

### -------------------------- EXAMPLE 6 --------------------------
```
PS C:\>get-childitem c:\windows\system32\*.txt -recurse | select-string -pattern "Microsoft" -casesensitive
```

This command examines all files in the subdirectories of C:\Windows\System32 with the .txt file name extension and searches for the string "Microsoft".
The CaseSensitive parameter indicates that the "M" in "Microsoft" must be capitalized and that the rest of the characters must be lowercase for Select-String to find a match.

### -------------------------- EXAMPLE 7 --------------------------
```
PS C:\>select-string -path process.txt -pattern idle, svchost -notmatch
```

This command finds lines of text in the Process.txt file that do not include the words "idle" or "svchost".

### -------------------------- EXAMPLE 8 --------------------------
```
PS C:\>$f = select-string -path audit.log -pattern "logon failed" -context 2, 3
PS C:\>$f.count
PS C:\>($f)[0].context | format-list
```

The first command searches the Audit.Log file for the phrase "logon failed." It uses the Context parameter to capture 2 lines before the match and 3 lines after the match.

The second command uses the Count property of object arrays to display the number of matches found, in this case, 2.

The third command displays the lines stored in the Context property of the first MatchInfo object.
It uses array notation to indicate the first match (match 0 in a zero-based array), and it uses the T:Microsoft.PowerShell.Commands.Format-List cmdlet to display the value of the Context property as a list.

The output consists of two MatchInfo objects, one for each match detected.
The context lines are stored in the Context property of the MatchInfo object.

### -------------------------- EXAMPLE 9 --------------------------
```
PS C:\>
$a = get-childitem $pshome\en-us\about*.help.txt | select-string -pattern transcript
PS C:\>$b = get-childitem $pshome\en-us\about*.help.txt | select-string -pattern transcript -allmatches
PS C:\>$a
C:\Windows\system32\WindowsPowerShell\v1.0\en-us\about_Pssnapins.help.txt:39:       Start-Transcript and Stop-Transcript.
PS C:\>$b
C:\Windows\system32\WindowsPowerShell\v1.0\en-us\about_Pssnapins.help.txt:39:       Start-Transcript and Stop-Transcript.

PS C:\>> $a.matches
Groups   : {Transcript}
Success  : True
Captures : {Transcript}
Index    : 13
Length   : 10
Value    : Transcript
PS C:\>$b.matches
Groups   : {Transcript}
Success  : True
Captures : {Transcript}
Index    : 13
Length   : 10
Value    : Transcript
Groups   : {Transcript}
Success  : True
Captures : {Transcript}
Index    : 33
Length   : 10
Value    : Transcript
```

This example demonstrates the effect of the AllMatches parameter of Select-String.
AllMatches finds all pattern matches in a line, instead of just finding the first match in each line.

The first command in the example searches the Windows PowerShell conceptual Help files ("about" Help) for instances of the word "transcript".
The output of the first command is saved in the $a variable.

The second command is identical, except that it uses the AllMatches parameter.
The output of the second command is saved in the $b variable.

When you display the value of the variables, the default display is identical, as shown in the example output.

However, the fifth and sixth commands display the value of the Matches property of each object.
The Matches property of the first command contains just one match (that is, one System.Text.RegularExpressions.Match object), whereas the Matches property of the second command contains objects for both of the matches in the line.

## PARAMETERS

### -AllMatches
Searches for more than one match in each line of text.
Without this parameter, Select-String finds only the first match in each line of text.

When Select-String finds more than one match in a line of text, it still emits only one MatchInfo object for the line, but the Matches property of the object contains all of the matches.

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

### -CaseSensitive
Makes matches case-sensitive.
By default, matches are not case-sensitive.

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

### -Context
Captures the specified number of lines before and after the line with the match.
This allows you to view the match in context.

If you enter one number as the value of this parameter, that number determines the number of lines captured before and after the match.
If you enter two numbers as the value, the first number determines the number of lines before the match and the second number determines the number of lines after the match.

In the default display, lines with a match are indicated by a right angle bracket (ASCII 62) in the first column of the display.
Unmarked lines are the context.

This parameter does not change the number of objects generated by Select-String.
Select-String generates one MatchInfo (Microsoft.PowerShell.Commands.MatchInfo) object for each match.
The context is stored as an array of strings in the Context property of the object.

When you pipe the output of a Select-String command to another Select-String command, the receiving command searches only the text in the matched line (the value of the Line property of the MatchInfo object), not the text in the context lines.
As a result, the Context parameter is not valid on the receiving Select-String command.

When the context includes a match, the MatchInfo object for each match includes all of the context lines, but the overlapping lines appear only once in the display.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Encoding
Specifies the character encoding that Select-String should assume when searching the file.
The default is UTF8.

Valid values are "UTF7", "UTF8", "UTF32", "ASCII", "Unicode", "BigEndianUnicode", "Default", and "OEM".
"Default" is the encoding of the system's current ANSI code page.
"OEM" is the current original equipment manufacturer code page identifier for the operating system.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: unicode, utf7, utf8, utf32, ascii, bigendianunicode, default, oem

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Exclude
Exclude the specified items.
The value of this parameter qualifies the Path parameter.
Enter a path element or pattern, such as "*.txt".
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Include
Include only the specified items.
The value of this parameter qualifies the Path parameter.
Enter a path element or pattern, such as "*.txt".
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationAction
When Select-String finds more than one match in a line of text, it still emits only one MatchInfo object for the line, but the Matches property of the object contains all of the matches.

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
When Select-String finds more than one match in a line of text, it still emits only one MatchInfo object for the line, but the Matches property of the object contains all of the matches.

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
Specifies the text to be searched.
Enter a variable that contains the text, or type a command or expression that gets the text.

Using the InputObject parameter is not the same as piping strings to Select-String.
The differences are as follows:

-- When you pipe more than one string (a "collection") to Select-String, Select-String searches for the specified text in each string and returns each string that contains the search text.
-- When you use the InputObject parameter to submit a collection of strings, Select-String treats the collection as a single combined string and returns the strings as a unit if it finds the search text in any string.

```yaml
Type: PSObject
Parameter Sets: Object
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -List
Returns only the first match in each input file.
By default, Select-String returns a MatchInfo object for each match it finds.

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

### -NotMatch
Finds text that does not match the specified pattern.

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

### -Path
Specifies the path to the files to be searched.
Wildcards are permitted.
The default location is the local directory.

Specify files in the directory, such as "log1.txt", "*.doc", or "*.*".
If you specify only a directory, the command fails.

```yaml
Type: String[]
Parameter Sets: File
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Pattern
Specifies the text to find.
Type a string or regular expression.
If you type a string, use the SimpleMatch parameter.

To learn about regular expressions, see about_Regular_Expressions.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Quiet
Returns a Boolean value (true or false), instead of a MatchInfo object.
The value is "true" if the pattern is found; otherwise, the value is "false".

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

### -SimpleMatch
Uses a simple match rather than a regular expression match.
In a simple match, Select-String searches the input for the text in the Pattern parameter.
It does not interpret the value of the Pattern parameter as a regular expression statement.

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

### -LiteralPath
Specifies the path to the files to be searched.
Unlike Path, the value of the LiteralPath parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: LiteralFile
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.PSObject
You can pipe any object that has a ToString method to Select-String.

## OUTPUTS

### Microsoft.PowerShell.Commands.MatchInfo or System.Boolean
By default, the output is a set of MatchInfo objects, one for each match found.
If you use the Quiet parameter, the output is a Boolean value indicating whether the pattern was found.

## NOTES
Select-String is like the Grep command in UNIX and the FindStr command in Windows.

The "sst" alias for the Select-String cmdlet was introduced in Windows PowerShell 3.0.

To use Select-String, type the text that you want to find as the value of the Pattern parameter.

To specify the text to be searched, do the following:

-- Type the text in a quoted string, and then pipe it to Select-String.
-- Store a text string in a variable, and then specify the variable as the value of the InputObject parameter.
-- If the text is stored in files, use the Path parameter to specify the path to the files.

By default, Select-String interprets the value of the Pattern parameter as a regular expression.
(For more information, see about_Regular_Expressions.) However, you can use the SimpleMatch parameter to override the regular expression matching.
The SimpleMatch parameter finds instances of the value of the Pattern parameter in the input.

The default output of Select-String is a MatchInfo object, which includes detailed information about the matches.
The information in the object is useful when you are searching for text in files, because MatchInfo objects have properties such as Filename and Line.
When the input is not from the file, the value of these parameters is "InputStream".

If you do not need the information in the MatchInfo object, use the Quiet parameter, which returns a Boolean value (true or false) to indicate whether it found a match, instead of a MatchInfo object.

When matching phrases, Select-String uses the current culture that is set for the system.
To find the current culture, use the T:Microsoft.PowerShell.Commands.Get-Culture cmdlet.

To find the properties of a MatchInfo object, type the following:

select-string -path test.txt -pattern "test" | get-member | format-list -property *

## RELATED LINKS

[about_Comparison_Operators]()

[about_Regular_Expressions]()

