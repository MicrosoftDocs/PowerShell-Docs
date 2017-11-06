---
ms.date:  2017-06-09
schema:  2.0.0
keywords:  powershell,cmdlet
title:  about_Comment_Based_Help
---
# About Comment Based Help

## about_Comment_Based_Help

## SHORT DESCRIPTION

Describes how to write comment-based help topics for functions and scripts.

## LONG DESCRIPTION

You can write comment-based help topics for functions and scripts by using
special help comment keywords.

The [Get-Help](../Get-Help.md) cmdlet displays comment-based help in the same format in which
it displays the cmdlet help topics that are generated from XML files. Users
can use all of the parameters of `Get-Help`, such as **Detailed**, **Full**, **Example**,
and **Online**, to display the contents of comment-based help.

You can also write XML-based help files for functions and scripts. To
enable the `Get-Help` cmdlet to find the XML-based help file for a function
or script, use the "ExternalHelp" keyword. Without this keyword, `Get-Help`
cannot find XML-based help topics for functions or scripts.

This topic explains how to write help topics for functions and scripts. For
information about how to display help topics for functions and scripts, see
`Get-Help`.

The [Update-Help](../Update-Help.md) and [Save-Help](../Save-Help.md) cmdlets work only on XML files. Updatable Help
does not support comment-based help topics.

## SYNTAX FOR COMMENT-BASED HELP

The syntax for comment-based help is as follows:

```
.<help keyword>
<help content>
```

or

```
<#
.<help keyword>
<help content>
#>
```

Comment-based help is written as a series of comments. You can type a
comment symbol `#` before each line of comments, or you can use the `<#` and `#>` symbols to create a comment block. All the lines within the comment block are interpreted as comments.

All of the lines in a comment-based help topic must be contiguous. If a
comment-based help topic follows a comment that is not part of the help
topic, there must be at least one blank line between the last non-help
comment line and the beginning of the comment-based help.

Keywords define each section of comment-based help. Each comment-based help
keyword is preceded by a dot `.`. The keywords can appear in any order. The
keyword names are not case-sensitive.

For example, the "Description" keyword precedes a description of a function or
script.

```
<#
.Description
Get-Function displays the name and syntax of all functions in the session.
#>
```

The comment block must contain at least one keyword. Some of the keywords,
such as "EXAMPLE", can appear many times in the same comment block. The help
content for each keyword begins on the line after the keyword and can span
multiple lines.

## SYNTAX FOR COMMENT-BASED HELP IN FUNCTIONS

Comment-based help for a function can appear in one of three locations:

- At the beginning of the function body.

- At the end of the function body.

- Before the Function keyword. There cannot be more than one blank line between the last line of the function help and the Function keyword.

For example:

```powershell
function Get-Function
{
<#
.<help keyword>
<help content>
#>

<function commands>
}
```

or

```powershell
function Get-Function
{
<function commands>

<#
.<help keyword>
<help content>
#>
}
```

or

```powershell
<#
.< help keyword>
< help content>
#>
function Get-Function { }
```

## SYNTAX FOR COMMENT-BASED HELP IN SCRIPTS

Comment-based help for a script can appear in one of the following two
locations in the script.

- At the beginning of the script file. Script help can be preceded in the script only by comments and blank lines.

- If the first item in the script body (after the help) is a function declaration, there must be at least two blank lines between the end of the script help and the function declaration. Otherwise, the help is interpreted as being help for the function, not help for the script.

- At the end of the script file. However, if the script is signed, place Comment-based help at the beginning of the script file. The end of the script is occupied by the signature block.

For example:

```powershell
<#
.<help keyword>
<help content>
#>

function Get-Function { }
```

or

```powershell
function Get-Function { }

<#
.< help keyword>
< help content>
#>
```

## SYNTAX FOR COMMENT-BASED HELP IN SCRIPT MODULES

In a script module `.psm1`, comment-based help uses the syntax
for functions, not the syntax for scripts. You cannot use the
script syntax to provide help for all functions defined in a
script module.

For example, if you are using the "ExternalHelp" keyword to
identify the XML-based help files for the functions in a script
module, you must add an "ExternalHelp" comment to each function.

```powershell
.ExternalHelp <XML-file-name>
function <function-name>
{
# ...

}
```

## COMMENT-BASED HELP KEYWORDS

