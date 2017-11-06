---
ms.date:  2017-06-09
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

| Format  | Logic | Example |
| ------- | ----- | ------- |
| value   | Matches exact characters anywhere in the original value. | "book" -match "oo" |
| .       | Matches any single character. | "copy" -match "c..y" |
| [value] | Matches at least one of the characters in the brackets. | "big" -match "b[iou]g" |
| [range] | Matches at least one of the characters within the range. The use of a hyphen (-) allows you to specify an adjacent character. | "and" -match "[a-e]nd" |
| [^]     | Matches any characters except those in brackets. | "and" -match "[^brt]nd" |
| ^       | Matches the beginning characters. | "book" -match "^bo" |
| $       | Matches the end characters. | "book" -match "ok$" |
| *       | Matches any instances of the preceding character. | "baggy" -match "g*" |
| ?       | Matches zero or one instance of the preceding character. | "baggy" -match "g?" |
| \       | Matches the character that follows as an escaped character. | "Try$" -match "Try\\$" |

Windows PowerShell supports the character classes available in
Microsoft .NET Framework regular expressions.

| Format   | Logic | Example |
| -------- | ----- | ------- |
| \p{name} | Matches any character in the named character class specified by {name}. Supported names are Unicode groups and block ranges such as Ll, Nd, Z, IsGreek, and IsBoxDrawing. | "abcd defg" -match "\p{Ll}+" |
| \P{name} | Matches text not included in the groups and block ranges specified in {name}. | 1234 -match "\P{Ll}+" |
| \w       | Matches any word character. Equivalent to the Unicode character categories [\p{Ll}\p{Lu}\p{Lt}\p{Lo}\p{Nd}\p{Pc}]. If ECMAScript-compliant behavior is specified with the ECMAScript option, \w is equivalent to [a-zA-Z_0-9]. | "abcd defg" -match "\w+" (this matches abcd) |
| \W       | Matches any nonword character. Equivalent to the Unicode categories [^\p{Ll}\p{Lu}\p{Lt}\p{Lo}\p{Nd}\p{Pc}]. | "abcd defg" -match "\W+" (this matches the space) |
| \s       | Matches any white-space character. Equivalent to the Unicode character categories [\f\n\r\t\v\x85\p{Z}]. | "abcd defg" -match "\s+" |
| \S       | Matches any non-white-space character. Equivalent to the Unicode character categories [^\f\n\r\t\v\x85\p{Z}]. | "abcd defg" -match "\S+" |
| \d       | Matches any decimal digit. Equivalent to \p{Nd} for Unicode and [0-9] for non-Unicode behavior. | 12345 -match "\d+" |
| \D       | Matches any nondigit. Equivalent to \P{Nd} for Unicode and [^0-9] for non-Unicode behavior. | "abcd" -match "\D+" |

Windows PowerShell supports the quantifiers available in .NET Framework
regular expressions. The following are some examples of quantifiers.

| Format | Logic | Example |
| ------ | ----- | ------- |
| *      | Specifies zero or more matches; for example, \wor (abc). Equivalent to {0,}. | "abc" -match "\w*" |
| +      | Matches repeating instances of the preceding characters. | "xyxyxy" -match "xy+" |
| ?      | Specifies zero or one matches; for example, \w? or (abc)?. Equivalent to {0,1}. | "abc" -match "\w?" |
| {n}    | Specifies exactly n matches; for example, (pizza){2}. | "abc" -match "\w{2}" |
| {n,}   | Specifies at least n matches; for example, (abc){2,}. | "abc" -match "\w{2,}" |
| {n,m}  | Specifies at least n, but no more than m, matches. | "abc" -match "\w{2,3}" |

All the comparisons shown in the preceding table evaluate to true.

Notice that the escape character for regular expressions, a backslash (\\),
is different from the escape character for Windows PowerShell. The
escape character for Windows PowerShell is the backtick character (`) (ASCII 96).

For more information, see [Regular Expression Language - Quick Reference](https://go.microsoft.com/fwlink/?LinkId=133231).

## SEE ALSO

[about_Comparison_Operators](about_Comparison_Operators.md)

[about_Operators](about_Operators.md)
