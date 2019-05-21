---
ms.date:  08/28/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Operators
---
# About Operators

## Short description
Describes the operators that are supported by PowerShell.

## Long description

An operator is a language element that you can use in a command or
expression. PowerShell supports several types of operators to help you
manipulate values.

### Arithmetic Operators

Use arithmetic operators (`+`, `-`, `*`, `/`, `%`) to calculate values in a
command or expression. With these operators, you can add, subtract,
multiply, or divide values, and calculate the remainder (modulus) of a
division operation.

The addition operator concatenates elements. The multiplication operator
returns the specified number of copies of each element. You can use
arithmetic operators on any .NET type that implements them, such as: `Int`,
`String`, `DateTime`, `Hashtable`, and Arrays.

For more information, see [about_Arithmetic_Operators](about_Arithmetic_Operators.md).

### Assignment Operators

Use assignment operators (`=`, `+=`, `-=`, `*=`, `/=`, `%=`) to assign, change,
or append values to variables. You can combine arithmetic operators with
assignment to assign the result of the arithmetic operation to a variable.

For more information, see [about_Assignment_Operators](about_Assignment_Operators.md).

### Comparison Operators

Use comparison operators (`-eq`, `-ne`, `-gt`, `-lt`, `-le`, `-ge`) to
compare values and test conditions. For example, you can compare two string
values to determine whether they are equal.

The comparison operators also include operators that find or replace patterns
in text. The (`-match`, `-notmatch`, `-replace`) operators use regular
expressions, and (`-like`, `-notlike`) use wildcards `*`.

Containment comparison operators determine whether a test value appears in a
reference set (`-in`, `-notin`, `-contains`, `-notcontains`).

Bitwise comparison operators (`-bAND`, `-bOR`, `-bXOR`, `-bNOT`) manipulate
the bit patterns in values.

For more information, see [about_Comparison_Operators](about_Comparison_Operators.md).

### Logical Operators

Use logical operators (`-and`, `-or`, `-xor`, `-not`, `!`) to connect
conditional statements into a single complex conditional. For example, you
can use a logical `-and` operator to create an object filter with two
different conditions.

For more information, see [about_Logical_Operators](about_logical_operators.md).

### Redirection Operators

Use redirection operators (`>`, `>>`, `2>`, `2>>`, and `2>&1`) to send the
output of a command or expression to a text file. The redirection operators
work like the `Out-File` cmdlet (without parameters) but they also let you
redirect error output to specified files. You can also use the `Tee-Object`
cmdlet to redirect output.

For more information, see [about_Redirection](about_Redirection.md)

### Split and Join Operators

The `-split` and `-join` operators divide and combine substrings. The
`-split` operator splits a string into substrings. The `-join` operator
concatenates multiple strings into a single string.

For more information, see [about_Split](about_Split.md) and
[about_Join](about_Join.md).

### Type Operators

Use the type operators (`-is`, `-isnot`, `-as`) to find or change the .NET
Framework type of an object.

For more information, see [about_Type_Operators](about_Type_Operators.md).

### Unary Operators

Use unary operators to increment or decrement variables or object
properties and to set integers to positive or negative numbers. For
example, to increment the variable `$a` from `9` to `10`, you type `$a++`.

### Special Operators

Special operators have specific use-cases that do not fit into any other
operator group. For example, special operators allow you to
run commands, change a value's data type, or retrieve elements from an array.

#### Array subexpression operator `@( )`

Returns the result of one or more statements as an array. If there is only
one item, the array has only one member.

```powershell
@(Get-WmiObject win32_logicalDisk)
```

#### Call operator `&`

Runs a command, script, or script block. The call operator, also known as the
"invocation operator," lets you run commands that are stored in variables and
represented by strings or script blocks. The call operator executes in a child
scope. For more about scopes, see [about_scopes](about_scopes.md).

This example stores a command in a string and executes it using the call
operator.

```
PS> $c = "get-executionpolicy"
PS> $c
get-executionpolicy
PS> & $c
AllSigned
```

The call operator does not parse strings. This means that you cannot use
command parameters within a string when you use the call operator.

```
PS> $c = "Get-Service -Name Spooler"
PS> $c
Get-Service -Name Spooler
PS> & $c
& : The term 'Get-Service -Name Spooler' is not recognized as the name of a
cmdlet, function, script file, or operable program. Check the spelling of
the name, or if a path was included, verify that the path is correct and
try again.
At line:1 char:2
+ &$c
+  ~~
    + CategoryInfo          : ObjectNotFound: (Get-Service -Name Spooler:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
```

The
[Invoke-Expression](../../Microsoft.PowerShell.Utility/Invoke-Expression.md)
cmdlet can execute code that causes parsing errors when using the call
operator.

```
PS> &"1+1"
& : The term '1+1' is not recognized as the name of a cmdlet, function, script
file, or operable program. Check the spelling of the name, or if a path was
included, verify that the path is correct and try again.
At line:1 char:2
+ &"1+1"
+  ~~~~~
    + CategoryInfo          : ObjectNotFound: (1+1:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
PS> Invoke-Expression "1+1"
2
```

You can use the call operator to execute scripts using their filenames. The
example below shows a script filename that contains spaces. When you try to
execute the script, PowerShell instead displays the contents of the quoted
string containing the filename. The call operator allows you to execute the
contents of the string containing the filename.

```
PS C:\Scripts> Get-ChildItem

    Directory: C:\Scripts


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        8/28/2018   1:36 PM             58 script name with spaces.ps1

PS C:\Scripts> ".\script name with spaces.ps1"
.\script name with spaces.ps1
PS C:\Scripts> &".\script name with spaces.ps1"
Hello World!
```

