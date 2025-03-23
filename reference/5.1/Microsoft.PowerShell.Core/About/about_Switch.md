---
description: Explains how to use a switch to handle multiple `if` statements.
Locale: en-US
ms.date: 02/19/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_switch?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Switch
---
# about_Switch

## Short description

Explains how to use a switch to handle multiple `if` statements.

## Long description

To check a condition in a script or function, use an `if` statement. The `if`
statement can check many types of conditions, including the value of variables
and the properties of objects.

To check multiple conditions, use a `switch` statement. The `switch` statement
is equivalent to a series of `if` statements, but it's simpler. The `switch`
statement lists each condition and an optional action. If a condition obtains,
the action is performed.

The `switch` statement can use the `$_` and `$switch` automatic variables. For
more information, see [about_Automatic_Variables][02].

## Syntax

A basic `switch` statement has the following format:

```Syntax
switch (<test-expression>)
{
    <result1-to-be-matched> {<action>}
    <result2-to-be-matched> {<action>}
}
```

The equivalent `if` statements are:

```Syntax
if (<result1-to-be-matched> -eq (<test-expression>)) {<action>}
if (<result2-to-be-matched> -eq (<test-expression>)) {<action>}
```

The `<test-expression>` is single expression that's evaluated in expression
mode to return a value.

The `<result-to-be-matched>` is an expression whose value is compared to the
input value. Expressions include literal values (strings or numbers),
variables, and scriptblocks that return a boolean value.

Any unquoted value that's not recognized as a number is treated as a string.
To avoid confusion or unintended string conversion, you should always quote
string values. Enclose any expressions in parentheses `()`, creating
subexpressions, to ensure that the expression is evaluated correctly.

It's important to understand that the `<result-to-be-matched>` value is on the
left-hand side of the comparison expression. That means the result of the
`<test-expression>` is on the right-hand side, which can be converted to the
type of the left-hand side value for comparison. For more information, see
[about_Comparison_Operators][04]

The value `default` is reserved for the action used when there are no other
matches.

The `$_` automatic variable contains the value of the expression passed to the
`switch` statement and is available for evaluation and use within the scope of
the `<result-to-be-matched>` statements.

The complete `switch` statement syntax is as follows:

```Syntax
switch [-Regex | -Wildcard | -Exact] [-CaseSensitive] (<test-expression>) {
    string | number | variable | { <value-scriptblock> }
        { <action-scriptblock> }
    default { <action-scriptblock> } # optional
}
```

or

```Syntax
switch [-Regex | -Wildcard | -Exact] [-CaseSensitive] -File filename {
    string | number | variable | { <value-scriptblock> }
        { <action-scriptblock> }
    default { <action-scriptblock> }  # optional
}
```

If you don't use parameters, `switch` behaves the same as using the **Exact**
parameter. It performs a case-insensitive match for the value. If the value is
a collection, each element is evaluated in the order in which it appears.

The `switch` statement must include at least one condition statement.

The `default` clause is triggered when the value doesn't match any of the
conditions. It's equivalent to an `else` clause in an `if` statement. Only one
`default` clause is permitted in each `switch` statement.

`switch` has the following parameters:

- **Wildcard** - Indicates that the condition is a wildcard string. If the
  match clause isn't a string, the parameter is ignored. The comparison is
  case-insensitive.
- **Exact** - Indicates that the match clause, if it's a string, must match
  exactly. If the match clause isn't a string, this parameter is ignored. The
  comparison is case-insensitive.
- **CaseSensitive** - Performs a case-sensitive match. If the match clause is
  not a string, this parameter is ignored.
- **File** - Takes input from a file rather than a `<test-expression>`. The
  file is read a line at a time and evaluated by the `switch` statement. By
  default, the comparison is case-insensitive. The **File** parameter only
  supports one file. If multiple **File** parameters are included, only the
  last one is used. For more information see [File parameter examples][01].
- **Regex** - Performs regular expression matching of the value to the
  condition. If the match clause isn't a string, this parameter is ignored.
  The comparison is case-insensitive. The `$Matches` automatic variable is
  available for use within the matching statement block.

