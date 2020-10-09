---
description: Describes regular expressions in PowerShell. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 03/10/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_regular_expressions?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Regular_Expressions
---
# About Regular Expressions

## Short description
Describes regular expressions in PowerShell.

## Long description

> [!NOTE]
> This article will show you the syntax and methods for using regular
> expressions in PowerShell, not all syntax is discussed. For a more complete
> reference, see the
> [Regular Expression Language - Quick Reference](/dotnet/standard/base-types/regular-expression-language-quick-reference).

A regular expression is a pattern used to match text. It can be made up of
literal characters, operators, and other constructs.

This article demonstrates regular expression syntax in PowerShell. PowerShell
has several operators and cmdlets that use regular expressions. You can read
more about their syntax and usage at the links below.

- [Select-String](xref:Microsoft.PowerShell.Utility.Select-String)
- [-match and -replace operators](about_Comparison_Operators.md)
- [-split](about_Split.md)
- [switch statement with -regex option](about_Switch.md)

PowerShell regular expressions are case-insensitive by default. Each method
shown above has a different way to force case sensitivity.

|       Method       |                      Case Sensitivity                      |
| ------------------ | ---------------------------------------------------------- |
| `Select-String`    | use `-CaseSensitive` switch                                |
| `switch` statement | use the `-casesensitive` option                            |
| operators          | prefix with **'c'** (`-cmatch`, `-csplit`, or `-creplace`) |

### Character literals

A regular expression can be a literal character or a string. The expression
causes the engine to match the text specified exactly.

```powershell
# This statement returns true because book contains the string "oo"
'book' -match 'oo'
```

### Character classes

While character literals work if you know the exact pattern, character classes
allow you to be less specific.

#### Character groups

`[character group]` allows you to match any number of characters one time,
while `[^character group]` only matches characters NOT in the group.

```powershell
# This expression returns true if the pattern matches big, bog, or bug.
'big' -match 'b[iou]g'
```

If your list of characters to match includes the hyphen character (`-`), it
must be at the beginning or end of the list to distinguish it from a character
range expression.

#### Character ranges

A pattern can also be a range of characters. The characters can be alphabetic `[A-Z]`,
numeric `[0-9]`, or even ASCII-based `[ -~]` (all printable characters).

```powershell
# This expression returns true if the pattern matches any 2 digit number.
42 -match '[0-9][0-9]'
```

#### Numbers

The `\d` character class will match any decimal digit. Conversely, `\D` will
match any non-decimal digit.

```powershell
# This expression returns true if it matches a server name.
# (Server-01 - Server-99).
'Server-01' -match 'Server-\d\d'
```

#### Word characters

The `\w` character class will match any word character `[a-zA-Z_0-9]`. To match
any non-word character, use `\W`.

```powershell
# This expression returns true.
# The pattern matches the first word character 'B'.
'Book' -match '\w'
```

#### Wildcards

The period (`.`) is a wildcard character in regular expressions. It will match
any character except a newline (`\n`).

```powershell
# This expression returns true.
# The pattern matches any 4 characters except the newline.
'a1\ ' -match '....'
```

#### Whitespace

Whitespace is matched using the `\s` character class. Any non-whitespace
character is matched using `\S`. Literal space characters `' '` can also be
used.

```powershell
# This expression returns true.
# The pattern uses both methods to match the space.
' - ' -match '\s- '
```

### Quantifiers

Quantifiers control how many instances of each element should be present in the
input string.

The following are a few of the quantifiers available in PowerShell:

| Quantifier |                Description                |
| ---------- | ----------------------------------------- |
| `*`        | Zero or more times.                       |
| `+`        | One or more times.                        |
| `?`        | Zero or one time.                         |
| `{n,m}`    | At least `n`, but no more than `m` times. |

The asterisk (`*`) matches the previous element zero or more times. The result
is that even an input string without the element would be a match.

```powershell
# This returns true for all account name strings even if the name is absent.
'ACCOUNT NAME:    Administrator' -match 'ACCOUNT NAME:\s*\w*'
```

The plus sign (`+`) matches the previous element one or more times.

