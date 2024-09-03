---
description: The `enum` statement is used to declare an enumeration. An enumeration is a distinct type that consists of a set of named labels called the enumerator list.
Locale: en-US
ms.date: 11/20/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_enum?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Enum
---
# about_Enum

## Short description

The `enum` statement declares an enumeration. An enumeration is a
distinct type that consists of a set of named labels called the enumerator
list.

## Long description

The `enum` statement allows you to create a strongly typed set of labels. You
can use that enumeration in the code without having to parse or check for
spelling errors.

Enumerations are internally represented as integral value types with a starting
value of zero. By default, PowerShell enumerations use **System.Int32**
(`[int]`) as the underlying type. By default, PowerShell assigns the first
label in the list the value zero. By default, PowerShell assigns the remaining
labels with consecutive integers.

In the definition, you can give labels any integer value. Labels with no value
assigned take the next integer value.

## Syntax

Enumerations use the following syntaxes:

### Integer enumeration definition syntax

```Syntax
[[<attribute>]...] enum <enum-name> {
    <label> [= <int-value>]
    ...
}
```

### Specific underlying type enumeration definition syntax

```Syntax
[[<attribute>]...] enum <enum-name> : <underlying-type-name> {
    <label> [= <int-value>]
    ...
}
```

### Flag enumeration definition syntax

```Syntax
[[<attribute>]...] [Flag()] enum <enum-name>[ : <underlying-type-name>] {
    <label 0> [= 1]
    <label 1> [= 2]
    <label 2> [= 4]
    <label 3> [= 8]
    ...
    ...
}
```

### Enumeration access syntax

```Syntax
[<enum-name>]::<label>
```

## Examples

### Example 1 - Minimal enumeration

The following code block defines the **MarkdownUnorderedListCharacter**
enumeration with three labels. It doesn't assign explicit values to any label.

```powershell
enum MarkdownUnorderedListCharacter {
    Asterisk
    Dash
    Plus
}
```

The next code block shows how both integer and string values behave when cast
to the enumeration type.

```powershell
$ValuesToConvert = @(0, 'Asterisk', 1, 'Dash', 2, 'Plus')
foreach ($Value in $ValuesToConvert) {
    [MarkdownUnorderedListCharacter]$EnumValue = $Value

    [pscustomobject]@{
        AssignedValue = $Value
        Enumeration   = $EnumValue
        AreEqual      = $Value -eq $EnumValue
    }
}
```

```Output
AssignedValue Enumeration AreEqual
------------- ----------- --------
            0    Asterisk     True
     Asterisk    Asterisk     True
            1        Dash     True
         Dash        Dash     True
            2        Plus     True
         Plus        Plus     True
```

Casting integers that are equal to the value of an enumeration returns that
enumeration. Casting strings that are the same as the label of an enumeration
returns that enumeration.

### Example 2 - Explicit and synonym enumeration values

The following example shows an enumeration of objects that correlate to media
files. The definition assigns explicit values to the underlying values of
`music`, `picture`, `video`. Labels immediately following an explicit
assignment get the next integer value. You can create synonyms by assigning the
same value to another label; see the constructed values for: `ogg`, `oga`,
`mogg`, or `jpg`, `jpeg`, or `mpg`, `mpeg`.

```powershell
enum MediaTypes {
    unknown
    music   = 10
    mp3
    aac
    ogg     = 15
    oga     = 15
    mogg    = 15
    picture = 20
    jpg
    jpeg    = 21
    png
    video   = 40
    mpg
    mpeg    = 41
    avi
    m4v
}
```

The `GetEnumNames()` method returns the list of the labels for the enumeration.

```powershell
[MediaTypes].GetEnumNames()
```

```Output
unknown
music
mp3
aac
ogg
oga
mogg
picture
jpg
jpeg
png
video
mpg
mpeg
avi
m4v
```

The `GetEnumValues()` method returns the list of the values for the
enumeration.

```powershell
[MediaTypes].GetEnumValues()
```

```Output
unknown
music
mp3
aac
ogg
ogg
ogg
picture
jpg
jpg
png
video
mpg
mpg
avi
m4v
```

