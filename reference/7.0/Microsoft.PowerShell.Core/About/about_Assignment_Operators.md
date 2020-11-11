---
description: Describes how to use operators to assign values to variables. 
keywords: powershell,cmdlet
ms.date: 04/26/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_assignment_operators?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Assignment_Operators
---
# About Assignment Operators

## Short description
Describes how to use operators to assign values to variables.

## Long description

Assignment operators assign one or more values to a variable. They can perform
numeric operations on the values before the assignment.

PowerShell supports the following assignment operators.

|Operator|Description                                                  |
|--------|-------------------------------------------------------------|
|=       |Sets the value of a variable to the specified value.         |
|+=      |Increases the value of a variable by the specified value, or |
|        |appends the specified value to the existing value.           |
|-=      |Decreases the value of a variable by the specified value.    |
|*=      |Multiplies the value of a variable by the specified value, or|
|        |appends the specified value to the existing value.           |
|/=      |Divides the value of a variable by the specified value.      |
|%=      |Divides the value of a variable by the specified value and   |
|        |then assigns the remainder (modulus) to the variable.        |
|++      |Increases the value of a variable, assignable property, or   |
|        |array element by 1.                                          |
|--      |Decreases the value of a variable, assignable property, or   |
|        |array element by 1.                                          |

## Syntax

The syntax of the assignment operators is as follows:

`<assignable-expression>` `<assignment-operator>` `<value>`

Assignable expressions include variables and properties. The value can be a
single value, an array of values, or a command, expression, or statement.

The increment and decrement operators are unary operators. Each has prefix and
postfix versions.

`<assignable-expression><operator>`
`<operator><assignable-expression>`

The assignable expression must be a number or it must be convertible to a
number.

## Assigning values

Variables are named memory spaces that store values. You store the values in
variables by using the assignment operator `=`. The new value can replace the
existing value of the variable, or you can append a new value to the existing
value.

The basic assignment operator is the equal sign `=` `(ASCII 61)`. For example,
the following statement assigns the value PowerShell to the `$MyShell`
variable:

```powershell
$MyShell = "PowerShell"
```

When you assign a value to a variable in PowerShell, the variable is created if
it did not already exist. For example, the first of the following two
assignment statements creates the `$a` variable and assigns a value of 6 to
`$a`. The second assignment statement assigns a value of 12 to `$a`. The first
statement creates a new variable. The second statement changes only its value:

```powershell
$a = 6
$a = 12
```

Variables in PowerShell do not have a specific data type unless you cast them.
When a variable contains only one object, the variable takes the data type of
that object. When a variable contains a collection of objects, the variable has
the System.Object data type. Therefore, you can assign any type of object to
the collection. The following example shows that you can add process objects,
service objects, strings, and integers to a variable without generating an
error:

```powershell
$a = Get-Process
$a += Get-Service
$a += "string"
$a += 12
```

Because the assignment operator `=` has a lower precedence than the pipeline
operator `|`, parentheses are not required to assign the result of a command
pipeline to a variable. For example, the following command sorts the services
on the computer and then assigns the sorted services to the `$a` variable:

```powershell
$a = Get-Service | Sort-Object -Property name
```

You can also assign the value created by a statement to a variable, as in the
following example:

```powershell
$a = if ($b -lt 0) { 0 } else { $b }
```

This example assigns zero to the `$a` variable if the value of `$b` is less
than zero. It assigns the value of `$b` to `$a` if the value of `$b` is not
less than zero.

### The assignment operator

The assignment operator `=` assigns values to variables. If the variable
already has a value, the assignment operator `=` replaces the value without
warning.

The following statement assigns the integer value 6 to the `$a` variable:

```powershell
$a = 6
```

To assign a string value to a variable, enclose the string value in quotation
marks, as follows:

```powershell
$a = "baseball"
```

To assign an array (multiple values) to a variable, separate the values
with commas, as follows:

```powershell
$a = "apple", "orange", "lemon", "grape"
```

To assign a hash table to a variable, use the standard hash table notation in
PowerShell. Type an at sign `@` followed by key/value pairs that are separated
by semicolons `;` and enclosed in braces `{ }`. For example, to assign a hash
table to the `$a` variable, type:

```powershell
$a = @{one=1; two=2; three=3}
```

To assign hexadecimal values to a variable, precede the value with `0x`.
PowerShell converts the hexadecimal value (0x10) to a decimal value (in this
case, 16) and assigns that value to the `$a` variable. For example, to assign a
value of 0x10 to the `$a` variable, type:

```powershell
$a = 0x10
```

