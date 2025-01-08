---
description: In PowerShell, each value has a type, and types fall into one of two main categories - value types and reference types.
ms.date: 05/26/2023
title: Types
---
# 4. Types

[!INCLUDE [Disclaimer](../../includes/language-spec.md)]

In PowerShell, each value has a type, and types fall into one of two main categories: **value
types** and **reference types**. Consider the type `int`, which is typical of value types. A value
of type `int` is completely self-contained; all the bits needed to represent that value are stored
in that value, and every bit pattern in that value represents a valid value for its type. Now,
consider the array type `int[]`, which is typical of reference types. A so-called value of an array
type can hold either a reference to an object that actually contains the array elements, or the
**null reference** whose value is `$null`. The important distinction between the two type categories
is best demonstrated by the differences in their semantics during assignment. For example,

```powershell
$i = 100 # $i designates an int value 100
$j = $i # $j designates an int value 100, which is a copy

$a = 10,20,30 # $a designates an object[], Length 3, value 10,20,30
$b = $a # $b designates exactly the same array as does $a, not a copy
$a[1] = 50 # element 1 (which has a value type) is changed from 20 to 50
$b[1] # $b refers to the same array as $a, so $b[1] is 50
```

As we can see, the assignment of a reference type value involves a **shallow copy**; that is, a copy
of the reference to the object rather than its actual value. In contrast, a **deep copy** requires
making a copy of the object as well.

A **numeric** type is one that allows representation of integer or fractional values, and that
supports arithmetic operations on those values. The set of numerical types includes the integer
([§4.2.3][§4.2.3]) and real number ([§4.2.4][§4.2.4]) types, but does not include bool
([§4.2.1][§4.2.1]) or char ([§4.2.2][§4.2.2]). An implementation may provide other numeric types
(such as signed byte, unsigned integer, and integers of other sizes).

A **collection** is a group of one or more related items, which need not have the same type.
Examples of collection types are arrays, stacks, queues, lists, and hash tables. A program can
_enumerate_ (or _iterate_) over the elements in a collection, getting access to each element one at
a time. Common ways to do this are with the foreach statement ([§8.4.4][§8.4.4]) and the
[ForEach-Object](xref:Microsoft.PowerShell.Core.ForEach-Object) cmdlet. The type of an object that
represents an enumerator is described in [§4.5.16][§4.5.16].

In this chapter, there are tables that list the accessible members for a given type. For methods,
the **Type** is written with the following form: _returnType_/_argumentTypeList_. If the argument
type list is too long to fit in that column, it is shown in the **Purpose** column instead.

Other integer types are `SByte`, `Int16`, `UInt16`, `UInt32`, and `UInt64`, all in the namespace
**System**.

Many collection classes are defined as part of the **System.Collections** or
**System.Collections.Generic** namespaces. Most collection classes implement the interfaces
`ICollection`, `IComparer`, `IEnumerable`, `IList`, `IDictionary`, and `IDictionaryEnumerator` and
their generic equivalents.

You can also use shorthand names for some types. For more information, see
[about_Type_Accelerators](/powershell/module/microsoft.powershell.core/about/about_type_accelerators).

## 4.1 Special types

### 4.1.1 The void type

This type cannot be instantiated. It provides a means to discard a value explicitly using the cast
operator ([§7.2.9][§7.2.9]).

### 4.1.2 The null type

The _null type_ has one instance, the automatic variable $null ([§2.3.2.2][§2.3.2.2]), also known as
the null value. This value provides a means for expressing "nothingness" in reference contexts. The
characteristics of this type are unspecified.

### 4.1.3 The object type

Every type in PowerShell except the null type ([§4.1.2][§4.1.2]) is derived directly or indirectly
from the type object, so object is the ultimate base type of all non-null types. A variable
constrained ([§5.3][§5.3]) to type object is really not constrained at all, as it can contain a
value of any type.

## 4.2 Value types

### 4.2.1 Boolean

The Boolean type is `bool`. There are only two values of this type, **False** and **True**,
represented by the automatic variables `$false` and `$true`, respectively ([§2.3.2.2][§2.3.2.2]).

In PowerShell, `bool` maps to `System.Boolean`.

### 4.2.2 Character

A character value has type char, which is capable of storing any UTF-16-encoded 16-bit Unicode code
point.

The type char has the following accessible members:

|   **Member**    |       **Member Kind**       |  **Type**   |                          **Purpose**                           |
| --------------- | --------------------------- | ----------- | -------------------------------------------------------------- |
| MaxValue        | Static property (read-only) | char        | The largest possible value of type char                        |
| MinValue        | Static property (read-only) | char        | The smallest possible value of type char                       |
| IsControl       | Static method               | bool/char   | Tests if the character is a control character                  |
| IsDigit         | Static method               | bool/char   | Tests if the character is a decimal digit                      |
| IsLetter        | Static method               | bool/char   | Tests if the character is an alphabetic letter                 |
| IsLetterOrDigit | Static method               | bool/char   | Tests if the character is a decimal digit or alphabetic letter |
| IsLower         | Static method               | bool/char   | Tests if the character is a lowercase alphabetic letter        |
| IsPunctuation   | Static method               | bool/char   | Tests if the character is a punctuation mark                   |
| IsUpper         | Static method               | bool/char   | Tests if the character is an uppercase alphabetic letter       |
| IsWhiteSpace    | Static method               | bool/char   | Tests if the character is a white space character.             |
| ToLower         | Static method               | char/string | Converts the character to lowercase                            |
| ToUpper         | Static method               | char/string | Converts the character to uppercase                            |

Windows PowerShell: char maps to System.Char.

### 4.2.3 Integer

There are two signed integer types, both of use two's-complement
representation for negative values:

- Type `int`, which uses 32 bits giving it a range of -2147483648 to +2147483647, inclusive.
- Type `long`, which uses 64 bits giving it a range of -9223372036854775808 to +9223372036854775807,
  inclusive.

Type int has the following accessible members:

| **Member** |       **Member Kind**       | **Type** |               **Purpose**               |
| ---------- | --------------------------- | -------- | --------------------------------------- |
| MaxValue   | Static property (read-only) | int      | The largest possible value of type int  |
| MinValue   | Static property (read-only) | int      | The smallest possible value of type int |

Type long has the following accessible members:

| **Member** |       **Member Kind**       | **Type** |               **Purpose**                |
| ---------- | --------------------------- | -------- | ---------------------------------------- |
| MaxValue   | Static property (read-only) | long     | The largest possible value of type long  |
| MinValue   | Static property (read-only) | long     | The smallest possible value of type long |

There is one unsigned integer type:

- Type `byte`, which uses 8 bits giving it a range of 0 to 255, inclusive.

Type `byte` has the following accessible members:

| **Member** |       **Member Kind**       | **Type** |               **Purpose**                |
| ---------- | --------------------------- | -------- | ---------------------------------------- |
| MaxValue   | Static property (read-only) | byte     | The largest possible value of type byte  |
| MinValue   | Static property (read-only) | byte     | The smallest possible value of type byte |

In PowerShell, `byte`, `int`, and `long` map to `System.Byte`, `System.Int32`, and `System.Int64`,
respectively.

### 4.2.4 Real number

#### 4.2.4.1 float and double

There are two real (or floating-point) types:

- Type `float` uses the 32-bit IEEE single-precision representation.
- Type `double` uses the 64-bit IEEE double-precision representation.

A third type name, `single`, is a synonym for type `float`; `float` is used throughout this
specification.

Although the size and representation of the types `float` and `double` are defined by this
specification, an implementation may use extended precision for intermediate results.

Type float has the following accessible members:

|    **Member**    |       **Member Kind**       | **Type** |                **Purpose**                |
| ---------------- | --------------------------- | -------- | ----------------------------------------- |
| MaxValue         | Static property (read-only) | float    | The largest possible value of type float  |
| MinValue         | Static property (read-only) | float    | The smallest possible value of type float |
| NaN              | Static property (read-only) | float    | The constant value Not-a-Number           |
| NegativeInfinity | Static property (read-only) | float    | The constant value negative infinity      |
| PositiveInfinity | Static property (read-only) | float    | The constant value positive infinity      |

Type double has the following accessible members:

|    **Member**    |       **Member Kind**       | **Type** |                **Purpose**                 |
| ---------------- | --------------------------- | -------- | ------------------------------------------ |
| MaxValue         | Static property (read-only) | double   | The largest possible value of type double  |
| MinValue         | Static property (read-only) | double   | The smallest possible value of type double |
| NaN              | Static property (read-only) | double   | The constant value Not-a-Number            |
| NegativeInfinity | Static property (read-only) | double   | The constant value negative infinity       |
| PositiveInfinity | Static property (read-only) | double   | The constant value positive infinity       |

In PowerShell, `float` and `double` map to `System.Single` and `System.Double`, respectively.

#### 4.2.4.2 decimal

Type decimal uses a 128-bit representation. At a minimum it must support a scale **s** such that 0
<= _s_ <= at least 28, and a value range -79228162514264337593543950335 to
79228162514264337593543950335. The actual representation of decimal is implementation defined.

Type decimal has the following accessible members:

| **Member** |       **Member Kind**       | **Type** |                 **Purpose**                 |
| ---------- | --------------------------- | -------- | ------------------------------------------- |
| MaxValue   | Static property (read-only) | decimal  | The largest possible value of type decimal  |
| MinValue   | Static property (read-only) | decimal  | The smallest possible value of type decimal |

> [!NOTE]
> Decimal real numbers have a characteristic called _scale_,  which represents the number of digits
> to the right of the decimal point. For example, the value 2.340 has a scale of 3 where trailing
> zeros are significant. When two decimal real numbers are added or subtracted, the scale of the
> result is the larger of the two scales. For example, 1.0 + 2.000 is 3.000, while 5.0 - 2.00 is
> 3.00. When two decimal real numbers are multiplied, the scale of the result is the sum of the two
> scales. For example, 1.0 * 2.000 is 2.0000. When two decimal real numbers are divided, the scale
> of the result is the scale of the first less the scale of the second. For example, 4.00000/2.000
> is 2.00. However, a scale cannot be less than that needed to preserve the correct result. For
> example, 3.000/2.000, 3.00/2.000, 3.0/2.000, and 3/2 are all 1.5.

In PowerShell, `decimal` maps to `System.Decimal`. The representation of decimal is as follows:

- When considered as an array of four `int` values it contains the following elements:
  - Index 0 (bits 0‑31) contains the low-order 32 bits of the decimal's coefficient.
  - Index 1 (bits 32‑63) contains the middle 32 bits of the decimal's coefficient.
  - Index 2 (bits 64‑95) contains the high-order 32 bits of the decimal's coefficient.
  - Index 3 (bits 96‑127) contains the sign bit and scale, as follows:
    - bits 0--15 are zero
    - bits 16‑23 contains the scale as a value 0--28
    - bits 24‑30 are zero
    - bit 31 is the sign (0 for positive, 1 for negative)

### 4.2.5 The switch type

This type is used to constrain the type of a parameter in a command ([§8.10.5][§8.10.5]). If an
argument having the corresponding parameter name is present the parameter tests $true; otherwise, it
tests `$false`.

In PowerShell, `switch` maps to `System.Management.Automation.SwitchParameter`.

### 4.2.6 Enumeration types

An enumeration type is one that defines a set of named constants representing all the possible
values that can be assigned to an object of that enumeration type. In some cases, the set of values
are such that only one value can be represented at a time. In other cases, the set of values are
distinct powers of two, and by using the -bor operator ([§7.8.5][§7.8.5]), multiple values can be
encoded in the same object.

The PowerShell environment provides a number of enumeration types, as described in the following
sections.

#### 4.2.6.1 Action-Preference type

This implementation-defined type has the following mutually
exclusive-valued accessible members:

|    **Member**    |   **Member Kind**    |                                               **Purpose**                                               |
| ---------------- | -------------------- | ------------------------------------------------------------------------------------------------------- |
| Continue         | Enumeration constant | The PowerShell runtime will continue processing and notify the user that an action has occurred.        |
| Inquire          | Enumeration constant | The PowerShell runtime will stop processing and ask the user how it should proceed.                     |
| SilentlyContinue | Enumeration constant | The PowerShell runtime will continue processing without notifying the user that an action has occurred. |
| Stop             | Enumeration constant | The PowerShell runtime will stop processing when an action occurs.                                      |

In PowerShell, this type is `System.Management.Automation.ActionPreference`.

#### 4.2.6.2 Confirm-Impact type

This implementation-defined type has the following mutually exclusive-valued accessible members:

| **Member** |   **Member Kind**    |                                      **Purpose**                                       |
| ---------- | -------------------- | -------------------------------------------------------------------------------------- |
| High       | Enumeration constant | The action performed has a high risk of losing data, such as reformatting a hard disk. |
| Low        | Enumeration constant | The action performed has a low risk of losing data.                                    |
| Medium     | Enumeration constant | The action performed has a medium risk of losing data.                                 |
| None       | Enumeration constant | Do not confirm any actions (suppress all requests for confirmation).                   |

In PowerShell, this type is `System.Management.Automation.ConfirmImpact`.

#### 4.2.6.3 File-Attributes type

This implementation-defined type has the following accessible members, which can be combined:

|    **Member**     |   **Member Kind**    |                                                                                                                  **Purpose**                                                                                                                  |
| ----------------- | -------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Archive           | Enumeration constant | The file's archive status. Applications use this attribute to mark files for backup or removal.                                                                                                                                               |
| Compressed        | Enumeration constant | The file is compressed.                                                                                                                                                                                                                       |
| Device            |                      | Reserved for future use.                                                                                                                                                                                                                      |
| Directory         | Enumeration constant | The file is a directory.                                                                                                                                                                                                                      |
| Encrypted         | Enumeration constant | The file or directory is encrypted. For a file, this means that all data in the file is encrypted. For a directory, this means that encryption is the default for newly created files and directories.                                        |
| Hidden            | Enumeration constant | The file is hidden, and thus is not included in an ordinary directory listing.                                                                                                                                                                |
| Normal            | Enumeration constant | The file is normal and has no other attributes set. This attribute is valid only if used alone.                                                                                                                                               |
| NotContentIndexed | Enumeration constant | The file will not be indexed by the operating system's content indexing service.                                                                                                                                                              |
| Offline           | Enumeration constant | The file is offline. The data of the file is not immediately available.                                                                                                                                                                       |
| ReadOnly          | Enumeration constant | The file is read-only.                                                                                                                                                                                                                        |
| ReparsePoint      | Enumeration constant | The file contains a reparse point, which is a block of user-defined data associated with a file or a directory.                                                                                                                               |
| SparseFile        | Enumeration constant | The file is a sparse file. Sparse files are typically large files whose data are mostly zeros.                                                                                                                                                |
| System            | Enumeration constant | The file is a system file. The file is part of the operating system or is used exclusively by the operating system.                                                                                                                           |
| Temporary         | Enumeration constant | The file is temporary. File systems attempt to keep all of the data in memory for quicker access rather than flushing the data back to mass storage. A temporary file should be deleted by the application as soon as it is no longer needed. |

In PowerShell, this type is System.IO.FileAttributes with attribute
FlagsAttribute.

#### 4.2.6.4 Regular-Expression-Option type