> [!NOTE]
> `GetEnumNames()` and `GetEnumValues()` seem to return the same results; a
> list of named values. However, internally, `GetEnumValues()` enumerates the
> values, then maps values into names. Read the list carefully and you'll
> notice that `ogg`, `oga`, and `mogg` appear in the output of
> `GetEnumNames()`, but the output of `GetEnumValues()` only shows `ogg`. The
> same thing happens for `jpg`, `jpeg`, and `mpg`, `mpeg`. The name PowerShell
> returns for synonym values isn't deterministic.

You can use the `GetEnumName()` method to get a name associated with a specific
value. If there are multiple names associated with a value, the method returns
the first defined name.

```powershell
[MediaTypes].GetEnumName(15)
```

```Output
ogg
```

The following example shows how to map each name to its value.

```powershell
[MediaTypes].GetEnumNames() | ForEach-Object {
  [pscustomobject]@{
    Name = $_
    Value = [int]([MediaTypes]::$_)
  }
}
```

```Output
Name    Value
----    -----
unknown     0
music      10
mp3        11
aac        12
ogg        15
oga        15
mogg       15
picture    20
jpg        21
jpeg       21
png        22
video      40
mpg        41
mpeg       41
avi        42
m4v        43
```

You can specify a single enum value by its label with the syntax
`[<enum-name>]::<label>`.

```powershell
[MediaTypes]::png
[MediaTypes]::png -eq 22
```

```Output
png
True
```

### Example 3 - Enumeration as flags

The following code block creates the **FileAttributes** enumeration as a set of
bit flags. The value for each label is double the value of the prior label.

```powershell
[Flags()] enum FileAttributes {
    Archive    = 1
    Compressed = 2
    Device     = 4
    Directory  = 8
    Encrypted  = 16
    Hidden     = 32
}

[FileAttributes]$file1 =  [FileAttributes]::Archive
[FileAttributes]$file1 += [FileAttributes]::Compressed
[FileAttributes]$file1 += [FileAttributes]::Device
"file1 attributes are: $file1"

[FileAttributes]$file2 = [FileAttributes]28 ## => 16 + 8 + 4
"file2 attributes are: $file2"
```

```Output
file1 attributes are: Archive, Compressed, Device
file2 attributes are: Device, Directory, Encrypted
```

To test whether a specific flag is set, you can use the binary comparison
operator `-band`. This example tests for the **Device** and the **Archive**
attributes in the value of `$file2`.

```powershell
PS > ($file2 -band [FileAttributes]::Device) -eq [FileAttributes]::Device
True

PS > ($file2 -band [FileAttributes]::Archive) -eq [FileAttributes]::Archive
False
```

You can also use the `HasFlag()` method to test whether a specific flag is set.
This example tests for the **Device** and **Hidden** attributes in the value of
`$file1`.

```powershell
PS > $file1.HasFlag([FileAttributes]::Device)
True

PS > $file1.HasFlag([FileAttributes]::Hidden)
False
```

### Example 4 - Enumeration as a parameter

In the following example, the function `ConvertTo-LineEndingRegex` defines the
**InputObject** parameter with the type **EndOfLine**.

```powershell
enum EndOfLine {
    CR   = 1
    LF   = 2
    CRLF = 3
}

function ConvertTo-LineEndingRegex {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [EndOfLine[]]$InputObject
    )

    process {
        switch ($InputObject) {
            CR   {  '\r'  }
            LF   {  '\n'  }
            CRLF { '\r\n' }
        }
    }
}

[EndOfLine]::CR | ConvertTo-LineEndingRegex

'CRLF' | ConvertTo-LineEndingRegex

ConvertTo-LineEndingRegex 2
```

```Output
\r

\r\n

\n
```

In the example, the first statement calling `ConvertTo-LineEndingRegex` passes
the enumeration value for `CR`. The second statement passes the string
`'CRLF'`, which is cast to a **LineEnding**. The third statement specifies the
value `2` for the parameter, which maps to the `LF` label.

You can see the argument completion options by typing the following text into
your PowerShell prompt:

```powershell
ConvertTo-LineEndingRegex -InputObject <Tab>
```

