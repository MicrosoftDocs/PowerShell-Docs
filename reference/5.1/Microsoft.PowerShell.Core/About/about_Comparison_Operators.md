---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  about_Comparison_Operators
ms.technology:  powershell
---

# About Comparison Operators
## about_Comparison_Operators

# SHORT DESCRIPTION

Describes the operators that compare values in Windows PowerShell.

# LONG DESCRIPTION

Comparison operators let you specify conditions for comparing values and
finding values that match specified patterns. To use a comparison operator,
specify the values that you want to compare together with an operator that
separates these values.

Windows PowerShell includes the following comparison operators:

-eq  
-ne  
-gt  
-ge  
-lt  
-le  
-like  
-notlike  
-match  
-notmatch  
-contains  
-notcontains  
-in  
-notin  
-replace

By default, all comparison operators are case-insensitive. To make a
comparison operator case-sensitive, precede the operator name with a "c".
For example, the case-sensitive version of "-eq" is "-ceq". To make the
case-insensitivity explicit, precede the operator with an "i". For example,
the explicitly case-insensitive version of "-eq" is "-ieq".

When the input to an operator is a scalar value, comparison operators
return a Boolean value. When the input is a collection of values, the
comparison operators return any matching values. If there are no matches
in a collection, comparison operators do not return anything.

The exceptions are the containment operators (-Contains, -NotContains),
the In operators (-In, -NotIn), and the type operators (-Is, -IsNot),
which always return a Boolean value.

Windows PowerShell supports the following comparison operators.

**-eq**  
Description: Equal to. Includes an identical value.  

Example:
```PowerShell
PS C:> "abc" -eq "abc"
True

PS C:> "abc" -eq "abc", "def"
False

PS C:> "abc", "def" -eq "abc"
abc
```

**-ne**  
Description: Not equal to. Includes a different value.  

Example:
```PowerShell
PS C:> "abc" -ne "def"
True

PS C:> "abc" -ne "abc"
False

PS C:> "abc" -ne "abc", "def"
True

PS C:> "abc", "def" -ne "abc"
def
```

**-gt**  
Description: Greater-than.  

Example:

```PowerShell
PS C:> 8 -gt 6
True

PS C:> 7, 8, 9 -gt 8
9
```

**-ge**  
Description: Greater-than or equal to.  

Example:

```Powershell
PS C:> 8 -ge 8
True

PS C:> 7, 8, 9 -ge 8
8
9
```

**-lt**  
Description: Less-than.  

Example:

```Powershell

PS C:> 8 -lt 6
False

PS C:> 7, 8, 9 -lt 8
7
```

**-le**  
Description: Less-than or equal to.  

Example:
```PowerSHell
PS C:> 6 -le 8
True

PS C:> 7, 8, 9 -le 8
7
8
```

**-like**  
Description: Match using the wildcard character (\*).
Example:

```PowerShell
PS C:> "Windows PowerShell" -like "*shell"
True

PS C:> "Windows PowerShell", "Server" -like "*shell"
Windows PowerShell
```

**-notlike**  
Description: Does not match using the wildcard character (\*).  

Example:
```PowerShell
PS C:> "Windows PowerShell" -notlike "*shell"
False

PS C:> "Windows PowerShell", "Server" -notlike "*shell"
Server
```

**-match**  
Description: Matches a string using regular expressions.
When the input is scalar, it populates the
$Matches automatic variable.  

Example:
```PowerShell
PS C:> "Sunday" -match "sun"
True

PS C:> $matches
Name Value
---- -----
0    Sun

PS C:> "Sunday", "Monday" -match "sun"
Sunday
```

**-notmatch**  
Description: Does not match a string. Uses regular expressions.
When the input is scalar, it populates the $Matches
automatic variable.  

Example:

```PowerShell
PS C:> "Sunday" -notmatch "sun"
False

PS C:> $matches
Name Value
---- -----
0    sun

PS C:> "Sunday", "Monday" -notmatch "sun"
Monday
```

**-contains**  
Description: Containment operator. Tells whether a collection of reference
values includes a single test value. Always returns a Boolean value. Returns TRUE
only when the test value exactly matches at least one of the reference values.

When the test value is a collection, the Contains operator uses reference
equality. It returns TRUE only when one of the reference values is the same
instance of the test value object.

