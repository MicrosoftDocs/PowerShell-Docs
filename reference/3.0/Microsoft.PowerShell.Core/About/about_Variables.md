---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Variables
---

# About Variables

## SHORT DESCRIPTION

Describes how variables store values that can be used in PowerShell.

## LONG DESCRIPTION

You can store all types of values in PowerShell variables. They are
typically used to store the results of commands and to store elements that
are used in commands and expressions, such as names, paths, settings, and
values.

A variable is a unit of memory in which values are stored. In Windows
PowerShell, variables are represented by text strings that begin with a
dollar sign (\$), such as \$a, \$process, or \$my_var.

Variable names are not case-sensitive. Variable names can include spaces
and special characters, but these are difficult to use and should be
avoided.

There are several different types of variables in  PowerShell.

- User-created variables: User-created variables are created and
  maintained by the user. By default, the variables that you create at the
  PowerShell command line exist only while the PowerShell
  window is open, and they are lost when you close the window. To save a
  variable, add it to your PowerShell profile. You can also create
  variables in scripts with global, script, or local scope.

- Automatic variables: Automatic variables store the state of Windows
  PowerShell. These variables are created by PowerShell, and
  PowerShell changes their values as required to maintain their
  accuracy. Users cannot change the value of these variables. For example,
  the \$PSHome variable stores the path to the PowerShell
  installation directory.

  For more information, a list, and a description of the automatic
  variables, see [about_Automatic_Variables](about_Automatic_Variables.md).

- Preference variables: Preference variables store user preferences for
  PowerShell. These variables are created by PowerShell and are populated
  with default values. Users can change the values of these variables. For
  example, the \$MaximumHistoryCount variable determines the maximum number
  of entries in the session history.

  For more information, a list, and a description of the preference
  variables, see [about_Preference_Variables](about_Preference_Variables.md).

### WORKING WITH VARIABLES

To create a new variable, use an assignment statement to assign a value to
the variable. You do not have to declare the variable before using it. The
default value of all variables is \$null.

For example:

```powershell
PS> $MyVariable = 1, 2, 3

PS> $path = "C:\Windows\System32"
```

Variables are very useful for storing the results of commands.

For example:

```powershell
PS> $processes = Get-Process

PS> $Today = (Get-Date).date
```

To display the value of a variable, type the variable name, preceded by a
dollar sign (\$).

For example:

```powershell
PS> $MyVariable
1
2
3

PS> $Today
Thursday, September 03, 2009 12:00:00 AM
```

To change the value of a variable, assign a new value to the variable.

The following examples displays the value of the\$MyVariable variable,
changes the value of the variable, and then displays the new value.

```powershell
PS> $MyVariable
1
2
3

PS> $MyVariable = "The green cat."

PS> $MyVariable
The green cat.
```

To delete the value of a variable, use the Clear-Variable cmdlet or change
the value to \$null.

```powershell
PS> Clear-Variable -name MyVariable

-or-

PS> $MyVariable = $null
```

To delete the variable, use the Remove-Variable or Remove-Item cmdlets.
(These cmdlets are discussed later in this topic.)

```powershell
PS> remove-variable -name MyVariable

PS> remove-item -path variable:\myvariable
```

To get a list of all of the variables in your  PowerShell session, type:

```powershell
get-variable
```

### TYPES OF VARIABLES

You can store any type of object in a variable, including integers, strings,
arrays, hash tables, and objects that represent processes, services, event
logs, and computers.

PowerShell variables are "loosely typed," which means that they are not
limited to a particular type of object. A single variable can even contain a
collection (an "array") of different types of objects at the same time.

The data type of a variable, which is a .NET Framework type, is determined by
the .NET types of the values of the variable.

For example:

```powershell
PS> $a = 12     (System.Int32)
PS> $a = "Word" (System.String)
PS> $a = 12, "Word" (System.Int32, System.String)
PS> $a = dir C:\Windows\System32  (Files and folders)
```

You can use a type attribute and cast notation to ensure that a variable can
contain only objects of the specified type or objects that can be converted to
that type. If you try to assign a value of another type, PowerShell tries to
convert the value to its type. If it cannot, the assignment statement fails.

To use cast notation, enter a type name, enclosed in brackets, before the
variable name (on the left side of the assignment statement). The following
example creates an \$number variable that can contain only integers, a \$words
variable that can contain only strings, and a \$dates variable that can
contain only DateTime objects.

```powershell
PS> [int]$number = 8
PS> $a = "12345" (The string is converted to an integer.)
PS> $a = "Hello"
Cannot convert value "Hello" to type "System.Int32". Error: "Input string
 was not in a correct format."
At line:1 char:3
+ $a <<<<  = "Hello"
    + CategoryInfo          : MetadataError: (:) [], ArgumentTransformati
onMetadataException
    + FullyQualifiedErrorId : RuntimeException

PS> [string]$words = "Hello"
PS> $words = 2   (The integer is converted to a string.)
PS> $words + 10  (The strings are concatenated.)
210

PS> #The string is converted to a DateTime object.
PS> [datetime] $dates = "09/12/91"
PS> $dates
Thursday, September 12, 1991 12:00:00 AM

PS> $dates = 10  #The integer is converted to a DateTime object.
PS> $dates
Monday, January 01, 0001 12:00:00 AM
```