> [!NOTE]
> When specifying conflicting values, like **Regex** and **Wildcard**, the last
> parameter specified takes precedence, and all conflicting parameters are
> ignored. Multiple instances of parameters are also permitted. However, only
> the last parameter listed is used.

## Simple match examples

In the following example, the `switch` statement compares the test value `3` to
each of the conditions. When the test value matches the condition, the action
is performed.

```powershell
switch (3) {
    1 { "It's one."   }
    2 { "It's two."   }
    3 { "It's three." }
    4 { "It's four."  }
}
```

```Output
It's three.
```

In this example, the value is compared to each condition in the list. The
following `switch` statement has two conditions for a value of 3, which
demonstrates that all conditions are tested.

```powershell
switch (3) {
    1 { "It's one."    }
    2 { "It's two."    }
    3 { "It's three."  }
    4 { "It's four."   }
    3 { "Three again." }
}
```

```Output
It's three.
Three again.
```

To direct the `switch` to stop comparing after a match, use the `break`
statement. The `break` statement terminates the `switch` statement.

```powershell
switch (3) {
    1 { "It's one."           }
    2 { "It's two."           }
    3 { "It's three."; break  }
    4 { "It's four."          }
    3 { "Three again."        }
}
```

```Output
It's three.
```

If the test value is a collection, such as an array, each item in the
collection is evaluated in the order in which it appears. The following
examples evaluates 4 and then 2.

```powershell
switch (4, 2) {
    1 { "It's one."    }
    2 { "It's two."    }
    3 { "It's three."  }
    4 { "It's four."   }
    3 { "Three again." }
}
```

```Output
It's four.
It's two.
```

Any `break` statements apply to the collection, not to each value, as shown
in the following example. The `switch` statement is terminated by the `break`
statement in the condition of value 4.

```powershell
switch (4, 2) {
    1 { "It's one.";    break }
    2 { "It's two." ;   break }
    3 { "It's three." ; break }
    4 { "It's four." ;  break }
    3 { "Three again."        }
}
```

```Output
It's four.
```

## More complex match examples

In this example, the `switch` statement is testing for the type of the value in
the hashtable. You must use and expression that returns a boolean value to
select the scriptblock to execute.

```powershell
$var = @{A = 10; B = 'abc'}

foreach ($key in $var.Keys) {
    switch ($var[$key].GetType()) {
        { $_ -eq [int32]  }  { "$key + 10 = $($var[$key] + 10)" }
        { $_ -eq [string] }  { "$key = $($var[$key])"           }
    }
}
```

```Output
A + 10 = 20
B = abc
```

In this example, an object that's not a string or numerical data is passed to
the `switch`. The `switch` performs a string coercion on the object and
evaluates the outcome.

```powershell
$test = @{
    Test  = 'test'
    Test2 = 'test2'
}

$test.ToString()

switch -Exact ($test) {
    'System.Collections.Hashtable' { 'Hashtable string coercion' }
    'test'                         { 'Hashtable value' }
}
```

```Output
System.Collections.Hashtable
Hashtable string coercion
```

In this example, there is no matching case so there is no output.

```powershell
switch ("fourteen") {
    1     { "It's one.";   break }
    2     { "It's two.";   break }
    3     { "It's three."; break }
    4     { "It's four.";  break }
    "fo*" { "That's too many."   }
}
```

By adding the `default` clause, you can perform an action when no other
conditions succeed.

```powershell
switch ("fourteen") {
    1       { "It's one.";   break }
    2       { "It's two.";   break }
    3       { "It's three."; break }
    4       { "It's four.";  break }
    "fo*"   { "That's too many."   }
    default { "No matches"         }
}
```

```Output
No matches
```

For the word `fourteen` to match a case you must use the `-Wildcard` or
`-Regex` parameter.

```powershell
switch -Wildcard ("fourteen") {
    1     { "It's one.";   break }
    2     { "It's two.";   break }
    3     { "It's three."; break }
    4     { "It's four.";  break }
    "fo*" { "That's too many."   }
}
```