This implementation-defined type has the following accessible members, which can be combined:

| **Member** |   **Member Kind**    |                   **Purpose**                    |
| ---------- | -------------------- | ------------------------------------------------ |
| IgnoreCase | Enumeration constant | Specifies that the matching is case-insensitive. |
| None       | Enumeration constant | Specifies that no options are set.               |

An implementation may provide other values.

In PowerShell, this type is `System.Text.RegularExpressions.RegexOptions` with attribute
`FlagsAttribute`. The following extra values are defined: `Compiled`, `CultureInvariant`,
`ECMAScript`, `ExplicitCapture`, `IgnorePatternWhitespace`, `Multiline`, `RightToLeft`,
`Singleline`.

## 4.3 Reference types

### 4.3.1 Strings

A string value has type string and is an immutable sequence of zero or more characters of type char
each containing a UTF-16-encoded 16-bit Unicode code point.

Type string has the following accessible members:

| **Member** |  **Member Kind**  |    **Type**     |                         **Purpose**                         |
| ---------- | ----------------- | --------------- | ----------------------------------------------------------- |
| Length     | Instance Property | int (read-only) | Gets the number of characters in the string                 |
| ToLower    | Instance Method   | string          | Creates a new string that contains the lowercase equivalent |
| ToUpper    | Instance Method   | string          | Creates a new string that contains the uppercase equivalent |

In PowerShell, `string` maps to `System.String`.

### 4.3.2 Arrays

All array types are derived from the type `Array`. This type has the following accessible members:

<table>
<thead>
<tr class="header">
<th><strong>Member</strong></th>
<th><strong>Member Kind</strong></th>
<th><strong>Type</strong></th>
<th><strong>Purpose</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Length</td>
<td>Instance Property (read-only)</td>
<td>int</td>
<td>Number of elements in the array</td>
</tr>
<tr class="even">
<td>Rank</td>
<td>Instance Property (read-only)</td>
<td>int</td>
<td>Number of dimensions in the array</td>
</tr>
<tr class="odd">
<td>Copy</td>
<td>Static Method</td>
<td>void/see Purpose column</td>
<td><p>Copies a range of elements from one array to another. There are four versions, where <em>source</em> is the source array, <em>destination</em> is the destination array, <em>count</em> is the number of elements to copy, and <em>sourceIndex</em> and <em>destinationIndex</em> are the starting locations in their respective arrays:</p>
<p>Copy(<em>source</em>, <em>destination</em>, int <em>count</em>)<br />
Copy(<em>source</em>, <em>destination</em>, long <em>count</em>)<br />
Copy(<em>source</em>, <em>sourceIndex</em>, <em>destination</em>, <em>destinationIndex</em>, int <em>count</em>)<br />
Copy(<em>source</em>, <em>sourceIndex</em>, <em>destination</em>, <em>destinationIndex</em>, long <em>count</em>)</p></td>
</tr>
<tr class="even">
<td>GetLength</td>
<td>Instance Method (read-only)</td>
<td>int/none</td>
<td><p>Number of elements in a given dimension</p>
<p>GetLength(int <em>dimension</em>)</p></td>
</tr>
</tbody>
</table>

For more details on arrays, see [§9.][§9.]

In PowerShell, `Array` maps to `System.Array`.

### 4.3.3 Hashtables

Type Hashtable has the following accessible members:

| **Member** |  **Member Kind**  |        **Type**        |                     **Purpose**                     |
| ---------- | ----------------- | ---------------------- | --------------------------------------------------- |
| Count      | Instance Property | int                    | Gets the number of key/value pairs in the Hashtable |
| Keys       | Instance Property | Implementation-defined | Gets a collection of all the keys                   |
| Values     | Instance Property | Implementation-defined | Gets a collection of all the values                 |
| Remove     | Instance Method   | void/none              | Removes the designated key/value                    |

For more details on Hashtables, see §10.

In PowerShell, `Hashtable` maps to `System.Collections.Hashtable`. `Hashtable` elements are stored
in an object of type `DictionaryEntry`, and the collections returned by Keys and Values have type
`ICollection`.

### 4.3.4 The xml type

Type xml implements the W3C Document Object Model (DOM) Level 1 Core and the Core DOM Level 2. The
DOM is an in-memory (cache) tree representation of an XML document and enables the navigation and
editing of this document. This type supports the subscript operator [] ([§7.1.4.4][§7.1.4.4]).

In PowerShell, `xml` maps to `System.Xml.XmlDocument`.

### 4.3.5 The regex type

Type `regex` provides machinery for supporting regular expression processing. It is used to
constrain the type of a parameter ([§5.3][§5.3]) whose corresponding argument might contain a
regular expression.

In PowerShell, `regex` maps to `System.Text.RegularExpressions.Regex`.

### 4.3.6 The ref type

Ordinarily, arguments are passed to commands by value. In the case of an argument having some value
type a copy of the value is passed. In the case of an argument having some reference type a copy of
the reference is passed.

Type ref provides machinery to allow arguments to be passed to commands by reference, so the
commands can modify the argument's value. Type ref has the following accessible members:

| **Member** |        **Member Kind**         |                **Type**                 |              **Purpose**              |
| ---------- | ------------------------------ | --------------------------------------- | ------------------------------------- |
| Value      | Instance property (read-write) | The type of the value being referenced. | Gets/sets the value being referenced. |

Consider the following function definition and call:

```powershell
function Doubler {
    param ([ref]$x) # parameter received by reference
    $x.Value *= 2.0 # note that 2.0 has type double
}

$number = 8 # designates a value of type int, value 8
Doubler([ref]$number) # argument received by reference
$number # designates a value of type double, value 8.0
```

Consider the case in which $number is type-constrained:

```powershell
[int]$number = 8 # designates a value of type int, value 8
Doubler([ref]$number) # argument received by reference
$number # designates a value of type int, value 8
```

As shown, both the argument and its corresponding parameter must be declared `ref`.

In PowerShell, `ref` maps to `System.Management.Automation.PSReference`.

### 4.3.7 The scriptblock type

Type `scriptblock` represents a precompiled block of script text ([§7.1.8][§7.1.8]) that can be used
as a single unit. It has the following accessible members:

<table>
<thead>
<tr class="header">
<th><strong>Member</strong></th>
<th><strong>Member Kind</strong></th>
<th><strong>Type</strong></th>
<th><strong>Purpose</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Attributes</td>
<td>Instance property (read-only)</td>
<td>Collection of attributes</td>
<td>Gets the attributes of the script block.</td>
</tr>
<tr class="even">
<td>File</td>
<td>Instance property (read-only)</td>
<td>string</td>
<td>Gets the name of the file in which the script block is defined.</td>
</tr>
<tr class="odd">
<td>Module</td>
<td>Instance property (read-only)</td>
<td>implementation defined ([§4.5.12][§4.5.12])</td>
<td>Gets information about the module in which the script block is defined.</td>
</tr>
<tr class="even">
<td>GetNewClosure</td>
<td>Instance method</td>
<td>scriptblock<br />
/none</td>
<td>Retrieves a script block that is bound to a module. Any local variables that are in the context of the caller will be copied into the module.</td>
</tr>
<tr class="odd">
<td>Invoke</td>
<td>Instance method</td>
<td>Collection of object/object[]</td>
<td>Invokes the script block with the specified arguments and returns the results.</td>
</tr>
<tr class="even">
<td>InvokeReturnAsIs</td>
<td>Instance method</td>
<td>object/object[]</td>
<td>Invokes the script block with the specified arguments and returns any objects generated.</td>
</tr>
<tr class="odd">
<td>Create</td>
<td>Static method</td>
<td>scriptblock<br />
/string</td>
<td>Creates a new scriptblock object that contains the specified script.</td>
</tr>
</tbody>
</table>

