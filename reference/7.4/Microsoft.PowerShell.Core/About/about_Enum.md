---
description: The `enum` statement is used to declare an enumeration. An enumeration is a distinct type that consists of a set of named labels called the enumerator list.
Locale: en-US
ms.date: 06/07/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_enum?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about Enum
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

Enumerations are internally represented as integers with a starting value of
zero. By default, PowerShell assigns the first label in the list the value
zero. By default, PowerShell assigns the remaining labels with consecutive
integers.

In the definition, you can give labels any integer value. Labels with no value
assigned take the next integer value.

## Syntax (basic)

```syntax
enum <enum-name> {
    <label> [= <int-value>]
    ...
}
```

## Usage example

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
oga
oga
oga
picture
jpeg
jpeg
png
video
mpeg
mpeg
avi
m4v
```

> [!NOTE]
> `GetEnumNames()` and `GetEnumValues()` seem to return the same results; a
> list of named values. However, internally, `GetEnumValues()` enumerates the
> values, then maps values into names. Read the list carefully and you'll
> notice that `ogg`, `oga`, and `mogg` appear in the output of
> `GetEnumNames()`, but the output of `GetEnumValues()` only shows `oga`. The
> same thing happens for `jpg`, `jpeg`, and `mpg`, `mpeg`.

You can use the `GetEnumName()` method to get a name associated with a specific
value. If there are multiple names associated with a value, the method returns
the alphabetically-first name.

```powershell
[MediaTypes].GetEnumName(15)
```

```Output
oga
```

The following example shows how to map each name to its value.

```powershell
[MediaTypes].GetEnumNames() | ForEach-Object {
  "{0,-10} {1}" -f $_,[int]([MediaTypes]::$_)
}
```

```Output
unknown    0
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

## Enumerations as flags

You can define enumerations as a collection of bit flags.
Where, at any given point the enumeration represents one or more of
those flags turned on.

For enumerations as flags to work properly, you must set each label's integer
value to a power of two. If you don't specify a value for a label, PowerShell
sets the value to one higher than the previous label.

## Syntax (flags)

```syntax
[Flags()] enum <enum-name> {
    <label 0> [= 1]
    <label 1> [= 2]
    <label 2> [= 4]
    <label 3> [= 8]
    ...
}
```

## Flags usage example

The following example creates the **FileAttributes** enumeration. The value for
each label is double the value of the prior label.

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

## Enumerations as parameters

You can define cmdlet parameters that use an enum as their type. When you
specify an enum as the type for a parameter, users get automatic completion for
and validation of the parameter's value. The argument completion suggests the
list of valid labels for the enum.

When a parameter has an enum as its type, you can specify any of:

- An enumeration, like `[<EnumType>]::<Label>`
- The label for an enumeration as a string
- The numerical value of an enumeration

## Enumeration parameter example

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
