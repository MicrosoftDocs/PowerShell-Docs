---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Arithmetic_Operators
---

# About Arithmetic Operators

## SHORT DESCRIPTION

Describes the operators that perform arithmetic in PowerShell.

## LONG DESCRIPTION

Arithmetic operators calculate numeric values. You can use one or more
arithmetic operators to add, subtract, multiply, and divide values, and to
calculate the remainder (modulus) of a division operation.

In addition, the addition operator (`+`) and multiplication operator (`*`)
also operate on strings, arrays, and hash tables. The addition operator
concatenates the input. The multiplication operator returns multiple copies
of the input. You can even mix object types in an arithmetic statement. The
method that is used to evaluate the statement is determined by the type of
the leftmost object in the expression.

Beginning in PowerShell 2.0, all arithmetic operators work on 64-bit
numbers.

Beginning in PowerShell 3.0, the `-shr` (shift-right) and `-shl`
(shift-left) are added to support bitwise arithmetic in PowerShell.

PowerShell supports the following arithmetic operators:

|Operator|Description|Example|
|--------|-----------|-------|
| + |Adds integers; concatenates strings,<br/> concatenates arrays, and hash tables.|`6 + 2`<br />`"file" + "name"`<br />`@(1, "one") + @(2.0, "two")`<br />`@{"one" = 1} + @{"two" = 2}`|
| - |Subtracts one value from another value.|`6-2`<br />`(get-date).date - 1`|
| - |Makes a number a negative number.|`-6`|
| * |Multiplies numbers, copies strings and<br/>arrays the specified number of times.|`6 * 2`<br />`"!" * 3`<br />`@("!") * 4`|
| / |Divides two values.|`6 / 2`|
| % |Returns the remainder of a division operation.|`7 % 2`|
|-band|Bitwise AND|`5 -band 3`|
|-bnot|Bitwise NOT|`-bnot 5`|
|-bor|Bitwise OR|`5 -bor 0x03`|
|-bxor|Bitwise XOR|`5 -bxor 3`|
|-shl|Shifts bits to the left the specified number of times|`102 -shl 2`|
|-shr|Shifts bits to the right the specified number of times|`102 -shr 2`|

The bitwise operators only work on integer types.

## OPERATOR PRECEDENCE

PowerShell processes arithmetic operators in the following order:

| Precedence | Operator | Description |
|---|---|---|
|1 | `()` | Parentheses|
|2 | `-` | For a negative number or unary operator|
|3 | `*`, `/`, `%` |
|4 | `+`, `-` | For addition and subtraction|

PowerShell processes the expressions from left to right according to the
precedence rules. The following examples show the effect of the precedence
rules:

| Expression | Result |
|---|---|
| `3+6/3*4` | `11` |
|`3+6/(3*4)` | `3.5` |
|`(3+6)/3*4` | `12` |

The order in which PowerShell evaluates expressions might differ from other
programming and scripting languages that you have used. The following
example shows a complicated assignment statement.

```powershell
$a = 0
$b = @(1,2)
$c = @(-1,-2)

$b[$a] = $c[$a++]
```

In this example, the expression `$a++` is evaluated before `$b[$a]`.
Evaluating `$a++` changes the value of `$a` after it is used in the
statement `$c[$a++]`; but, before it is used in `$b[$a]`. The variable `$a`
in `$b[$a]` equals `1`, not `0`; so, the statement assigns a value to
`$b[1]`, not `$b[0]`.

The above code is equivalent to:

```powershell
$a = 0
$b = @(1,2)
$c = @(-1,-2)

$tmp = $c[$a]
$a = $a + 1
$b[$a] = $tmp
```

## DIVISION AND ROUNDING

When the quotient of a division operation is an integer, PowerShell rounds
the value to the nearest integer. When the value is `.5`, it rounds to the
nearest even integer.

The following example shows the effect of rounding to the nearest even
integer.

| Expression | Result |
|---|---|
|`[int]( 5 / 2 )` | `2` |
|`[int]( 7 / 2 )` | `4` |

Notice how **_5/2_ = 2.5** gets rounded to **2**. But, **_7/2_ = 3.5** gets
rounded to **4**.

## ADDING AND MULTIPLYING NON-NUMERIC TYPES

You can add numbers, strings, arrays, and hash tables. And, you can
multiply numbers, strings, and arrays. However, you cannot multiply hash
tables.

