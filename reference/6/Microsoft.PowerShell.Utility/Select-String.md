---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 2/8/2019
online version: http://go.microsoft.com/fwlink/?LinkId=821853
schema: 2.0.0
title: Select-String
---

# Select-String

## SYNOPSIS
Finds text in strings and files.

## SYNTAX

### File (Default)

```
Select-String [-Pattern] <string[]> [-Path] <string[]> [-SimpleMatch] [-CaseSensitive] [-Quiet]
[-List] [-Include <string[]>] [-Exclude <string[]>] [-NotMatch] [-AllMatches] [-Encoding <Encoding>]
[-Context <int[]>] [<CommonParameters>]
```

### Object

```
Select-String [-Pattern] <string[]> -InputObject <psobject> [-SimpleMatch] [-CaseSensitive] [-Quiet]
[-List] [-Include <string[]>] [-Exclude <string[]>] [-NotMatch] [-AllMatches] [-Encoding <Encoding>]
[-Context <int[]>] [<CommonParameters>]
```

### LiteralFile

```
Select-String [-Pattern] <string[]> -LiteralPath <string[]> [-SimpleMatch] [-CaseSensitive] [-Quiet]
[-List] [-Include <string[]>] [-Exclude <string[]>] [-NotMatch] [-AllMatches] [-Encoding <Encoding>]
[-Context <int[]>] [<CommonParameters>]
```

## DESCRIPTION

The `Select-String` cmdlet searches for text and text patterns in input strings and files. You can
use `Select-String` similar to **grep** in UNIX or **findstr.exe** in Windows.

`Select-String` is based on lines of text. By default, `Select-String` finds the first match in each
line and, for each match, it displays the file name, line number, and all text in the line
containing the match. You can direct `Select-String` to find multiple matches per line, display text
before and after the match, or display a Boolean value (True or False) that indicates whether a
match is found.

`Select-String` uses regular expression matching, but it can also perform a match that searches the
input for the text that you specify.

`Select-String` can display all of the text matches or stop after the first match in each input
file. `Select-String` can be used to display all text that does not match the specified pattern. You
can also specify that `Select-String` should expect a particular character encoding, such as when
you are searching files of Unicode text.

## EXAMPLES

### Example 1: Find a case-sensitive match

This command performs a case-sensitive match of the text that was sent down the pipeline to the
`Select-String` cmdlet.

```powershell
'Hello', 'HELLO' | Select-String -Pattern 'HELLO' -CaseSensitive -SimpleMatch
```

The text strings **Hello** and **HELLO** are sent down the pipeline to the `Select-String` cmdlet.
`Select-String` uses the **Pattern** parameter to specify **HELLO**. The **CaseSensitive** parameter
specifies that the case must match only the upper-case pattern. **SimpleMatch** is an optional
parameter and specifies that the string in the pattern is not interpreted as a regular expression.
`Select-String` displays **HELLO** in the PowerShell console.

### Example 2: Find matches in text files

This command searches all files with the `.txt` file name extension in the current directory. The
output displays the lines in those files that include the specified string.

```powershell
Get-Alias | Out-File -FilePath .\Alias.txt
Get-Command | Out-File -FilePath .\Command.txt
Select-String -Path .\*.txt -Pattern 'Get'
```

```Output
Alias.txt:8:Alias            cat -> Get-Content
Alias.txt:28:Alias           dir -> Get-ChildItem
Alias.txt:43:Alias           gal -> Get-Alias
Command.txt:966:Cmdlet       Get-Acl
Command.txt:967:Cmdlet       Get-Alias
```

In this example, `Get-Alias` and `Get-Command` are used with the `Out-File` cmdlet to create two
text files in the current directory, **Alias.txt** and **Command.txt**.

`Select-String` uses the **Path** parameter with the asterisk (`*`) wildcard to search all files in
the current directory with the file name extension `.txt`. The **Pattern** parameter specifies the
text to match **Get-**. `Select-String` displays the output in the PowerShell console. The file name
and line number precede each line of content that contains a match for the **Pattern** parameter.

### Example 3: Find a pattern match

In this example, multiple files are searched to find matches for the specified pattern. The pattern
uses a regular expression quantifier. For more information, see [about_Regular_Expressions](../Microsoft.PowerShell.Core/About/About_Regular_Expressions.md).

