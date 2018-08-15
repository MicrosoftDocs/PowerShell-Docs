﻿---
ms.date:  12/01/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Regular_Expressions
---
# About Regular Expressions

## Short description

Describes regular expressions in Windows PowerShell.

## Long description

> [!NOTE]
> This article will show you the syntax and methods for using regular
> expressions in PowerShell, not all syntax is discussed. For a more
> complete reference, see the [Regular Expression Language - Quick Reference](https://go.microsoft.com/fwlink/?LinkId=133231).

A regular expression is a pattern used to match text. It can be made up of
literal characters, operators, and other constructs.

PowerShell has several operators and cmdlets that use regular expressions.

- `Select-String`
- `-match`, `-split`, and `-replace` operators
- `switch` statement with `-regex` option.

PowerShell regular expressions are case-insensitive by default. Each method
shown above has a different way to force case sensitivity.

|Method  |Case Sensitivity  |
|---------|---------|
|`Select-String`|use `-CaseSensitive` switch|
|`switch` statement |use the `-casesensitive` option|
|operators|prefix with **'c'** (`-cmatch`, `-csplit`, or `-creplace`)|

### Character literals

A regular expression can be a literal character or a string.
This causes the engine to match the text specified exactly.

```powershell
# This statement returns true because book contains the string "oo"
"book" -match "oo"
```

### Character classes

While character literals work if you know the exact pattern, character
classes allow you to be less specific.

#### Character groups

`[character group]` allows you to match any number of characters one time,
while `[^character group]` only matches characters NOT in the group.

```powershell
# This expression returns true if the pattern matches big, bog, or bug.
"big" -match "b[iou]g"
```

#### Character ranges

A pattern can also be a range of characters. This can be alphabetic
`[A-Z]`, numeric `[0-9]`, or even ASCII-based `[ -~]` (all printable
characters).

```powershell
# This expression returns true if the pattern matches any 2 digit number.
42 -match "[0-9][0-9]"
```

#### Numbers

The `\d` character class will match any decimal digit.  Conversely, `\D`
will match any non-decimal digit.

```powershell
# This expression returns true if it matches a server name.
# (Server-01 - Server-99).
"Server-01" -match "Server-\d\d"
```

#### Word characters

The `\w` character class will match any word character `[a-zA-Z_0-9]`.
To match any non-word character, use `\W`.

```powershell
# This expression returns true.
# The pattern matches the first word character 'B'.
"Book" -match "\w"
```

#### Wildcards

The period (`.`) is a wildcard character in regular expressions. It will
match any character except a newline (`\n`).

```powershell
# This expression returns true.
# The pattern matches any 4 characters except the newline.
"a1\ " -match "...."
```

#### Whitespace

Whitespace is matched using the `\s` character class.  Any non-whitespace
character is matched using `\S`. Literal space characters `' '` can also be
used.

```powershell
# This expression returns true.
# The pattern uses both methods to match the space.
" - " -match "\s- "
```

### Quantifiers

Quantifiers control how many instances of each element should be present in
the input string.

These are a few of the quantifiers are available in PowerShell.

|Quantifier  |Description  |
|---------|---------|
|`*`|Zero or more times.|
|`+`|One or more times.|
|`?`|Zero or one time.|
|`{n,m}`|At least `n`, but no more than `m` times.|

The asterisk `*` matches the previous element Zero or more times. This means
that even an input string without the element would be a match.

```powershell
# This returns true for all account name strings even if the name is absent.
"ACCOUNT NAME:    Administrator" -match "ACCOUNT NAME:\s*\w*"
```

The plus sign `+` matches the previous element One or more times.

```powershell
# This returns true if it matches any server name.
"DC-01" -match "[A-Z]+-\d\d"
```

The question mark `?` matches the previous element zero or one time. Like
asterisk `*`, it will even match strings where the element is absent.

```powershell
# This returns true for any server name, even ones without dashes.
"SERVER01" -match "[A-Z]+-?\d\d"
```

The `{n, m}` quantifier can be used several different ways to allow granular
control over the quantifier. The second element `m` and the comma `,` are
optional.

|Quantifier  |Description  |
|---------|---------|
|`{n}`|Match EXACTLY `n` number of times.|
|`{n,}`|Match at LEAST `n` number of times.|
|`{n,m}`|Match between `n` and `m` number of times.|

```powershell
# This returns true if it matches any phone number.
"111-222-3333" -match "\d{3}-\d{3}-\d{4}"
```

### Anchors

Anchors allow you to cause a match to succeed or fail based on the matches
position within the input string.

The two commonly used anchors are `^` and `$`. The carat `^` matches the
start of a string, and `$`, which matches the end of a string. This allows
you to match your text at a specific position while also discarding unwanted
characters.

```powershell
# The pattern expects the 'h' to be followed by the end of the word.
# This will return FALSE.
"fishing" -match "^fish$"
```

When using anchors in powershell, you should understand the difference
between **Singleline** and **Multiline** regular expression options.

- **Multiline**: Multiline mode forces `^` and `$` to match the beginning
  end of every LINE instead of the beginning and end of the input string.
- **Singleline**: Singleline mode treats the input string as a *SingleLine*.
  It forces the `.` character to match every character (including newlines),
  instead of matching every character EXCEPT the newline `\n`.

To read more about these options and how to use them, visit the
[Regular Expression Language - Quick Reference](https://go.microsoft.com/fwlink/?LinkId=133231).

### Escaping characters

The backslash `\` is used to escape characters so they are not parsed by the
regular expression engine.

The following characters are reserved: `[]().\^$|?*+{}`.

You will need to escape these characters in your patterns to match
them in your input strings.

```powershell
# This returns true and matches numbers with at least 2 digits of precision.
# The decimal point is escaped using the backslash.
"3.141" -match "3\.\d{2,}"
```

There`s a static method of the regex class that can escape text for you.

```powershell
[regex]::escape("3.\d{2,}")
```

```output
3\.\\d\{2,}
```

> [!NOTE]
> This escapes all reserved regular expression characters, including
> existing backslashes used in character classes.  Be sure to only use it on
> the portion of your pattern that you need to escape.

#### Other character escapes

There are also reserved character escapes that you can use to match special
character types.

The following are a few commonly used character escapes.

|Character Escape  |Description  |
|---------|---------|
|`\t`|Matches a tab|
|`\n`|Matches a newline|
|`\r`|Matches a carriage return|

## See also

[about_Comparison_Operators](about_Comparison_Operators.md)

[about_Operators](about_Operators.md)