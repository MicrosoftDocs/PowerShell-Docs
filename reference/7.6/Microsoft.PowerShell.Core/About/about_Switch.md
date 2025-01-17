---
description: Explains how to use a switch to handle multiple `if` statements.
Locale: en-US
ms.date: 02/28/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_switch?view=powershell-7.6&WT.mc_id=ps-gethelp
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
is equivalent to a series of `if` statements, but it is simpler. The `switch`
statement lists each condition and an optional action. If a condition obtains,
the action is performed.

The `switch` statement can use the `$_` and `$switch` automatic variables. For
more information, see
[about_Automatic_Variables](about_Automatic_Variables.md).

## Syntax

A basic `switch` statement has the following format:

```Syntax
Switch (<test-expression>)
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

The `<test-expression>` is single expression that is evaluated in expression
mode to return a value.

The `<result-to-be-matched>` is an expression whose value is compared to the
input value. Expressions include literal values (strings or numbers),
variables, and scriptblocks that return a boolean value.

Any unquoted value that is not recognized as a number is treated as a string.
To avoid confusion or unintended string conversion, you should always quote
string values. Enclose any expressions in parentheses `()`, creating
subexpressions, to ensure that the expression is evaluated correctly.

It is important to understand that the `<result-to-be-matched>` value is on the
left-hand side of the comparison expression. That means the result of the
`<test-expression>` is on the right-hand side, which can be converted to the
type of the left-hand side value for comparison. For more information, see
[about_Comparison_Operators](about_Comparison_Operators.md)

The value `default` is reserved for the action used when there are no other
matches.

The `$_` automatic variable contains the value of the expression passed to the
`switch` statement and is available for evaluation and use within the scope of
the `<result-to-be-matched>` statements.

The complete `switch` statement syntax is as follows:

```Syntax
switch [-regex | -wildcard | -exact] [-casesensitive] (<test-expression>)
{
    "string" | number | variable | { <value-scriptblock> } { <action-scriptblock> }
    default { <action-scriptblock> } # optional
}
```

or

```Syntax
switch [-regex | -wildcard | -exact] [-casesensitive] -file filename
{
    "string" | number | variable | { <value-scriptblock> } { <action-scriptblock> }
    default { <action-scriptblock> }  # optional
}
```

If no parameters are used, `switch` behaves the same as using the **Exact**
parameter. It performs a case-insensitive match for the value. If the value is
a collection, each element is evaluated in the order in which it appears.

The `switch` statement must include at least one condition statement.

The `default` clause is triggered when the value does not match any of the
conditions. It is equivalent to an `else` clause in an `if` statement. Only one
`default` clause is permitted in each `switch` statement.

`switch` has the following parameters:

- **Wildcard** - Indicates that the condition is a wildcard string. If the
  match clause is not a string, the parameter is ignored. The comparison is
  case-insensitive.
- **Exact** - Indicates that the match clause, if it is a string, must match
  exactly. If the match clause is not a string, this parameter is ignored. The
  comparison is case-insensitive.
- **CaseSensitive** - Performs a case-sensitive match. If the match clause is
  not a string, this parameter is ignored.
- **File**- Takes input from a file rather than a `<test-expression>`. If
  multiple **File** parameters are included, only the last one is used. Each
  line of the file is read and evaluated by the `switch` statement. The
  comparison is case-insensitive.
- **Regex** - Performs regular expression matching of the value to the
  condition. If the match clause is not a string, this parameter is ignored.
  The comparison is case-insensitive. The `$matches` automatic variable is
  available for use within the matching statement block.

> [!NOTE]
> When specifying conflicting values, like **Regex** and **Wildcard**, the last
> parameter specified takes precedence, and all conflicting parameters are
> ignored. Multiple instances of parameters are also permitted. However, only
> the last parameter listed is used.

## Examples

In the following example, the `switch` statement compares the test value, 3, to
each of the conditions. When the test value matches the condition, the action
is performed.

```powershell
switch (3)
{
    1 {"It is one."}
    2 {"It is two."}
    3 {"It is three."}
    4 {"It is four."}
}
```

```Output
It is three.
```

In this simple example, the value is compared to each condition in the list,
even though there is a match for the value 3. The following `switch` statement
has two conditions for a value of 3. It demonstrates that, by default, all
conditions are tested.

```powershell
switch (3)
{
    1 {"It is one."}
    2 {"It is two."}
    3 {"It is three."}
    4 {"It is four."}
    3 {"Three again."}
}
```

```Output
It is three.
Three again.
```

To direct the `switch` to stop comparing after a match, use the `break`
statement. The `break` statement terminates the `switch` statement.

```powershell
switch (3)
{
    1 {"It is one."}
    2 {"It is two."}
    3 {"It is three."; Break}
    4 {"It is four."}
    3 {"Three again."}
}
```

```Output
It is three.
```

If the test value is a collection, such as an array, each item in the
collection is evaluated in the order in which it appears. The following
examples evaluates 4 and then 2.

```powershell
switch (4, 2)
{
    1 {"It is one." }
    2 {"It is two." }
    3 {"It is three." }
    4 {"It is four." }
    3 {"Three again."}
}
```

```Output
It is four.
It is two.
```

Any `break` statements apply to the collection, not to each value, as shown
in the following example. The `switch` statement is terminated by the `break`
statement in the condition of value 4.

```powershell
switch (4, 2)
{
    1 {"It is one."; Break}
    2 {"It is two." ; Break }
    3 {"It is three." ; Break }
    4 {"It is four." ; Break }
    3 {"Three again."}
}
```

```Output
It is four.
```

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

switch -Exact ($test)
{
    'System.Collections.Hashtable'
    {
        'Hashtable string coercion'
    }
    'test'
    {
        'Hashtable value'
    }
}
```