When you specify an invalid label name or numerical value for the parameter,
the function raises an error.

```powershell
ConvertTo-LineEndingRegex -InputObject 0
```

```output
ConvertTo-LineEndingRegex: Cannot process argument transformation on
parameter 'InputObject'. Cannot convert value "0" to type "EndOfLine" due
to enumeration values that are not valid. Specify one of the following
enumeration values and try again. The possible enumeration values are
"CR,LF,CRLF".
```

### Example 5 - Enumerations with specific underlying types

Starting in PowerShell 6.2, you can define enumerations with a specific
underlying type. This example shows the valid underlying types for an
enumeration.

The first code block initializes two variables as arrays. `$EnumTypes` is an
empty array to hold the dynamically created types. `$IntegralTypes` is an array
that contains the valid underlying types for an enumeration.

```powershell
$EnumTypes     = @()
$IntegralTypes = @(
    'byte', 'sbyte', 'short', 'ushort', 'int', 'uint', 'long', 'ulong'
)
```

The next code block defines a template to use for dynamically creating the
enumeration definitions. When the `{0}` format placeholder is replaced with an
integral type name, the template creates a scriptblock that:

1. Defines an enumeration named `<type>Enum`, like `byteEnum`. The defined
   enumeration uses the specified integral type as the underlying value type.

   The enumeration is defined with the `Min` value set to the minimum value for
   the integral type. It defines the `Max` value set to the maximum value for
   the integral type.
1. Returns the newly defined type.

```powershell
$DefinitionTemplate = @"
enum {0}Enum : {0} {{
    Min = [{0}]::MinValue
    Max = [{0}]::MaxValue
}}

[{0}Enum]
"@
```

The next code block uses the template to create and invoke a scriptblock in the
current scope. It adds the returned type definitions into the `$EnumTypes`
array.

```powershell
foreach ($IntegralType in $IntegralTypes) {
    $Definition  = $DefinitionTemplate -f $IntegralType
    $ScriptBlock = [scriptblock]::Create($Definition)
    $EnumTypes  += . $ScriptBlock
}
```

The last code block loops over the enum types, using the
`GetEnumValuesAsUnderlyingType()` method to list the values as the underlying
type. The loop creates a new object for each value, showing the enumeration
type, the value type, the label, and the actual value.

```powershell
foreach ($EnumType in $EnumTypes) {
    $EnumType.GetEnumValuesAsUnderlyingType() | ForEach-Object {
        [pscustomobject]@{
            EnumType  = $EnumType.FullName
            ValueType = $_.GetType().FullName
            Label     = $EnumType.GetEnumName($_)
            Value     = $_
        }
    }
}
```

```Output
EnumType   ValueType     Label                Value
--------   ---------     -----                -----
byteEnum   System.Byte   Min                      0
byteEnum   System.Byte   Max                    255
sbyteEnum  System.SByte  Max                    127
sbyteEnum  System.SByte  Min                   -128
shortEnum  System.Int16  Max                  32767
shortEnum  System.Int16  Min                 -32768
ushortEnum System.UInt16 Min                      0
ushortEnum System.UInt16 Max                  65535
intEnum    System.Int32  Max             2147483647
intEnum    System.Int32  Min            -2147483648
uintEnum   System.UInt32 Min                      0
uintEnum   System.UInt32 Max             4294967295
longEnum   System.Int64  Max    9223372036854775807
longEnum   System.Int64  Min   -9223372036854775808
ulongEnum  System.UInt64 Min                      0
ulongEnum  System.UInt64 Max   18446744073709551615
```

## Enumeration methods

The following list includes useful methods available to enumerations in
PowerShell and how to use them.

### Format

The `Format()` static method returns the formatted string output for a given
enumeration type, enumeration value, and format string. The output is the same
as calling the [ToString][01] method on the value with the specified format
string.

You can use the static method on the **System.Enum** base class type or a
specific enumeration type.

```Syntax
[System.Enum]::format([<enum-name>], <value>, <format-string>)
```

```Syntax
[<enum-name>]::format([<enum-name>], <value>, <format-string>)
```