Syntax:  
\<Reference-values> -Contains \<Test-value>

Examples:  
```PowerShell
PS C:> "abc", "def" -contains "def"  
True

PS C:> "Windows", "PowerShell" -contains "Shell"  
False  #Not an exact match

# Does the list of computers in $DomainServers
include $ThisComputer?
PS C:> $DomainServers -contains $thisComputer  
True

PS C:> "abc", "def", "ghi" -contains "abc", "def"  
False

PS C:> $a = "abc", "def"  
PS C:> "abc", "def", "ghi" -contains $a  
False  
PS C:> $a, "ghi" -contains $a  
True
``` 

**-notcontains**  
Description: Containment operator. Tells whether a collection of reference
values includes a single test value. Always returns a Boolean value. Returns
TRUE when the test value is not an exact matches for at least one of the reference
values.

When the test value is a collection, the NotContains operator uses reference
equality.

Syntax:
\<Reference-values> -NotContains \<Test-value>

Examples:
```PowerShell
PS C:> "Windows", "PowerShell" -notcontains "Shell"
True  #Not an exact match

# Get cmdlet parameters, but exclude common parameters
function get-parms ($cmdlet)
{
$Common = "Verbose", "Debug", "WarningAction", "WarningVariable", `
"ErrorAction", "ErrorVariable", "OutVariable", "OutBuffer"

$allparms = (Get-Command $Cmdlet).parametersets | foreach {$_.Parameters} | `
foreach {$_.Name} | Sort-Object | Get-Unique

$allparms | where {$Common -notcontains $_ }
}

# Find unapproved verbs in the functions in my module
PS C:> $ApprovedVerbs = Get-Verb | foreach {$_.verb}
PS C:> $myVerbs = Get-Command -Module MyModule | foreach {$_.verb}
PS C:> $myVerbs | where {$ApprovedVerbs -notcontains $_}
ForEach
Sort
Tee
Where
```

**-in**  
Description: In operator. Tells whether a test value appears in a collection
of reference values. Always return as Boolean value. Returns TRUE only when
the test value exactly matches at least one of the reference values.

When the test value is a collection, the In operator uses reference equality.
It returns TRUE only when one of the reference values is the same
instance of the test value object.

The -In operator was introduced in Windows PowerShell 3.0.

Syntax:
\<Test-value> -in \<Reference-values>

Examples:  
```PowerShell
PS C:> "def" -in "abc", "def"
True

PS C:> "Shell" -in "Windows", "PowerShell"
False  #Not an exact match

PS C:> "Windows" -in "Windows", "PowerShell"
True  #An exact match

PS C:> "Windows", "PowerShell" -in "Windows", "PowerShell", "ServerManager"
False  #Using reference equality

PS C:> $a = "Windows", "PowerShell"
PS C:> $a -in $a, "ServerManager"
True  #Using reference equality

# Does the list of computers in $domainServers include $thisComputer?
PS C:> $thisComputer -in  $domainServers
True
```
**-notin**  
Description: Tells whether a test value appears in a collection
of reference values. Always returns a Boolean value. Returns TRUE when the test
value is not an exact match for at least one of the reference values.

When the test value is a collection, the In operator uses reference equality.
It returns TRUE only when one of the reference values is the same
instance of the test value object.

The -NotIn operator was introduced in Windows PowerShell 3.0.

Syntax:
\<Test-value> -NotIn \<Reference-values>

Examples:
```PowerShell
PS C:> "def" -notin "abc", "def"
False

PS C:> "ghi" -notin "abc", "def"
True

PS C:> "Shell" -notin "Windows", "PowerShell"
True  #Not an exact match

PS C:> "Windows" -notin "Windows", "PowerShell"
False  #An exact match

# Find unapproved verbs in the functions in my module
PS C:> $ApprovedVerbs = Get-Verb | foreach {$_.verb}
PS C:> $MyVerbs = Get-Command -Module MyModule | foreach {$_.verb}

PS C:> $MyVerbs | where {$_ -notin $ApprovedVerbs}
ForEach
Sort
Tee
Where
```

**-replace**  
Description: Replace operator. Changes the specified elements of a value.
Example:
```PowerShell
PS C:> "Get-Process" -replace "Get", "Stop"
Stop-Process

# Change all .GIF file name extension to .JPG
PS C:> dir *.gif | foreach {$_ -replace ".gif", ".jpg"}
```