```Output
System.Collections.Hashtable
Hashtable string coercion
```

In this example, there is no matching case so there is no output.

```powershell
switch ("fourteen")
{
    1 {"It is one."; Break}
    2 {"It is two."; Break}
    3 {"It is three."; Break}
    4 {"It is four."; Break}
    "fo*" {"That's too many."}
}
```

By adding the `default` clause, you can perform an action when no other
conditions succeed.

```powershell
switch ("fourteen")
{
    1 {"It is one."; Break}
    2 {"It is two."; Break}
    3 {"It is three."; Break}
    4 {"It is four."; Break}
    "fo*" {"That's too many."}
    Default {
        "No matches"
    }
}
```

```Output
No matches
```

For the word "fourteen" to match a case you must use the `-Wildcard` or
`-Regex` parameter.

```powershell
   PS> switch -Wildcard ("fourteen")
       {
           1 {"It is one."; Break}
           2 {"It is two."; Break}
           3 {"It is three."; Break}
           4 {"It is four."; Break}
           "fo*" {"That's too many."}
       }
 ```

```Output
That's too many.
```

The following example uses the `-Regex` parameter.

```powershell
$target = 'https://bing.com'
switch -Regex ($target)
{
    '^ftp\://.*$' { "$_ is an ftp address"; Break }
    '^\w+@\w+\.com|edu|org$' { "$_ is an email address"; Break }
    '^(http[s]?)\://.*$' { "$_ is a web address that uses $($matches[1])"; Break }
}
```

```Output
https://bing.com is a web address that uses https
```

The following example demonstrates the use of script blocks as `switch`
statement conditions.

```powershell
switch ("Test")
{
    {$_ -is [String]} {
        "Found a string"
    }
    "Test" {
        "This $_ executes as well"
    }
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
    { $_.Year -eq 2021 } {
        $days = ((Get-Date 1/1/2022) - $_).days
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

The following example processes an array of numbers and displays if they are
odd or even. Negative numbers are skipped with the `continue` keyword. If a
non-number is encountered, execution is terminated with the `break` keyword.

```powershell
switch (1,4,-1,3,"Hello",2,1)
{
    {$_ -lt 0} { continue }
    {$_ -isnot [Int32]} { break }
    {$_ % 2} {
        "$_ is Odd"
    }
    {-not ($_ % 2)} {
        "$_ is Even"
    }
}
```

```Output
1 is Odd
4 is Even
3 is Odd
```

## See also

- [about_Break](about_Break.md)
- [about_Continue](about_Continue.md)
- [about_If](about_If.md)
- [about_Script_Blocks](about_Script_Blocks.md)