To assign an exponential value to a variable, type the root number, the letter
`e`, and a number that represents a multiple of 10. For example, to assign a
value of 3.1415 to the power of 1,000 to the `$a` variable, type:

```powershell
$a = 3.1415e3
```

PowerShell can also convert kilobytes `KB`, megabytes `MB`, and gigabytes `GB`
into bytes. For example, to assign a value of 10 kilobytes to the `$a`
variable, type:

```powershell
$a = 10kb
```

### The assignment by addition operator

The assignment by addition operator `+=` either increments the value of a
variable or appends the specified value to the existing value. The action
depends on whether the variable has a numeric or string type and whether the
variable contains a single value (a scalar) or multiple values (a collection).

The `+=` operator combines two operations. First, it adds, and then it assigns.
Therefore, the following statements are equivalent:

```powershell
$a += 2
$a = ($a + 2)
```

When the variable contains a single numeric value, the `+=` operator increments
the existing value by the amount on the right side of the operator. Then, the
operator assigns the resulting value to the variable. The following example
shows how to use the `+=` operator to increase the value of a variable:

```powershell
$a = 4
$a += 2
$a
```

```
6
```

When the value of the variable is a string, the value on the right side of the
operator is appended to the string, as follows:

```powershell
$a = "Windows"
$a += " PowerShell"
$a
```

```
Windows PowerShell
```

When the value of the variable is an array, the `+=` operator appends the
values on the right side of the operator to the array. Unless the array is
explicitly typed by casting, you can append any type of value to the array, as
follows:

```powershell
$a = 1,2,3
$a += 2
$a
```

```
1
2
3
2
```

and

```powershell
$a += "String"
$a
```

```
1
2
3
2
String
```

When the value of a variable is a hash table, the `+=` operator appends the
value on the right side of the operator to the hash table. However, because the
only type that you can add to a hash table is another hash table, all other
assignments fail.

For example, the following command assigns a hash table to the `$a` variable.
Then, it uses the `+=` operator to append another hash table to the existing
hash table, effectively adding a new key/value pair to the existing hash table.
This command succeeds, as shown in the output:

```powershell
$a = @{a = 1; b = 2; c = 3}
$a += @{mode = "write"}
$a
```

```
Name                           Value
----                           -----
a                              1
b                              2
mode                           write
c                              3
```

The following command attempts to append an integer "1" to the hash table in
the `$a` variable. This command fails:

```powershell
$a = @{a = 1; b = 2; c = 3}
$a += 1
```

```
You can add another hash table only to a hash table.
At line:1 char:6
+ $a += <<<<  1
```

### The assignment by subtraction operator

The assignment by subtraction operator `-=` decrements the value of a variable
by the value that is specified on the right side of the operator. This operator
cannot be used with string variables, and it cannot be used to remove an
element from a collection.

The `-=` operator combines two operations. First, it subtracts, and then it
assigns. Therefore, the following statements are equivalent:

```powershell
$a -= 2
$a = ($a - 2)
```

The following example shows how to use of the `-=` operator to decrease the
value of a variable:

```powershell
$a = 8
$a -= 2
$a
```

```
6
```

You can also use the `-=` assignment operator to decrease the value of a member
of a numeric array. To do this, specify the index of the array element that you
want to change. In the following example, the value of the third element of an
array (element 2) is decreased by 1:

```powershell
$a = 1,2,3
$a[2] -= 1
$a
```

```
1
2
2
```

You cannot use the `-=` operator to delete the values of a variable. To delete
all the values that are assigned to a variable, use the
[Clear-Item](xref:Microsoft.PowerShell.Management.Clear-Item) or
[Clear-Variable](xref:Microsoft.PowerShell.Utility.Clear-Variable) cmdlets
to assign a value of `$null` or `""` to the variable.

```powershell
$a = $null
```

To delete a particular value from an array, use array notation to assign a
value of `$null` to the particular item. For example, the following statement
deletes the second value (index position 1) from an array:

```powershell
$a = 1,2,3
$a
```

```
1
2
3
```

```powershell
$a[1] = $null
$a
```

```
1
3
```

To delete a variable, use the
[Remove-Variable](xref:Microsoft.PowerShell.Utility.Remove-Variable)
cmdlet. This method is useful when the variable is explicitly cast to a
particular data type, and you want an untyped variable. The following command
deletes the `$a` variable:

```powershell
Remove-Variable -Name a
```

### The assignment by multiplication operator

The assignment by multiplication operator `*=` multiplies a numeric value or
appends the specified number of copies of the string value of a variable.

When a variable contains a single numeric value, that value is multiplied by
the value on the right side of the operator. For example, the following example
shows how to use the `*=` operator to multiply the value of a variable:

```powershell
$a = 3
$a *= 4
$a
```

```
12
```

In this case, the `*=` operator combines two operations. First, it multiplies,
and then it assigns. Therefore, the following statements are equivalent:

```powershell
$a *= 2
$a = ($a * 2)
```

When a variable contains a string value, PowerShell appends the specified
number of strings to the value, as follows:

```powershell
$a = "file"
$a *= 4
$a
```

```
filefilefilefile
```

To multiply an element of an array, use an index to identify the element that
you want to multiply. For example, the following command multiplies the first
element in the array (index position 0) by 2:

```powershell
$a[0] *= 2
```

### The assignment by division operator

The assignment by division operator `/=` divides a numeric value by the value
that is specified on the right side of the operator. The operator cannot be
used with string variables.

The `/=` operator combines two operations. First, it divides, and then it
assigns. Therefore, the following two statements are equivalent:

```powershell
$a /= 2
$a = ($a / 2)
```

For example, the following command uses the `/=` operator to divide the value
of a variable:

```powershell
$a = 8
$a /=2
$a
```

```
4
```

To divide an element of an array, use an index to identify the element that you
want to change. For example, the following command divides the second element
in the array (index position 1) by 2:

```powershell
$a[1] /= 2
```

### The assignment by modulus operator

The assignment by modulus operator `%=` divides the value of a variable by the
value on the right side of the operator. Then, the `%=` operator assigns the
remainder (known as the modulus) to the variable. You can use this operator
only when a variable contains a single numeric value. You cannot use this
operator when a variable contains a string variable or an array.

The `%=` operator combines two operations. First, it divides and determines the
remainder, and then it assigns the remainder to the variable. Therefore, the
following statements are equivalent:

```powershell
$a %= 2
$a = ($a % 2)
```

The following example shows how to use the `%=` operator to save the modulus of
a quotient:

```powershell
$a = 7
$a %= 4
$a
```

```
3
```

## The increment and decrement operators

The increment operator `++` increases the value of a variable by 1. When you
use the increment operator in a simple statement, no value is returned. To view
the result, display the value of the variable, as follows:

```powershell
$a = 7
++$a
$a
```

```
8
```

To force a value to be returned, enclose the variable and the operator in
parentheses, as follows:

```powershell
$a = 7
(++$a)
```

```
8
```

The increment operator can be placed before (prefix) or after (postfix) a
variable. The prefix version of the operator increments a variable before its
value is used in the statement, as follows:

```powershell
$a = 7
$c = ++$a
$a
```

```
8
```

```powershell
$c
```

```
8
```

The postfix version of the operator increments a variable after its value is
used in the statement. In the following example, the `$c` and `$a` variables
have different values because the value is assigned to `$c` before `$a`
changes:

```powershell
$a = 7
$c = $a++
$a
```

```
8
```

```powershell
$c
```

```
7
```

The decrement operator `--` decreases the value of a variable by 1. As with the
increment operator, no value is returned when you use the operator in a simple
statement. Use parentheses to return a value, as follows:

```powershell
$a = 7
--$a
$a
```

```
6
```

```powershell
(--$a)
```

```
5
```

The prefix version of the operator decrements a variable before its value is
used in the statement, as follows:

```powershell
$a = 7
$c = --$a
$a
```

```
6
```

```powershell
$c
```

```
6
```

The postfix version of the operator decrements a variable after its value is
used in the statement. In the following example, the `$d` and `$a` variables
have different values because the value is assigned to `$d` before `$a`
changes:

```powershell
$a = 7
$d = $a--
$a
```

```
6
```

```powershell
$d
```

```
7
```

## Microsoft .NET Framework types

By default, when a variable has only one value, the value that is assigned to
the variable determines the data type of the variable. For example, the
following command creates a variable that has the "Integer" (System.Int32)
type:

```powershell
$a = 6
```

To find the .NET Framework type of a variable, use the **GetType** method and
its **FullName** property, as follows. Be sure to include the parentheses after
the **GetType** method name, even though the method call has no arguments:

```powershell
$a = 6
$a.GetType().FullName
```

```
System.Int32
```

To create a variable that contains a string, assign a string value to the
variable. To indicate that the value is a string, enclose it in quotation
marks, as follows:

```powershell
$a = "6"
$a.GetType().FullName
```

```
System.String
```

If the first value that is assigned to the variable is a string, PowerShell
treats all operations as string operations and casts new values to strings.
This occurs in the following example:

```powershell
$a = "file"
$a += 3
$a
```

```
file3
```

If the first value is an integer, PowerShell treats all operations as integer
operations and casts new values to integers. This occurs in the following
example:

```powershell
$a = 6
$a += "3"
$a
```

```
9
```

You can cast a new scalar variable as any .NET Framework type by placing the
type name in brackets that precede either the variable name or the first
assignment value. When you cast a variable, you can determine the types of data
that can be stored in the variable. And, you can determine how the variable
behaves when you manipulate it.

For example, the following command casts the variable as a string type:

```powershell
[string]$a = 27
$a += 3
$a
```

```
273
```

The following example casts the first value, instead of casting the
variable:

```powershell
$a = [string]27
```

When you cast a variable to a specific type, the common convention is to cast
the variable, not the value. However, you cannot recast the data type of an
existing variable if its value cannot be converted to the new data type. To
change the data type, you must replace its value, as follows:

```powershell
$a = "string"
[int]$a
```

```
Cannot convert value "string" to type "System.Int32". Error: "Input string was
not in a correct format." At line:1 char:8 + [int]$a <<<<
```

```powershell
[int]$a = 3
```

In addition, when you precede a variable name with a data type, the type of
that variable is locked unless you explicitly override the type by specifying
another data type. If you try to assign a value that is incompatible with the
existing type, and you do not explicitly override the type, PowerShell displays
an error, as shown in the following example:

```powershell
$a = 3
$a = "string"
[int]$a = 3
$a = "string"
```

```
Cannot convert value "string" to type "System.Int32". Error: "Input
string was not in a correct format."
At line:1 char:3
+ $a <<<<  = "string"
```

```powershell
[string]$a = "string"
```

In PowerShell, the data types of variables that contain multiple items in an
array are handled differently from the data types of variables that contain a
single item. Unless a data type is specifically assigned to an array variable,
the data type is always `System.Object []`. This data type is specific to
arrays.

Sometimes, you can override the default type by specifying another type. For
example, the following command casts the variable as a `string []` array type:

```powershell
[string []] $a = "one", "two", "three"
```

PowerShell variables can be any .NET Framework data type. In addition, you can
assign any fully qualified .NET Framework data type that is available in the
current process. For example, the following command specifies a
`System.DateTime` data type:

```powershell
[System.DateTime]$a = "5/31/2005"
```

The variable will be assigned a value that conforms to the `System.DateTime`
data type. The value of the `$a` variable would be the following:

```
Tuesday, May 31, 2005 12:00:00 AM
```

## Assigning multiple variables

In PowerShell, you can assign values to multiple variables by using a single
command. The first element of the assignment value is assigned to the first
variable, the second element is assigned to the second variable, the third
element to the third variable, and so on. For example, the following command
assigns the value 1 to the `$a` variable, the value 2 to the `$b` variable, and
the value 3 to the `$c` variable:

```powershell
$a, $b, $c = 1, 2, 3
```

If the assignment value contains more elements than variables, all the
remaining values are assigned to the last variable. For example, the following
command contains three variables and five values:

```powershell
$a, $b, $c = 1, 2, 3, 4, 5
```

Therefore, PowerShell assigns the value 1 to the `$a` variable and the value 2
to the `$b` variable. It assigns the values 3, 4, and 5 to the `$c` variable.
To assign the values in the `$c` variable to three other variables, use the
following format:

```powershell
$d, $e, $f = $c
```

This command assigns the value 3 to the `$d` variable, the value 4 to the `$e`
variable, and the value 5 to the `$f` variable.

If the assignment value contains less elements than variables, all the
remaining variables at the end are not assigned any values. For example, the
following command contains three variables and two values:

```powershell
$a, $b, $c = 1, 2
```

Therefore, PowerShell assigns the value 1 to the `$a` variable and the value 2
to the `$b` variable. It will not assign any value to the `$c` variable.

You can also assign a single value to multiple variables by chaining the
variables. For example, the following command assigns a value of "three" to all
four variables:

```powershell
$a = $b = $c = $d = "three"
```

## Variable-related cmdlets

In addition to using an assignment operation to set a variable value, you
can also use the
[Set-Variable](xref:Microsoft.PowerShell.Utility.Set-Variable) cmdlet. For
example, the following command uses `Set-Variable` to assign an array of 1,
2, 3 to the `$a` variable.

```powershell
Set-Variable -Name a -Value 1, 2, 3
```

## See also

[about_Arrays](about_Arrays.md)

[about_Hash_Tables](about_Hash_Tables.md)

[about_Variables](about_Variables.md)

[Clear-Variable](xref:Microsoft.PowerShell.Utility.Clear-Variable)

[Remove-Variable](xref:Microsoft.PowerShell.Utility.Remove-Variable)

[Set-Variable](xref:Microsoft.PowerShell.Utility.Set-Variable)