In PowerShell, `scriptblock` maps to `System.Management.Automation.ScriptBlock`. `Invoke` returns a
collection of `PSObject`.

### 4.3.8 The math type

Type `math` provides access to some constants and methods useful in mathematical computations. It
has the following accessible members:

<table>
<thead>
<tr class="header">
<th><strong>Member</strong></th>
<th><strong>Member Kind</strong></th>
<th><strong>Type</strong></th>
<th><strong>Purpose</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>E</td>
<td>Static property (read-only)</td>
<td>double</td>
<td>Natural logarithmic base</td>
</tr>
<tr class="even">
<td>PI</td>
<td>Static property (read-only)</td>
<td>double</td>
<td>Ratio of the circumference of a circle to its diameter</td>
</tr>
<tr class="odd">
<td>Abs</td>
<td>Static method</td>
<td>numeric/numeric</td>
<td>Absolute value (the return type is the same as the type of the argument passed in)</td>
</tr>
<tr class="even">
<td>Acos</td>
<td>Static method</td>
<td>double / double</td>
<td>Angle whose cosine is the specified number</td>
</tr>
<tr class="odd">
<td>Asin</td>
<td>Static method</td>
<td>double / double</td>
<td>Angle whose sine is the specified number</td>
</tr>
<tr class="even">
<td>Atan</td>
<td>Static method</td>
<td>double / double</td>
<td>Angle whose tangent is the specified number</td>
</tr>
<tr class="odd">
<td>Atan2</td>
<td>Static method</td>
<td>double / double <em>y</em>, double <em>x</em></td>
<td>Angle whose tangent is the quotient of two specified numbers <em>x</em> and <em>y</em></td>
</tr>
<tr class="even">
<td>Ceiling</td>
<td>Static method</td>
<td><p>decimal / decimal</p>
<p>double / double</p></td>
<td>smallest integer greater than or equal to the specified number</td>
</tr>
<tr class="odd">
<td>Cos</td>
<td>Static method</td>
<td>double / double</td>
<td>Cosine of the specified angle</td>
</tr>
<tr class="even">
<td>Cosh</td>
<td>Static method</td>
<td>double / double</td>
<td>Hyperbolic cosine of the specified angle</td>
</tr>
<tr class="odd">
<td>Exp</td>
<td>Static method</td>
<td>double / double</td>
<td>e raised to the specified power</td>
</tr>
<tr class="even">
<td>Floor</td>
<td>Static method</td>
<td><p>decimal / decimal</p>
<p>double / double</p></td>
<td>Largest integer less than or equal to the specified number</td>
</tr>
<tr class="odd">
<td>Log</td>
<td>Static method</td>
<td><p>double / double <em>number</em></p>
<p>double / double <em>number</em>, double <em>base</em></p></td>
<td>Logarithm of number using base e or base <em>base</em></td>
</tr>
<tr class="even">
<td>Log10</td>
<td>Static method</td>
<td>double / double</td>
<td>Base-10 logarithm of a specified number</td>
</tr>
<tr class="odd">
<td>Max</td>
<td>Static method</td>
<td>numeric/numeric</td>
<td>Larger of two specified numbers (the return type is the same as the type of the arguments passed in)</td>
</tr>
<tr class="even">
<td>Min</td>
<td>Static method</td>
<td>numeric/numeric, numeric</td>
<td>Smaller of two specified numbers (the return type is the same as the type of the arguments passed in)</td>
</tr>
<tr class="odd">
<td>Pow</td>
<td>Static method</td>
<td>double / double <em>x</em>, double <em>y</em></td>
<td>A specified number <em>x</em> raised to the specified power <em>y</em></td>
</tr>
<tr class="even">
<td>Sin</td>
<td>Static method</td>
<td>double / double</td>
<td>Sine of the specified angle</td>
</tr>
<tr class="odd">
<td>Sinh</td>
<td>Static method</td>
<td>double / double</td>
<td>Hyperbolic sine of the specified angle</td>
</tr>
<tr class="even">
<td>Sqrt</td>
<td>Static method</td>
<td>double / double</td>
<td>Square root of a specified number</td>
</tr>
<tr class="odd">
<td>Tan</td>
<td>Static method</td>
<td>double / double</td>
<td>Tangent of the specified angle</td>
</tr>
<tr class="even">
<td>Tanh</td>
<td>Static method</td>
<td>double / double</td>
<td>Hyperbolic tangent of the specified angle</td>
</tr>
</tbody>
</table>

In PowerShell, `Math` maps to `System.Math`.

### 4.3.9 The ordered type

Type `ordered` is a pseudo type used only for conversions.

### 4.3.10 The pscustomobject type

Type `pscustomobject` is a pseudo type used only for conversions.

## 4.4 Generic types

A number of programming languages and environments provide types that can be _specialized_.  Many of
these types are referred to as _container types_,  as instances of them are able to contain objects
of some other type. Consider a type called Stack that can represent a stack of values, which can be
pushed on and popped off. Typically, the user of a stack wants to store only one kind of object on
that stack. However, if the language or environment does not support type specialization, multiple
distinct variants of the type Stack must be implemented even though they all perform the same task,
just with different type elements.

Type specialization allows a _generic type_ to be implemented such that it can be constrained to
handling some subset of types when it is used. For example,

- A generic stack type that is specialized to hold strings might be written as `Stack[string]`.
- A generic dictionary type that is specialized to hold int keys with associated string values might
  be written as `Dictionary[int,string]`.
- A stack of stack of strings might be written as `Stack[Stack[string]]`.

Although PowerShell does not define any built-in generic types, it can use such types if they are
provided by the host environment. See the syntax in [§7.1.10][§7.1.10].

The complete name for the type `Stack[string]` suggested above is
`System.Collections.Generic.Stack[string]`. The complete name for the type `Dictionary[int,string]`
suggested above is `System.Collections.Generic.Dictionary[int,string]`.

## 4.5 Anonymous types

In some circumstances, an implementation of PowerShell creates objects of some type, and those
objects have members accessible to script. However, the actual name of those types need not be
specified, so long as the accessible members are specified sufficiently for them to be used. That
is, scripts can save objects of those types and access their members without actually knowing those
types' names. The following subsections specify these types.

### 4.5.1 Provider description type

This type encapsulates the state of a provider. It has the following accessible members:

| **Member** |        **Member Kind**        |              **Type**               |                **Purpose**                |
| ---------- | ----------------------------- | ----------------------------------- | ----------------------------------------- |
| Drives     | Instance property (read-only) | Implementation defined ([§4.5.2][§4.5.2]) | A collection of drive description objects |
| Name       | Instance property (read-only) | string                              | The name of the provider                  |

In PowerShell, this type is `System.Management.Automation.ProviderInfo`.

### 4.5.2 Drive description type

This type encapsulates the state of a drive. It has the following accessible members:

|   **Member**    |        **Member Kind**         | **Type** |                      **Purpose**                       |
| --------------- | ------------------------------ | -------- | ------------------------------------------------------ |
| CurrentLocation | Instance property (read-write) | string   | The current working location ([§3.1.4][§3.1.4]) of the drive |
| Description     | Instance property (read-write) | string   | The description of the drive                           |
| Name            | Instance property (read-only)  | string   | The name of the drive                                  |
| Root            | Instance property (read-only)  | string   | The name of the drive                                  |

In PowerShell, this type is `System.Management.Automation.PSDriveInfo`.

### 4.5.3 Variable description type

This type encapsulates the state of a variable. It has the following accessible members:

| **Member**  |        **Member Kind**         |               **Type**               |                                                                                        **Purpose**                                                                                         |
| ----------- | ------------------------------ | ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Attributes  | Instance property (read-only)  | Implementation defined               | A collection of attributes                                                                                                                                                                 |
| Description | Instance property (read-write) | string                               | The description assigned to the variable via the [New-Variable](xref:Microsoft.PowerShell.Utility.New-Variable) or [Set-Variable](xref:Microsoft.PowerShell.Utility.Set-Variable) cmdlets. |
| Module      | Instance property (read-only)  | Implementation defined ([§4.5.12][§4.5.12]) | The module from which this variable was exported                                                                                                                                           |
| ModuleName  | Instance property (read-only)  | string                               | The module in which this variable was defined                                                                                                                                              |
| Name        | Instance property (read-only)  | string                               | The name assigned to the variable when it was created in the PowerShell language or via the `New-Variable` and `Set-Variable` cmdlets.                                                     |
| Options     | Instance property (read-write) | string                               | The options assigned to the variable via the `New-Variable` and `Set-Variable` cmdlets.                                                                                                    |
| Value       | Instance property (read-write) | object                               | The value assigned to the variable when it was assigned in the PowerShell language or via the `New-Variable` and `Set-Variable` cmdlets.                                                   |

In PowerShell, this type is `System.Management.Automation.PSVariable`.

Windows PowerShell: The type of the attribute collection is
System.Management.Automation.PSVariableAttributeCollection.

### 4.5.4 Alias description type

This type encapsulates the state of an alias. It has the following accessible members:

|    **Member**     |        **Member Kind**         |               **Type**               |                                                                                        **Purpose**                                                                                         |
| ----------------- | ------------------------------ | ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| CommandType       | Instance property (read-only)  | Implementation defined               | Should compare equal with "Alias".                                                                                                                                                         |
| Definition        | Instance property (read-only)  | string                               | The command or alias to which the alias was assigned via the [New-Alias](xref:Microsoft.PowerShell.Utility.New-Alias) or [Set-Alias](xref:Microsoft.PowerShell.Utility.Set-Alias) cmdlets. |
| Description       | Instance property (read-write) | string                               | The description assigned to the alias via the `New-Alias` or `Set-Alias` cmdlets.                                                                                                          |
| Module            | Instance property (read-only)  | Implementation defined ([§4.5.12][§4.5.12]) | The module from which this alias was exported                                                                                                                                              |
| ModuleName        | Instance property (read-only)  | string                               | The module in which this alias was defined                                                                                                                                                 |
| Name              | Instance property (read-only)  | string                               | The name assigned to the alias when it was created via the `New-Alias` or `Set-Alias` cmdlets.                                                                                             |
| Options           | Instance property (read-write) | string                               | The options assigned to the alias via the New-Alias `New-Alias` or `Set-Alias` cmdlets.                                                                                                    |
| OutputType        | Instance property (read-only)  | Implementation defined collection    | Specifies the types of the values output by the command to which the alias refers.                                                                                                         |
| Parameters        | Instance property (read-only)  | Implementation defined collection    | The parameters of the command.                                                                                                                                                             |
| ParameterSets     | Instance property (read-only)  | Implementation defined collection    | Information about the parameter sets associated with the command.                                                                                                                          |
| ReferencedCommand | Instance property (read-only)  | Implementation defined               | Information about the command that is immediately referenced by this alias.                                                                                                                |
| ResolvedCommand   | Instance property (read-only)  | Implementation defined               | Information about the command to which the alias eventually resolves.                                                                                                                      |

In PowerShell, this type is `System.Management.Automation.AliasInfo`.

### 4.5.5 Working location description type

This type encapsulates the state of a working location. It has the following accessible members:

|  **Member**  |        **Member Kind**        |              **Type**               |           **Purpose**            |
| ------------ | ----------------------------- | ----------------------------------- | -------------------------------- |
| Drive        | Instance property (read-only) | Implementation defined ([§4.5.2][§4.5.2]) | A drive description object       |
| Path         | Instance property (read-only) | string                              | The working location             |
| Provider     | Instance property (read-only) | Implementation defined ([§4.5.1][§4.5.1]) | The provider                     |
| ProviderPath | Instance property (read-only) | string                              | The current path of the provider |

A stack of working locations is a collection of working location objects, as described above.

In PowerShell, a current working location is represented by an object of type
`System.Management.Automation.PathInfo`. A stack of working locations is represented by an object of
type `System.Management.Automation.PathInfoStack`, which is a collection of `PathInfo` objects.

### 4.5.6 Environment variable description type

This type encapsulates the state of an environment variable. It has the following accessible
members:

| **Member** |        **Member Kind**         | **Type** |              **Purpose**              |
| ---------- | ------------------------------ | -------- | ------------------------------------- |
| Name       | Instance property (read-write) | string   | The name of the environment variable  |
| Value      | Instance property (read-write) | string   | The value of the environment variable |

In PowerShell, this type is `System.Collections.DictionaryEntry`. The name of the variable is the
dictionary key. The value of the environment variable is the dictionary value. **Name** is an
`AliasProperty` that equates to **Key**.

### 4.5.7 Application description type

This type encapsulates the state of an application. It has the following accessible members:

|  **Member**   |        **Member Kind**         |               **Type**               |                            **Purpose**                            |
| ------------- | ------------------------------ | ------------------------------------ | ----------------------------------------------------------------- |
| CommandType   | Instance property (read-only)  | Implementation defined               | Should compare equal with "Application".                          |
| Definition    | Instance property (read-only)  | string                               | A description of the application.                                 |
| Extension     | Instance property (read-write) | string                               | The extension of the application file.                            |
| Module        | Instance property (read-only)  | Implementation defined ([§4.5.12][§4.5.12]) | The module that defines this command.                             |
| ModuleName    | Instance property (read-only)  | string                               | The name of the module that defines the command.                  |
| Name          | Instance property (read-only)  | string                               | The name of the command.                                          |
| OutputType    | Instance property (read-only)  | Implementation defined collection    | Specifies the types of the values output by the command.          |
| Parameters    | Instance property (read-only)  | Implementation defined collection    | The parameters of the command.                                    |
| ParameterSets | Instance property (read-only)  | Implementation defined collection    | Information about the parameter sets associated with the command. |
| Path          | Instance property (read-only)  | string                               | Gets the path of the application file.                            |

In PowerShell, this type is `System.Management.Automation.ApplicationInfo`.

### 4.5.8 Cmdlet description type

This type encapsulates the state of a cmdlet. It has the following accessible members:

|     **Member**      |        **Member Kind**         |               **Type**               |                                                            **Purpose**                                                            |
| ------------------- | ------------------------------ | ------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------- |
| CommandType         | Instance property (read-only)  | Implementation defined               | Should compare equal with "Cmdlet".                                                                                               |
| DefaultParameterSet | Instance property (read-only)  | Implementation defined               | The default parameter set that is used if PowerShell cannot determine which parameter set to use based on the supplied arguments. |
| Definition          | Instance property (read-only)  | string                               | A description of the cmdlet.                                                                                                      |
| HelpFile            | Instance property (read-write) | string                               | The path to the Help file for the cmdlet.                                                                                         |
| ImplementingType    | Instance property (read-write) | Implementation defined               | The type that implements the cmdlet.                                                                                              |
| Module              | Instance property (read-only)  | Implementation defined ([§4.5.12][§4.5.12]) | The module that defines this cmdlet.                                                                                              |
| ModuleName          | Instance property (read-only)  | string                               | The name of the module that defines the cmdlet.                                                                                   |
| Name                | Instance property (read-only)  | string                               | The name of the cmdlet.                                                                                                           |
| Noun                | Instance property (read-only)  | string                               | The noun name of the cmdlet.                                                                                                      |
| OutputType          | Instance property (read-only)  | Implementation defined collection    | Specifies the types of the values output by the cmdlet.                                                                           |
| Parameters          | Instance property (read-only)  | Implementation defined collection    | The parameters of the cmdlet.                                                                                                     |
| ParameterSets       | Instance property (read-only)  | Implementation defined collection    | Information about the parameter sets associated with the cmdlet.                                                                  |
| Verb                | Instance property (read-only)  | string                               | The verb name of the cmdlet.                                                                                                      |
| PSSnapIn            | Instance property (read-only)  | Implementation defined               | Windows PowerShell: Information about the Windows PowerShell snap-in that is used to register the cmdlet.                         |

