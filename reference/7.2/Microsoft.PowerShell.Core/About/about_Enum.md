---
description: The `enum` statement is used to declare an enumeration. An enumeration is a distinct type that consists of a set of named labels called the enumerator list.
Locale: en-US
ms.date: 11/27/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_enum?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Enum
---
# About Enum

## SHORT DESCRIPTION
The `enum` statement is used to declare an enumeration. An enumeration is a
distinct type that consists of a set of named labels called the enumerator
list.

## LONG DESCRIPTION

The `enum` statement allows you to create a strongly typed set of labels. That
enumeration can be used in the code without having to parse or check for
spelling errors.

Enumerations are internally represented as integers with a starting value of
zero. The first label in the list is assigned the value zero. The remaining
labels are assigned with consecutive numbers.

In the definition, labels can be given any integer value. Labels with no value
assigned take the next integer value.

## Syntax (basic)

```syntax
enum <enum-name> {
    <label> [= <int-value>]
    ...
}
```

## Usage example

The following example shows an enumeration of objects that can be seen as
media files. The definition assigns explicit values to the underlying values
of `music`, `picture`, `video`. Labels immediately following an explicit
assignment get the next integer value. Synonyms can be created by assigning
the same value to another label; see the constructed values for: `ogg`, `oga`,
`mogg`, or `jpg`, `jpeg`, or `mpg`, `mpeg`.

```powershell
enum MediaTypes {
    unknown
    music = 10
    mp3
    aac
    ogg = 15
    oga = 15
    mogg = 15
    picture = 20
    jpg
    jpeg = 21
    png
    video = 40
    mpg
    mpeg = 41
    avi
    m4v
}
```

The `GetEnumNames()` method returns the list of the labels for the enumeration.

```powershell
[MediaTypes].GetEnumNames()
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

The `GetEnumValues()` method returns the list of the values for the enumeration.

```powershell
[MediaTypes].GetEnumValues()
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

**Note**: GetEnumNames() and GetEnumValues() seem to return the same results.
However, internally, PowerShell is changing values into labels. Read the list
carefully and you'll notice that `oga` and `mogg` are mentioned under the 'Get
Names' results, but not under the 'Get Values' similar output for `jpg`,
`jpeg`, and `mpg`, `mpeg`.

```powershell
[MediaTypes].GetEnumName(15)
oga

[MediaTypes].GetEnumNames() | ForEach-Object {
  "{0,-10} {1}" -f $_,[int]([MediaTypes]::$_)
}
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

## Enumerations as flags

Enumerations can be defined as a collection of bit flags.
Where, at any given point the enumeration represents one or more of
those flags turned on.

For enumerations as flags to work properly, each label should have a power of
two value.

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

In the following example the *FileAttributes* enumeration is created.

```powershell
[Flags()] enum FileAttributes {
    Archive = 1
    Compressed = 2
    Device = 4
    Directory = 8
    Encrypted = 16
    Hidden = 32
}

[FileAttributes]$file1 = [FileAttributes]::Archive
[FileAttributes]$file1 +=[FileAttributes]::Compressed
[FileAttributes]$file1 +=  [FileAttributes]::Device
"file1 attributes are: $file1"

[FileAttributes]$file2 = [FileAttributes]28 ## => 16 + 8 + 4
"file2 attributes are: $file2"
```

```output
file1 attributes are: Archive, Compressed, Device
file2 attributes are: Device, Directory, Encrypted
```

To test that a specific is set, you can use the binary comparison operator
`-band`. In this example, we test for the **Device** and the **Archive**
attributes in the value of `$file2`.

```
PS > ($file2 -band [FileAttributes]::Device) -eq [FileAttributes]::Device
True

PS > ($file2 -band [FileAttributes]::Archive) -eq [FileAttributes]::Archive
False
```

