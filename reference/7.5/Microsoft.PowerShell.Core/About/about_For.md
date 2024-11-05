---
description: Describes a language command you can use to run statements based on a conditional test.
Locale: en-US
ms.date: 06/10/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_for?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_For
---
# about_For

## Short description

Describes a language command you can use to run statements based on a
conditional test.

## Long description

The `For` statement (also known as a `For` loop) is a language construct you
can use to create a loop that runs commands in a command block while a
specified condition evaluates to `$true`.

A typical use of the `For` loop is to iterate an array of values and to operate
on a subset of these values. In most cases, if you want to iterate all the
values in an array, consider using a `Foreach` statement.

### Syntax

The following shows the `For` statement syntax.

```
for (<Init>; <Condition>; <Repeat>)
{
    <Statement list>
}
```

The **Init** placeholder represents one or more commands that are run before
the loop begins. You typically use the **Init** portion of the statement to
create and initialize a variable with a starting value.

This variable will then be the basis for the condition to be tested in the next
portion of the `For` statement.

The **Condition** placeholder represents the portion of the `For` statement
that resolves to a `$true` or `$false` **Boolean** value. PowerShell evaluates
the condition each time the `For` loop runs. If the statement is `$true`, the
commands in the command block run, and the statement is evaluated again. If the
condition is still `$true`, the commands in the **Statement list** run again.
The loop is repeated until the condition becomes `$false`.

The **Repeat** placeholder represents one or more commands, separated by
commas, that are executed each time the loop repeats. Typically, this is used
to modify a variable that is tested inside the **Condition** part of the
statement.

The **Statement list** placeholder represents a set of one or more commands
that are run each time the loop is entered or repeated. The contents of the
**Statement list** are surrounded by braces.

### Support for multiple operations

The following syntaxes are supported for multiple assignment operations in the
**Init** statement:

```powershell
# Comma separated assignment expressions enclosed in parentheses.
for (($i = 0), ($j = 0); $i -lt 10; $i++)
{
    "`$i:$i"
    "`$j:$j"
}

# Sub-expression using the semicolon to separate statements.
for ($($i = 0;$j = 0); $i -lt 10; $i++)
{
    "`$i:$i"
    "`$j:$j"
}
```

The following syntaxes are supported for multiple assignment operations in the
**Repeat** statement:

```powershell
# Comma separated assignment expressions.
for (($i = 0), ($j = 0); $i -lt 10; $i++, $j++)
{
    "`$i:$i"
    "`$j:$j"
}

# Comma separated assignment expressions enclosed in parentheses.
for (($i = 0), ($j = 0); $i -lt 10; ($i++), ($j++))
{
    "`$i:$i"
    "`$j:$j"
}