```Output
That's too many.
```

The following example uses the `-Regex` parameter.

```powershell
$target = 'https://bing.com'
switch -Regex ($target) {
    '^ftp\://.*$'
        {
            "$_ is an ftp address"
            break
        }
    '^\w+@\w+\.com|edu|org$'
        {
            "$_ is an email address"
            break
        }
    '^(http[s]?)\://.*$'
        {
            "$_ is a web address that uses $($Matches[1])"
            break
        }
}
```

```Output
https://bing.com is a web address that uses https
```

The following example demonstrates the use of script blocks as `switch`
statement conditions.

```powershell
switch ("Test") {
    { $_ -is [string] } { "Found a string" }
    "Test"              { "This $_ executes as well" }
}
```

```Output
Found a string
This Test executes as well
```

The following example processes an array containing two date values. The
`<value-scriptblock>` compares the **Year** property of each date. The
`<action-scriptblock>` displays a welcome message or the number of days until
the beginning of the year 2022.

```powershell
switch ((Get-Date 1-Jan-2022), (Get-Date 25-Dec-2021)) {
    { $_.Year -eq 2021 }
        {
            $days = ((Get-Date 1/1/2022) - $_).Days
            "There are $days days until 2022."
        }
    { $_.Year -eq 2022 } { 'Welcome to 2022!' }
}
```

If the value matches multiple conditions, the action for each condition is
executed. To change this behavior, use the `break` or `continue` keywords.

The `break` keyword stops processing and exits the `switch` statement.

The `continue` keyword stops processing the current value, but continues
processing any subsequent values.

The following example processes an array of numbers and displays if they're
odd or even. Negative numbers are skipped with the `continue` keyword. If a
non-number is encountered, execution is terminated with the `break` keyword.

```powershell
switch (1,4,-1,3,"Hello",2,1) {
    {$_ -lt 0}           { continue }
    {$_ -isnot [int32]}  { break }
    {$_ % 2}             { "$_ is Odd" }
    {-not ($_ % 2)}      { "$_ is Even" }
}
```

```Output
1 is Odd
4 is Even
3 is Odd
```

## File parameter examples

Using the `switch` statement with the **File** parameter is an efficient way to
process large files line by line. PowerShell streams the lines of the file to
the `switch` statement. Each line is processed individually.

You can terminate the processing before reaching the end of the file by using
the `break` keyword in the action statement. The `switch` statement is more
efficient than using `Get-Content` to process large files line by line.

You can combine `switch -File` with `-Wildcard` or `-Regex` for flexible and
efficient line-by-line pattern matching.

The following example reads the `README.md` in the PowerShell-Docs repository.
It outputs each line until it reaches the line that starts with `##`.

```powershell
switch -Regex -File .\README.md {
    '^##\s' { break }
    default { $_; continue }
}
```

The `<filename>` argument is interpreted as a wildcard expression, but it must
match only one file. The following example is the same as the previous one
except it uses a wildcard in the `<filename>` argument. This example works
because the wildcard pattern matches only one file.

```powershell
switch -Regex -File .\README.* {
    '^##\s' { break }
    default { $_; continue }
}
```

You must escape characters that can be interpreted as wildcards if you want
them to be treated as literals.

```powershell
$file = (New-Item -Path 'Temp:\Foo[0]' -Value Foo -Force).FullName
switch -File $file { Foo { 'Foo' } }
# No files matching '...\Temp\Foo[0]' were found.

$fileEscaped = [WildcardPattern]::Escape($file)
switch -File $fileEscaped { foo { 'Foo' } }
# Foo
```

## See also

- [about_Break][03]
- [about_Continue][05]
- [about_If][06]
- [about_Script_Blocks][07]

<!-- updated link references -->
[01]: #file-parameter-examples
[02]: about_Automatic_Variables.md
[03]: about_break.md
[04]: about_Comparison_Operators.md
[05]: about_Continue.md
[06]: about_If.md
[07]: about_Script_Blocks.md