In PowerShell, this type is `System.Management.Automation.CmdletInfo`.

### 4.5.9 External script description type

This type encapsulates the state of an external script (one that is directly executable by
PowerShell, but is not built-in). It has the following accessible members:

|    **Member**    |        **Member Kind**        |               **Type**               |                                 **Purpose**                                  |
| ---------------- | ----------------------------- | ------------------------------------ | ---------------------------------------------------------------------------- |
| CommandType      | Instance property (read-only) | Implementation defined               | Should compare equal with "ExternalScript".                                  |
| Definition       | Instance property (read-only) | string                               | A definition of the script.                                                  |
| Module           | Instance property (read-only) | Implementation defined ([§4.5.12][§4.5.12]) | The module that defines this script.                                         |
| ModuleName       | Instance property (read-only) | string                               | The name of the module that defines the script.                              |
| Name             | Instance property (read-only) | string                               | The name of the script.                                                      |
| OriginalEncoding | Instance property (read-only) | Implementation defined               | The original encoding used to convert the characters of the script to bytes. |
| OutputType       | Instance property (read-only) | Implementation defined collection    | Specifies the types of the values output by the script.                      |
| Parameters       | Instance property (read-only) | Implementation defined collection    | The parameters of the script.                                                |
| ParameterSets    | Instance property (read-only) | Implementation defined collection    | Information about the parameter sets associated with the script.             |
| Path             | Instance property (read-only) | string                               | The path to the script file.                                                 |
| ScriptBlock      | Instance property (read-only) | scriptblock                          | The external script.                                                         |
| ScriptContents   | Instance property (read-only) | string                               | The original contents of the script.                                         |

In PowerShell, this type is `System.Management.Automation.ExternalScriptInfo`.

### 4.5.10 Function description type

This type encapsulates the state of a function. It has the following accessible members:

|     **Member**      |        **Member Kind**         |               **Type**               |                                                                                                                                                                      **Purpose**                                                                                                                                                                      |
| ------------------- | ------------------------------ | ------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| CmdletBinding       | Instance property (read-only)  | bool                                 | Indicates whether the function uses the same parameter binding that compiled cmdlets use (see [§12.3.5][§12.3.5]).                                                                                                                                                                                                                                           |
| CommandType         | Instance property (read-only)  | Implementation defined               | Can be compared for equality with "Function" or "Filter" to see which of those this object represents.                                                                                                                                                                                                                                                |
| DefaultParameterSet | Instance property (read-only)  | string                               | Specifies the parameter set to use if that cannot be determined from the arguments (see [§12.3.5][§12.3.5]).                                                                                                                                                                                                                                                 |
| Definition          | Instance property (read-only)  | string                               | A string version of ScriptBlock                                                                                                                                                                                                                                                                                                                       |
| Description         | Instance property (read-write) | string                               | The description of the function.                                                                                                                                                                                                                                                                                                                      |
| Module              | Instance property (read-only)  | Implementation defined ([§4.5.12][§4.5.12]) | The module from which this function was exported                                                                                                                                                                                                                                                                                                      |
| ModuleName          | Instance property (read-only)  | string                               | The module in which this function was defined                                                                                                                                                                                                                                                                                                         |
| Name                | Instance property (read-only)  | string                               | The name of the function                                                                                                                                                                                                                                                                                                                              |
| Options             | Instance property (read-write) | Implementation defined               | The scope options for the function ([§3.5.4][§3.5.4]).                                                                                                                                                                                                                                                                                                      |
| OutputType          | Instance property (read-only)  | Implementation defined collection    | Specifies the types of the values output, in order (see [§12.3.6][§12.3.6]).                                                                                                                                                                                                                                                                                 |
| Parameters          | Instance property (read-only)  | Implementation defined collection    | Specifies the parameter names, in order. If the function acts like a cmdlet (see CmdletBinding above) the [common parameters][common parameters] are included at the end of the collection.                                                                                                                                                                            |
| ParameterSets       | Instance property (read-only)  | Implementation defined collection    | Information about the parameter sets associated with the command. For each parameter, the result shows the parameter name and type, and indicates if the parameter is mandatory, by position or a switch parameter. If the function acts like a cmdlet (see CmdletBinding above) the [common parameters][common parameters] are included at the end of the collection. |
| ScriptBlock         | Instance property (read-only)  | scriptblock ([§4.3.6][§4.3.6])             | The body of the function                                                                                                                                                                                                                                                                                                                              |

In PowerShell, this type is `System.Management.Automation.FunctionInfo`.

- `CommandType` has type `System.Management.Automation.CommandTypes`.
- `Options` has type `System.Management.Automation.ScopedItemOptions`.
- `OutputType` has type
  `System.Collections.ObjectModel.ReadOnlyCollection``1[[System.Management.Automation.PSTypeName,System.Management.Automation]]`.
- `Parameters` has type
  `System.Collections.Generic.Dictionary``2[[System.String,mscorlib],[System.Management.Automation.ParameterMetadata,System.Management.Automation]]`.
- `ParameterSets` has type
  `System.Collections.ObjectModel.ReadOnlyCollection``1[[System.Management.Automation.CommandParameterSetInfo,System.Management.Automation]]`.
- Visibility has type `System.Management.Automation.SessionStateEntryVisibility`.
- PowerShell also has a property called **Visibility**.

### 4.5.11 Filter description type

This type encapsulates the state of a filter. It has the same set of accessible members as the
function description type ([§4.5.10][§4.5.10]).

In PowerShell, this type is `System.Management.Automation.FilterInfo`. It has the same set of
properties as `System.Management.Automation.FunctionInfo` ([§4.5.11][§4.5.11]).

### 4.5.12 Module description type

This type encapsulates the state of a module. It has the following accessible members:

| **Member**  |        **Member Kind**         |        **Type**        |                     **Purpose**                      |
| ----------- | ------------------------------ | ---------------------- | ---------------------------------------------------- |
| Description | Instance property (read-write) | string                 | The description of the module (set by the manifest)  |
| ModuleType  | Instance property (read-only)  | Implementation defined | The type of the module (Manifest, Script, or Binary) |
| Name        | Instance property (read-only)  | string                 | The name of the module                               |
| Path        | Instance property (read-only)  | string                 | The module's path                                    |

In PowerShell, this type is `System.Management.Automation.PSModuleInfo`. The type of `ModuleType` is
`System.Management.Automation.ModuleType`.

### 4.5.13 Custom object description type

This type encapsulates the state of a custom object. It has no accessible members.

In PowerShell, this type is `System.Management.Automation.PSCustomObject`. The cmdlets
`Import-Module` and `New-Object` can generate an object of this type.

### 4.5.14 Command description type

The automatic variable `$PsCmdlet` is an object that represents the cmdlet or function being
executed. The type of this object is implementation defined; it has the following accessible
members:

<table>
<thead>
<tr class="header">
<th><strong>Member</strong></th>
<th><strong>Member Kind</strong></th>
<th><strong>Type</strong></th>
<th><strong>Purpose</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>ParameterSetName</td>
<td>Instance property (read-only)</td>
<td>string</td>
<td>Name of the current parameter set (see ParameterSetName)</td>
</tr>
<tr class="even">
<td>ShouldContinue</td>
<td>Instance method</td>
<td><p>Overloaded</p>
<p>/bool</p></td>
<td>Requests confirmation of an operation from the user.</td>
</tr>
<tr class="odd">
<td>ShouldProcess</td>
<td>Instance method</td>
<td><p>Overloaded</p>
<p>/bool</p></td>
<td>Requests confirmation from the user before an operation is performed.</td>
</tr>
</tbody>
</table>

In PowerShell, this type is System.Management.Automation.PSScriptCmdlet.

### 4.5.15 Error record description type

The automatic variable `$Error` contains a collection of error records that represent recent errors
([§3.12][§3.12]). Although the type of this collection is unspecified, it does support subscripting
to get access to individual error records.

In PowerShell, the collection type is `System.Collections.ArrayList`. The type of an individual
error record in the collection is `System.Management.Automation.ErrorRecord`. This type has the
following public properties:

- CategoryInfo - Gets information about the category of the error.
- ErrorDetails - Gets and sets more detailed error information, such as a replacement error message.
- Exception - Gets the exception that is associated with this error record.
- FullyQualifiedErrorId - Gets the fully qualified error identifier for this error record.
- InvocationInfo - Gets information about the command that was invoked when the error occurred.
- PipelineIterationInfo - Gets the status of the pipeline when this error record was created
- TargetObject - Gets the object that was being processed when the error occurred.

### 4.5.16 Enumerator description type

A number of variables are enumerators for collections (§4). The automatic variable `$foreach` is the
enumerator created for any `foreach` statement. The automatic variable `$input` is the enumerator
for a collection delivered to a function from the pipeline. The automatic variable `$switch` is the
enumerator created for any `switch` statement.

The type of an enumerator is implementation defined; it has the
following accessible members:

| **Member** |        **Member Kind**        | **Type**  |                                                                                                 **Purpose**                                                                                                  |
| ---------- | ----------------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Current    | Instance property (read-only) | object    | Gets the current element in the collection. If the enumerator is not currently positioned at an element of the collection, the behavior is implementation defined.                                           |
| MoveNext   | Instance method               | None/bool | Advances the enumerator to the next element of the collection. Returns $true if the enumerator was successfully advanced to the next element; $false if the enumerator has passed the end of the collection. |

In PowerShell, these members are defined in the interface `System.IEnumerator`, which is implemented
by the types identified below. If the enumerator is not currently positioned at an element of the
collection, an exception of type `InvalidOperationException` is raised. For `$foreach`, this type is
`System.Array+SZArrayEnumerator`. For `$input`, this type is
`System.Collections.ArrayList+ArrayListEnumeratorSimple`. For `$switch`, this type is
`System.Array+SZArrayEnumerator`.

### 4.5.17 Directory description type

The cmdlet [New-Item](xref:Microsoft.PowerShell.Management.New-Item) can create items of various
kinds including FileSystem directories. The type of a directory description object is implementation
defined; it has the following accessible members:

|  **Member**   |        **Member Kind**         |               **Type**                |                             **Purpose**                             |
| ------------- | ------------------------------ | ------------------------------------- | ------------------------------------------------------------------- |
| Attributes    | Instance property (read-write) | Implementation defined ([§4.2.6.3][§4.2.6.3]) | Gets or sets one or more of the attributes of the directory object. |
| CreationTime  | Instance property (read-write) | Implementation defined ([§4.5.19][§4.5.19])  | Gets and sets the creation time of the directory object.            |
| Extension     | Instance property (read- only) | string                                | Gets the extension part of the directory name.                      |
| FullName      | Instance property (read-only)  | string                                | Gets the full path of the directory.                                |
| LastWriteTime | Instance property (read-write) | Implementation defined ([§4.5.19][§4.5.19])  | Gets and sets the time when the directory was last written to.      |
| Name          | Instance property (read- only) | string                                | Gets the name of the directory.                                     |

In PowerShell, this type is `System.IO.DirectoryInfo`. The type of the **Attributes** property is
`System.IO.FileAttributes`.

### 4.5.18 File description type

The cmdlet `New-Item` can create items of various kinds including FileSystem files. The type of a
file description object is implementation defined; it has the following accessible members:

|  **Member**   |        **Member Kind**         |               **Type**                |                                            **Purpose**                                             |
| ------------- | ------------------------------ | ------------------------------------- | -------------------------------------------------------------------------------------------------- |
| Attributes    | Instance property (read-write) | Implementation defined ([§4.2.6.3][§4.2.6.3]) | Gets or sets one or more of the attributes of the file object.                                     |
| BaseName      | Instance property (read- only) | string                                | Gets the name of the file excluding the extension.                                                 |
| CreationTime  | Instance property (read-write) | Implementation defined ([§4.5.19][§4.5.19])  | Gets and sets the creation time of the file object.                                                |
| Extension     | Instance property (read- only) | string                                | Gets the extension part of the file name.                                                          |
| FullName      | Instance property (read-only)  | string                                | Gets the full path of the file.                                                                    |
| LastWriteTime | Instance property (read-write) | Implementation defined ([§4.5.19][§4.5.19])  | Gets and sets the time when the file was last written to.                                          |
| Length        | Instance property (read- only) | long                                  | Gets the size of the file, in bytes.                                                               |
| Name          | Instance property (read- only) | string                                | Gets the name of the file.                                                                         |
| VersionInfo   | Instance property (read- only) | Implementation defined                | Windows PowerShell: This ScriptProperty returns a System.Diagnostics.FileVersionInfo for the file. |

In PowerShell, this type is `System.IO.FileInfo`.

### 4.5.19 Date-Time description type

The type of a date-time description object is implementation defined; it has the following
accessible members:

| **Member** |        **Member Kind**        | **Type** |                             **Purpose**                              |
| ---------- | ----------------------------- | -------- | -------------------------------------------------------------------- |
| Day        | Instance property (read-only) | int      | Gets the day component of the month represented by this instance.    |
| Hour       | Instance property (read-only) | int      | Gets the hour component of the date represented by this instance.    |
| Minute     | Instance property (read-only) | int      | Gets the minute component of the date represented by this instance.  |
| Month      | Instance property (read-only) | int      | Gets the month component of the date represented by this instance.   |
| Second     | Instance property (read-only) | int      | Gets the seconds component of the date represented by this instance. |
| Year       | Instance property (read-only) | int      | Gets the year component of the date represented by this instance.    |

An object of this type can be created by cmdlet [Get-Date](xref:Microsoft.PowerShell.Utility.Get-Date).

In PowerShell, this type is `System.DateTime`.

### 4.5.20 Group-Info description type

The type of a **group-info** description object is implementation defined; it has the following
accessible members:

| Member |          Member Kind          |               Type                |                    Purpose                    |
| ------ | ----------------------------- | --------------------------------- | --------------------------------------------- |
| Count  | Instance property (read-only) | int                               | Gets the number of elements in the group.     |
| Group  | Instance property (read-only) | Implementation-defined collection | Gets the elements of the group.               |
| Name   | Instance property (read-only) | string                            | Gets the name of the group.                   |
| Values | Instance property (read-only) | Implementation-defined collection | Gets the values of the elements of the group. |

An object of this type can be created by cmdlet [Group-Object](xref:Microsoft.PowerShell.Utility.Group-Object).

In PowerShell, this type is `Microsoft.PowerShell.Commands.GroupInfo`.

### 4.5.21 Generic-Measure-Info description type

The type of a **generic-measure-info** description object is implementation defined; it has the
following accessible members:

