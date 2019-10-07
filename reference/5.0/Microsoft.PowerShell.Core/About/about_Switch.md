---
keywords: powershell,cmdlet
locale: en-us
ms.date: 2/27/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_switch?view=powershell-5.0&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Switch
---
# About Switch

## SHORT DESCRIPTION
Explains how to use a switch to handle multiple If statements.

## LONG DESCRIPTION

To check a condition in a script or function, use an `If` statement. The `If`
statement can check many types of conditions, including the value of variables
and the properties of objects.

To check multiple conditions, use a `Switch` statement. The `Switch` statement
is equivalent to a series of If statements, but it is simpler. The `Switch`
statement lists each condition and an optional action. If a condition
obtains, the action is performed.

The `Switch` statement also uses the `$switch` automatic variable. For more
information, see [about_Automatic_Variables](about_Automatic_Variables.md).

A basic `Switch` statement has the following format:

```powershell
Switch (<test-value>)
{
    <condition> {<action>}
    <condition> {<action>}
}
```

For example, the following `Switch` statement compares the test value, 3, to
each of the conditions. When the test value matches the condition, the
action is performed.

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

In this simple example, the value is compared to each condition in the
list, even though there is a match for the value 3. The following `Switch`
statement has two conditions for a value of 3. It demonstrates that, by
default, all conditions are tested.

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

To direct the `Switch` to stop comparing after a match, use the `Break`
statement. The `Break` statement terminates the `Switch` statement.

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

Any `Break` statements apply to the collection, not to each value, as shown
in the following example. The `Switch` statement is terminated by the `Break`
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

### Syntax

The complete `Switch` statement syntax is as follows:

```
switch [-regex|-wildcard|-exact][-casesensitive] (<value>)
{
    "string"|number|variable|{ expression } { statementlist }
    default { statementlist }
}
```

or

```
switch [-regex|-wildcard|-exact][-casesensitive] -file filename
{
    "string"|number|variable|{ expression } { statementlist }
    default { statementlist }
}
```

If no parameters are used, `Switch` performs a case-insensitive exact match
for the value. If the value is a collection, each element is evaluated in
the order in which it appears.

The `Switch` statement must include at least one condition statement.

The `Default` clause is triggered when the value does not match any of the
conditions. It is equivalent to an `Else` clause in an `If` statement. Only one
`Default` clause is permitted in each `Switch` statement.

`Switch` has the following parameters:

|Parameter   |Description                                               |
|------------|----------------------------------------------------------|
|**Wildcard**|Indicates that the condition is a wildcard string. |
|            |If the match clause is not a string, the parameter is|
|            |ignored.                                                   |
|**Exact**        |Indicates that the match clause, if it is a string, must   |
|             |match exactly. If the match clause is not a string, this parameter      |
|             |is ignored.                                                    |
|**CaseSensitive**|Performs a case-sensitive match. If the match clause is not|
|                 |a string, this parameter is ignored.                       |
|**File**     |Takes input from a file rather than a value statement. If      |
|             |multiple **File** parameters are included, only the last one is|
|             |used. Each line of the file is read and evaluated by the       |
|             |`Switch` statement.                                            |
|**Regex**    |Performs regular expression matching of the value to the       |
|             |condition. If the|
|             |match clause is not a string, this parameter is ignored.       |

> [!NOTE]
> When specifying conflicting values, like **Regex** and **Wildcard**, the last
> parameter specified takes precedence, and all conflicting parameters are ignored.
> Multiple instances of parameters are also permitted. However, only the
> last parameter used is effective.

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

By adding the `Default` clause, you can perform an action when no other
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
$target = 'user@contoso.com'
switch -Regex ($target)
{
    'ftp\://.*' { "$_ is an ftp address"; Break }
    '\w+@\w+\.com|edu|org' { "$_ is an email address"; Break }
    'http[s]?\://.*' { "$_ is a web address"; Break }
}
```

```Output
user@contoso.com is an email address
```

A `Switch` statement condition may be either:

- An expression whose value is compared to the input value
- A script block which should return `$true` if a condition is met. The
  script block receives the current object to compare in the `$_`
  automatic variable and is evaluated in its own scope.

The action for each condition is independent of the actions in other
conditions.

The following example demonstrates the use of script blocks as `Switch`
statement conditions.

```powershell
switch ("Test")
{
    {$_ -is [String]} {
        "Found a string"
    }
    "Test" {
        "This executes as well"
    }
}
```

```Output
Found a string
This executes as well
```

If the value matches multiple conditions, the action for each condition is
executed. To change this behavior, use the `Break` or `Continue` keywords.

The `Break` keyword stops processing and exits the `Switch` statement.

The `Continue` keyword stops processing the current value, but continues
processing any subsequent values.

The following example processes an array of numbers and displays if they are
odd or even. Negative numbers are skipped with the `Continue` keyword. If a
non-number is encountered, execution is terminated with the `Break` keyword.

```powershell
switch (1,4,-1,3,"Hello",2,1)
{
    {$_ -lt 0} { Continue }
    {$_ -isnot [Int32]} { Break }
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

## SEE ALSO

[about_Break](about_Break.md)

[about_Continue](about_Continue.md)

[about_If](about_If.md)

[about_Script_Blocks](about_Script_Blocks.md)
