---
description: Describes the operators that are supported by PowerShell.
Locale: en-US
ms.date: 09/03/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Operators
---
# about_Operators

## Short description
Describes the operators that are supported by PowerShell.

## Long description

An operator is a language element that you can use in a command or expression.
PowerShell supports several types of operators to help you manipulate values.

## Arithmetic Operators

Use arithmetic operators (`+`, `-`, `*`, `/`, `%`) to calculate values in a
command or expression. With these operators, you can add, subtract, multiply,
or divide values, and calculate the remainder (modulus) of a division
operation.

The addition operator concatenates elements. The multiplication operator
returns the specified number of copies of each element. You can use arithmetic
operators on any .NET type that implements them, such as: `Int`, `String`,
`DateTime`, `Hashtable`, and Arrays.

Bitwise operators (`-band`, `-bor`, `-bxor`, `-bnot`, `-shl`, `-shr`)
manipulate the bit patterns in values.

For more information, see [about_Arithmetic_Operators][05].

## Assignment Operators

Use assignment operators (`=`, `+=`, `-=`, `*=`, `/=`, `%=`) to assign, change,
or append values to variables. You can combine arithmetic operators with
assignment to assign the result of the arithmetic operation to a variable.

For more information, see [about_Assignment_Operators][06].

## Comparison Operators

Use comparison operators (`-eq`, `-ne`, `-gt`, `-lt`, `-le`, `-ge`) to compare
values and test conditions. For example, you can compare two string values to
determine whether they're equal.

The comparison operators also include operators that find or replace patterns
in text. The (`-match`, `-notmatch`, `-replace`) operators use regular
expressions, and (`-like`, `-notlike`) use wildcards `*`.

Containment comparison operators determine whether a test value appears in a
reference set (`-in`, `-notin`, `-contains`, `-notcontains`).

Type comparison operators (`-is`, `-isnot`) determine whether an object is of a
given type.

For more information, see [about_Comparison_Operators][07].

## Logical Operators

Use logical operators (`-and`, `-or`, `-xor`, `-not`, `!`) to connect
conditional statements into a single complex conditional. For example, you can
use a logical `-and` operator to create an object filter with two different
conditions.

For more information, see [about_Logical_Operators][13].

## Redirection Operators

Use redirection operators (`>`, `>>`, `2>`, `2>>`, and `2>&1`) to send the
output of a command or expression to a text file. The redirection operators
work like the `Out-File` cmdlet (without parameters) but they also let you
redirect error output to specified files. You can also use the `Tee-Object`
cmdlet to redirect output.

For more information, see [about_Redirection][18]

## Split and Join Operators

The `-split` and `-join` operators divide and combine substrings. The `-split`
operator splits a string into substrings. The `-join` operator concatenates
multiple strings into a single string.

For more information, see [about_Split][21] and [about_Join][12].

## Type Operators

Use the type operators (`-is`, `-isnot`, `-as`) to find or change the .NET type
of an object.

For more information, see [about_Type_Operators][22].

## Unary Operators

Use the unary `++`  and `--` operators to increment or decrement values and
`-` for negation. For example, to increment the variable `$a` from `9` to
`10`, you type `$a++`.

For more information, see [about_Arithmetic_Operators][05].

## Special Operators

Special operators have specific use-cases that don't fit into any other
operator group. For example, special operators allow you to run commands,
change a value's data type, or retrieve elements from an array.

### Grouping operator `( )`

As in other languages, `(...)` serves to override operator precedence in
expressions. For example: `(1 + 2) / 3`

However, in PowerShell, there are additional behaviors.

#### Grouping result expressions

`(...)` allows you to let output from a _command_ participate in an expression.
For example:

```powershell
PS> (Get-Item *.txt).Count -gt 10
True
```

> [!NOTE]
> Wrapping a command in parentheses causes the automatic variable `$?` to be
> set to `$true`, even when the enclosed command itself set `$?` to `$false`.
> For example, `(Get-Item /Nosuch); $?` unexpectedly yields **True**. For
> more information about `$?`, see [about_Automatic_Variables][06].

#### Piping grouped expressions

