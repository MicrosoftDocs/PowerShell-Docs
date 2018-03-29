---
ms.date:  12/01/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Regular_Expressions
---

# About Regular Expressions

## SHORT DESCRIPTION

Describes regular expressions in Windows PowerShell.

## LONG DESCRIPTION

Windows PowerShell supports the following regular expression characters.

```
Format   value
Logic    Matches exact characters anywhere in the original value.
Example  "book" -match "oo"

Format   .
Logic    Matches any single character.
Example  "copy" -match "c..y"

Format   [value]
Logic    Matches at least one of the characters in the brackets.
Example  "big" -match "b[iou]g"

Format   [range]
Logic    Matches at least one of the characters within the range. The use
         of a hyphen (-) allows you to specify an adjacent character.
Example  "and" -match "[a-e]nd"

Format   [^]
Logic    Matches any characters except those in brackets.
Example  "and" -match "[^brt]nd"

Format   ^
Logic    Matches the beginning characters.
Example  "book" -match "^bo"

Format   $
Logic    Matches the end characters.
Example  "book" -match "ok$"

Format   *
Logic    Matches any instances of the preceding character.
Example  "baggy" -match "g*"

Format   ?
Logic    Matches zero or one instance of the preceding character.
Example  "baggy" -match "g?"

Format   \
Logic    Matches the character that follows as an escaped character.
Example  "Try$" -match "Try\\$"
```

Windows PowerShell supports the character classes available in Microsoft .NET
Framework regular expressions.

```
Format:  \p{name}
Logic:   Matches any character in the named character class specified by
         {name}. Supported names are Unicode groups and block ranges such
         as Ll, Nd, Z, IsGreek, and IsBoxDrawing.
Example: "abcd defg" -match "\p{Ll}+"

Format:  \P{name}
Logic:   Matches text not included in the groups and block ranges specified
         in {name}.
Example: 1234 -match "\P{Ll}+"

Format:  \w
Logic:   Matches any word character. Equivalent to the Unicode character
         categories [\p{Ll}\p{Lu}\p{Lt}\p{Lo}\p{Nd}\p{Pc}]. If ECMAScript-
         compliant behavior is specified with the ECMAScript option, \w is
         equivalent to [a-zA-Z_0-9].
Example: "abcd defg" -match "\w+" (this matches abcd)

Format:  \W
Logic:   Matches any nonword character. Equivalent to the Unicode categories
         [^\p{Ll}\p{Lu}\p{Lt}\p{Lo}\p{Nd}\p{Pc}].
Example: "abcd defg" -match "\W+" (this matches the space)

Format:  \s
Logic:   Matches any white-space character. Equivalent to the Unicode
         character categories [\f\n\r\t\v\x85\p{Z}].
Example: "abcd defg" -match "\s+"

Format:  \S
Logic:   Matches any non-white-space character. Equivalent to the Unicode
         character categories [^\f\n\r\t\v\x85\p{Z}].
Example: "abcd defg" -match "\S+"

Format:  \d
Logic:   Matches any decimal digit. Equivalent to \p{Nd} for Unicode and
         [0-9] for non-Unicode behavior.
Example: 12345 -match "\d+"

Format:  \D
Logic:   Matches any nondigit. Equivalent to \P{Nd} for Unicode and [^0-9]
         for non-Unicode behavior.
Example: "abcd" -match "\D+"
```
Windows PowerShell supports the quantifiers available in .NET Framework
regular expressions. The following are some examples of quantifiers.

```
Format:  *
Logic    Specifies zero or more matches; for example, \wor (abc). Equivalent
         to {0,}.
Example: "abc" -match "\w*"

Format:  +
Logic:   Matches repeating instances of the preceding characters.
Example: "xyxyxy" -match "xy+"

Format:  ?
Logic:   Specifies zero or one matches; for example, \w? or (abc)?.
         Equivalent to {0,1}.
Example: "abc" -match "\w?"

Format:  {n}
Logic:   Specifies exactly n matches; for example, (pizza){2}.
Example: "abc" -match "\w{2}"

Format:  {n,}
Logic:   Specifies at least n matches; for example, (abc){2,}.
Example: "abc" -match "\w{2,}"

Format:  {n,m}
Logic:   Specifies at least n, but no more than m, matches.
Example: "abc" -match "\w{2,3}"
```

All the comparisons shown in the preceding table evaluate to true.

Notice that the escape character for regular expressions, a backslash (\\), is
different from the escape character for Windows PowerShell. The escape
character for Windows PowerShell is the backtick character (`) (ASCII 96).

For more information, see [Regular Expression Language - Quick Reference](https://go.microsoft.com/fwlink/?LinkId=133231).

## SEE ALSO

[about_Comparison_Operators](about_Comparison_Operators.md)

[about_Operators](about_Operators.md)