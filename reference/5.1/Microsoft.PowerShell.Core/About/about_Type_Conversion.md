---
description: Describes how and when PowerShell performs type conversions.
Locale: en-US
ms.date: 12/16/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_type_conversion?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Type_Conversion
---
# about_Type_Conversion

## Short description

PowerShell has a flexible type system that makes it easier to use. However, you
must understand how it works to avoid unexpected results.

## Long description

By default, PowerShell _variables_ aren't _type-constrained_. You can create a
variable containing an instance of one type and later assign values of any
other type. Also, PowerShell automatically converts values to other types, both
explicitly and implicitly. While implicit type conversion can be helpful, there
are pitfalls, especially for users more familiar with languages that have
stricter type handling.

## Type-constrained variables and explicit types conversion

To type-constrain a variable, place a type literal to the left of the variable
name in an assignment. For example:

```powershell
[int]$foo = 42
```

You can use type casting to explicitly convert a value to a specific type. For
example:

```powershell
PS> $var = [int]'43'
PS> $var.GetType().Name
Int32
```

Type constraining ensures that only values of the specified type can be
assigned to the variable. PowerShell performs an implicit conversion if you try
to assign a value of a different type that can be converted to the constrained
type. For more information, see the [Implicit type conversion][03] section of
this article.

### Numeric type conversion

Numeric types can be converted to any other numeric type as long as the target
type is capable of holding the converted value. For example:

```powershell
PS> (42.1).GetType().Name
Double
PS> $byte = [byte] 42.1
PS> $byte
42
PS> $byte.GetType().Name
Byte
```

The value `42.1` is a **Double**. When you cast it to a **Byte**, PowerShell
truncates it to an integer `42`, which is small enough to fit into a **Byte**.

When converting real numbers to integer types, PowerShell uses rounding rather
than truncation, specifically using the _rounding-to-nearest-even_ method.
The following examples illustrate this behavior. Both values are rounded to the
nearest even integer, `22`.

```powershell
PS> [byte]21.5
22
PS> [byte]22.5
22
```

For more information, see the _Midpoint values and rounding conventions_
section of the [Math.Round][20] method.

### Boolean type conversion

A value of _any_ type can be coerced to a **Boolean**.

- For numeric types, `0` converts to `$false` and any other value converts to
  `$true`.

  ```powershell
  PS> [boolean]0
  False
  PS> [boolean]0.0
  False
  PS> [boolean]-1
  True
  PS> [boolean]1
  True
  PS> [boolean]42.1
  True
  ```

- For other types, null values, empty strings, and empty arrays are converted
  to `$false`.

  ```powershell
  PS> [boolean]''
  False
  PS> [boolean]@()
  False
  PS> [boolean]'Hello'
  True
  ```

  Other values, including empty hashtables convert to `$true`. Single-element
  collections evaluate to the Boolean value of their one and only element.
  Collections with more than 1 element are always `$true`.

  ```powershell
  PS> [boolean]@(0)
  False
  PS> [boolean]@(0,0)
  True
  PS> [boolean]@{}
  True
  ```

### String type conversion

A value of _any_ type can be coerced to a **String**. The default conversion is
to call the `ToString()` method on the object.

Arrays are converted to strings. Each element in the array is converted to a
string, individually and joined to the resulting string. By default, the
converted values are separated by a space. The separator can be changed by
setting the `$OFS` preference variable.

```powershell
PS> [string] @(1, 2, 3)
1 2 3
```

For more information about `$OFS`, see [about_Preference_Variables][09].

A single string value can be converted to an instance of a type if the type
implements a static `Parse()` method. For example, `[bigint]'42'` is the same
as `[bigint]::Parse('42', [cultureinfo]::InvariantCulture)`. The optional
`[cultureinfo]::InvariantCulture` value binds to an `IFormatProvider` type
parameter of the method. It ensures culture-invariant behavior of the
conversion. Not all implementations of `Parse()` methods have this parameter.