The following are valid comment-based help keywords. They are listed in the order in
which they typically appear in a help topic along with their intended use.
These keywords can appear in any order in the comment-based help, and they
are not case-sensitive.

### .SYNOPSIS

A brief description of the function or script. This keyword can be used
only once in each topic.

### .DESCRIPTION

A detailed description of the function or script. This keyword can be
used only once in each topic.

### .PARAMETER

The description of a parameter. Add a ".PARAMETER" keyword for
each parameter in the function or script syntax.

Type the parameter name on the same line as the ".PARAMETER" keyword.
Type the parameter description on the lines following the ".PARAMETER"
keyword. Windows PowerShell interprets all text between the ".PARAMETER"
line and the next keyword or the end of the comment block as part of
the parameter description. The description can include paragraph breaks.

```
.PARAMETER  <Parameter-Name>
```

The Parameter keywords can appear in any order in the comment block, but
the function or script syntax determines the order in which the parameters
(and their descriptions) appear in help topic. To change the order,
change the syntax.

You can also specify a parameter description by placing a comment in the
function or script syntax immediately before the parameter variable name.
If you use both a syntax comment and a Parameter keyword, the description
associated with the Parameter keyword is used, and the syntax comment is
ignored.

### .EXAMPLE

A sample command that uses the function or script, optionally followed
by sample output and a description. Repeat this keyword for each example.

### .INPUTS

The Microsoft .NET Framework types of objects that can be piped to the
function or script. You can also include a description of the input
objects.

### .OUTPUTS

The .NET Framework type of the objects that the cmdlet returns. You can
also include a description of the returned objects.

### .NOTES

Additional information about the function or script.

### .LINK

The name of a related topic. The value appears on the line below
the ".LINK" keyword and must be preceded by a comment symbol `#` or
included in the comment block.

Repeat the ".LINK" keyword for each related topic.

This content appears in the Related Links section of the help topic.

The "Link" keyword content can also include a Uniform Resource Identifier
(URI) to an online version of the same help topic. The online version
opens when you use the **Online** parameter of `Get-Help`. The URI must begin
with "http" or "https".

### .COMPONENT

The technology or feature that the function or script uses, or to which
it is related. This content appears when the `Get-Help` command includes
the **Component** parameter of `Get-Help`.

### .ROLE

The user role for the help topic. This content appears when the `Get-Help`
command includes the **Role** parameter of `Get-Help`.

### .FUNCTIONALITY

The intended use of the function. This content appears when the `Get-Help`
command includes the **Functionality** parameter of `Get-Help`.

### .FORWARDHELPTARGETNAME

Redirects to the help topic for the specified command. You can redirect
users to any help topic, including help topics for a function, script,
cmdlet, or provider.

```
.FORWARDHELPTARGETNAME <Command-Name>
```

### .FORWARDHELPCATEGORY

Specifies the help category of the item in "ForwardHelpTargetName".
Valid values are "Alias", "Cmdlet", "HelpFile", "Function", "Provider", "General",
"FAQ", "Glossary", "ScriptCommand", "ExternalScript", "Filter", or "All". Use this
keyword to avoid conflicts when there are commands with the same name.

```
.FORWARDHELPCATEGORY <Category>
```

### .REMOTEHELPRUNSPACE

Specifies a session that contains the help topic. Enter a variable that
contains a "PSSession". This keyword is used by the [Export-PSSession](../../Microsoft.PowerShell.Utility/Export-PSSession.md)
cmdlet to find the help topics for the exported commands.

```
.REMOTEHELPRUNSPACE <PSSession-variable>
```

### .EXTERNALHELP

Specifies an XML-based help file for the script or function.

```
.EXTERNALHELP <XML Help File>
```

The "ExternalHelp" keyword is required when a function or script
is documented in XML files. Without this keyword, `Get-Help` cannot
find the XML-based help file for the function or script.

The "ExternalHelp" keyword takes precedence over other comment-based
help keywords. If "ExternalHelp" is present, `Get-Help` does not display
comment-based help, even if it cannot find a help topic that matches
the value of the "ExternalHelp" keyword.

If the function is exported by a module, set the value of the
"ExternalHelp" keyword to a file name without a path. `Get-Help` looks for
the specified file name in a language-specific subdirectory of the module
directory. There are no requirements for the name of the XML-based help
file for a function, but a best practice is to use the following format:

```
<ScriptModule.psm1>-help.xml
```

If the function is not included in a module, include a path to the
XML-based help file. If the value includes a path and the path contains
UI-culture-specific subdirectories, `Get-Help` searches the subdirectories
recursively for an XML file with the name of the script or function in
accordance with the language fallback standards established for Windows,
just as it does in a module directory.

For more information about the cmdlet help XML-based help file format,
see [How to Write Cmdlet Help](https://go.microsoft.com/fwlink/?LinkID=123415) in the MSDN library.

## AUTOGENERATED CONTENT

The name, syntax, parameter list, parameter attribute table, common
parameters, and remarks are automatically generated by the `Get-Help` cmdlet.

### Name

The "Name" section of a function help topic is taken from the function
name in the function syntax. The "Name" of a script help topic is
taken from the script file name. To change the name or its
capitalization, change the function syntax or the script file name.

### Syntax

The "Syntax" section of the help topic is generated from the function
or script syntax. To add detail to the help topic syntax, such as
the .NET Framework type of a parameter, add the detail to the syntax.
If you do not specify a parameter type, the "Object" type is
inserted as the default value.

### Parameter List

The "Parameter list" in the help topic is generated from the function
or script syntax and from the descriptions that you add by using the
"Parameters" keyword. The function parameters appear in the "Parameters"
section of the help topic in the same order that they appear in
the function or script syntax. The spelling and capitalization of
parameter names is also taken from the syntax; it is not affected
by the parameter name specified by the "Parameter" keyword.

### Common Parameters

The "Common parameters" are added to the syntax and parameter list
of the help topic, even if they have no effect. For more information
about the common parameters, see [about_CommonParameters](about_CommonParameters.md).

### Parameter Attribute Table

`Get-Help` generates the table of parameter attributes that appears
when you use the **Full** or **Parameter** parameter of `Get-help`. The value
of the "Required", "Position", and "Default" value attributes is taken
from the function or script syntax.

Default values and a value for "Accept Wildcard characters" do not appear in
the "Parameter attribute table" even when they are defined in the function or
script. To help users, provide this information in the parameter description.

### Remarks

The "Remarks" section of the help topic is automatically generated
from the function or script name. You cannot change or affect its
content.

## DISABLING COMMENT-BASED HELP

[This technique was suggested by Rich Prescott, a Windows engineer
from New York, NY.]

You can disable comment-based help. This makes the comment-based
help ineffective without deleting it.

To disable comment-based help, enclose the comments in a here-string. To
hide the here-string, assign it to a variable or pipe it to the Out-Null
cmdlet.

While it is disabled, the comment-based help has no effect.

For example, the following function has comment-based help.

```powershell
<#
.SYNOPSIS

Adds a file name extension to a supplied name.
#>
function Add-Extension
{
param ([string]$Name,[string]$Extension = "txt")
...

}
```

To disable the comment-based help, enclose it in a here-string,
as shown in the following example.

```powershell
@"
<#
.SYNOPSIS

Adds a file name extension to a supplied name.
#>
"@

function Add-Extension
{
param ([string]$Name,[string]$Extension = "txt")
...

}
```

To hide the disabled comment-based help, assign the here-string to
a local variable that is not otherwise used in the function, as
shown in the following example. You can also pipe it to the [Out-Null](../Out-Null.md)
cmdlet.

```powershell
$x = @"
<#
.SYNOPSIS

Adds a file name extension to a supplied name.
#>
"@

function Add-Extension
{
param ([string]$Name,[string]$Extension = "txt")
...

}
```

For more information about here-strings, see [about_Quoting_Rules](about_Quoting_Rules.md).

## EXAMPLES

- Comment-based Help for a Function

The following sample function includes comment-based help:

```powershell
function Add-Extension
{
param ([string]$Name,[string]$Extension = "txt")
$name = $name + "." + $extension
$name

<#
.SYNOPSIS

Adds a file name extension to a supplied name.

.DESCRIPTION

Adds a file name extension to a supplied name.
Takes any strings for the file name or extension.

.PARAMETER Name
Specifies the file name.

.PARAMETER Extension
Specifies the extension. "Txt" is the default.

.INPUTS

None. You cannot pipe objects to Add-Extension.

.OUTPUTS

System.String. Add-Extension returns a string with the extension or file name.

.EXAMPLE

C:\PS> extension -name "File"
File.txt

.EXAMPLE

C:\PS> extension -name "File" -extension "doc"
File.doc

.EXAMPLE

C:\PS> extension "File" "doc"
File.doc

.LINK

http://www.fabrikam.com/extension.html

.LINK

Set-Item
#>
}
```

The results are as follows:

```powershell
Get-Help -Name "Add-Extension" -Full
```

```
NAME

Add-Extension

SYNOPSIS

Adds a file name extension to a supplied name.

SYNTAX

Add-Extension [[-Name] <String>] [[-Extension] <String>] [<CommonParameters>]

DESCRIPTION

Adds a file name extension to a supplied name. Takes any strings for the file name or extension.

PARAMETERS

-Name
Specifies the file name.

Required?                    false
Position?                    0
Default value
Accept pipeline input?       false
Accept wildcard characters?

-Extension
Specifies the extension. "Txt" is the default.

Required?                    false
Position?                    1
Default value
Accept pipeline input?       false
Accept wildcard characters?

<CommonParameters>
This cmdlet supports the common parameters: -Verbose, -Debug,
-ErrorAction, -ErrorVariable, -WarningAction, -WarningVariable,
-OutBuffer and -OutVariable. For more information, type
"get-help about_commonparameters".

INPUTS
None. You cannot pipe objects to Add-Extension.

OUTPUTS

System.String. Add-Extension returns a string with the extension or file name.

Example 1

C:\PS> extension -name "File"
File.txt

Example 2

C:\PS> extension -name "File" -extension "doc"
File.doc

Example 3

C:\PS> extension "File" "doc"
File.doc

RELATED LINKS

http://www.fabrikam.com/extension.html
Set-Item
```

- Parameter Descriptions in Function Syntax

This example is the same as the previous one, except that the parameter
descriptions are inserted in the function syntax. This format is most
useful when the descriptions are brief.

```powershell
function Add-Extension
{
param
(

[string]
#Specifies the file name.
$name,

[string]
#Specifies the file name extension. "Txt" is the default.
$extension = "txt"
)

$name = $name + "." + $extension
$name

<#
.SYNOPSIS

Adds a file name extension to a supplied name.

.DESCRIPTION

Adds a file name extension to a supplied name. Takes any strings for the file name or extension.

.INPUTS

None. You cannot pipe objects to Add-Extension.

.OUTPUTS

System.String. Add-Extension returns a string with the extension or file name.

.EXAMPLE

C:\PS> extension -name "File"
File.txt

.EXAMPLE

C:\PS> extension -name "File" -extension "doc"
File.doc

.EXAMPLE

C:\PS> extension "File" "doc"
File.doc

.LINK

http://www.fabrikam.com/extension.html

.LINK

Set-Item
#>
}
```

- Comment-based Help for a Script

The following sample script includes comment-based help.
Notice the blank lines between the closing "#>" and the "Param" statement.
In a script that does not have a Param statement, there must be at least
two blank lines between the final comment in the help topic and the first
function declaration. Without these blank lines, `Get-Help` associates the
help topic with the function, not the script.

```powershell
<#
.SYNOPSIS

Performs monthly data updates.

.DESCRIPTION

The Update-Month.ps1 script updates the registry with new data generated
during the past month and generates a report.

.PARAMETER InputPath
Specifies the path to the CSV-based input file.

.PARAMETER OutputPath
Specifies the name and path for the CSV-based output file. By default,
MonthlyUpdates.ps1 generates a name from the date and time it runs, and
saves the output in the local directory.

.INPUTS

None. You cannot pipe objects to Update-Month.ps1.

.OUTPUTS

None. Update-Month.ps1 does not generate any output.

.EXAMPLE

C:\PS> .\Update-Month.ps1

.EXAMPLE

C:\PS> .\Update-Month.ps1 -inputpath C:\Data\January.csv

.EXAMPLE

C:\PS> .\Update-Month.ps1 -inputpath C:\Data\January.csv -outputPath C:\Reports\2009\January.csv
#>

param ([string]$InputPath, [string]$OutPutPath)

function Get-Data { }
...
```

The following command gets the script help. Because the script is not
in a directory that is listed in the "Path" environment variable, the
`Get-Help` command that gets the script help must specify the script path.

```powershell
Get-Help -Path .\update-month.ps1 -Full
```

```
# NAME

C:\ps-test\Update-Month.ps1

# SYNOPSIS

Performs monthly data updates.

# SYNTAX

C:\ps-test\Update-Month.ps1 [-InputPath] <String> [[-OutputPath]
<String>] [<CommonParameters>]

# DESCRIPTION

The Update-Month.ps1 script updates the registry with new data
generated during the past month and generates a report.

# PARAMETERS

-InputPath
Specifies the path to the CSV-based input file.

Required?                    true
Position?                    0
Default value
Accept pipeline input?       false
Accept wildcard characters?

-OutputPath
Specifies the name and path for the CSV-based output file. By
default, MonthlyUpdates.ps1 generates a name from the date
and time it runs, and saves the output in the local directory.

Required?                    false
Position?                    1
Default value
Accept pipeline input?       false
Accept wildcard characters?

<CommonParameters>
This cmdlet supports the common parameters: -Verbose, -Debug,
-ErrorAction, -ErrorVariable, -WarningAction, -WarningVariable,
-OutBuffer and -OutVariable. For more information, type,
"get-help about_commonparameters".

# INPUTS

None. You cannot pipe objects to Update-Month.ps1.

# OUTPUTS

None. Update-Month.ps1 does not generate any output.

Example 1

C:\PS> .\Update-Month.ps1

Example 2

C:\PS> .\Update-Month.ps1 -inputpath C:\Data\January.csv

Example 3

C:\PS> .\Update-Month.ps1 -inputpath C:\Data\January.csv -outputPath
C:\Reports\2009\January.csv

# RELATED LINKS
```

- Redirecting to an XML File

You can write XML-based help topics for functions and scripts. Although
comment-based help is easier to implement, XML-based help is required
for Updatable Help and to provide help topics in multiple languages.

The following example shows the first few lines of the Update-Month.ps1
script. The script uses the "ExternalHelp" keyword to specify the path to
an XML-based help topic for the script.

Note that the value of the "ExternalHelp" keyword appears on the same
line as the keyword. Any other placement is ineffective.

```powershell
 .ExternalHelp C:\MyScripts\Update-Month-Help.xml

param ([string]$InputPath, [string]$OutPutPath)
function Get-Data { }
...
```

The following examples show three valid placements of the "ExternalHelp" keyword in a function.

```powershell
function Add-Extension
{
.ExternalHelp C:\ps-test\Add-Extension.xml

param ([string] $name, [string]$extension = "txt")
$name = $name + "." + $extension
$name
}
```

```powershell
function Add-Extension
{
param ([string] $name, [string]$extension = "txt")
$name = $name + "." + $extension
$name

.ExternalHelp C:\ps-test\Add-Extension.xml
}
```

```powershell
.ExternalHelp C:\ps-test\Add-Extension.xml
function Add-Extension
{
param ([string] $name, [string]$extension = "txt")
$name = $name + "." + $extension
$name
}
```

- Redirecting to a Different Help Topic

The following code is an excerpt from the beginning of the built-in
help function in Windows PowerShell, which displays one screen of help
text at a time. Because the help topic for the `Get-Help` cmdlet describes
the help function, the help function uses the "ForwardHelpTargetName" and
"ForwardHelpCategory" keywords to redirect the user to the `Get-Help` cmdlet
help topic.

```powershell
function help
{

<#
.FORWARDHELPTARGETNAME Get-Help
.FORWARDHELPCATEGORY Cmdlet
#>
[CmdletBinding(DefaultParameterSetName='AllUsersView')]
param(
[Parameter(Position=0, ValueFromPipelineByPropertyName=$true)]
[System.String]
${Name},
...
```

The following command uses this feature:

```powershell
Get-Help -Name help
```

```
NAME

Get-Help

SYNOPSIS

Displays information about Windows PowerShell cmdlets and concepts.
...
```

## SEE ALSO

[about_Functions](about_Functions.md)

[about_Functions_Advanced_Parameters](about_Functions_Advanced_Parameters.md)

[about_Scripts](about_Scripts.md)

[How to Write Cmdlet Help](https://go.microsoft.com/fwlink/?LinkID=123415)