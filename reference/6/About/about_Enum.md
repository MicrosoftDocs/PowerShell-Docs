---
ms.date:  2017-06-09
schema:  2.0.0
keywords:  powershell,cmdlet
title:  about_Enum
---

# About Enum
## about_Enum


# SHORT DESCRIPTION

`enum` is used to declare an enumeration;
a distinct type that consists of a set of named labels called the
enumerator list.

# LONG DESCRIPTION

The `enum` statement allows to create a strongly typed set of labels;
that can be used in the code without having to parse or check for
spelling errors.

Enumerations are,internally, represented as integers with a starting
value of zero.
So, the first label in the list is assigned with the zero value;
the reminding labels are assigned consecutive numbers, one after each other.

In the definition, labels can be given any integer value. Labels with
no value assigned take the next integer value.

## Syntax (basic)

```syntax
enum <enum-name> {
    <label> [= <int-value>]
    ...
}
```

## Usage example

The following example shows an enumeration of objects
that can be seen as media files.
The enumeration definition assigns explicit values to the underlying
values of `music`, `picture`, `video`; labels coming immediately
after an explicit assignment gets the next integer value.
Synonyms can be created by assigning the same value to another label;
see the constructed values for: `ogg`, `oga`, `mogg`, or `jpg`, `jpeg`,
or `mpg`, `mpeg`.

> **Warning Note**: GetNames() and GetValues() seem to return the same results;
> however, under the hood is PowerShell is changing values into labels.
> Read the list carefully and you'll notice that `oga` and `mogg` are
> mentioned under the 'Get Names' results, but not under the 'Get Values';
> similar output for `jpg`, `jpeg`, and `mpg`, `mpeg`.

```PowerShell
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

'Get Names'
'---------'
[enum]::GetNames([MediaTypes])
'Get Values'
'----------'
[enum]::GetValues([MediaTypes])
'Enumerate Values'
'----------------'
[enum]::GetValues([MediaTypes]).foreach({$intvalue = [int]$_; "{0,-10} {1}" -f $_,$intvalue})

```

```output
Get Names
---------
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
Get Values
----------
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
Enumerate Values
----------------
unknown    0
music      10
mp3        11
aac        12
oga        15
oga        15
oga        15
picture    20
jpeg       21
jpeg       21
png        22
video      40
mpeg       41
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

 ```PowerShell
 [Flags()] enum FileAttributes {
     Archive = 1
     Compressed = 2
     Device = 4
     Directory = 8
     Encrypted = 16
     Hidden = 32
 }

[FileAttributes]$file1 = [FileAttributes]::Archive + [FileAttributes]::Compressed + [FileAttributes]::Device
"file1 attributes are: $file1"

[FileAttributes]$file2 = [FileAttributes]28 ## => 16 + 8 + 4
"file2 attributes are: $file2"
 ```

```output
file1 attributes are: Archive, Compressed, Device
file2 attributes are: Device, Directory, Encrypted
PS C:\tmp>

```