The valid format strings are `G` or `g`, `D` or `d`, `X` or `x`, and `F` or
`f`. For more information, see [Enumeration Format Strings][02].

The following example uses each of the supported enumeration format strings to
convert each value of the **TaskState** enumeration to its string
representations.

```powershell
enum TaskState {
    ToDo
    Doing
    Done
}

# String format template for the statements
$Statement = "[System.Enum]::Format([TaskState], {0}, '{1}')"

foreach ($Format in @('G', 'D', 'X', 'F')) {
    $StatementToDo  = $Statement -f 0, $Format
    $StatementDoing = $Statement -f "([TaskState]'Doing')", $Format
    $StatementDone  = $Statement -f '[TaskState]::Done', $Format
    $FormattedToDo  = [System.Enum]::Format(
      [TaskState], 0, $Format
    )
    $FormattedDoing = [System.Enum]::Format(
        [TaskState], ([TaskState]'Doing'), $Format
    )
    $FormattedDone  = [System.Enum]::Format(
      [TaskState], [TaskState]::Done, $Format
    )

    "{0,-62} => {1}" -f $StatementToDo,  $FormattedToDo
    "{0,-62} => {1}" -f $StatementDoing, $FormattedDoing
    "{0,-62} => {1}" -f $StatementDone,  $FormattedDone
}
```

```Output
[System.Enum]::Format([TaskState], 0, 'G')                     => ToDo
[System.Enum]::Format([TaskState], ([TaskState]'Doing'), 'G')  => Doing
[System.Enum]::Format([TaskState], [TaskState]::Done, 'G')     => Done
[System.Enum]::Format([TaskState], 0, 'D')                     => 0
[System.Enum]::Format([TaskState], ([TaskState]'Doing'), 'D')  => 1
[System.Enum]::Format([TaskState], [TaskState]::Done, 'D')     => 2
[System.Enum]::Format([TaskState], 0, 'X')                     => 00000000
[System.Enum]::Format([TaskState], ([TaskState]'Doing'), 'X')  => 00000001
[System.Enum]::Format([TaskState], [TaskState]::Done, 'X')     => 00000002
[System.Enum]::Format([TaskState], 0, 'F')                     => ToDo
[System.Enum]::Format([TaskState], ([TaskState]'Doing'), 'F')  => Doing
[System.Enum]::Format([TaskState], [TaskState]::Done, 'F')     => Done
```

### GetEnumName

The `GetEnumName()` reflection method returns the name for a specific
enumeration value. The input value must be a valid underlying type for an
enumeration, like an integer, or an enumeration value. If there are multiple
names associated with a value, the method returns the first defined name.

```Syntax
[<enum-name>].GetEnumName(<value>)
```

```powershell
enum GateState {
    Unknown
    Open
    Opening
    Closing
    Closed
}

foreach ($Value in 0..4) {
    [pscustomobject]@{
      IntegerValue = $Value
      EnumName     = [GateState].GetEnumName($Value)
    }
}
```

```Output
IntegerValue EnumName
------------ --------
           0 Unknown
           1 Open
           2 Opening
           3 Closing
           4 Closed
```

### GetEnumNames

The `GetEnumNames()` reflection method returns the names for every enumeration
value as strings. The output includes synonyms.

```Syntax
[<enum-name>].GetEnumNames()
```

```powershell
enum Season {
    Unknown
    Spring
    Summer
    Autumn
    Winter
    Fall   = 3
}

[Season].GetEnumNames()
```

```Output
Unknown
Spring
Summer
Fall
Autumn
Winter
```

### GetEnumUnderlyingType

The `GetEnumUnderlyingType()` reflection method returns the underlying type for
the enumeration values.

```Syntax
[<enum-name>].GetEnumUnderlyingType()
```

```powershell
enum IntBasedEnum {
    Zero
    One
    Two
}
enum ShortBasedEnum : short {
    Zero
    One
    Two
}

foreach ($EnumType in @([IntBasedEnum], [ShortBasedEnum])) {
    [pscustomobject]@{
        EnumType = $EnumType
        ValueType = $EnumType.GetEnumUnderlyingType()
    }
}
```