When used as the first segment of a pipeline, wrapping a command or expression
in parentheses invariably causes _enumeration_ of the expression result. If the
parentheses wrap a _command_, it's run to completion with all output _collected
in memory_ before the results are sent through the pipeline.

For example, the outputs for these statements are different:

```powershell
PS> ConvertFrom-Json '["a", "b"]'   | ForEach-Object { "The value is '$_'" }

The value is 'a b'

PS> (ConvertFrom-Json '["a", "b"]') | ForEach-Object { "The value is '$_'" }

The value is 'a'
The value is 'b'
```

Grouping an expression before piping also ensures that subsequent
object-by-object processing can't interfere with the enumeration the command
uses to produce its output.

For example, piping the output from `Get-ChildItem` to `Rename-Item` can have
unexpected effects where an item is renamed, then discovered again and renamed
a second time.

#### Grouping assignment statements

Ungrouped assignment statements don't output values. When grouping an
assignment statement, the value of the assigned variable is _passed through_
and can be used in larger expressions. For example:

```powershell
PS> ($var = 1 + 2)
3
PS> ($var = 1 + 2) -eq 3
True
```

Wrapping the statement in parentheses turns it into an expression that outputs
the value of `$var`.

This behavior applies to all the assignment operators, including compound
operators like `+=`, and the increment (`++`) and decrement (`--`) operators.
However, the order of operation for increment and decrement depends on their
position.

```powershell
PS> $i = 0
PS> (++$i) # prefix
1
PS> $i = 0
PS> ($i++) # postfix
0
PS> $i
1
```

In the prefix case, the value of `$i` is incremented before being output. In
the postfix case, the value of `$i` is incremented after being output.

You can also use this technique In the context of a conditional statement, such
as the `if` statement.

```powershell
if ($textFiles = Get-ChildItem *.txt) {
    $textFiles.Count
}
```

In this example, if no files match, the `Get-ChildItem` command returns nothing
and assigns nothing to `$textFiles`, which is considered `$false` in a boolean
context. If one or more **FileInfo** objects are assigned to `$textFiles`, the
conditional evaluates to `$true`. You can work with the value of `$textFiles`
in the body of the `if` statement.

> [!NOTE]
> While this technique is convenient and concise, it can lead to confusion
> between the assignment operator (`=`) and the equality-comparison operator
> (`-eq`).

### Subexpression operator `$( )`

Returns the result of one or more statements. For a single result, returns a
[scalar][04]. For multiple results, returns an array. Use this when you want to
use an expression within another expression. For example, to embed the results
of command in a string expression.

```powershell
PS> "Today is $(Get-Date)"
Today is 12/02/2019 13:15:20

PS> "Folder list: $((dir c:\ -dir).Name -join ', ')"
Folder list: Program Files, Program Files (x86), Users, Windows
```

### Array subexpression operator `@( )`

Returns the result of one or more statements as an array. The result is always
an array of 0 or more objects.

```powershell
PS> $list = @(Get-Process | Select-Object -First 10; Get-Service | Select-Object -First 10 )
PS> $list.GetType()

IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     True     Object[]                                 System.Array

PS> $list.Count
20
PS> $list = @(Get-Service | Where-Object Status -eq Starting )
PS> $list.GetType()

IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     True     Object[]                                 System.Array

PS> $list.Count
0
```

### Hash table literal syntax `@{}`

Similar to the array subexpression, this syntax is used to declare a hash
table. For more information, see [about_Hash_Tables][09].

### Call operator `&`

Runs a command, script, or script block. The call operator, also known as the
_invocation operator_, lets you run commands that are stored in variables and
represented by strings or script blocks. The call operator executes in a child
scope. For more about scopes, see [about_Scopes][19]. You can use this to build
strings containing the command, parameters, and arguments you need, and then
invoke the string as if it were a command. The strings that you create must
follow the same parsing rules as a command that you type at the command line.
For more information, see [about_Parsing][08].

This example stores a command in a string and executes it using the call
operator.

```
PS> $c = "get-executionpolicy"
PS> $c
get-executionpolicy
PS> & $c
AllSigned
```