```powershell
Select-String -Path "$PSHOME\en-US\*.txt" -Pattern '\?'
```

```Output
C:\Program Files\PowerShell\6\en-US\default.help.txt:27:    beginning at http://go.microsoft.com/fwlink/?LinkID=108518.
C:\Program Files\PowerShell\6\en-US\default.help.txt:50:    or go to: http://go.microsoft.com/fwlink/?LinkID=210614
```

The `Select-String` cmdlet uses two parameters, **Path** and **Pattern**. The **Path** parameter
uses the variable `$PSHOME` that specifies the PowerShell directory. The remainder of the path
includes the subdirectory **en-US** and specifies each `*.txt` file in the directory. The
**Pattern** parameter specifies to match a question mark (`?`) in each file. A backslash (`\`) is
used as an escape character and is necessary because the question mark (`?`) is a regular expression
quantifier. `Select-String` displays the output in the PowerShell console. The file name and line
number precede each line of content that contains a match for the **Pattern** parameter.

### Example 4: Use Select-String in a function

This example creates a function to search for a pattern in the PowerShell help files. For this
example, the function only exists in the PowerShell session. When the PowerShell session is closed
the function is deleted. For more information, see [about_Functions](../Microsoft.PowerShell.Core/About/about_Functions.md).

```
PS> Function Search-Help
>> {
>> $PSHelp = "$PSHOME\en-US\*.txt"
>> Select-String -Path $PSHelp -Pattern 'About_'
>> }
PS>

PS> Search-Help

C:\Program Files\PowerShell\6\en-US\default.help.txt:67:    The titles of conceptual topics begin with "About_".
C:\Program Files\PowerShell\6\en-US\default.help.txt:70:    Get-Help About_<topic-name>
C:\Program Files\PowerShell\6\en-US\default.help.txt:93:    Get-Help About_Modules : Displays help about PowerShell modules.
C:\Program Files\PowerShell\6\en-US\default.help.txt:97:    about_Updatable_Help
```

The function is created on the PowerShell command line. The `Function` command uses the name
**Search-Help**. Press **Enter** to begin adding statements to the function. From the `>>` prompt,
add each statement and press **Enter** as shown in the example. After the closing bracket is added,
you are returned to a PowerShell prompt.

The function contains two commands. The `$PSHelp` variable stores the path to the PowerShell help
files. `$PSHOME` is the PowerShell installation directory with the subdirectory **en-US** that
specifies each `*.txt` file in the directory.

The `Select-String` command in the function uses the **Path** and **Pattern** parameters. The
**Path** parameter uses the `$PSHelp` variable to get the path. The **Pattern** parameter uses the
string **About_** as the search criteria.

To run the function, type `Search-Help`. The function's `Select-String` command displays the output
in the PowerShell console.

### Example 5: Search for a string in a Windows event log

This example searches for a string in a Windows event log. The variable `$_` represents the current
object in the pipeline. For more information, see [about_Automatic_Variables](../Microsoft.PowerShell.Core/About/about_Automatic_Variables.md).

```powershell
$Events = Get-WinEvent -LogName Application -MaxEvents 50
$Events | Select-String -InputObject {$_.message} -Pattern 'Failed'
```

The `Get-WinEvent` cmdlet uses the **LogName** parameter to specify the Application log. The
**MaxEvents** parameter gets the 50 most recent events from the log. The log content is stored in
the variable named `$Events`.

The `$Events` variable is sent down the pipeline to the `Select-String` cmdlet. `Select-String` uses
the **InputObject** parameter. The `$_` variable represents the current object and `message` is a
property of the event. The **Pattern** parameter species the string **Failed** and searches for
matches in `$_.message`. `Select-String` displays the output in the PowerShell console.

### Example 6: Find a string in subdirectories

This example searches a directory and all of its subdirectories for a specific text string.

```powershell
Get-ChildItem -Path C:\Windows\System32\*.txt -Recurse | Select-String -Pattern 'Microsoft' -CaseSensitive
```

`Get-ChildItem` uses the **Path** parameter to specify **C:\Windows\System32\*.txt**. The
**Recurse** parameter includes the subdirectories. The objects are sent down the pipeline to
`Select-String`.

`Select-String` uses the **Pattern** parameter and specifies the string **Microsoft**. The
**CaseSensitive** parameter is used to match the exact case of the string. `Select-String` displays
the output in the PowerShell console.

> [!NOTE]
> Dependent upon your permissions, you might see **Access denied** messages in the output.

### Example 7: Find strings that do not match a pattern

This example shows how to exclude lines of data that do not match a pattern.

```powershell
Get-Command | Out-File -FilePath .\Command.txt
Select-String -Path .\Command.txt -Pattern 'Get', 'Set'  -NotMatch
```

The `Get-Command` cmdlet sends objects down the pipeline to the `Out-File` to create the
**Command.txt** file in the current directory. `Select-String` uses the **Path** parameter to
specify the **Command.txt** file. The **Pattern** parameter specifies **Get** and **Set** as the
search pattern. The **NotMatch** parameter excludes **Get** and **Set** from the results.
`Select-String` displays the output in the PowerShell console that does not include **Get** or
**Set**.

### Example 8: Find lines before and after a match

This example shows how to get the lines before and after the matched pattern.

```powershell
Get-Command | Out-File -FilePath .\Command.txt
Select-String -Path .\Command.txt -Pattern 'Get-Computer' -Context 2, 3
```

```Output
  Command.txt:986:Cmdlet          Get-CmsMessage           6.1.0.0    Microsoft.PowerShell.Security
  Command.txt:987:Cmdlet          Get-Command              6.1.2.0    Microsoft.PowerShell.Core
> Command.txt:988:Cmdlet          Get-ComputerInfo         6.1.0.0    Microsoft.PowerShell.Management
  Command.txt:990:Cmdlet          Get-Content              6.1.0.0    Microsoft.PowerShell.Management
  Command.txt:991:Cmdlet          Get-ControlPanelItem     3.1.0.0    Microsoft.PowerShell.Management
  Command.txt:992:Cmdlet          Get-Credential           6.1.0.0    Microsoft.PowerShell.Security
```

The `Get-Command` cmdlet sends objects down the pipeline to the `Out-File` to create the
**Command.txt** file in the current directory. `Select-String` uses the **Path** parameter to
specify the **Command.txt** file. The **Pattern** parameter specifies **Get-Computer** as the search
pattern. The **Context** parameter uses two values, before and after, and marks pattern matches in
the output with an angle bracket (`>`). The **Context** parameter outputs the two lines before the
first pattern match and three lines after the last pattern match.

### Example 9: Find all pattern matches

This example shows how the **AllMatches** parameter finds each pattern match in a line of text. By
default, `Select-String` only finds the first occurrence of a pattern in a line of text. This
example uses object properties that are found with the `Get-Member` cmdlet.

```
PS> $A = Get-ChildItem -Path "$PSHOME\en-US\*.txt" | Select-String -Pattern 'PowerShell'

PS> $A

C:\Program Files\PowerShell\6\en-US\default.help.txt:3:    PowerShell Help System
C:\Program Files\PowerShell\6\en-US\default.help.txt:6:    Displays help about PowerShell cmdlets and concepts.
C:\Program Files\PowerShell\6\en-US\default.help.txt:9:    PowerShell Help describes PowerShell cmdlets

PS> $A.Matches

Groups   : {0}
Success  : True
Name     : 0
Captures : {0}
Index    : 4
Length   : 10
Value    : PowerShell

PS> $A.Matches.Length

8

PS> $B = Get-ChildItem -Path "$PSHOME\en-US\*.txt" | Select-String -Pattern 'PowerShell' -AllMatches

PS> $B.Matches.Length

9
```

The `Get-ChildItem` cmdlet uses the **Path** parameter. The **Path** parameter uses the variable
`$PSHOME` that specifies the PowerShell directory. The remainder of the path includes the
subdirectory **en-US** and specifies each `*.txt` file in the directory. The `Get-ChildItem` objects
are stored in the `$A` variable. The `$A` variable is sent down the pipeline to the `Select-String`
cmdlet. `Select-String` uses the **Pattern** parameter to search each file for the string
**PowerShell**.

From the PowerShell command line, the `$A` variable contents are displayed. There is a line that
contains two occurrences of the string **PowerShell**.

The `$A.Matches` property lists the first occurrence of the pattern **PowerShell** on each line.

The `$A.Matches.Length` property counts the first occurrence of the pattern **PowerShell** on each
line.

The `$B` variable uses the same `Get-ChildItem` and `Select-String` cmdlets, but adds the
**AllMatches** parameter. **AllMatches** finds each occurrence of the pattern **PowerShell** on each
line. The objects stored in the `$A` and `$B` variables are identical.

The `$B.Matches.Length` property increases because for each line, every occurrence of the pattern
**PowerShell** is counted.

## PARAMETERS

### -AllMatches

Indicates that the cmdlet searches for more than one match in each line of text. Without this
parameter, `Select-String` finds only the first match in each line of text.

When `Select-String` finds more than one match in a line of text, it still emits only one
**MatchInfo** object for the line, but the **Matches** property of the object contains all of the
matches.

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

Indicates that the cmdlet matches are case-sensitive. By default, matches are not case-sensitive.

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

Captures the specified number of lines before and after the line that matches the pattern.

If you enter one number as the value of this parameter, that number determines the number of lines
captured before and after the match. If you enter two numbers as the value, the first number
determines the number of lines before the match and the second number determines the number of lines
after the match. For example, `-Context 2,3`.

In the default display, lines with a match are indicated by a right angle bracket (`>`) (ASCII 62)
in the first column of the display. Unmarked lines are the context.

The **Context** parameter does not change the number of objects generated by `Select-String`.
`Select-String` generates one **MatchInfo** (**Microsoft.PowerShell.Commands.MatchInfo**) object for
each match. The context is stored as an array of strings in the **Context** property of the object.

When the output of a `Select-String` command is sent down the pipeline to another `Select-String`
command, the receiving command searches only the text in the matched line. The matched line is the
value of the **Line** property of the **MatchInfo** object, not the text in the context lines. As a
result, the **Context** parameter is not valid on the receiving `Select-String` command.

When the context includes a match, the **MatchInfo** object for each match includes all of the
context lines, but the overlapping lines appear only once in the display.

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

Specifies the type of encoding for the target file. The default value is **UTF8NoBOM**.

The acceptable values for this parameter are as follows:

- **ASCII**: Uses the encoding for the ASCII (7-bit) character set.
- **BigEndianUnicode**: Encodes in UTF-16 format using the big-endian byte order.
- **OEM**: Uses the default encoding for MS-DOS and console programs.
- **Unicode**: Encodes in UTF-16 format using the little-endian byte order.
- **UTF7**: Encodes in UTF-7 format.
- **UTF8**: Encodes in UTF-8 format.
- **UTF8BOM**: Encodes in UTF-8 format with Byte Order Mark (BOM)
- **UTF8NoBOM**: Encodes in UTF-8 format without Byte Order Mark (BOM)
- **UTF32**: Encodes in UTF-32 format.

Beginning with PowerShell 6.2, the **Encoding** parameter also allows numeric IDs of registered code
pages (like `-Encoding 1251`) or string names of registered code pages (like
`-Encoding "windows-1251"`). For more information, see the .NET documentation for
[Encoding.CodePage](/dotnet/api/system.text.encoding.codepage?view=netcore-2.2).

```yaml
Type: Encoding
Parameter Sets: (All)
Aliases:
Accepted values: ASCII, BigEndianUnicode, Byte, Default, OEM, String, Unicode, UTF7, UTF8, UTF8BOM, UTF8NoBOM, UTF32, Unknown

Required: False
Position: Named
Default value: UTF8NoBOM
Accept pipeline input: False
Accept wildcard characters: False
```

### -Exclude

Exclude the specified items. The value of this parameter qualifies the **Path** parameter. Enter a
path element or pattern, such as `*.txt`. Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Include

Includes the specified items. The value of this parameter qualifies the **Path** parameter. Enter a
path element or pattern, such as `*.txt`. Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -InputObject

Specifies the text to be searched. Enter a variable that contains the text, or type a command or
expression that gets the text.

Using the **InputObject** parameter is not the same as sending strings down the pipeline to
`Select-String`.

When you pipe more than one string to the `Select-String` cmdlet, it searches for the specified text
in each string and returns each string that contains the search text.

When you use the **InputObject** parameter to submit a collection of strings, `Select-String` treats
the collection as a single combined string. `Select-String` returns the strings as a unit if it
finds the search text in any string.

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

Indicates that the cmdlet returns only the first match in each input file. By default,
`Select-String` returns a **MatchInfo** object for each match it finds.

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

Specifies the path to the files to be searched. The value of the **LiteralPath** parameter is used
exactly as it is typed. No characters are interpreted as wildcards. If the path includes escape
characters, enclose it in single quotation marks. Single quotation marks tell PowerShell not to
interpret any characters as escape sequences. For more information, see [about_Quoting_Rules](../Microsoft.Powershell.Core/About/about_Quoting_Rules.md).

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

### -NotMatch

The **NotMatch** parameter finds text that does not match the specified pattern.

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

Specifies the path to the files to search. Wildcards are permitted. The default location is the
local directory.

Specify files in the directory, such as `log1.txt`, `*.doc`, or `*.*`. If you specify only a
directory, the command fails.

```yaml
Type: String[]
Parameter Sets: File
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Pattern

Specifies the text to find on each line. Type a string or regular expression. If you type a string,
use the **SimpleMatch** parameter.

To learn about regular expressions, see [about_Regular_Expressions](../Microsoft.PowerShell.Core/About/about_Regular_Expressions.md).

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Quiet

Indicates that the cmdlet returns a Boolean value (True or False), instead of a **MatchInfo**
object. The value is True if the pattern is found; otherwise the value is False.

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

Indicates that the cmdlet uses a simple match rather than a regular expression match. In a simple
match, `Select-String` searches the input for the text in the **Pattern** parameter. It does not
interpret the value of the **Pattern** parameter as a regular expression statement.

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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object that has a **ToString** method to `Select-String`.

## OUTPUTS

### Microsoft.PowerShell.Commands.MatchInfo or System.Boolean

By default, the output is a set of **MatchInfo** objects with one for each match found. If you use
the **Quiet** parameter, the output is a Boolean value indicating whether the pattern was found.

## NOTES

`Select-String` is similar to **grep** in UNIX or **findstr.exe** in Windows.

The **sls** alias for the `Select-String` cmdlet was introduced in PowerShell 3.0.

To use `Select-String`, type the text that you want to find as the value of the **Pattern**
parameter. To specify the text to be searched, use the following criteria:

- Type the text in a quoted string, and then pipe it to `Select-String`.
- Store a text string in a variable, and then specify the variable as the value of the
  **InputObject** parameter.
- If the text is stored in files, use the **Path** parameter to specify the path to the files.

By default, `Select-String` interprets the value of the **Pattern** parameter as a regular
expression. (For more information, see [about_Regular_Expressions](../Microsoft.PowerShell.Core/About/about_Regular_Expressions.md).
You can use the **SimpleMatch** parameter to override the regular expression matching. The
**SimpleMatch** parameter finds instances of the value of the **Pattern** parameter in the input.

The default output of `Select-String` is a **MatchInfo** object, which includes detailed information
about the matches. The information in the object is useful when you are searching for text in files,
because **MatchInfo** objects have properties such as **Filename** and **Line**. When the input is
not from the file, the value of these parameters is **InputStream**.

If you do not need the information in the **MatchInfo** object, use the **Quiet** parameter. The
**Quiet** parameter returns a Boolean value (True or False) to indicate whether it found a match,
instead of a **MatchInfo** object.

When matching phrases, `Select-String` uses the current culture that is set for the system. To find
the current culture, use the Get-Culture cmdlet.

To find the properties of a **MatchInfo** object, type the following command:

`Select-String -Path test.txt -Pattern 'test' | Get-Member | Format-List -Property *`

## RELATED LINKS

[about_Automatic_Variables](../Microsoft.PowerShell.Core/About/about_Automatic_Variables.md)

[about_Comparison_Operators](../Microsoft.PowerShell.Core/About/about_Comparison_Operators.md)

[about_Functions](../Microsoft.PowerShell.Core/About/about_Functions.md)

[about_Quoting_Rules](../Microsoft.Powershell.Core/About/about_Quoting_Rules.md)

[about_Regular_Expressions](../Microsoft.PowerShell.Core/About/about_Regular_Expressions.md)

[Get-Alias](Get-Alias.md)

[Get-ChildItem](../Microsoft.PowerShell.Management/Get-ChildItem.md)

[Get-Command](../Microsoft.PowerShell.Core/Get-Command.md)

[Get-Member](Get-Member.md)

[Get-WinEvent](../Microsoft.PowerShell.Diagnostics/Get-WinEvent.md)

[Out-File](Out-File.md)