When you add strings, arrays, or hash tables, the elements are
concatenated. When you concatenate collections, such as arrays or hash
tables, a new object is created that contains the objects from both
collections. If you try to concatenate hash tables that have the same key,
the operation fails.

For example, the following commands create two arrays and then add them:

```powershell
$a = 1,2,3
$b = "A","B","C"
$a + $b
```

```output
1
2
3
A
B
C
```

You can also perform arithmetic operations on objects of different types.
The operation that PowerShell performs is determined by the Microsoft .NET
Framework type of the leftmost object in the operation. PowerShell tries to
convert all the objects in the operation to the .NET Framework type of the
first object. If it succeeds in converting the objects, it performs the
operation appropriate to the .NET Framework type of the first object. If it
fails to convert any of the objects, the operation fails.

The following examples demonstrate the use of the addition and
multiplication operators; in operations that include different object
types. Assume `$array = 1,2,3`:

| Expression | Result |
|---|---|
|`"file" + 16` | `file16`|
|`$array + 16` | `1`<br/>`2`<br/>`3`<br/>`16`|
|`$array + "file"` | `1`<br/>`2`<br/>`3`<br/>`file`|
|`$array * 2` | `1`<br/>`2`<br/>`3`<br/>`1`<br/>`2`<br/>`3`|
|`"file" * 3` | `filefilefile`|

Because the method that is used to evaluate statements is determined by the
leftmost object, addition and multiplication in PowerShell are not strictly
commutative. For example, `(a + b)` does not always equal `(b + a)`, and
`(ab)` does not always equal `(ba)`.

The following examples demonstrate this principle:

| Expression | Result |
|---|---|
|`"file" + 16` | `file16`|
|`16 + "file"` | `Cannot convert value "file" to type "System.Int32".`<br/>`Error: "Input string was not in a correct format."`<br/>`At line:1 char:1`<br/>`+ 16 + "file"`|

Hash tables are a slightly different case. You can add hash tables to
another hash table, as long as, the added hash tables don't have duplicate
keys.

The following example show how to add hash tables to each other.

```powershell
$hash1 = @{a=1; b=2; c=3}
$hash2 = @{c1="Server01"; c2="Server02"}
$hash1 + $hash2
```

```output
Name                           Value
----                           -----
c2                             Server02
a                              1
b                              2
c1                             Server01
c                              3
```

The following example throws an error because one of the keys is duplicated
in both hash tables.

```powershell
$hash1 = @{a=1; b=2; c=3}
$hash2 = @{c1="Server01"; c="Server02"}
$hash1 + $hash2
```

```output
Item has already been added. Key in dictionary: 'c'  Key being added: 'c'
At line:3 char:1
+ $hash1 + $hash2
+ ~~~~~~~~~~~~~~~
    + CategoryInfo          : OperationStopped: (:) [], ArgumentException
    + FullyQualifiedErrorId : System.ArgumentException
```

Also, you can add a hash table to an array; and, the entire hash table
becomes an item in the array.

```powershell
$array1 = @(0, "Hello World", [datetime]::Now)
$hash1 = @{a=1; b=2}
$array2 = $array1 + $hash1
$array2
```

```output
0
Hello World

Monday, June 12, 2017 3:05:46 PM

Key   : a
Value : 1
Name  : a

Key   : b
Value : 2
Name  : b
```

However, you cannot add any other type to a hash table.

```powershell
$hash1 + 2
```

```output
A hash table can only be added to another hash table.
At line:3 char:1
+ $hash1 + 2
```

Although the addition operators are very useful, use the assignment
operators to add elements to hash tables and arrays. For more information
see [about_assignment_operators](about_Assignment_Operators.md). The
following examples use the `+=` assignment operator to add items to an
array:

```powershell
$array = @()
(0..9).foreach{ $array += $_ }
$array
```

```output
0
1
2
```

## TYPE CONVERSION TO ACCOMMODATE RESULT

PowerShell automatically selects the .NET Framework numeric type that best
expresses the result without losing precision. For example:

```powershell
2 + 3.1

(2). GetType().FullName
(2 + 3.1).GetType().FullName
```

```output
5.1
System.Int32
System.Double
```

If the result of an operation is too large for the type, the type of the
result is widened to accommodate the result, as in the following example:

```powershell
(512MB).GetType().FullName
(512MB * 512MB).GetType().FullName
```

```output
System.Int32
System.Double
```

The type of the result will not necessarily be the same as one of the
operands. In the following example, the negative value cannot be cast to an
unsigned integer, and the unsigned integer is too large to be cast to
`Int32`:

```powershell
([int32]::minvalue + [uint32]::maxvalue).gettype().fullname
```

```output
System.Int64
```

In this example, `Int64` can accommodate both types.

The `System.Decimal` type is an exception. If either operand has the
Decimal type, the result will be of the Decimal type. If the result is too
large for the Decimal type, it will not be cast to Double. Instead, an
error results.

| Expression | Result |
|---|---|
|`[Decimal]::maxvalue` | `79228162514264337593543950335`|
|`[Decimal]::maxvalue + 1` | `Value was either too large`<br/>`or too small for a Decimal.`|

## ARITHMETIC OPERATORS AND VARIABLES

You can also use arithmetic operators with variables. The operators act on
the values of the variables. The following examples demonstrate the use of
arithmetic operators with variables:

| Expression | Result |
|---|---|
|`$intA = 6`<br/>`$intB = 4`<br/>`$intA + $intB` | `10`|
|`$a = "Power"`<br/>`$b = "Shell"`<br/>`$a + $b` | `PowerShell`|

## ARITHMETIC OPERATORS AND COMMANDS

Typically, you use the arithmetic operators in expressions with numbers,
strings, and arrays. However, you can also use arithmetic operators with
the objects that commands return and with the properties of those objects.

The following examples show how to use the arithmetic operators in
expressions with PowerShell commands:

```powershell
(get-date) + (new-timespan -day 1)
```

The parenthesis operator forces the evaluation of the `get-date` cmdlet and
the evaluation of the `new-timespan -day 1` cmdlet expression, in that
order. Both results are then added using the `+` operator.

```powershell
Get-Process | Where-Object { ($_.ws * 2) -gt 50mb }
```

```output
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
   1896      39    50968      30620   264 1,572.55   1104 explorer
  12802      78   188468      81032   753 3,676.39   5676 OUTLOOK
    660       9    36168      26956   143    12.20    988 PowerShell
    561      14     6592      28144   110 1,010.09    496 services
   3476      80    34664      26092   234 ...45.69    876 svchost
    967      30    58804      59496   416   930.97   2508 WINWORD
```

In the above expression, each process working space (`$_.ws`) is multiplied
by `2`; and, the result, compared against `50mb` to see if it is greater
than that.

### EXAMPLES

The following examples show how to use the arithmetic operators in
PowerShell:

|Expression|Result|
|----------|------|
|`1 + 1`   | `2`  |
|`1 - 1`   | `0`  |
|`-(6 + 3)`| `-9` |
|`6 * 2`   | `12` |
|`7 / 2`   | `3.5`|
|`7 % 2`   | `1`  |
|`'w' * 3` | `www`|
|`3 * 'w'` | `Cannot convert value "w" to type "System.Int32".`<br/>` Error: "Input string was not in a correct format."`|
|`"Power" + "Shell"` | `PowerShell`|
|`$a = "Power" + "Shell"`<br/>`$a[5]` | `S`|
|`$b = 1,2,3`<br/>`$b + 4` | `1`<br/>`2`<br/>`3`<br/>`4`|
|`$servers = @{`<br/>&nbsp;&nbsp;`0 = "LocalHost"`<br/>&nbsp;&nbsp;`1 = "Server01"`<br/>&nbsp;&nbsp;`2 = "Server02"`<br/>`}`<br/>`$servers + @{3 = "Server03"}` | `Name Value`<br/>`---- -----`<br/>`3    Server03`<br/>`2    Server02`<br/>`1    Server01`<br/>`0    LocalHost`|
|`#Use assignment operator`<br/>`$servers += @{3 = "Server03"}` | `Name Value`<br/>`---- -----`<br/>`3    Server03`<br/>`2    Server02`<br/>`1    Server01`<br/>`0    LocalHost`|

## Bitwise Operators

PowerShell supports the standard bitwise operators, including bitwise-AND
(`-bAnd`), the inclusive and exclusive bitwise-OR operators (`-bOr` and
`-bXor`), and bitwise-NOT (`-bNot`).

Beginning in PowerShell 2.0, all bitwise operators work with 64-bit
integers.

Beginning in PowerShell 3.0, the `-shr` (shift-right) and `-shl`
(shift-left) are introduced to support bitwise arithmetic in PowerShell.

PowerShell supports the following bitwise operators.