The call operator doesn't parse strings. This means that you can't use
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
+ & $c
+  ~~
    + CategoryInfo          : ObjectNotFound: (Get-Service -Name Spooler:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
```

The [Invoke-Expression][25] cmdlet can execute code that causes parsing errors
when using the call operator.

```
PS> & "1+1"
&: The term '1+1' is not recognized as a name of a cmdlet, function, script
file, or executable program. Check the spelling of the name, or if a path was
included, verify that the path is correct and try again.
At line:1 char:2
+ & "1+1"
+  ~~~~~
    + CategoryInfo          : ObjectNotFound: (1+1:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
PS> Invoke-Expression "1+1"
2
```

You can execute a script using its filename. A script file must have a `.ps1`
file extension to be executable. Files that have spaces in their path must be
enclosed in quotes. If you try to execute the quoted path, PowerShell displays
the contents of the quoted string instead of running the script. The call
operator allows you to execute the contents of the string containing the
filename.

```
PS C:\Scripts> Get-ChildItem

    Directory: C:\Scripts


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        8/28/2018   1:36 PM             58 script name with spaces.ps1

PS C:\Scripts> ".\script name with spaces.ps1"
.\script name with spaces.ps1
PS C:\Scripts> & ".\script name with spaces.ps1"
Hello World!
```

For more about script blocks, see [about_Script_Blocks][20].

### Cast operator `[ ]`

Converts or limits objects to the specified type. If the objects can't be
converted, PowerShell generates an error.

```powershell
[DateTime] '2/20/88' - [DateTime] '1/20/88' -eq [TimeSpan] '31'
```

A cast can also be performed when a variable is assigned to using
[cast notation][23].

### Comma operator `,`

As a binary operator, the comma creates an array or appends to the array being
created. In expression mode, as a unary operator, the comma creates an array
with just one member. Place the comma before the member.

```powershell
$myArray = 1,2,3
$SingleArray = ,1
Write-Output (,1)
```

Since `Write-Output` expects an argument, you must put the expression in
parentheses.

### Dot sourcing operator `.`

Runs a script in the current scope so that any functions, aliases, and
variables that the script creates are added to the current scope, overriding
existing ones. Parameters declared by the script become variables. Parameters
for which no value has been given become variables with no value. However, the
automatic variable `$args` is preserved.

```powershell
. c:\scripts\sample.ps1 1 2 -Also:3
```

> [!NOTE]
> The dot sourcing operator is followed by a space. Use the space to
> distinguish the dot from the dot (`.`) symbol that represents the current
> directory.
>
> In the following example, the Sample.ps1 script in the current directory is
> run in the current scope.
>
> ```powershell
> . .\sample.ps1
> ```

### Format operator `-f`

Provide access to the .NET composite formatting feature. A composite format
string consists of fixed text intermixed with indexed placeholders, called
_format items_. These format items correspond to the objects in the list.

Each format item takes the following form and consists of the following
components:

`{index[,alignment][:formatString]}`

The matching braces (`{` and `}`) are required.

The formatting operation yields a result string that consists of the original
fixed text intermixed with the string representation of the objects in the
list. For more information, see [Composite Formatting][02].

Enter the composite format string on the left side of the operator and the
objects to be formatted on the right side of the operator.

```powershell
"{0} {1,-10} {2:N}" -f 1,"hello",[math]::pi
```

```output
1 hello      3.14
```

You can zero-pad a numeric value with the ["0" custom specifier][03]. The
number of zeroes following the `:` indicates the maximum width to pad the
formatted string to.

```powershell
"{0:00} {1:000} {2:000000}" -f 7, 24, 365
```

```output
07 024 000365
```

If you need to keep the curly braces (`{}`) in the formatted string, you can
escape them by doubling the curly braces.

```powershell
"{0} vs. {{0}}" -f 'foo'
```

```Output
foo vs. {0}
```

### Index operator `[ ]`

Selects objects from indexed collections, such as arrays and hash tables. Array
indexes are zero-based, so the first object is indexed as `[0]`. You can also
use negative indexes to get the last values. Hash tables are indexed by key
value.

Given a list of indices, the index operator returns a list of members
corresponding to those indices.

```
PS> $a = 1, 2, 3
PS> $a[0]
1
PS> $a[-1]
3
PS> $a[2, 1, 0]
3
2
1
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

When an object isn't an indexed collection, using the index operator to access
the first element returns the object itself. Index values beyond the first
element return `$null`.

```
PS> (2)[0]
2
PS> (2)[-1]
2
PS> (2)[1] -eq $null
True
PS> (2)[0,0] -eq $null
True
```

### Pipeline operator `|`

Sends ("pipes") the output of the command that precedes it to the command that
follows it. When the output includes more than one object (a "collection"), the
pipeline operator sends the objects one at a time.

```powershell
Get-Process | Get-Member
Get-Service | Where-Object {$_.StartType -eq 'Automatic'}
```

### Range operator `..`

The range operator can be used to represent an array of sequential integers.
The values joined by the range operator define the start and end values of the
range.

```powershell
1..10
$max = 10
foreach ($a in 1..$max) {Write-Host $a}
```

You can also create ranges in reverse order.

```powershell
10..1
5..-5 | ForEach-Object {Write-Output $_}
```

The start and end values of the range can be any pair of expressions that
evaluate to an integer or a character. The endpoints of the range must be
convertible to signed 32-bit integers (`[int32]`). Larger values cause an
error. Also, if the range is captured in an array, the size of resulting array
is limited to `268435448` (or `256mb - 8`). This is maximum size of an array in
.NET Framework.

For example, you could use the members of an enumeration for your start and end
values.

```powershell
PS> enum Food {
      Apple
      Banana = 3
      Kiwi = 10
    }
PS> [Food]::Apple..[Food]::Kiwi
0
1
2
3
4
5
6
7
8
9
10
```

> [!IMPORTANT]
> The resulting range isn't limited to the values of the enumeration. Instead
> it represents the range of values between the two values provided. You can't
> use the range operator to reliably represent the members of an enumeration.

### Member-access operator `.`

Accesses the properties and methods of an object. The member name may be an
expression.

```powershell
$myProcess.peakWorkingSet
(Get-Process PowerShell).kill()
'OS', 'Platform' | Foreach-Object { $PSVersionTable. $_ }
```

Starting PowerShell 3.0, when you use the operator on a list collection object
that doesn't have the member, PowerShell automatically enumerates the items in
that collection and uses the operator on each of them. For more information,
see [about_Member-Access_Enumeration][14].

### Static member operator `::`

Calls the static properties and methods of a .NET class. To find the static
properties and methods of an object, use the Static parameter of the
`Get-Member` cmdlet. The member name may be an expression.

```powershell
[datetime]::Now
'MinValue', 'MaxValue' | Foreach-Object { [int]:: $_ }
```

## See also

- [about_Arithmetic_Operators][05]
- [about_Assignment_Operators][06]
- [about_Comparison_Operators][07]
- [about_Logical_Operators][13]
- [about_Operator_Precedence][15]
- [about_Member-Access_Enumeration][14]
- [about_Type_Operators][22]
- [about_Split][21]
- [about_Join][12]
- [about_Redirection][18]

<!-- link references -->
[02]: /dotnet/standard/base-types/composite-formatting
[03]: /dotnet/standard/base-types/custom-numeric-format-strings#Specifier0
[04]: /powershell/scripting/learn/glossary#scalar-value
[05]: about_Arithmetic_Operators.md
[06]: about_Assignment_Operators.md
[07]: about_Comparison_Operators.md
[08]: about_Parsing.md
[09]: about_Hash_Tables.md
[12]: about_Join.md
[13]: about_logical_operators.md
[14]: about_Member-Access_Enumeration.md
[15]: about_operator_precedence.md
[18]: about_Redirection.md
[19]: about_Scopes.md
[20]: about_Script_Blocks.md
[21]: about_Split.md
[22]: about_Type_Operators.md
[23]: about_Variables.md
[25]: xref:Microsoft.PowerShell.Utility.Invoke-Expression