```Output
EnumType       ValueType
--------       ---------
IntBasedEnum   System.Int32
ShortBasedEnum System.Int16
```

### GetEnumValues

The `GetEnumValues()` reflection method returns every defined value for the
enumeration.

```Syntax
[<enum-name>].GetEnumValues()
```

```powershell
enum Season {
    Unknown
    Spring
    Summer
    Autumn
    Winter
    Fall   = 3
}

[Season].GetEnumValues()
```

```Output
Unknown
Spring
Summer
Fall
Fall
Winter
```

### GetEnumValuesAsUnderlyingType

The `GetEnumValuesAsUnderlyingType()` reflection method returns every defined
value for the enumeration as the underlying type.

```Syntax
[<enum-name>].GetEnumValuesAsUnderlyingType()
```

```powershell
enum IntBasedEnum {
    Zero
    One
    Two
}
enum ShortBasedEnum : short {
    Zero
    One
    Two
}

foreach ($EnumType in @([IntBasedEnum], [ShortBasedEnum])) {
    [pscustomobject]@{
        EnumType = $EnumType
        ValueType = $EnumType.GetEnumValuesAsUnderlyingType()[0].GetType()
    }
}
```

```output
EnumType       ValueType
--------       ---------
IntBasedEnum   System.Int32
ShortBasedEnum System.Int16
```

### HasFlag

The `HasFlag` instance method determines whether a bit flag is set for a flag
enumeration value. Using this method is shorter and easier to read than doing a
binary comparison and equivalency check.

```Syntax
<enum-value>.HasFlag(<enum-flag-value>)
```

The following example defines the **ModuleFeatures** flag enumeration and shows
which flags the value `39` has.

```powershell
[Flags()] enum ModuleFeatures {
    Commands  = 1
    Classes   = 2
    Enums     = 4
    Types     = 8
    Formats   = 16
    Variables = 32
}

$Features = [ModuleFeatures]39

foreach ($Feature in [ModuleFeatures].GetEnumValues()) {
    "Has flag {0,-12}: {1}" -f "'$Feature'", ($Features.HasFlag($Feature))
}
```

```Output
Has flag 'Commands'  : True
Has flag 'Classes'   : True
Has flag 'Enums'     : True
Has flag 'Types'     : False
Has flag 'Formats'   : False
Has flag 'Variables' : True
```

### IsDefined

The `IsDefined()` static method returns `$true` if the input value is defined
for the enumeration and otherwise `$false`. Use this method to check whether a
value is valid for an enumeration without needing to handle invalid argument
errors.

You can use the static method on the **System.Enum** base class type or a
specific enumeration type.

```Syntax
[System.Enum]::IsDefined([<enum-name>], <value>)
```

```Syntax
[<enum-name>]::IsDefined([<enum-name>], <value>)
```

```powershell
enum Season {
    Unknown
    Spring
    Summer
    Autumn
    Winter
    Fall   = 3
}

foreach ($Value in 0..5) {
    $IsValid   = [Season]::IsDefined([Season], $Value)
    $EnumValue = if ($IsValid) { [Season]$Value }

    [pscustomobject] @{
        InputValue = $Value
        IsValid    = $IsValid
        EnumValue  = $EnumValue
    }
}
```

```Output
InputValue IsValid EnumValue
---------- ------- ---------
         0    True   Unknown
         1    True    Spring
         2    True    Summer
         3    True      Fall
         4    True    Winter
         5   False
```

### ToString

The `ToString()` instance method returns the label for an enumeration value.
This method is also the default view for how an enumeration value displays as
output. Optionally, you can specify a format string to control how the value
displays. For more information about formatting, see
[Formatting enumeration values][03].

> [!NOTE]
> For enumerations that define synonyms for a specific value, don't write code
> that depends on the output of `ToString()`. The method can return any valid
> name for the value.

```Syntax
<enum-value>.ToString([<format-string>])
```

The following example defines the **Shade** enumeration with `Gray` as a
synonym for `Grey`. It then outputs objects that show the actual enum value,
the enum as a string, and the enum as an integer.

