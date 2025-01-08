---
description: A type conversion is performed when a value of one type is used in a context that requires a different type.
ms.date: 05/19/2021
title: Conversions
---
# 6. Conversions

[!INCLUDE [Disclaimer](../../includes/language-spec.md)]

A *type conversion* is performed when a value of one type is used in a context that requires a
different type. If such a conversion happens automatically it is known as *implicit conversion*. (A
common example of this is with some operators that need to convert one or more of the values
designated by their operands.) Implicit conversion is permitted provided the sense of the source
value is preserved, such as no loss of precision of a number when it is converted.

The cast operator ([§7.2.9][§7.2.9]) allows for *explicit conversion*.

Conversions are discussed below, with supplementary information being provided as necessary in the
description of each operator in [§6.19][§6.19].

Explicit conversion of a value to the type it already has causes no change to that value or its
representation.

The rules for handing conversion when the value of an expression is being bound to a parameter are
covered in [§6.17][§6.17].

## 6.1 Conversion to void

A value of any type can be discarded explicitly by casting it to type void. There is no result.

## 6.2 Conversion to bool

The rules for converting any value to type bool are as follows:

- A numeric or char value of zero is converted to False; a numeric or char value of non-zero is
  converted to True.
- A value of null type is converted to False.
- A string of length 0 is converted to False; a string of length > 0 is converted to True.
- A switch parameter with value `$true` is converted to True, and one with value `$false` is
  converted to False.
- All other non-null reference type values are converted to True.

If the type implements IList:

- If the object's Length > 2, the value is converted to True.
- If the object's Length is 1 and that first element is not itself an IList, then if that element's
  value is true, the value is converted to True.
- Otherwise, if the first element's Count >= 1, the value is converted to True.
- Otherwise, the value is converted to False.

## 6.3 Conversion to char

The rules for converting any value to type char are as follows:

- The conversion of a value of type bool, decimal, float, or double is in error.
- A value of null type is converted to the null (U+0000) character.
- An integer type value whose value can be represented in type char has that value; otherwise, the
  conversion is in error.
- The conversion of a string value having a length other than 1 is in error.
- A string value having a length 1 is converted to a char having that one character's value.
- A numeric type value whose value after rounding of any fractional part can be represented in the
  destination type has that rounded value; otherwise, the conversion is in error.
- For other reference type values, if the reference type supports such a conversion, that conversion
  is used; otherwise, the conversion is in error.

## 6.4 Conversion to integer

The rules for converting any value to type byte, int, or long are as
follows:

- The bool value False is converted to zero; the bool value True is converted to 1.
- A char type value whose value can be represented in the destination type has that value;
  otherwise, the conversion is in error.
- A numeric type value whose value after rounding of any fractional part can be represented in the
  destination type has that rounded value; otherwise, the conversion is in error.
- A value of null type is converted to zero.
- A string that represents a number is converted as described in [§6.16][§6.16]. If after truncation of
  the fractional part the result can be represented in the destination type the string is well
  formed and it has the destination type; otherwise, the conversion is in error. If the string does
  not represent a number, the conversion is in error.
- For other reference type values, if the reference type supports such a conversion, that conversion
  is used; otherwise, the conversion is in error.

## 6.5 Conversion to float and double

The rules for converting any value to type float or double are as
follows:

- The bool value False is converted to zero; the bool value True is converted to 1.
- A char value is represented exactly.
- A numeric type value is represented exactly, if possible; however, for int, long, and decimal
  conversions to float, and for long and decimal conversions to double, some of the least
  significant bits of the integer value may be lost.
- A value of null type is converted to zero.
- A string that represents a number is converted as described in [§6.16][§6.16]; otherwise, the
  conversion is in error.
- For other reference type values, if the reference type supports such a conversion, that conversion
  is used; otherwise, the conversion is in error.

## 6.6 Conversion to decimal

The rules for converting any value to type decimal are as follows:

- The bool value False is converted to zero; the bool value True is converted to 1.
- A char type value is represented exactly.
- A numeric type value is represented exactly; however, if that value is too large or too small to
  fit in the destination type, the conversion is in error.
- A value of null type is converted to zero.
- A string that represents a number is converted as described in [§6.16][§6.16]; otherwise, the
  conversion is in error.
- For other reference type values, if the reference type supports such a conversion, that conversion
  is used; otherwise, the conversion is in error.
- The scale of the result of a successful conversion is such that the fractional part has no
  trailing zeros.

## 6.7 Conversion to object

The value of any type except the null type (4.1.2) can be converted to type object. The value
retains its type and representation.

## 6.8 Conversion to string

The rules for converting any value to type string are as follows:

- The bool value `$false` is converted to "False"; the bool value `$true` is converted to "True".
- A char type value is converted to a 1-character string containing that char.
- A numeric type value is converted to a string having the form of a corresponding numeric literal.
  However, the result has no leading or trailing spaces, no leading plus sign, integers have base
  10, and there is no type suffix. For a decimal conversion, the scale is preserved. For values of
  -∞, +∞, and NaN, the resulting strings are "-Infinity", "Infinity", and "NaN", respectively.