For more about script blocks, see [about_Script_Blocks](about_Script_Blocks.md).

#### Ampersand background operator `&`

Runs the pipeline before it in a PowerShell job. The ampersand background
operator acts similarly to the UNIX "ampersand operator" which famously runs
the command before it as a background process. The ampersand background
operator is built on top of PowerShell jobs so it shares a lot of functionality
with `Start-Job`. The following command contains basic usage of the ampersand
background operator.

```powershell
Get-Process -Name pwsh &
```

This is functionally equivalent to the following usage of
`Start-Job`.

```powershell
Start-Job -ScriptBlock {Get-Process -Name pwsh}
```

Since it's functionally equivalent to using
`Start-Job`,
the ampersand background operator returns a
`Job`
object just like
`Start-Job` does.
This means that you are able to use
`Receive-Job` and `Remove-Job`
just as you would if you had used
`Start-Job` to start the job.

```powershell
$job = Get-Process -Name pwsh &
Receive-Job $job
```

```Output

 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
      0     0.00     221.16      25.90    6988 988 pwsh
      0     0.00     140.12      29.87   14845 845 pwsh
      0     0.00      85.51       0.91   19639 988 pwsh

```

```powershell
$job = Get-Process -Name pwsh &
Remove-Job $job
```

For more information on PowerShell jobs, see [about_Jobs](about_Jobs.md).

#### Cast operator `[ ]`

Converts or limits objects to the specified type. If the objects cannot be
converted, PowerShell generates an error.

```powershell
[datetime]$birthday = "1/20/88"
[int64]$a = 34
```

#### Comma operator `,`

As a binary operator, the comma creates an array. As a unary operator, the
comma creates an array with one member. Place the comma before the member.

```powershell
$myArray = 1,2,3
$SingleArray = ,1
```

#### Dot sourcing operator `.`

Runs a script in the current scope so that any functions, aliases, and
variables that the script creates are added to the current scope.

```powershell
. c:\scripts\sample.ps1
```

> [!NOTE]
> The dot sourcing operator is followed by a space. Use the space to
> distinguish the dot from the dot (`.`) symbol that represents the current
> directory.

In the following example, the Sample.ps1 script in the current directory is
run in the current scope.

```powershell
. .\sample.ps1
```

#### Format operator `-f`

Formats strings by using the format method of string objects. Enter the
format string on the left side of the operator and the objects to be
formatted on the right side of the operator.

```powershell
"{0} {1,-10} {2:N}" -f 1,"hello",[math]::pi
```

```output
1 hello      3.14
```

For more information, see the [String.Format](/dotnet/api/system.string.format)
method and [Composite Formatting](/dotnet/standard/base-types/composite-formatting).

#### Index operator `[ ]`

Selects objects from indexed collections, such as arrays and hash tables.
Array indexes are zero-based, so the first object is indexed as `[0]`. For
arrays (only), you can also use negative indexes to get the last values.
Hash tables are indexed by key value.

```
PS> $a = 1, 2, 3
PS> $a[0]
1
PS> $a[-1]
3
```

```powershell
(Get-HotFix | Sort-Object installedOn)[-1]
```

```powershell
$h = @{key="value"; name="PowerShell"; version="2.0"}
$h["name"]
```

```output
PowerShell
```

```powershell
$x = [xml]"<doc><intro>Once upon a time...</intro></doc>"
$x["doc"]
```

```output
intro
-----
Once upon a time...
```

#### Pipeline operator `|`

Sends ("pipes") the output of the command that precedes it to the command
that follows it. When the output includes more than one object (a
"collection"), the pipeline operator sends the objects one at a time.

```powershell
Get-Process | Get-Member
Get-PSSnapin | Where-Object {$_.vendor -ne "Microsoft"}
```

#### Property dereferences operator `.`

Accesses the properties and methods of an object.

```powershell
$myProcess.peakWorkingSet
(Get-Process PowerShell).kill()
```

#### Range operator `..`

Represents the sequential integers in an integer array, given an upper, and
lower boundary.

```powershell
1..10
10..1
foreach ($a in 1..$max) {Write-Host $a}
```

Beginning in PowerShell 6, the range operator works with **Characters** as
well as **Integers**.

To create a range of characters, enclose the boundary characters in quotes.

```powershell
PS> 'a'..'f'
a
b
c
d
e
f
```

You can also create ranges in reverse order. PowerShell matches the case of
the boundary characters automatically.

```powershell
PS> 'F'..'A'
F
E
D
C
B
A
```

#### Static member operator `::`

Calls the static properties operator and methods of a .NET Framework class.
To find the static properties and methods of an object, use the Static
parameter of the `Get-Member` cmdlet.

```powershell
[datetime]::now
```

#### Subexpression operator `$( )`

Returns the result of one or more statements. For a single result, returns
a scalar. For multiple results, returns an array.

```powershell
$($x * 23)
$(Get-WmiObject win32_Directory)
```

## See also

[about_Arithmetic_Operators](about_Arithmetic_Operators.md)

[about_Assignment_Operators](about_Assignment_Operators.md)

[about_Comparison_Operators](about_Comparison_Operators.md)

[about_Logical_Operators](about_logical_operators.md)

[about_Type_Operators](about_Type_Operators.md)

[about_Split](about_Split.md)

[about_Join](about_Join.md)

[about_Redirection](about_Redirection.md)