**Equality Operators**
The equality operators (-eq, -ne) return a value of TRUE or the matches
when one or more of the input values is identical to the specified
pattern. The entire pattern must match an entire value.

Example:
```PowerShell
C:PS> 2 -eq 2
True

C:PS> 2 -eq 3
False

C:PS> 1,2,3 -eq 2
2

C:PS> "PowerShell" -eq "Shell"
False

C:PS> "Windows", "PowerShell" -eq "Shell"
C:PS>

PS C:> "abc", "def", "123" -eq "def"
def

PS C:> "abc", "def", "123" -ne "def"
abc
123
```


**Containment Operators**  
The containment operators (-Contains and -NotContains) are similar to the
equality operators. However, the containment operators always return a
Boolean value, even when the input is a collection.

Also, unlike the equality operators, the containment operators return a
value as soon as they detect the first match. The equality operators
evaluate all input and then return all the matches in the collection.

The following examples show the effect of the -Contains operator:
```PowerShell
C:PS> 1,2,3 -contains 2
True

C:PS> "PowerShell" -contains "Shell"
False

C:PS> "Windows", "PowerShell" -contains "Shell"
False

PS C:> "abc", "def", "123" -contains "def"
True

PS C:> "true", "blue", "six" -contains "true"
True
```

The following example shows how the containment operators differ from the
equal to operator. The containment operators return a value of TRUE on the
first match.

```PowerShell
PS C:> 1,2,3,4,5,4,3,2,1 -eq 2
2
2

PS C:> 1,2,3,4,5,4,3,2,1 -contains 2
True
```
In a very large collection, the -Contains operator returns results
quicker than the equal to operator.

**Match Operators**  
The match operators (-Match and -NotMatch) find elements that match or
do not match a specified pattern using regular expressions.

The syntax is:

\<string[]> -Match \<regular-expression>
\<string[]> -NotMatch \<regular-expression>

The following examples show some uses of the -Match operator:

```Powershell
PS C:> "Windows", "PowerShell" -Match ".shell"
PowerShell

PS C:> (Get-Command Get-Member -Syntax) -Match "-view"
True

PS C:> (Get-Command Get-Member -Syntax) -NotMatch "-path"
True

PS C:> (Get-Content Servers.txt) -Match "^Server\d\d"
Server01
Server02
```
The match operators search only in strings. They cannot search in arrays
of integers or other objects.

The -Match and -NotMatch operators populate the $Matches automatic
variable when the input (the left-side argument) to the operator
is a single scalar object. When the input is scalar, the -Match and
-NotMatch operators return a Boolean value and set the value of the
$Matches automatic variable to the matched components of the argument.

If the input is a collection, the -Match and -NotMatch operators return
the matching members of that collection, but the operator does not
populate the $Matches variable.

For example, the following command submits a collection of strings to
the -Match operator. The -Match operator returns the items in the collection
that match. It does not populate the $Matches automatic variable.

```PowerShell
PS C:> "Sunday", "Monday", "Tuesday" -Match "sun"
Sunday

PS C:> $matches
PS C:>
```

In contrast, the following command submits a single string to the
-Match operator. The -Match operator returns a Boolean value and
populates the $Matches automatic variable.

```PowerShell
PS C:> "Sunday" -Match "sun"
True

PS C:> $matches

Name                           Value
----                           -----
0                              Sun
```

The -NotMatch operator populates the $Matches automatic variable when
the input is scalar and the result is False, that it, when it detects
a match.

```PowerShell
PS C:> "Sunday" -NotMatch "rain"
True

PS C:> $matches
# PS C:>


PS C:> "Sunday" -NotMatch "day"
False

PS C:> $matches

Name                           Value
----                           -----
0                              day
```

**Replace Operator**  
The -Replace operator replaces all or part of a value with the specified
value using regular expressions. You can use the -Replace operator for
many administrative tasks, such as renaming files. For example, the
following command changes the file name extensions of all .gif files
to .jpg:

```PowerShell
Get-ChildItem | Rename-Item -NewName { $_ -Replace '.gif$','.jpg$' }
```

The syntax of the -Replace operator is as follows, where the \<original>
placeholder represents the characters to be replaced, and the
\<substitute> placeholder represents the characters that will replace
them:

\<input> \<operator> \<original>, \<substitute>

By default, the -Replace operator is case-insensitive. To make it case
sensitive, use -cReplace. To make it explicitly case-insensitive, use
-iReplace. Consider the following examples:

```PowerShell
PS C:> "book" -Replace "B", "C"
Cook
PS C:> "book" -iReplace "B", "C"
Cook
PS C:> "book" -cReplace "B", "C"
book
```

**Bitwise Operators**  
Windows PowerShell supports the standard bitwise operators, including
bitwise-AND (-bAnd), the inclusive and exclusive bitwise-OR operators
(-bOr and -bXor), and bitwise-NOT (-bNot).

Beginning in Windows PowerShell 2.0, all bitwise operators work with
64-bit integers.

Beginning in Windows PowerShell 3.0, the -shr (shift-right) and
-shl (shift-left) are introduced to support bitwise arithmetic in
Windows PowerShell.

Windows PowerShell supports the following bitwise operators.

Operator  Description               Example
--------  ----------------------    -------------------
-bAnd     Bitwise AND               PS C:> 10 -band 3
2

-bOr      Bitwise OR (inclusive)    PS C:> 10 -bor 3
11

-bXor     Bitwise OR (exclusive)    PS C:> 10 -bxor 3
9

-bNot     Bitwise NOT               PS C:> -bNot 10
-11

-shl      Shift-left                PS C:> 100 -shl 2
400

-shr      Shift-right               PS C:> 100 -shr 1
50

Bitwise operators act on the binary format of a value. For example, the
bit structure for the number 10 is 00001010 (based on 1 byte), and the
bit structure for the number 3 is 00000011. When you use a bitwise
operator to compare 10 to 3, the individual bits in each byte are
compared.

In a bitwise AND operation, the resulting bit is set to 1 only when both
input bits are 1.

1010      (10)  
0011      ( 3)  
------------  bAND  
0010      ( 2)


In a bitwise OR (inclusive) operation, the resulting bit is set to 1
when either or both input bits are 1. The resulting bit is set to 0 only
when both input bits are set to 0.

1010      (10)  
0011      ( 3)  
--------------  bOR (inclusive)  
1011      (11)


In a bitwise OR (exclusive) operation, the resulting bit is set to 1 only
when one input bit is 1.

1010      (10)  
0011      ( 3)  
------------  bXOR (exclusive)  
1001      ( 9)


The bitwise NOT operator is a unary operator that produces the binary
complement of the value. A bit of 1 is set to 0 and a bit of 0 is set
to 1.

For example, the binary complement of 0 is -1, the maximum unsigned
integer (0xffffffff), and the binary complement of -1 is 0.

```PowerShell
PS C:> -bNOT 10
-11
```

0000 0000 0000 1010  (10)  
------------------------- bNOT  
1111 1111 1111 0101  (-11, xfffffff5)

In a bitwise shift-left operation, all bits are moved "n" places to
the left, where "n" is the value of the right operand. A zero is
inserted in the ones place.

When the left operand is an Integer (32-bit) value, the lower 5 bits
of the right operand determine how many bits of the left operand are
shifted.

When the left operand is a Long (64-bit) value, the lower 6 bits of
the right operand determine how many bits of the left operand are
shifted.

```PowerShell
PS C:> 21 -shl 1
42

# 00010101  (21)
# 00101010  (42)


PS C:> 21 -shl 2
84


#00010101  (21)
#00101010  (42)
#01010100  (84)
```

In a bitwise shift-right operation, all bits are moved "n" places
to the right, where "n" is specified by the right operand. The
shift-right operator (-shr) inserts a zero in the left-most
place when shifting a positive or unsigned value to the right.

When the left operand is an Integer (32-bit) value, the lower 5 bits
of the right operand determine how many bits of the left operand are
shifted.

When the left operand is a Long (64-bit) value, the lower 6 bits of
the right operand determine how many bits of the left operand are
shifted.

```PowerShell
PS C:> 21 -shr 1
10

# 00010101  (21)
# 00001010  (10)

PS C:> 21 -shr 2
5
00010101  (21)
00001010  (10)
00000101  ( 5)
```

# SEE ALSO

about_Operators

about_Regular_Expressions

about_Wildcards

Compare-Object

Foreach-Object

Where-Object

