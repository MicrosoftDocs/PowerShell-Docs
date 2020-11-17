---
description: Both integer and real numeric literals can have type and multiplier suffixes.
Locale: en-US
ms.date: 04/12/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_numeric_literals?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: About numeric literals
---
# About numeric literals

There are two kinds of numeric literals: integer and real. Both can have type
and multiplier suffixes.

## Integer literals

Integer literals can be written in decimal, hexadecimal, or binary notation.
Hexadecimal literals are prefixed with `0x` and binary literals are prefixed
with `0b` to distinguish them from decimal numbers.

Integer literals can have a type suffix and a multiplier suffix.

| Suffix |            Meaning             |          Note           |
| ------ | ------------------------------ | ----------------------- |
| y      | signed byte data type          | Added in PowerShell 6.2 |
| uy     | unsigned byte data type        | Added in PowerShell 6.2 |
| s      | short data type                | Added in PowerShell 6.2 |
| us     | unsigned short data type       | Added in PowerShell 6.2 |
| l      | long data type                 |                         |
| u      | unsigned int or long data type | Added in PowerShell 6.2 |
| ul     | unsigned long data type        | Added in PowerShell 6.2 |
| n      | BigInteger data type           | Added in PowerShell 7.0 |
| kb     | kilobyte multiplier            |                         |
| mb     | megabyte multiplier            |                         |
| gb     | gigabyte multiplier            |                         |
| tb     | terabyte multiplier            |                         |
| pb     | petabyte multiplier            |                         |

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

- If the type suffix is `u` and the value can be represented by type `[uint]`
  then its type is `[uint]`.
- If the type suffix is `u` and the value can be represented by type `[ulong]`
  then its type is `[ulong]`.
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

The multiplier suffixes can be used in combination with any type suffixes,
but must be present after the type suffix. For example, the literal
`100gbL` is malformed, but the literal `100Lgb` is valid.

If a multiplier creates a value that exceeds the possible values for the
numeric type that the suffix specifies, the literal is malformed. For
example, the literal `1usgb` is malformed, because the value `1gb` is larger
than what is permitted for the `[ushort]` type specified by the `us` suffix.

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
| `[short]`   | alias for `[int16]`  | 16-bit integer                   |
| `[UInt16]`  |                      | 16-bit integer (unsigned)        |
| `[ushort]`  | alias for `[uint16]` | 16-bit integer (unsigned)        |
| `[Int32]`   |                      | 32-bit integer                   |
| `[int]`     | alias for `[int32]`  | 32-bit integer                   |
| `[UInt32]`  |                      | 32-bit integer (unsigned)        |
| `[uint]`    | alias for `[uint32]` | 32-bit integer (unsigned)        |
| `[Int64]`   |                      | 64-bit integer                   |
| `[long]`    | alias for `[int64]`  | 64-bit integer                   |
| `[UInt64]`  |                      | 64-bit integer (unsigned)        |
| `[ulong]`   | alias for `[uint64]` | 64-bit integer (unsigned)        |
| `[bigint]`  |                      | See [BigInteger Struct][bigint]  |
| `[single]`  |                      | Single precision floating point  |
| `[float]`   | alias for `[single]` | Single precision floating point  |
| `[double]`  |                      | Double precision floating point  |
| `[decimal]` |                      | 128-bit floating point           |

> [!NOTE]
> The following type accelerators were added in PowerShell 6.2: `[short]`,
> `[ushort]`, `[uint]`, `[ulong]`.

## Examples

The following table contains several examples of numeric literals and lists
their type and value:

|   Number    |    Type    |    Value     |
| ----------: | ---------- | -----------: |
|         100 | Int32      |          100 |
|        100u | UInt32     |          100 |
|        100D | Decimal    |          100 |
|        100l | Int64      |          100 |
|       100uL | UInt64     |          100 |
|       100us | UInt16     |          100 |
|       100uy | Byte       |          100 |
|        100y | SByte      |          100 |
|         1e2 | Double     |          100 |
|        1.e2 | Double     |          100 |
|       0x1e2 | Int32      |          482 |
|      0x1e2L | Int64      |          482 |
|      0x1e2D | Int32      |         7725 |
|        482D | Decimal    |          482 |
|       482gb | Int64      | 517543559168 |
|      482ngb | BigInteger | 517543559168 |
|    0x1e2lgb | Int64      | 517543559168 |
|   0b1011011 | Int32      |           91 |
|     0xFFFFs | Int16      |           -1 |
|  0xFFFFFFFF | Int32      |           -1 |
| -0xFFFFFFFF | Int32      |            1 |
| 0xFFFFFFFFu | UInt32     |   4294967295 |

### Working with binary or hexadecimal numbers

Overly large binary or hexadecimal literals can return as `[bigint]` rather
than failing the parse, if and only if the `n` suffix is specified. Sign
bits are still respected above even `[decimal]` ranges, however:

- If a binary string is some multiple of 8 bits long, the highest bit is
  treated as the sign bit.
- If a hex string, which has a length that is a multiple of 8, has the first
  digit with 8 or higher, the numeral is treated as negative.

Specifying an unsigned suffix on binary and hex literals ignores sign bits. For
example, `0xFFFFFFFF` returns `-1`, but `0xFFFFFFFFu` returns the
`[uint]::MaxValue` of 4294967295.

In PowerShell 7.1, using a type suffix on a hex literal now returns a signed
value of that type. For example, in PowerShell 7.0 the expression `0xFFFFs` returns
an error because the positive value is too large for an `[int16]` type.
PowerShell 7.1 interprets this as `-1` that is an `[int16]` type.

Prefixing the literal with a `0` will bypass this and be treated as unsigned.
For example: `0b011111111`. This can be necessary when working with literals
in the `[bigint]` range, as the `u` and `n` suffixes cannot be combined.

You can also negate binary and hex literals using the `-` prefix. This can
result in a positive number since sign bits are permitted.

Sign bits are accepted for BigInteger-suffixed numerals:

- BigInteger-suffixed hex treats the high bit of any literal with a length
  multiple of 8 characters as the sign bit. The length does not include the
  `0x` prefix or any suffixes.
- BigInteger-suffixed binary accepts sign bits at 96 and 128 characters, and at
  every 8 characters after.

### Commands that look like numeric literals

Any command that looks like a valid numeric literal must be executed using the
call operator (`&`), otherwise it is interpreted as a number. Malformed
literals with valid syntax like `1usgb` will result in the following error:

```
PS> 1usgb
At line:1 char:6
+ 1usgb
+      ~
The numeric constant 1usgb is not valid.
+ CategoryInfo          : ParserError: (:) [], ParentContainsErrorRecordException
+ FullyQualifiedErrorId : BadNumericConstant
```

However, malformed literals with invalid syntax like `1gbus` will be interpreted
as a standard bare string, and can be interpreted as a valid command name in
contexts where commands may be called.

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
PS> 2uL.GetType().Name
UInt64
PS> 1.234.GetType().Name
Double
PS> (2).GetType().Name
Int32
```

The first two examples work without enclosing the literal value in parentheses
because the PowerShell parser can determine where the numeric literal ends and
the **GetType** method starts.

## How PowerShell parses numeric literals

PowerShell v7.0 changed the way numeric literals are parsed to enable the new
features.

### Parsing real numeric literals

If the literal contains a decimal point or the e-notation, the literal string is parsed a real number.

- If the decimal-suffix is present then directly into `[decimal]`.
- Else, parse as `[Double]` and apply multiplier to the value. Then check the
  type suffixes and attempt to cast into appropriate type.
- If the string has no type suffix, then parse as `[Double]`.

### Paring integer numeric literals

Integer type literals are parsed using the following steps:

1. Determine the radix format
   - For binary formats, parse into `[BigInteger]`.
   - For hexidecimal formats, parse into `[BigInteger]` using special casies to
     retain original behaviours when the value is in the `[int]` or `[long]`
     range.
   - If neither binary nor hex, parse normally as a `[BigInteger]`.
2. Apply the multiplier value before attempting any casts to ensure type bounds
   can be appropriately checked without overflows.
3. Check type suffixes.
   - Check type bounds and attempt to parse into that type.
   - If no suffix is used, then the value is bounds-checked in the following
     order, resulting in the first successful test determining the type of the
     number.
     - `[int]`
     - `[long]`
     - `[decimal]` (base-10 literals only)
     - `[double]` (base-10 literals only)
   - If the value is outside the `[long]` range for hex and binary numbers, the
     parse fails.
   - If the value is outside the `[double]` range for base 10 number, the parse
     fails.
   - Higher values must be explicitly written using the `n` suffix to parse the
     literal as a `BigInteger`.

### Parsing large value literals

Previously, higher integer values were parsed as double before being cast to any
other type. This results in a loss of precision in the higher ranges. For example:

```
PS> [bigint]111111111111111111111111111111111111111111111111111111
111111111111111100905595216014112456735339620444667904
```

To avoid this problem you had to write values as strings and then convert them:

```
PS> [bigint]'111111111111111111111111111111111111111111111111111111'
111111111111111111111111111111111111111111111111111111
```

In PowerShell 7.0 you must use the `N` suffix.

```
PS> 111111111111111111111111111111111111111111111111111111n
111111111111111111111111111111111111111111111111111111
```

Also values between `[ulong]::MaxValue` and `[decimal]::MaxValue` should be
denoted using the decimal-suffix `D` to maintain accuracy. Without the suffix,
these values are parsed as `[Double]` using the real-parsing mode.

<!-- reference links -->
[bigint]: /dotnet/api/system.numerics.biginteger