# Sub-expression using the semicolon to separate statements.
for ($($i = 0;$j = 0); $i -lt 10; $($i++;$j++))
{
    "`$i:$i"
    "`$j:$j"
}
```

> [!NOTE]
> Operations other than pre or post increment may not work with all syntaxes.

For multiple **Conditions** use logical operators as demonstrated by the
following example.

```powershell
for (($i = 0), ($j = 0); $i -lt 10 -and $j -lt 10; $i++,$j++)
{
    "`$i:$i"
    "`$j:$j"
}
```

For more information, see [about_Logical_Operators](about_Logical_Operators.md).

### Syntax examples

At a minimum, a `For` statement requires the parenthesis surrounding the
**Init**, **Condition**, and **Repeat** part of the statement and a command
surrounded by braces in the **Statement list** part of the statement.

Note that the upcoming examples intentionally show code outside the `For`
statement. In later examples, code is integrated into the `For` statement.

For example, the following `For` statement continually displays the value of
the `$i` variable until you manually break out of the command by pressing
CTRL+C.

```powershell
$i = 1
for (;;)
{
    Write-Host $i
}
```

You can add additional commands to the statement list so that the value of `$i`
is incremented by 1 each time the loop is run, as the following example shows.

```powershell
for (;;)
{
    $i++; Write-Host $i
}
```

Until you break out of the command by pressing CTRL+C, this statement will
continually display the value of the `$i` variable as it is incremented by 1
each time the loop is run.

Rather than change the value of the variable in the statement list part of the
`For` statement, you can use the **Repeat** portion of the `For` statement
instead, as follows.

```powershell
$i=1
for (;;$i++)
{
    Write-Host $i
}
```

This statement will still repeat indefinitely until you break out of the
command by pressing CTRL+C.

You can terminate the `For` loop using a **condition**. You can place a
condition using the **Condition** portion of the `For` statement. The `For`
loop terminates when the condition evaluates to `$false`.

In the following example, the `For` loop runs while the value of `$i` is less
than or equal to 10.

```powershell
$i=1
for(;$i -le 10;$i++)
{
    Write-Host $i
}
```

Instead of creating and initializing the variable outside the `For` statement,
you can perform this task inside the `For` loop by using the **Init** portion
of the `For` statement.

```powershell
for($i=1; $i -le 10; $i++){Write-Host $i}
```

You can use carriage returns instead of semicolons to delimit the **Init**,
**Condition**, and **Repeat** portions of the `For` statement. The following
example shows a `For` that uses this alternative syntax.

```powershell
for ($i = 0
  $i -lt 10
  $i++){
  $i
}
```

This alternative form of the `For` statement works in PowerShell script files
and at the PowerShell command prompt. However, it is easier to use the `For`
statement syntax with semicolons when you enter interactive commands at the
command prompt.

The `For` loop is more flexible than the `Foreach` loop because it allows you
to increment values in an array or collection by using patterns. In the
following example, the `$i` variable is incremented by 2 in the **Repeat**
portion of the `For` statement.

```powershell
for ($i = 0; $i -le 20; $i += 2)
{
    Write-Host $i
}
```

The `For` loop can also be written on one line as in the following example.

```powershell
for ($i = 0; $i -lt 10; $i++) { Write-Host $i }
```

### Functional example

The following example demonstrates how you can use a `For` loop to iterate over
an array of files and rename them. The files in the `work_items` folder have
their work item ID as the filename. The loop iterates through the files
to ensure that the ID number is zero-padded to five digits.

First, the code retrieves the list of work item data files. They're all JSON
files that use the format `<work-item-type>-<work-item-number>` for their name.
With the file info objects saved to the `$fileList` variable, you can sort them
by name and see that while items are grouped by type, the ordering of the items
by ID is unexpected.

```powershell
$fileList = Get-ChildItem -Path ./work_items
$fileList | Sort-Object -Descending -Property Name
```

```Output
bug-219.json
bug-41.json
bug-500.json
bug-697.json
bug-819.json
bug-840.json
feat-176.json
feat-367.json
feat-373.json
feat-434.json
feat-676.json
feat-690.json
feat-880.json
feat-944.json
maint-103.json
maint-367.json
maint-454.json
maint-49.json
maint-562.json
maint-579.json
```

To ensure that you can sort the work items alphanumerically, the work item
numbers need to be zero-padded.

The code does this by first searching for the work item with the longest
numerical suffix. It loops over the files using a `for` loop, using the index
to access each file in the array. It compares each filename to a regular
expression pattern to extract the work item number as a string instead of an
integer. Then it compares the lengths of the work item numbers to find the
longest number.

```powershell
# Default the longest numeral count to 1, since it can't be smaller.
$longestNumeralCount = 1

# Regular expression to find the numerals in the filename - use a template
# to simplify updating the pattern as needed.
$patternTemplate = '-(?<WorkItemNumber>{{{0},{1}}})\.json'
$pattern         =  $patternTemplate -f $longestNumeralCount