### USING VARIABLES IN COMMANDS AND EXPRESSIONS

To use a variable in a command or expression, type the variable name,
preceded by the dollar sign (\$).

If the variable name (and dollar sign) are not enclosed in quotation marks, or
if they are enclosed in double quotation marks ("), the value of the variable
is used in the command or expression.

If the variable name (and dollar sign) are enclosed in single quotation marks,
('), the variable name is used in the expression.

For example, the first command gets the value of the \$profile variable, which
is the path to the PowerShell user profile file in the PowerShell console. The
second command opens the file in Notepad, and the third and fourth commands
use the name of the variable in an expression.

```powershell
PS> $profile
C:\Documents and Settings\User01\My Documents\WindowsPowerShell\Microso
ft.PowerShell_profile.ps1

PS> notepad $profile
- or -
PS> notepad "$profile"
C:\Documents and Settings\User01\My Documents\WindowsPowerShell\Microso
ft.PowerShell_profile.ps1

PS> '$profile'
$profile

PS> 'Use the $profile variable.'
Use the $profile variable.
```

For more information about using quotation marks in PowerShell, see
[about_Quoting_Rules](about_Quoting_Rules.md).

### VARIABLE NAMES THAT INCLUDE SPECIAL CHARACTERS

Variable names begin with a dollar sign. They can include alphanumeric
characters and special characters. The length of the variable name is limited
only by available memory.

Whenever possible, variable names should include only alphanumeric characters
and the underscore character (_).Variable names that include spaces and other
special characters, are difficult to use and should be avoided.

To create or display a variable name that includes spaces or special
characters, enclose the variable name in braces. This directs PowerShell to
interpret the characters in the variable name literally.

For example, the following command creates and then displays a variable named
"save-items".

```powershell
C:\PS> ${save-items} = "a", "b", "c"
C:\PS> ${save-items}
a
b
c
```

The following command gets the child items in the directory that is
represented by the "ProgramFiles(x86)" environment variable.

```powershell
C:\PS> Get-childitem ${env:ProgramFiles(x86)}
```

To refer to a variable name that includes braces, enclose the variable name in
braces, and use the backtick (escape) character to escape the braces. For
example, to create a variable named "this{value}is" with a value of 1, type:

```powershell
C:\PS> ${this`{value`}is} = 1
C:\PS> ${this`{value`}is}
1
```

### VARIABLES AND SCOPE

By default, variables are available only in the scope in which they are
created.

For example, a variable that you create in a function is available only within
the function. A variable that you create in a script is available only within
the script (unless you dot-source the script, which adds it to the current
scope).

You can use a scope modifier to change the default scope of the variable. The
following expression creates a variable named "Computers". The variable has a
global scope, even when it is created in a script or function.

```powershell
$global:computers = "Server01"
```

For more information, see about_Scopes.

### SAVING VARIABLES

Variables that you create are available only in the session in which you
create them. They are lost when you close your session.

To create the in every PowerShell session that you start, add the variable to
your PowerShell profile.

For example, to change the value of the \$VerbosePreference variable in every
PowerShell session, add the following command to your PowerShell profile.

```powershell
$VerbosePreference = "Continue"
```

You can add this command to your profile by opening the profile file in a text
editor, such as Notepad. For more information about PowerShell profiles, see
about_profiles.

### THE VARIABLE: DRIVE

PowerShell Variable provider creates a Variable: drive that looks and acts
like a file system drive, but it contains the variables in your session and
their values.

To change to the variable: drive, type:

```powershell
set-location variable:

 (or "cd variable:")
```

To list the items (variables) in the Variable: drive, use the Get-Item or
Get-ChildItem cmdlets. For example:

```powershell
get-childitem variable:
```

To get the value of a particular variable, use file system notation to specify
the name of the drive and the name of the variable. For example, to get the
\$PSCulture automatic variable, use the following command.

```powershell
get-item variable:\PSCulture

Name                           Value
----                           -----
PSCulture                      en-US
```

For more information about the Variable: drive and the PowerShell Variable
provider, type "get-help variable".

### THE VARIABLE CMDLETS

PowerShell includes a set of cmdlets that are designed to manage variables.

| Cmdlet Name     | Description                                |
| --------------- | ------------------------------------------ |
| Clear-Variable  | Deletes the value of a variable.           |
| Get-Variable    | Gets the variables in the current console. |
| New-Variable    | Creates a new variable.                    |
| Remove-Variable | Deletes a variable and its value.          |
| Set-Variable    | Changes the value of a variable.           |

To get help for these cmdlets, type: "Get-Help <cmdlet-hame>".

## SEE ALSO

- [about_Automatic_Variables](about_Automatic_Variables.md)
- [about_Environment_Variables](about_Environment_Variables.md)
- [about_Preference_Variables](about_Preference_Variables.md)
- [about_Profiles](about_Profiles.md)
- [about_Quoting_Rules](about_Quoting_Rules.md)
- [about_Scopes](about_Scopes.md)