- A value of null type is converted to the empty string.
- For a 1-dimensional array, the result is a string containing the value of each element in that
  array, from start to end, converted to string, with elements being separated by the current Output
  Field Separator ([§2.3.2.2][§2.3.2.2]). For an array having elements that are themselves arrays, only the
  top-level elements are converted. The string used to represent the value of an element that is an
  array, is implementation defined. For a multi-dimensional array, it is flattened ([§9.12][§9.12]) and
  then treated as a 1‑dimensional array.
- A value of null type is converted to the empty string.
- A scriptblock type value is converted to a string containing the text of that block without the
  delimiting { and } characters.
- For an enumeration type value, the result is a string containing the name of each enumeration
  constant encoded in that value, separated by commas.
- For other reference type values, if the reference type supports such a conversion, that conversion
  is used; otherwise, the conversion is in error.

The string used to represent the value of an element that is an array has the form `System.type[]`,
`System.type[,]`, and so on. For other reference types, the method `ToString` is called. For other
enumerable types, the source value is treated like a 1-dimensional array.

## 6.9 Conversion to array

The rules for converting any value to an array type are as follows:

- The target type may not be a multidimensional array.
- A value of null type is retained as is.
- For a scalar value other than `$null` or a value of type hashtable, a new 1-element array is
  created whose value is the scalar after conversion to the target element type.
- For a 1-dimensional array value, a new array of the target type is created, and each element is
  copied with conversion from the source array to the corresponding element in the target array.
- For a multi-dimensional array value, that array is first flattened ([§9.12][§9.12]), and then treated
  as a 1-dimensional array value.
- A string value is converted to an array of char having the same length with successive characters
  from the string occupying corresponding positions in the array.

For other enumerable types, a new 1-element array is created whose value is the corresponding
element after conversion to the target element type, if such a conversion exists. Otherwise, the
conversion is in error.

## 6.10 Conversion to xml

The object is converted to type string and then into an XML Document object of type `xml`.

## 6.11 Conversion to regex

An expression that designates a value of type string may be converted to type `regex`.

## 6.12 Conversion to scriptblock

The rules for converting any value to type `scriptblock` are as follows:

- A string value is treated as the name of a command optionally following by arguments to a call to
  that command.

## 6.13 Conversion to enumeration types

The rules for converting any value to an enumeration type are as
follows:

- A value of type string that contains one of the named values (with regard for case) for an
  enumeration type is converted to that named value.
- A value of type string that contains a comma-separated list of named values (with regard for case)
  for an enumeration type is converted to the bitwise-OR of all those named values.

## 6.14 Conversion to other reference types

The rules for converting any value to a reference type other than an array type or string are as
follows:

- A value of null type is retained as is.
- Otherwise, the behavior is implementation defined.

A number of pieces of machinery come in to play here; these include the possible use of single
argument constructors or default constructors if the value is a hashtable, implicit and explicit
conversion operators, and Parse methods for the target type; the use of Convert.ConvertTo; and the
ETS conversion mechanism.

## 6.15 Usual arithmetic conversions

If neither operand designates a value having numeric type, then

- If the left operand designates a value of type bool, the conversion is in error.
- Otherwise, all operands designating the value `$null` are converted to zero of type int and the
  process continues with the numeric conversions listed below.
- Otherwise, if the left operand designates a value of type char and the right operand designates a
  value of type bool, the conversion is in error.
- Otherwise, if the left operand designates a value of type string but does not represent a number
  ([§6.16][§6.16]), the conversion is in error.
- Otherwise, if the right operand designates a value of type string but does not represent a number
  ([§6.16][§6.16]), the conversion is in error.
- Otherwise, all operands designating values of type string are converted to numbers ([§6.16][§6.16]),
  and the process continues with the numeric conversions listed below.
- Otherwise, the conversion is in error.

Numeric conversions:

- If one operand designates a value of type decimal, the value designated by the other operand is
  converted to that type, if necessary. The result has type decimal.
- Otherwise, if one operand designates a value of type double, the value designated by the other
  operand is converted to that type, if necessary. The result has type double.
- Otherwise, if one operand designates a value of type float, the values designated by both operands
  are converted to type double, if necessary. The result has type double.
- Otherwise, if one operand designates a value of type long, the value designated by the other
  operand value is converted to that type, if necessary. The result has the type first in the
  sequence long and double that can represent its value.
- Otherwise, the values designated by both operands are converted to type int, if necessary. The
  result has the first in the sequence int, long, double that can represent its value without
  truncation.

## 6.16 Conversion from string to numeric type

Depending on its contents, a string can be converted explicitly or
implicitly to a numeric value. Specifically,

- An empty string is converted to the value zero.
- Leading and trailing spaces are ignored; however, a string may not consist of spaces only.
- A string containing only white space and/or line terminators is converted to the value zero.
- One leading + or - sign is permitted.
- An integer number may have a hexadecimal prefix (0x or 0X).
- An optionally signed exponent is permitted.
- Type suffixes and multipliers are not permitted.
- The case-distinct strings "-Infinity", "Infinity", and "NaN" are recognized as the values -∞, +∞,
  and NaN, respectively.