> [!NOTE]
> Conversion to and from strings is usually performed using the
> [invariant culture][16]. Invariant culture is based on, but not identical to,
> the US-English culture. Notably, it uses the period (`.`) as the decimal
> mark and US-style month-first dates by default. However, _binary cmdlets_
> perform culture-sensitive conversion during parameter binding.

### Enum type conversion

PowerShell can convert [Enum][15] types to and from **String** instances. For
example, the typecast string `[System.PlatformId]'Unix'` is the same as the
enum value `[System.PlatformId]::Unix`. PowerShell also handles flag-based
enums correctly for comma-separated values inside a string or as an array of
strings. Consider the following examples:

```powershell
[System.Reflection.TypeAttributes]'Public, Abstract'
[System.Reflection.TypeAttributes]('Public', 'Abstract')
```

These examples are equivalent to the enum expression:

```powershell
[System.Reflection.TypeAttributes]::Public -bor
    [System.Reflection.TypeAttributes]::Abstract
```

### Other type conversions

A single value (non-array) can be converted to an instance of a type if:

- That type has a (public) single-parameter constructor
- And the value is the same type or can be coerced to the type of the parameter

For example, the following two lines are equivalent:

```powershell
[regex]'a|b'
[regex]::new('a|b')`
```

## Implicit types

PowerShell also assigns types to literal values automatically.

Numeric literals are implicitly typed by default. Numbers are typed based on
their size. For example, `42` is small enough to be stored as an **Int32** type
and `1.2` is stored as a **Double**. Integers larger than `[Int32]::MaxValue`
are stored as **Int64**. While `42` can be stored as a **Byte** and `1.2` can
be stored as a **Single** type, the implicit typing uses **Int32** and
**Double** respectively. For more information, see
[about_Numeric_Literals][07].

Literal strings are implicitly typed as **String**. Single-character **String**
instances can be converted to and from the **Char** type. However, PowerShell
has no literal **Char** type.

## Implicit type conversion

In certain contexts, PowerShell can implicitly convert values to other types.
These contexts include:

- Parameter binding
- Type-constrained variables
- Expressions using operators
- Boolean contexts - PowerShell converts the conditional expressions of `if`,
  `while`, `do`, or `switch` statements to **Boolean** values, as previously
  described. For more information, see [about_Booleans][04].
- Extended Type System (ETS) type definitions - Type conversions can be defined
  in several ways:
  - Using the **TypeConverter** parameter of [Update-TypeData][12]
  - In [Types.ps1xml][10] files
  - In compiled code for types decorated with a [TypeConverterAttribute][14]
    attribute
  - Via classes derived from [TypeConverter][13] or [PSTypeConverter][18]

### Parameter binding conversions

PowerShell attempts to convert values passed to parameters to match the
parameter type. Type conversion of parameter values occurs in cmdlets,
functions, scripts, scriptblocks, or .NET methods where the parameter is
declared with a specific type. Declaring a parameter with the type `[object]`
or not defining a specific type allows any value type to be passed to a
parameter. Parameters can also have custom conversions defined by decorating
parameters with [ArgumentTransformationAttribute][17] attribute.

For more information, see [about_Parameter_Binding][08].

### Best practices for parameter binding

For .NET methods, it's better to pass the exact type expected using a type
casts where needed. Without exact types, PowerShell can select the wrong method
overload. Also, new method overloads added in future versions of .NET can break
existing code. For an extreme example of this problem, see this
[Stack Overflow question][11].

If you pass an array to a `[string]` typed parameter, PowerShell might convert
the array to a string as previously described. Consider the following basic
function:

```powershell
function Test-String {
    param([string] $String)
    $String
}

Test-String -String 1, 2
```

This function outputs `1 2` because the array is converted to a string. To
avoid this behavior, create an [advanced function][06] by adding the
`[CmdletBinding()]` attribute.

```powershell
function Test-String {
    [CmdletBinding()]
    param([string] $String)
    $String
}