# Iterate, checking the length of the work item number as a string.
for (
    $i = 0                 # Start at zero for first array item.
    $i -lt $fileList.Count # Stop on the last item in the array.
    $i++                   # Increment by one to step through the array.
) {
    if ($fileList[$i].Name -match $pattern) {
        $numeralCount = $Matches.WorkItemNumber.Length
        if ($numeralCount -gt $longestNumeralCount) {
            # Count is higher, check against it for remaining items.
            $longestNumeralCount = $numeralCount
            # Update the pattern to speed up the search, ignoring items
            # with a smaller numeral count using pattern matching.
            $pattern = $patternTemplate -f $longestNumeralCount
        }
    }
}
```

Now that you know the maximum numeral count for the work items, you can loop
over the files to rename them as needed. The next snippet of code iterates over
the file list again, padding them as needed. It uses another regular expression
pattern to only process files with a numeral count smaller than the maximum.

```powershell
# Regular expression to find the numerals in the filename, but only if the
# numeral count is smaller than the longest numeral count.
$pattern = $patternTemplate -f 1, ($longestNumeralCount - 1)
for (
    $i = 0                 # Start at zero for first array item.
    $i -lt $fileList.Count # Stop on the last item in the array.
    $i++                   # Increment by one to step through the array.
) {
    # Get the file from the array to process
    $file = $fileList[$i]

    # If the file doesn't need to be renamed, continue to the next file
    if ($file.Name -notmatch $pattern) {
        continue
    }

    # Get the work item number from the regular expression, create the
    # padded string from it, and define the new filename by replacing
    # the original number string with the padded number string.
    $workItemNumber = $Matches.WorkItemNumber
    $paddedNumber   = "{0:d$longestNumeralCount}" -f $workItemNumber
    $paddedName     = $file.Name -replace $workItemNumber, $paddedNumber

    # Rename the file with the padded work item number.
    $file | Rename-Item -NewName $paddedName
}
```

Now that the files are renamed, you can retrieve the list of files again and
sort both the old and new files by name. The following snippet retrieves a
the files again to save in a new array and compare with the initial set of
objects. Then it sorts both arrays of files, saving the sorted arrays into
the new variables `$sortedOriginal` and `$sortedPadded`. Finally, it uses a
`for` loop to iterate over the arrays and output an object with the following
properties:

- **Index** represents the current index in the sorted arrays.
- **Original** is the item in the sorted array of original filenames at the
  current index.
- **Padded** is the item in the sorted array of padded filenames at the current
  index.

```powershell
$paddedList = Get-ChildItem -path ./work_items

# Sort both file lists by name.
$sortedOriginal = $fileList    | Sort-Object -Property Name
$sortedPadded   = $renamedList | Sort-Object -Property Name

# Iterate over the arrays and output an object to simplify comparing how
# the arrays were sorted before and after padding the work item numbers.
for (
  $i = 0
  $i -lt $fileList.Count
  $i++
) {
    [pscustomobject] @{
        Index    = $i
        Original = $sortedOriginal[$i].Name
        Padded   = $sortedPadded[$i].Name
    }
}
```

```Output
Index Original       Padded
----- --------       ------
    0 bug-219.json   bug-00041.json
    1 bug-41.json    bug-00219.json
    2 bug-500.json   bug-00500.json
    3 bug-697.json   bug-00697.json
    4 bug-819.json   bug-00819.json
    5 bug-840.json   bug-00840.json
    6 feat-176.json  feat-00176.json
    7 feat-367.json  feat-00367.json
    8 feat-373.json  feat-00373.json
    9 feat-434.json  feat-00434.json
   10 feat-676.json  feat-00676.json
   11 feat-690.json  feat-00690.json
   12 feat-880.json  feat-00880.json
   13 feat-944.json  feat-00944.json
   14 maint-103.json maint-00049.json
   15 maint-367.json maint-00103.json
   16 maint-454.json maint-00367.json
   17 maint-49.json  maint-00454.json
   18 maint-562.json maint-00562.json
   19 maint-579.json maint-00579.json
```

In the output, the sorted work items after padding are in the expected order.

## See also

- [about_Comparison_Operators](about_Comparison_Operators.md)
- [about_Foreach](about_Foreach.md)