```powershell
# This returns true if it matches any server name.
'DC-01' -match '[A-Z]+-\d\d'
```

The question mark `?` matches the previous element zero or one time. Like
asterisk `*`, it will even match strings where the element is absent.

```powershell
# This returns true for any server name, even server names without dashes.
'SERVER01' -match '[A-Z]+-?\d\d'
```

The `{n, m}` quantifier can be used several different ways to allow granular
control over the quantifier. The second element `m` and the comma `,` are
optional.

| Quantifier |                Description                 |
| ---------- | ------------------------------------------ |
| `{n}`      | Match EXACTLY `n` number of times.         |
| `{n,}`     | Match at LEAST `n` number of times.        |
| `{n,m}`    | Match between `n` and `m` number of times. |

```powershell
# This returns true if it matches any phone number.
'111-222-3333' -match '\d{3}-\d{3}-\d{4}'
```

### Anchors

Anchors allow you to cause a match to succeed or fail based on the matches
position within the input string.

The two commonly used anchors are `^` and `$`. The caret `^` matches the start
of a string, and `$`, which matches the end of a string. The anchors allow you
to match your text at a specific position while also discarding unwanted
characters.

```powershell
# The pattern expects the string 'fish' to be the only thing on the line.
# This returns FALSE.
'fishing' -match '^fish$'
```

> [!NOTE]
> When defining a regex containing an `$` anchor, be sure to enclose the regex
> using single quotes (`'`) instead of double quotes (`"`) or PowerShell will
> expand the expression as a variable.

When using anchors in PowerShell, you should understand the difference between
**Singleline** and **Multiline** regular expression options.

- **Multiline**: Multiline mode forces `^` and `$` to match the beginning end
  of every LINE instead of the beginning and end of the input string.
- **Singleline**: Singleline mode treats the input string as a **SingleLine**.
  It forces the `.` character to match every character (including newlines),
  instead of matching every character EXCEPT the newline `\n`.

To read more about these options and how to use them, visit the
[Regular Expression Language - Quick Reference](/dotnet/standard/base-types/regular-expression-language-quick-reference).

### Escaping characters