Test-String -String 1, 2
```

For advanced functions, PowerShell refuses to bind the array to a non-array
type. When you pass an array, PowerShell returns the following error message:

```Output
Test-String:
Line |
   7 |  Test-String -String 1, 2
     |                      ~~~~
     | Cannot process argument transformation on parameter 'String'. Cannot
     | convert value to type System.String.
```

Unfortunately, you can't avoid this behavior for .NET method calls.

```powershell
PS> (Get-Date).ToString(@(1, 2))
1 2
```

PowerShell converts the array to the string `"1 2"`, which is passed to the
**Format** parameter of the `ToString()` method.

The following example shows another instance of the array conversion problem.

```powershell
PS> $bytes = [byte[]] @(1..16)
PS> $guid = New-Object System.Guid($bytes)
New-Object: Cannot find an overload for "Guid" and the argument count: "16".
```

PowerShell treats the `$bytes` array as a list of individual parameters even
though `$bytes` is an array of bytes and `System.Guid` has a `Guid(Byte[])`
constructor.

This common code pattern is an instance of _pseudo method syntax_, which
doesn't always work as intended. This syntax translates to:

```powershell
PS> [byte[]] $bytes = 1..16
PS> New-Object -TypeName System.Guid -ArgumentList $bytes
New-Object: Cannot find an overload for "Guid" and the argument count: "16".
```

Given that the type of **ArgumentList** is `[object[]]`, a single argument that
happens to be an array (of any type) binds to it _element by element_. The
workaround is to wrap `$bytes` in an outer array so that PowerShell looks for a
constructor with parameters that match the contents of the outer array.

```powershell
PS> [byte[]] $bytes = 1..16
PS> $guid = New-Object -TypeName System.Guid -ArgumentList (, $bytes)
PS> $guid

Guid
----
04030201-0605-0807-090a-0b0c0d0e0f10
```

The first item of the wrapped array is our original `Byte[]` instance. That
value matches the `Guid(Byte[]]` constructor.

An alternative to the array wrapping workaround is to use the intrinsic static
`new()` method.

```powershell
PS> [byte[]] $bytes = 1..16
PS> [System.Guid]::new($bytes)  # OK