```powershell
enum Shade {
    White
    Grey
    Gray = 1
    Black
}

[Shade].GetEnumValues() | Foreach-Object -Process {
    [pscustomobject]@{
        EnumValue    = $_
        StringValue  = $_.ToString()
        IntegerValue = [int]$_
    }
}
```

```Output
numValue StringValue IntegerValue
--------- ----------- ------------
    White White                  0
     Grey Grey                   1
     Grey Grey                   1
    Black Black                  2
```

## Enumeration value synonyms

You can define enumerations that give different names to the same integer
value. When you do, the names that point to the same underlying value are
called _synonyms_. Enumerations with synonyms enable users to specify different
names for the same value.

When you define an enumeration with synonyms, don't write code that depends on
a synonym value converting _to_ a specific name. You can reliably write code
that converts a synonym string to the enumeration value. When working with the
enumeration value itself, always compare it as an enumeration value or its
underlying type instead of as a string.

The following code block defines the **Shade** enumeration with `Grey` and
`Gray` as synonyms.

```powershell
enum Shade {
    White
    Grey
    Gray = 1
    Black
}

[Shade]'Grey' -eq [Shade]::Gray
[Shade]::Grey -eq 1
[Shade]'Gray' -eq 1
```

```Output
True
True
True
```

## Enumerations as flags

One common use of an enumeration is to represent a set of mutually exclusive
values. For example, an **ArrivalStatus** instance can have a value of Early,
OnTime, or Late. It makes no sense for the value of an **ArrivalStatus**
instance to reflect more than one enumeration constant.

In other cases, however, the value of an enumeration object can include
multiple enumeration members, and each member represents a bit field in the
enumeration value. You can use the [FlagsAttribute][04] to indicate that the
enumeration consists of bit fields as flags that users can combine.

For enumerations as flags to work properly, you must set each label's integer
value to a power of two. If you don't specify a value for a label, PowerShell
sets the value to one higher than the previous label.

You can define values for commonly used flag combinations to make it easier for
users to specify a set of flags at once. The name for the value should be the
combined names of the flags. The integer value should be the sum of the flag
values.

To determine whether a specific flag is set for a value, use the `HasFlag()`
method on the value or use the binary comparison operator `-band`.

For a sample showing how to use flag enumerations and check whether a flag is
set, see [Example 3][05].

## Enumerations as parameters

You can define cmdlet parameters that use an enum as their type. When you
specify an enum as the type for a parameter, users get automatic completion for
and validation of the parameter's value. The argument completion suggests the
list of valid labels for the enum.

When a parameter has an enum as its type, you can specify any of:

- An enumeration, like `[<EnumType>]::<Label>`
- The label for an enumeration as a string
- The numerical value of an enumeration

For a sample showing the behavior of an enumeration-typed parameter, see
[Example 4][06].

## Enumerations with specific underlying types

Starting in PowerShell 6.2, you can define enumerations with a specific
underlying type. When you define an enumeration without a specific underlying
type, PowerShell creates the enumeration with `[int]` (**System.Int32**) as the
underlying type.

The underlying type for an enumeration must be an [integral numeric type][07].
The following list includes the valid types with their short name and full type
name:

- `byte` - **System.Byte**
- `sbyte` - **System.SByte**
- `short` - **System.Int16**
- `ushort` - **System.UInt16**
- `int` - **System.Int32**
- `uint` - **System.UInt32**
- `long` - **System.Int64**
- `ulong` - **System.UInt64**

You can define a specific underlying type for enumeration as either the short
name or the full type name. The following definitions are functionally
identical. Only the name used for the underlying type is different.

```powershell
enum LongValueEnum : long {
    Zero
    One
    Two
}
```

```powershell
enum LongValueEnum : System.Int64 {
    Zero
    One
    Two
}
```

## Formatting enumeration values

You can convert enumeration values to their string representations by calling
the static [Format][08] method, as well as the overloads of the instance
[ToString][09] method. You can use a format string to control the precise way
in which an enumeration value is represented as a string. For more information,
see [Enumeration Format Strings][02].

The following example uses each of the supported enumeration format strings
(`G` or `g`, `D` or `d`, `X` or `x`, and `F` or `f` ) to convert each member of
the **TaskState** enumeration to its string representations.