The backslash (`\`) is used to escape characters so they aren't parsed by the
regular expression engine.

The following characters are reserved: `[]().\^$|?*+{}`.

You'll need to escape these characters in your patterns to match them in your
input strings.

```powershell
# This returns true and matches numbers with at least 2 digits of precision.
# The decimal point is escaped using the backslash.
'3.141' -match '3\.\d{2,}'
```

There`s a static method of the regex class that can escape text for you.

```powershell
[regex]::escape('3.\d{2,}')
```

```Output
3\.\\d\{2,}
```

> [!NOTE]
> This escapes all reserved regular expression characters, including existing
> backslashes used in character classes. Be sure to only use it on the portion
> of your pattern that you need to escape.

#### Other character escapes

There are also reserved character escapes that you can use to match special
character types.

The following are a few commonly used character escapes:

|Character Escape  |Description  |
|---------|---------|
|`\t`|Matches a tab|
|`\n`|Matches a newline|
|`\r`|Matches a carriage return|

### Groups, Captures, and Substitutions

Grouping constructs separate an input string into substrings that can be
captured or ignored. Grouped substrings are called subexpressions. By default
subexpressions are captured in numbered groups, though you can assign names to
them as well.

A grouping construct is a regular expression surrounded by parentheses. Any
text matched by the enclosed regular expression is captured. The following
example will break the input text into two capturing groups.

```powershell
'The last logged on user was CONTOSO\jsmith' -match '(.+was )(.+)'
```

```Output
True
```

Use the `$Matches` **Hashtable** automatic variable to retrieve captured text.
The text representing the entire match is stored at key `0`.

```powershell
$Matches.0
```

```Output
The last logged on user was CONTOSO\jsmith
```

Captures are stored in numeric **Integer** keys that increase from left to
right. Capture `1` contains all the text until the username, capture `2`
contains just the username.

```powershell
$Matches
```

```Output
Name                           Value
----                           -----
2                              CONTOSO\jsmith
1                              The last logged on user was
0                              The last logged on user was CONTOSO\jsmith
```

> [!IMPORTANT]
> The `0` key is an **Integer**. You can use any **Hashtable** method to access
> the value stored.
>
> ```
> PS> 'Good Dog' -match 'Dog'
> True
>
> PS> $Matches[0]
> Dog
>
> PS> $Matches.Item(0)
> Dog
>
> PS> $Matches.0
> Dog
> ```

#### Named Captures

By default, captures are stored in ascending numeric order, from left to right.
You can also assign a **name** to a capturing group. This **name** becomes a
key on the `$Matches` **Hashtable** automatic variable.

Inside a capturing group, use `?<keyname>` to store captured data under a named
key.

```
PS> $string = 'The last logged on user was CONTOSO\jsmith'
PS> $string -match 'was (?<domain>.+)\\(?<user>.+)'
True

PS> $Matches

Name                           Value
----                           -----
domain                         CONTOSO
user                           jsmith
0                              was CONTOSO\jsmith

PS> $Matches.domain
CONTOSO

PS> $Matches.user
jsmith
```

The following example stores the newest log entry in the Windows Security Log.
The provided regular expression extracts the username and domain from the
message and stores them under the keys:**N** for name and **D** for domain.

```powershell
$log = (Get-WinEvent -LogName Security -MaxEvents 1).message
$r = '(?s).*Account Name:\s*(?<N>.*).*Account Domain:\s*(?<D>[A-Z,0-9]*)'
$log -match $r
```

```Output
True
```

```powershell
$Matches
```

```Output
Name                           Value
----                           -----
D                              CONTOSO
N                              jsmith
0                              A process has exited....
```

For more information, see
[Grouping Constructs in Regular Expressions](/dotnet/standard/base-types/grouping-constructs-in-regular-expressions).

#### Substitutions in Regular Expressions

Using the regular expressions with the `-replace` operator allows you to
dynamically replace text using captured text.

`<input> -replace <original>, <substitute>`

- `<input>`: The string to be searched
- `<original>`: A regular expression used to search the input string
- `<substitute>`: A regular expression substitution expression to replace
  matches found in the input string.

> [!NOTE]
> The `<original>` and `<substitute>` operands are subject to rules of the
> regular expression engine such as character escaping.

Capturing groups can be referenced in the `<substitute>` string. The
substitution is done by using the `$` character before the group identifier.

Two ways to reference capturing groups are by **Number** and by **Name**.

- By **Number** - Capturing Groups are numbered from left to right.

  ```powershell
  'John D. Smith' -replace '(\w+) (\w+)\. (\w+)', '$1.$2.$3@contoso.com'
  ```

  ```Output
  John.D.Smith@contoso.com
  ```

- By **Name** - Capturing Groups can also be referenced by name.

  ```powershell
  'CONTOSO\Administrator' -replace '\w+\\(?<user>\w+)', 'FABRIKAM\${user}'
  ```

  ```Output
  FABRIKAM\Administrator
  ```

The `$&` expression represents all the text matched.

```powershell
'Gobble' -replace 'Gobble', '$& $&'
```

```Output
Gobble Gobble
```

> [!WARNING]
> Since the `$` character is used in string expansion, you'll need to use
> literal strings with substitution, or escape the `$` character when using
> double quotes.
>
> ```powershell
> 'Hello World' -replace '(\w+) \w+', '$1 Universe'
> "Hello World" -replace "(\w+) \w+", "`$1 Universe"
> ```
>
> ```Output
> Hello Universe
> Hello Universe
> ```
>
> Additionally, if you want to have the `$` as a literal character, use `$$`
> instead of the normal escape characters. When using double quotes, still
> escape all instances of `$` to avoid incorrect substitution.
>
> ```powershell
> '5.72' -replace '(.+)', '$$$1'
> "5.72" -replace "(.+)", "`$`$`$1"
> ```
>
> ```Output
> $5.72
> $5.72
> ```

For more information, see [Substitutions in Regular Expressions](/dotnet/standard/base-types/substitutions-in-regular-expressions).

## See also

[about_Comparison_Operators](about_Comparison_Operators.md)

[about_Operators](about_Operators.md)