|Operator|Description|Example|
|--------|-----------|-------|
|`-band` |Bitwise AND|`PS C:> 10 -band 3`<br />`2`|
|`-bor`  |Bitwise OR (inclusive)|`PS C:> 10 -bor 3`<br />`11`|
|`-bxor` |Bitwise OR (exclusive)|`PS C:> 10 -bxor 3`<br />`9`|
|`-bnot` |Bitwise NOT|`PS C:> -bNot 10`<br />`-11`|
|`-shl`  |Shift-left |`PS C:> 102 -shl 2`<br />`408`|
|`-shr`  |Shift-right|`PS C:> 102 -shr 1`<br />`51`|

Bitwise operators act on the binary format of a value. For example, the bit
structure for the number 10 is 00001010 (based on 1 byte), and the bit
structure for the number 3 is 00000011. When you use a bitwise operator to
compare 10 to 3, the individual bits in each byte are compared.

In a bitwise AND operation, the resulting bit is set to 1 only when both
input bits are 1.

```
1010      (10)
0011      ( 3)
--------------  bAND
0010      ( 2)
```

In a bitwise OR (inclusive) operation, the resulting bit is set to 1 when
either or both input bits are 1. The resulting bit is set to 0 only when
both input bits are set to 0.

```
1010      (10)
0011      ( 3)
--------------  bOR (inclusive)
1011      (11)
```

In a bitwise OR (exclusive) operation, the resulting bit is set to 1 only
when one input bit is 1.

```
1010      (10)
0011      ( 3)
--------------  bXOR (exclusive)
1001      ( 9)
```

The bitwise NOT operator is a unary operator that produces the binary
complement of the value. A bit of 1 is set to 0 and a bit of 0 is set to 1.

For example, the binary complement of 0 is -1, the maximum unsigned integer
(0xffffffff), and the binary complement of -1 is 0.

```powershell
PS C:\> -bNot 10
-11
```

```
0000 0000 0000 1010  (10)
------------------------- bNOT
1111 1111 1111 0101  (-11, xfffffff5)
```

In a bitwise shift-left operation, all bits are moved "n" places to the
left, where "n" is the value of the right operand. A zero is inserted in
the ones place.

When the left operand is an Integer (32-bit) value, the lower 5 bits of the
right operand determine how many bits of the left operand are shifted.

When the left operand is a Long (64-bit) value, the lower 6 bits of the
right operand determine how many bits of the left operand are shifted.

| Expression | Result | Binary Result |
|---|---|---|
|`21 -shl 0`  | 21 | 0001 0101 |
|`21 -shl 1`  | 42 | 0010 1010 |
|`21 -shl 2`  | 84 | 0101 0100 |

In a bitwise shift-right operation, all bits are moved "n" places to the
right, where "n" is specified by the right operand. The shift-right
operator (-shr) inserts a zero in the left-most place when shifting a
positive or unsigned value to the right.

When the left operand is an Integer (32-bit) value, the lower 5 bits of the
right operand determine how many bits of the left operand are shifted.

When the left operand is a Long (64-bit) value, the lower 6 bits of the
right operand determine how many bits of the left operand are shifted.

| Expression | Result | Binary Result |
|---|---|---|
|`21 -shr 0`  | 21 | 0001 0101 |
|`21 -shr 1`  | 10 | 0000 1010 |
|`21 -shr 2`  |  5 | 0000 0101 |
|`21 -shr 31` |  0 | 0000 0000 |
|`21 -shr 32` | 21 | 0001 0101 |
|`21 -shr 64` | 21 | 0001 0101 |
|`21 -shr 65` | 10 | 0000 1010 |
|`21 -shr 66` |  5 | 0000 0101 |
|`[int]::MaxValue -shr 1` |  1073741823 | 0011 1111 1111 1111 1111 1111 1111 1111 |
|`[int]::MinValue -shr 1` | -1073741824 | 1100 0000 0000 0000 0000 0000 0000 0000 |
|`-1 -shr 1` | -1 | 1111 1111 1111 1111 1111 1111 1111 1111 |

## SEE ALSO

* [about_arrays](about_Arrays.md)
* [about_assignment_operators](about_Assignment_Operators.md)
* [about_comparison_operators](about_Comparison_Operators.md)
* [about_hash_tables](about_Hash_Tables.md)
* [about_operators](about_Operators.md)
* [about_variables](about_Variables.md)
* [Get-Date](../../Microsoft.PowerShell.Utility/Get-Date.md)
* [New-TimeSpan](../../Microsoft.PowerShell.Utility/New-TimeSpan.md)