```powershell
enum TaskState {
    ToDo
    Doing
    Done
}

[TaskState].GetEnumValues() | ForEach-Object {
    [pscustomobject]@{
        "ToString('G')" = $_.ToString('G')
        "ToString('D')" = $_.ToString('D')
        "ToString('X')" = $_.ToString('X')
        "ToString('F')" = $_.ToString('F')
    }
}
```

```Output
ToString('G') ToString('D') ToString('X') ToString('F')
------------- ------------- ------------- -------------
ToDo          0             00000000      ToDo
Doing         1             00000001      Doing
Done          2             00000002      Done
```

The following example uses the format strings for values of a flag enumeration.

```powershell
[Flags()] enum FlagEnum {
    A = 1
    B = 2
    C = 4
}

$FlagValues = @(
    [FlagEnum]::A                                 # 1
    [FlagEnum]::B                                 # 2
    [FlagEnum]::A + [FlagEnum]::B                 # 3
    [FlagEnum]::C                                 # 4
    [FlagEnum]::C + [FlagEnum]::A                 # 5
    [FlagEnum]::C + [FlagEnum]::B                 # 6
    [FlagEnum]::C + [FlagEnum]::A + [FlagEnum]::B # 7
    [FlagEnum]::C + [FlagEnum]::C                 # 8
)

foreach ($Value in $FlagValues) {
    [pscustomobject]@{
        "ToString('G')" = $Value.ToString('G')
        "ToString('D')" = $Value.ToString('D')
        "ToString('X')" = $Value.ToString('X')
        "ToString('F')" = $Value.ToString('F')
    }
}
```

```Output
ToString('G') ToString('D') ToString('X') ToString('F')
------------- ------------- ------------- -------------
A             1             00000001      A
B             2             00000002      B
A, B          3             00000003      A, B
C             4             00000004      C
A, C          5             00000005      A, C
B, C          6             00000006      B, C
A, B, C       7             00000007      A, B, C
8             8             00000008      8
```

Notice that for flags enumerations, the `G` and `F` format strings display the
list of set flags for the value delimited with commas. The last value, `8`,
doesn't list any flags because it's not actually a valid flag set. You can't
combine the enumeration flags to get a sum of `8` without duplicating at least
one flag.

## Defining extension methods with Update-TypeData

You can't define methods in the declaration for an enumeration. To extend the
functionality of an enumeration, you can use the [Update-TypeData][10] cmdlet
to define `ScriptMethod` members for the enumeration.

The following example uses the `Update-TypeData` cmdlet to add a `GetFlags()`
method to the **FileAttributes** flag enumeration. It returns an array of the
flags set for the value.

```powershell
[Flags()] enum FileAttributes {
    Archive    = 1
    Compressed = 2
    Device     = 4
    Directory  = 8
    Encrypted  = 16
    Hidden     = 32
}

$MemberDefinition = @{
    TypeName   = 'FileAttributes'
    MemberName = 'GetFlags'
    MemberType = 'ScriptMethod'
    Value      = {
        foreach ($Flag in $this.GetType().GetEnumValues()) {
          if ($this.HasFlag($Flag)) { $Flag }
        }
    }
}

Update-TypeData @MemberDefinition

$File = [FileAttributes]28

$File.GetFlags()
```

```Output
Device
Directory
Encrypted
```

## Exporting enumerations with type accelerators

By default, PowerShell modules don't automatically export classes and
enumerations defined in PowerShell. The custom types aren't available outside
of the module without calling a `using module` statement.

However, if a module adds type accelerators, those type accelerators are
immediately available in the session after users import the module.

> [!NOTE]
> Adding type accelerators to the session uses an internal (not public) API.
> Using this API may cause conflicts. The pattern described below throws an
> error if a type accelerator with the same name already exists when you import
> the module. It also removes the type accelerators when you remove the module
> from the session.
>
> This pattern ensures that the types are available in a session. It doesn't
> affect IntelliSense or completion when authoring a script file in VS Code.
> To get IntelliSense and completion suggestions for custom types in VS Code,
> you need to add a `using module` statement to the top of the script.