## 6.17 Conversion during parameter binding

For information about parameter binding see [§8.14][§8.14].

When the value of an expression is being bound to a parameter, there are extra conversion
considerations, as described below:

- If the parameter type is switch ([§4.2.5][§4.2.5], [§8.10.5][§8.10.5]) and the parameter has no
  argument, the value of the parameter in the called command is set to `$true`. If the parameter
  type is other than switch, a parameter having no argument is in error.
- If the parameter type is switch and the argument value is `$null`, the parameter value is set to
  `$false`.
- If the parameter type is object or is the same as the type of the argument, the argument's value
  is passed without conversion.
- If the parameter type is not object or scriptblock, an argument having type scriptblock is
  evaluated and its result is passed as the argument's value. (This is known as *delayed script
  block binding*.) If the parameter type is object or scriptblock, an argument having type
  scriptblock is passed as is.
- If the parameter type is a collection of type T2, and the argument is a scalar of type T1, that
  scalar is converted to a collection of type T2 containing one element. If necessary, the scalar
  value is converted to type T2 using the conversion rules of this section.
- If the parameter type is a scalar type other than object and the argument is a collection, the
  argument is in error.
- If the expected parameter type is a collection of type T2, and the argument is a collection of
  type T1, the argument is converted to a collection of type T2 having the same length as the
  argument collection. If necessary, the argument collection element values are converted to type T2
  using the conversion rules of this section.
- If the steps above and the conversions specified earlier in this chapter do not suffice, the rules
  in [§6.18][§6.18] are applied. If those fail, the parameter binding fails.

## 6.18 .NET Conversion

For an implicit conversion, PowerShell's built-in conversions are tried first. If they cannot
resolve the conversion, the .NET custom converters below are tried, in order, from top to bottom. If
a conversion is found, but it throws an exception, the conversion has failed.

- **PSTypeConverter**: There are two ways of associating the implementation of the
  **PSTypeConverter** class with its target class: through the type configuration file
  (types.ps1xml) or by applying the `System.ComponentModel.TypeConverterAttribute` attribute to the
  target class. Refer to the PowerShell SDK documentation for more information.

- **TypeConverter**: This CLR type provides a unified way of converting types of values to other
  types, as well as for accessing standard values and sub-properties. The most common type of
  converter is one that converts to and from a text representation. The type converter for a class
  is bound to the class with a `System.ComponentModel.TypeConverterAttribute`. Unless this attribute
  is overridden, all classes that inherit from this class use the same type converter as the base
  class. Refer to the PowerShell SDK and the Microsoft .NET framework documentation for more
  information.

- **Parse Method**: If the source type is string and the destination type has a method called
  `Parse`, that method is called to perform the conversion.

- **Constructors**: If the destination type has a constructor taking a single argument whose type is
  that of the source type, that constructor is called to perform the conversion.

- **Implicit Cast Operator**: If the source type has an implicit cast operator that converts to the
  destination type, that operator is called to perform the conversion.

- **Explicit Cast Operator**: If the source type has an explicit cast operator that converts to the
  destination type, that operator is called to perform the conversion. If the destination type has
  an explicit cast operator that converts from the source type, that operator is called to perform
  the conversion.

- **IConvertable**: `System.Convert.ChangeType` is called to perform the conversion.

## 6.19 Conversion to ordered

The rules for converting any value to the pseudo-type ordered are as
follows:

- If the value is a hash literal ([§2.3.5.6][§2.3.5.6]), the result is an object with an implementation
  defined type that behaves like a hashtable and the order of the keys matches the order specified
  in the hash literal.
- Otherwise, the behavior is implementation defined.

Only hash literals ([§2.3.5.6][§2.3.5.6]) can be converted to ordered. The result is an instance of
`System.Collections.Specialized.OrderedDictionary`.

## 6.20 Conversion to pscustomobject

The rules for converting any value to the pseudo-type pscustomobject are
as follows:

- A value of type hashtable is converted to a PowerShell object. Each key in the hashtable becomes a
  NoteProperty with the corresponding value.
- Otherwise, the behavior is implementation defined.

The conversion is always allowed but does not change the type of the value.

<!-- reference links -->
[§2.3.2.2]: chapter-02.md#2322-automatic-variables
[§2.3.5.6]: chapter-02.md#2356-hash-literals
[§4.2.5]: chapter-04.md#425-the-switch-type
[§6.16]: chapter-06.md#616-conversion-from-string-to-numeric-type
[§6.17]: chapter-06.md#617-conversion-during-parameter-binding
[§6.18]: chapter-06.md#618-net-conversion
[§6.19]: chapter-06.md#619-conversion-to-ordered
[§7.2.9]: chapter-07.md#729-cast-operator
[§8.10.5]: chapter-08.md#8105-the-switch-type-constraint
[§8.14]: chapter-08.md#814-parameter-binding
[§9.12]: chapter-09.md#912-multidimensional-array-flattening