| **Member** |        **Member Kind**        | **Type** |                             **Purpose**                             |
| ---------- | ----------------------------- | -------- | ------------------------------------------------------------------- |
| Average    | Instance property (read-only) | double   | Gets the average of the values of the properties that are measured. |
| Count      | Instance property (read-only) | int      | Gets the number of objects with the specified properties.           |
| Maximum    | Instance property (read-only) | double   | Gets the maximum value of the specified properties.                 |
| Minimum    | Instance property (read-only) | double   | Gets the minimum value of the specified properties.                 |
| Property   | Instance property (read-only) | string   | Gets the property to be measured.                                   |
| Sum        | Instance property (read-only) | double   | Gets the sum of the values of the specified properties.             |

An object of this type can be created by cmdlet [Measure-Object](xref:Microsoft.PowerShell.Utility.Measure-Object).

In PowerShell, this type is `Microsoft.PowerShell.Commands.GenericMeasureInfo`.

### 4.5.22 Text-Measure-Info description type

The type of a **text-info** description object is implementation defined; it has the following
accessible members:

| **Member** |        **Member Kind**        | **Type** |                     **Purpose**                     |
| ---------- | ----------------------------- | -------- | --------------------------------------------------- |
| Characters | Instance property (read-only) | int      | Gets the number of characters in the target object. |
| Lines      | Instance property (read-only) | int      | Gets the number of lines in the target object.      |
| Property   | Instance property (read-only) | string   | Gets the property to be measured.                   |
| Words      | Instance property (read-only) | int      | Gets the number of words in the target object.      |

An object of this type can be created by cmdlet `Measure-Object`.

In PowerShell, this type is `Microsoft.PowerShell.Commands.TextMeasureInfo`.

### 4.5.23 Credential type

A credential object can then be used in various security operations. The type of a credential object
is implementation defined; it has the following accessible members:

|  Member  |          Member Kind          |          Type          |      Purpose       |
| -------- | ----------------------------- | ---------------------- | ------------------ |
| Password | Instance property (read-only) | Implementation defined | Gets the password. |
| UserName | Instance property (read-only) | string                 | Gets the username. |

An object of this type can be created by cmdlet [Get-Credential](xref:Microsoft.PowerShell.Security.Get-Credential).

In PowerShell, this type is `System.Management.Automation.PSCredential`.

### 4.5.24 Method designator type

The type of a method designator is implementation defined; it has the
following accessible members:

| **Member** | **Member Kind** |            **Type**             |                                                                 **Purpose**                                                                  |
| ---------- | --------------- | ------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| Invoke     | Instance method | object/variable number and type | Takes a variable number of arguments, and indirectly calls the method referred to by the parent method designator, passing in the arguments. |

An object of this type can be created by an _invocation-expression_ ([§7.1.3][§7.1.3]).

In PowerShell, this type is System.Management.Automation.PSMethod.

### 4.5.25 Member definition type

This type encapsulates the definition of a member. It has the following accessible members:

| **Member** |        **Member Kind**        |        **Type**        |               **Purpose**               |
| ---------- | ----------------------------- | ---------------------- | --------------------------------------- |
| Definition | Instance property (read-only) | string                 | Gets the definition of the member.      |
| MemberType | Instance property (read-only) | Implementation defined | Gets the PowerShell type of the member. |
| Name       | Instance property (read-only) | string                 | Gets the name of the member.            |
| TypeName   | Instance property (read-only) | string                 | Gets the type name of the member.       |

In PowerShell, this type is `Microsoft.PowerShell.Commands.MemberDefinition`.

## 4.6 Type extension and adaptation

A PowerShell implementation includes a family of core types (which are documented in this chapter)
that each contain their own set of _base members_.  Those members can be methods or properties, and
they can be instance or static members. For example, the base members of the type string
([§4.3.1][§4.3.1]) are the instance property Length and the instance methods ToLower and ToUpper.

When an object is created, it contains all the instance properties of that object's type, and the
instance methods of that type can be called on that object. An object may be customized via the
addition of instance members at runtime. The result is called a _custom object_.  Any members added
to an instance exist only for the life of that instance; other instances of the same core type are
unaffected.

The base member set of a type can be augmented by the addition of the following kinds of members:

- _adapted members_,  via the _Extended Type System_ (ETS), most details of which are unspecified.
- _extended members_,  via the cmdlet [Add-Member](xref:Microsoft.PowerShell.Utility.Add-Member).

In PowerShell, extended members can also be added via `types.ps1xml` files. Adapted and extended
members are collectively called **synthetic** _members_.

The ETS adds the following members to all PowerShell objects: **psbase**, **psadapted**,
**psextended**, and **pstypenames**. See the **Force** and **View** parameters in the cmdlet
[Get-Member](xref:Microsoft.PowerShell.Utility.Get-Member) for more information on these members.

An instance member may hide an extended and/or adapted member of the same name, and an extended
member may hide an adapted member. In such cases, the member sets **psadapted** and **psextended**
can be used to access those hidden members.

If a `types.ps1xml` specifies a member called **Supports**, `obj.psextended` provides access to just
that member and not to a member added via `Add-Member`.

There are three ways create a custom object having a new member M:

1. This approach can be used to add one or more NoteProperty members.

   ```powershell
   $x = New-Object PSObject -Property @{M = 123}
   ```

1. This approach can be used to add NoteProperty or ScriptMethod members.

   ```powershell
   $x = New-Module -AsCustomObject {$M = 123 ; Export-ModuleMember --Variable M}
   ```

1. This approach can be used to add any kind of member.

   ```powershell
   $x = New-Object PSObject
   Add-Member -InputObject $x -Name M -MemberType NoteProperty -Value 123
   ```

`PSObject` is the base type of all PowerShell types.

<!-- reference links -->
[§12.3.5]: chapter-12.md#1235-the-cmdletbinding-attribute
[§12.3.6]: chapter-12.md#1236-the-outputtype-attribute
[§2.3.2.2]: chapter-02.md#2322-automatic-variables
[§3.1.4]: chapter-03.md#314-functions
[§3.12]: chapter-03.md#312-error-handling
[§3.5.4]: chapter-03.md#354-function-name-scope
[§4.1.2]: chapter-04.md#412-the-null-type
[§4.2.1]: chapter-04.md#421-boolean
[§4.2.2]: chapter-04.md#422-character
[§4.2.3]: chapter-04.md#423-integer
[§4.2.4]: chapter-04.md#424-real-number
[§4.2.6.3]: chapter-04.md#4263-file-attributes-type
[§4.3.1]: chapter-04.md#431-strings
[§4.3.6]: chapter-04.md#436-the-ref-type
[§4.5.1]: chapter-04.md#451-provider-description-type
[§4.5.10]: chapter-04.md#4510-function-description-type
[§4.5.11]: chapter-04.md#4511-filter-description-type
[§4.5.12]: chapter-04.md#4512-module-description-type
[§4.5.16]: chapter-04.md#4516-enumerator-description-type
[§4.5.19]: chapter-04.md#4519-date-time-description-type
[§4.5.2]: chapter-04.md#452-drive-description-type
[§5.3]: chapter-05.md#53-constrained-variables
[§7.1.10]: chapter-07.md#7110-type-literal-expression
[§7.1.3]: chapter-07.md#713-invocation-expressions
[§7.1.4.4]: chapter-07.md#7144-subscripting-an-xml-document
[§7.1.8]: chapter-07.md#718-script-block-expression
[§7.2.9]: chapter-07.md#729-cast-operator
[§7.8.5]: chapter-07.md#785-shift-operators
[§8.10.5]: chapter-08.md#8105-the-switch-type-constraint
[§8.4.4]: chapter-08.md#844-the-foreach-statement
[§9.]: chapter-09.md#9-arrays
[common parameters]: /powershell/module/microsoft.powershell.core/about/about_commonparameters
