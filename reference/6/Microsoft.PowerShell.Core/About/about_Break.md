---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Break
---
# About Break

## SHORT DESCRIPTION
Describes a statement you can use to immediately exit Foreach, For, While,
Do, or Switch statements.

## LONG DESCRIPTION

When a Break statement appears in a loop, such as a Foreach, For, or While
loop, the Break statement causes PowerShell to immediately exit the loop.
In a Switch construct, Break causes PowerShell to exit the Switch code
block.

A Break statement can include a label that lets you exit embedded loops. A
label can specify any loop keyword, such as Foreach, For, or While, in a
script.

The following example shows how to use a Break statement to exit a For
statement:

```powershell
for($i=1; $i -le 10; $i++) {
   Write-Host $i
   break
}
```

In this example, the Break statement exits the For loop when the $i
variable equals 1. Even though the For statement evaluates to True until $i
is greater than 10, PowerShell reaches the break statement the first time
the For loop is run.

It is more common to use the Break statement in a loop where an inner
condition must be met. Consider the following Foreach statement example:

```powershell
$i=0
$varB = 10,20,30,40
foreach ($val in $varB) {
  $i++
  if ($val -eq 30) {
    break
  }
}
Write-Host "30 was found in array position $i"
```

In this example, the Foreach statement iterates the $varB array. Each time
the code block is run, the $i variable is incremented by 1. The If
statement evaluates to False the first two times the loop is run. The third
time the loop is run, $i equals 3, and the $val variable equals 30. At this
point, the Break statement runs, and the Foreach loop exits.

You break out of the other looping statements in the same way you break out
of the Foreach loop. In the following example, the Break statement exits a
While statement when a DivideByZeroException exception is trapped using the
Trap statement.

```powershell
$i = 3
while ($true) {
  trap [DivideByZeroException] {
    Write-Host 'divide by zero trapped'
    break
  }
   1 / $i--
}

```

A Break statement can include a label. If you use the Break keyword with a
label, PowerShell exits the labeled loop instead of exiting the current
loop. The syntax for a label is as follows (this example shows a label in a
While loop):

:myLabel while (`<condition>`) { `<statement list>`}

The label is a colon followed by a name that you assign. The label must be
the first token in a statement, and it must be followed by the looping
keyword, such as While.

In PowerShell, only loop keywords, such as Foreach, For, and While can have
a label.

Break moves execution out of the labeled loop. In embedded loops, this has
a different result than the Break keyword has when it is used by itself.
This schematic example has a While statement with a For statement:

```powershell
:myLabel while (<condition 1>) {
  for ($item in $items) {
    if (<condition 2>) {
      break myLabel
    }
    $item = $x   # A statement inside the For-loop
  }
}
$a = $c  # A statement after the labeled While-loop
```

If condition 2 evaluates to True, the execution of the script skips down to
the statement after the labeled loop. In the example, execution starts
again with the statement "$a = $c".

You can nest many labeled loops, as shown in the following schematic
example.

```powershell
:red while (<condition1>) {
  :yellow while (<condition2>) {
    while (<condition3>) {
      if ($a) {break}
      if ($b) {break red}
      if ($c) {break yellow}
    }
    Write-Host "After innermost loop"
  }
  Write-Host "After yellow loop"
}
Write-Host "After red loop"
```

If the $b variable evaluates to True, execution of the script resumes after
the loop that is labeled "red". If the $c variable evaluates to True,
execution of the script control resumes after the loop that is labeled
"yellow".

If the $a variable evaluates to True, execution resumes after the innermost
loop. No label is needed.

PowerShell does not limit how far labels can resume execution. The label
can even pass control across script and function call boundaries.

The Break keyword is used to leave the Switch construct. For example, the
following Switch statement uses Break statements to test for the most
specific condition:

```powershell
$var = "word2"
switch -regex ($var) {
    "word2" {
      Write-Host "Exact" $_
      break
    }

    "word.*" {
      Write-Host "Match on the prefix" $_
      break
    }

    "w.*" {
      Write-Host "Match on at least the first letter" $_
      break
    }

    default {
      Write-Host "No match" $_
      break
    }
}
```

In this example, the $var variable is created and initialized to a string
value of "word2". The Switch statement uses the Regex class to match the
variable value first with the term "word2". (The Regex class is a regular
expression Microsoft .NET Framework class.) Because the variable value and
the first test in the Switch statement match, the first code block in the
Switch statement runs.

When PowerShell reaches the first Break statement, the Switch statement
exits. If the four Break statements are removed from the example, all four
conditions are met. This example uses the break statement to display
results when the most specific condition is met.

## SEE ALSO

[about_Comparison_Operators](about_Comparison_Operators.md)

[about_Continue](about_Continue.md)

[about_For](about_For.md)

[about_Foreach](about_Foreach.md)

[about_Switch](about_Switch.md)

[about_Throw](about_Throw.md)

[about_Trap](about_Trap.md)

[about_Try_Catch_Finally](about_Try_Catch_Finally.md)

[about_While](about_While.md)