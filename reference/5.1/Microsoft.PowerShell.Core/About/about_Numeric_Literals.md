---
description: Both integer and real numeric literals can have type and multiplier suffixes.
Locale: en-US
ms.date: 04/09/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_numeric_literals?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: About numeric literals
---
# About numeric literals

There are two kinds of numeric literals: integer and real. Both can have type
and multiplier suffixes.

## Integer literals

Integer literals can be written in decimal or hexadecimal notation. Hexadecimal
literals are prefixed with `0x` to distinguish them from decimal numbers.

Integer literals can have a type suffix and a multiplier suffix.

| Suffix |       Meaning       |
| ------ | ------------------- |
| l      | long data type      |
| kb     | kilobyte multiplier |
| mb     | megabyte multiplier |
| gb     | gigabyte multiplier |
| tb     | terabyte multiplier |
| pb     | petabyte multiplier |

The type of an integer literal is determined by its value, the type suffix, and
the numeric multiplier suffix.

For an integer literal with no type suffix:

- If the value can be represented by type `[int]`, that is its type.
- Otherwise, if the value can be represented by type `[long]`, that is its
  type.
- Otherwise, if the value can be represented by type `[decimal]`, that is its
  type.
- Otherwise, it is represented by type `[double]`.

For an integer literal with a type suffix:

- If the type suffix is `u` and the value can be represented by type `[int]`
  then its type is `[int]`.
- If the type suffix is `u` and the value can be represented by type `[long]`
  then its type is `[long]`.
- If its value can be represented by type specified then that is its type.
- Otherwise, that literal is malformed.

## Real literals

Real literals can only be written in decimal notation. This notation can
include fractional values following a decimal point and scientific notation
using an exponential part.

The exponential part includes an 'e' followed by an optional sign (+/-) and a
number representing the exponent. For example, the literal value `1e2` equals
the numeric value 100.

Real literals can have a type suffix and a multiplier suffix.

| Suffix |       Meaning       |
| ------ | ------------------- |
| d      | decimal data type   |
| kb     | kilobyte multiplier |
| mb     | megabyte multiplier |
| gb     | gigabyte multiplier |
| tb     | terabyte multiplier |
| pb     | petabyte multiplier |

There are two kinds of real literal: double and decimal. These are indicated by
the absence or presence, respectively, of decimal-type suffix. PowerShell does
not support a literal representation of a `[float]` value. A double real
literal has type `[double]`. A decimal real literal has type `[decimal]`.
Trailing zeros in the fraction part of a decimal real literal are significant.

If the value of exponent-part's digits in a `[double]` real literal is less
than the minimum supported, the value of that `[double]` real literal is 0. If
the value of exponent-part's digits in a `[decimal]` real literal is less than
the minimum supported, that literal is malformed. If the value of
exponent-part's digits in a `[double]` or `[decimal]` real literal is greater
than the maximum supported, that literal is malformed.

> [!NOTE]
> The syntax permits a double real literal to have a long-type suffix.
> PowerShell treats this case as an integer literal whose value is represented
> by type `[long]`. This feature has been retained for backwards compatibility
> with earlier versions of PowerShell. However, programmers are discouraged
> from using integer literals of this form as they can easily obscure the
> literal's actual value. For example, `1.2L` has value 1, `1.2345e1L` has
> value 12, and `1.2345e-5L` has value 0, none of which are immediately
> obvious.

## Numeric multipliers

For convenience, integer and real literals can contain a numeric multiplier,
which indicates one of a set of commonly used powers of 2. The numeric
multiplier can be written in any combination of upper or lowercase letters.

The multiplier suffixes can be used in combination with the `u`, `ul`, and `l`
type suffixes.

### Multiplier examples

```
PS> 1kb
1024

PS> 1.30Dmb
1363148.80

PS> 0x10Gb
17179869184

PS> 1.4e23tb
1.5393162788864E+35

PS> 0x12Lpb
20266198323167232
```

## Numeric type accelerators

PowerShell supports the following type accelerators:

| Accelerator |         Note         |           Description            |
| ----------- | -------------------- | -------------------------------- |
| `[byte]`    |                      | Byte (unsigned)                  |
| `[sbyte]`   |                      | Byte (signed)                    |
| `[Int16]`   |                      | 16-bit integer                   |
| `[UInt16]`  |                      | 16-bit integer (unsigned)        |
| `[Int32]`   |                      | 32-bit integer                   |
| `[int]`     | alias for `[int32]`  | 32-bit integer                   |
| `[UInt32]`  |                      | 32-bit integer (unsigned)        |
| `[Int64]`   |                      | 64-bit integer                   |
| `[long]`    | alias for `[int64]`  | 64-bit integer                   |
| `[UInt64]`  |                      | 64-bit integer (unsigned)        |
| `[bigint]`  |                      | See [BigInteger Struct][bigint]  |
| `[single]`  |                      | Single precision floating point  |
| `[float]`   | alias for `[single]` | Single precision floating point  |
| `[double]`  |                      | Double precision floating point  |
| `[decimal]` |                      | 128-bit floating point           |

### Working with other numeric types

To work with any other numeric types you must use type accelerators, which is
not without some problems. For example, high integer values are always parsed
as double before being cast to any other type.

```
PS> [bigint]111111111111111111111111111111111111111111111111111111
111111111111111100905595216014112456735339620444667904
```

The value is parsed as a double first, losing precision in the higher ranges.
To avoid this problem, enter values as strings and then convert them:

```
PS> [bigint]'111111111111111111111111111111111111111111111111111111'
111111111111111111111111111111111111111111111111111111
```

## Examples

The following table contains several examples of numeric literals and lists
their type and value:

|  Number  |  Type   |    Value     |
| -------: | ------- | -----------: |
|      100 | Int32   |          100 |
|     100D | Decimal |          100 |
|     100l | Int64   |          100 |
|      1e2 | Double  |          100 |
|     1.e2 | Double  |          100 |
|    0x1e2 | Int32   |          482 |
|   0x1e2L | Int64   |          482 |
|   0x1e2D | Int32   |         7725 |
|     482D | Decimal |          482 |
|    482gb | Int64   | 517543559168 |
| 0x1e2lgb | Int64   | 517543559168 |

### Commands that look like numeric literals

Any command that looks like a numeric literal must be executed using the the
call operator (`&`), otherwise it is interpreted as a number of the associated
type.

### Access properties and methods of numeric objects

To access a member of a numeric literal, there are cases when you need to
enclose the literal in parentheses.

- The literal does not have a decimal point
- The literal does not have any digits following the decimal point
- The literal does not have a suffix

For example, the following example fails:

```
PS> 2.GetType().Name
At line:1 char:11
+ 2.GetType().Name
+           ~
An expression was expected after '('.
+ CategoryInfo          : ParserError: (:) [], ParentContainsErrorRecordException
+ FullyQualifiedErrorId : ExpectedExpression
```

The following examples work:

```
PS> 2L.GetType().Name
Int64
PS> 1.234.GetType().Name
Double
PS> (2).GetType().Name
Int32
```

The first two examples work without enclosing the literal value in parentheses
because the PowerShell parser can determine where the numeric literal ends and
the **GetType** method starts.

<!-- reference links -->
[bigint]: /dotnet/api/system.numerics.biginteger