The following pattern shows how you can register PowerShell classes and
enumerations as type accelerators in a module. Add the snippet to the root
script module after any type definitions. Make sure the `$ExportableTypes`
variable contains each of the types you want to make available to users when
they import the module. The other code doesn't require any editing.

```powershell
# Define the types to export with type accelerators.
$ExportableTypes =@(
    [DefinedTypeName]
)
# Get the internal TypeAccelerators class to use its static methods.
$TypeAcceleratorsClass = [psobject].Assembly.GetType(
    'System.Management.Automation.TypeAccelerators'
)
# Ensure none of the types would clobber an existing type accelerator.
# If a type accelerator with the same name exists, throw an exception.
$ExistingTypeAccelerators = $TypeAcceleratorsClass::Get
foreach ($Type in $ExportableTypes) {
    if ($Type.FullName -in $ExistingTypeAccelerators.Keys) {
        $Message = @(
            "Unable to register type accelerator '$($Type.FullName)'"
            'Accelerator already exists.'
        ) -join ' - '

        throw [System.Management.Automation.ErrorRecord]::new(
            [System.InvalidOperationException]::new($Message),
            'TypeAcceleratorAlreadyExists',
            [System.Management.Automation.ErrorCategory]::InvalidOperation,
            $Type.FullName
        )
    }
}
# Add type accelerators for every exportable type.
foreach ($Type in $ExportableTypes) {
    $TypeAcceleratorsClass::Add($Type.FullName, $Type)
}
# Remove type accelerators when the module is removed.
$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    foreach($Type in $ExportableTypes) {
        $TypeAcceleratorsClass::Remove($Type.FullName)
    }
}.GetNewClosure()
```

When users import the module, any types added to the type accelerators for the
session are immediately available for IntelliSense and completion. When the
module is removed, so are the type accelerators.

## Manually importing enumerations from a PowerShell module

`Import-Module` and the `#requires` statement only import the module functions,
aliases, and variables, as defined by the module. Enumerations aren't imported.

If a module defines classes and enumerations but doesn't add type accelerators
for those types, use a `using module` statement to import them.

The `using module` statement imports classes and enumerations from the root
module (`ModuleToProcess`) of a script module or binary module. It doesn't
consistently import classes defined in nested modules or classes defined in
scripts that are dot-sourced into the root module. Define classes that you want
to be available to users outside of the module directly in the root module.

For more information about the `using` statement, see [about_Using][11].

## Loading newly changed code during development

During development of a script module, it's common to make changes to the code
then load the new version of the module using `Import-Module` with the
**Force** parameter. This works for changes to functions in the root module
only. `Import-Module` doesn't reload any nested modules. Also, there's no way
to load any updated classes.

To ensure that you're running the latest version, you must start a new session.
Classes and enumerations defined in PowerShell and imported with a `using`
statement can't be unloaded.

Another common development practice is to separate your code into different
files. If you have function in one file that use enumerations defined in
another module, you should using the `using module` statement to ensure that
the functions have the enumeration definitions that are needed.

## Limitations

- You can't decorate enumeration values defined in PowerShell with attributes.
  You can only decorate the enumeration declaration itself, as with the
  [FlagsAttribute][04] for defining an enumeration as a set of bit flags.

  Workaround: None

- You can't define methods inside enumeration definitions and PowerShell
  doesn't support defining [extension methods] like C#.

  Workaround: Use the [Update-TypeData][10] cmdlet to define `ScriptMethod`
  members for the enumeration.

<!-- Reference link definitions -->
[01]: #tostring
[02]: /dotnet/standard/base-types/enumeration-format-strings
[03]: #formatting-enumeration-values
[04]: xref:System.FlagsAttribute
[05]: #example-3---enumeration-as-flags
[06]: #example-4---enumeration-as-a-parameter
[07]: /dotnet/csharp/language-reference/builtin-types/integral-numeric-types
[08]: /dotnet/api/system.enum.format
[09]: xref:System.Enum.ToString
[10]: xref:Microsoft.PowerShell.Utility.Update-TypeData
[11]: about_Using.md