Guid
----
04030201-0605-0807-090a-0b0c0d0e0f10
```

### Type-constrained variable conversions

When you assign a value to a type-constrained variable, PowerShell attempts to
convert the value to the variable type. If the value provided can be converted
to the variable type, the assignment succeeds.

For example:

```powershell
PS> [int]$foo = '43'
PS> $foo.GetType().Name
Int32
```

The conversion works because the string `'43'` can be converted to a number.

## Operator conversions

PowerShell can implicitly convert the operands in an expression to produce a
reasonable result. Also, some operators have type-specific behaviors.

### Numeric operations

In numeric operations, even if both operands are the same numeric type, the
result can be a different type, due to automatic type conversion to accommodate
the result.

```powershell
PS> [int]$a = 1
PS> [int]$b = 2
PS> $result = $a / $b
PS> $result
0.5
PS> $result.GetType().Name
Double
```

Even though both operands are integers, the result is converted to a **Double**
to support the fractional result. To get true integer division, use the
`[int]::Truncate()` or `[Math]::DivRem()` static methods. For more information,
see [Truncate()][21] and [DivRem()][19].

In integer arithmetic, when the result overflows the size of the operands,
PowerShell defaults to using **Double** for the results, even when the result
could fit into an **Int64** type.

```powershell
PS> $result = [int]::MaxValue + 1
PS> $result
2147483648
PS> $result.GetType().Name
Double
```

If you want the result to be an **Int64**, you can cast the result type or
operands.

```powershell
PS> ([Int64]([int]::MaxValue + 1)).GetType().Name
Int64
```

However, use care when casting results to a specific type. For example, type
casting the result to the `[decimal]` type can lead to loss of precision.
Adding `1` to the maximum **Int64** value results in a **Double** type. When
you cast a **Double** to a **Decimal** type, the result is
`9223372036854780000`, which isn't accurate.

```powershell
PS> ([int64]::MaxValue + 1).GetType().Name
Double
PS> [decimal]([int64]::MaxValue + 1)
9223372036854780000
```

The conversion is limited to 15 digits of precision. For more information, see
the _Remarks_ section of the [Decimal(Double)][01] constructor documentation.

To avoid a loss of precision, use the `D` suffix on the `1` literal. By adding
the `D` suffix, PowerShell converts the `[int64]::MaxValue` to a **Decimal**
before adding `1D`.

```powershell
PS> ([int64]::MaxValue + 1D).GetType().Name
Decimal
PS> ([int64]::MaxValue + 1D)
9223372036854775808
```

For more information about numeric suffixes, see [about_Numeric_Literals][07].

Usually, the left-hand side (LHS) operand of PowerShell operators determines
the data type used in the operation. PowerShell converts (coerces) the
right-hand side (RHS) operand to the required type.

```powershell
PS> 10 - ' 9 '
1
```

In this example, the RHS operand is the string `' 9 '`, which is implicitly
converted to an integer before the subtraction operation. The same is true for
the comparison operators.

```powershell
PS> 10 -eq ' 10'
True
PS> 10 -eq '0xa'
True
```

There are exceptions when using arithmetic_ operators (`+`, `-`, `*`, `/`) with
_non-numeric_ operands.

When you use the `-` and `/` operands with strings, PowerShell converts both
operands from strings to numbers.

```powershell
PS> '10' - '2'
8
PS> '10' / '2'
5
```

By contrast, the `+` and `*` operators have string-specific semantics
(concatenation and replication).

```powershell
PS> '10' + '2'
102
PS> '10' * '2'
1010
```

When you use **Boolean** values with arithmetic operators, PowerShell converts
the values to integers: `$true` becomes `[int]1` and `$false` becomes
`[int]0`.

```powershell
PS> $false - $true
-1
```

The one exception is the multiplication (`*`) of two booleans.

```powershell
PS> $false * $true
InvalidOperation: The operation '[System.Boolean] * [System.Boolean]' is not
defined.
```

For other LHS types, arithmetic operators only succeed if a given type
custom-defines these operators via [operator overloading][02].

### Comparison operations

The comparison operators, such as `-eq`, `-lt`, and `-gt`, can compare operands
of different types. The behavior of non-strings and non-primitive types depends
on whether the LHS type implements interfaces such as `IEquatable` and
`IComparable`.

The collection-based comparison operators (`-in` and `-contains`) perform per
element `-eq` comparisons until a match is found. It's each individual element
of the collection operand that drives any type coercion.

```powershell
PS> $true -in 'true', 'false'
True
PS> 'true', 'false' -contains $true
True
```

Both examples return true because `'true' -eq $true` yields `$true`.

For more information, see [about_Comparison_Operators][05].

<!-- link references -->
[01]: /dotnet/api/system.decimal.-ctor#system-decimal-ctor(system-double)
[02]: /dotnet/csharp/programming-guide/statements-expressions-operators/overloadable-operators
[03]: #implicit-type-conversion
[04]: about_Booleans.md
[05]: about_Comparison_Operators.md
[06]: about_Functions_Advanced.md
[07]: about_Numeric_Literals.md
[08]: about_parameter_binding.md
[09]: about_preference_variables.md#ofs
[10]: about_Types.ps1xml.md
[11]: https://stackoverflow.com/questions/76241804/how-does-powershell-split-consecutive-strings-not-a-single-letter
[12]: xref:Microsoft.PowerShell.Utility.Update-TypeData
[13]: xref:System.ComponentModel.TypeConverter
[14]: xref:System.ComponentModel.TypeConverterAttribute
[15]: xref:System.Enum
[16]: xref:System.Globalization.CultureInfo.InvariantCulture*
[17]: xref:System.Management.Automation.ArgumentTransformationAttribute
[18]: xref:System.Management.Automation.PSTypeConverter
[19]: xref:System.Math.DivRem*
[20]: xref:System.Math.Round*#midpoint-values-and-rounding-conventions
[21]: xref:System.Math.Truncate*
