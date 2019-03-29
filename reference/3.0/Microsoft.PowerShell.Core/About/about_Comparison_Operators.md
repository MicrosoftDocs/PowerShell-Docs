---
ms.date:  01/18/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Comparison_Operators
---
# About Comparison Operators

## Short description

Describes the operators that compare values in PowerShell.

## Long description

Comparison operators let you specify conditions for comparing values and
finding values that match specified patterns. To use a comparison operator,
specify the values that you want to compare together with an operator that
separates these values.

PowerShell includes the following comparison operators:

| Type        | Operators    | Description                                 |
| ----------- | ------------ | --------------------------------------------|
| Equality    | -eq          | equals                                      |
|             | -ne          | not equals                                  |
|             | -gt          | greater than                                |
|             | -ge          | greater than or equal                       |
|             | -lt          | less than                                   |
|             | -le          | less than or equal                          |
|             |              |                                             |
| Matching    | -like        | Returns true when string matches wildcard   |
|             |              | pattern                                     |
|             | -notlike     | Returns true when string does not match     |
|             |              | wildcard pattern                            |
|             | -match       | Returns true when string matches regex      |
|             |              | pattern; $matches contains matching strings |
|             | -notmatch    | Returns true when string does not match     |
|             |              | regex pattern; $matches contains matching   |
|             |              | strings                                     |
|             |              |                                             |
| Containment | -contains    | Returns true when reference value contained |
|             |              | in a collection                             |
|             | -notcontains | Returns true when reference value not       |
|             |              | contained in a collection                   |
|             | -in          | Returns true when test value contained in a |
|             |              | collection                                  |
|             | -notin       | Returns true when test value not contained  |
|             |              | in a collection                             |
|             |              |                                             |
| Replacement | -replace     | Replaces a string pattern                   |
|             |              |                                             |
| Type        | -is          | Returns true if both object are the same    |
|             |              | type                                        |
|             | -isnot       | Returns true if the objects are not the same|
|             |              | type                                        |

By default, all comparison operators are case-insensitive. To make a
comparison operator case-sensitive, precede the operator name with a `c`. For
example, the case-sensitive version of `-eq` is `-ceq`. To make the
case-insensitivity explicit, precede the operator with an `i`. For example,
the explicitly case-insensitive version of `-eq` is `-ieq`.

When the input to an operator is a scalar value, comparison operators return a
Boolean value. When the input is a collection of values, the comparison
operators return any matching values. If there are no matches in a collection,
comparison operators do not return anything.

The exceptions are the containment operators (`-contains`, `-notcontains`),
the In operators (`-in`, `-notin`), and the type operators (`-is`, `-isnot`),
which always return a Boolean value.

### Equality Operators

The equality operators (`-eq`, `-ne`) return a value of TRUE or the matches
when one or more of the input values is identical to the specified pattern.
The entire pattern must match an entire value.

Example:

#### -eq

Description: Equal to. Includes an identical value.

Example:

```powershell
C:PS> 2 -eq 2
True

C:PS> 2 -eq 3
False

C:PS> 1,2,3 -eq 2
2
PS> "abc" -eq "abc"
True

PS> "abc" -eq "abc", "def"
False

PS> "abc", "def" -eq "abc"
abc
```

#### -ne

Description: Not equal to. Includes a different value.

Example:

```powershell
PS> "abc" -ne "def"
True

PS> "abc" -ne "abc"
False

PS> "abc" -ne "abc", "def"
True

PS> "abc", "def" -ne "abc"
def
```

#### -gt

Description: Greater-than.

Example:

```powershell
PS> 8 -gt 6
True

PS> 7, 8, 9 -gt 8
9
```

> [!NOTE]
> This should not to be confused with `>`, the greater-than operator in many other programming languages. In PowerShell, `>` is used for redirection. For more information, see [About_redirection](about_Redirection.md#potential-confusion-with-comparison-operators).

#### -ge

Description: Greater-than or equal to.

Example:

```powershell
PS> 8 -ge 8
True

PS> 7, 8, 9 -ge 8
8
9
```

#### -lt

Description: Less-than.

Example:

```powershell

PS> 8 -lt 6
False

PS> 7, 8, 9 -lt 8
7
```

#### -le

Description: Less-than or equal to.

Example:

```powershell
PS> 6 -le 8
True

PS> 7, 8, 9 -le 8
7
8
```

### Matching Operators

The like operators (`-like` and `-notlike`) find elements that match or do not
match a specified pattern using wildcard expressions.

The syntax is:

```powershell
<string[]> -like <wildcard-expression>
<string[]> -notlike <wildcard-expression>
```

The match operators (`-match` and `-notmatch`) find elements that match or do
not match a specified pattern using regular expressions.

The match operators populate the `$Matches` automatic variable when the input
(the left-side argument) to the operator is a single scalar object. When the
input is scalar, the `-match` and `-notmatch` operators return a Boolean value
and set the value of the `$Matches` automatic variable to the matched
components of the argument.

The syntax is:

```powershell
<string[]> -match <regular-expression>
<string[]> -notmatch <regular-expression>
```

#### -like

Description: Match using the wildcard character (\*).

Example:

```powershell
PS> "PowerShell" -like "*shell"
True

PS> "PowerShell", "Server" -like "*shell"
PowerShell
```

#### -notlike

Description: Does not match using the wildcard character (\*).

Example:

```powershell
PS> "PowerShell" -notlike "*shell"
False

PS> "PowerShell", "Server" -notlike "*shell"
Server
```

### -match

Description: Matches a string using regular expressions. When the input is
scalar, it populates the `$Matches` automatic variable.

The match operators search only in strings. They cannot search in arrays of
integers or other objects.

If the input is a collection, the `-match` and `-notmatch` operators return
the matching members of that collection, but the operator does not populate
the `$Matches` variable.

For example, the following command submits a collection of strings to the
`-match` operator. The `-match` operator returns the items in the collection
that match. It does not populate the `$Matches` automatic variable.

```powershell
PS> "Sunday", "Monday", "Tuesday" -match "sun"
Sunday

PS> $Matches
PS>
```

In contrast, the following command submits a single string to the `-match`
operator. The `-match` operator returns a Boolean value and populates the
`$Matches` automatic variable. The `$Matches` automatic variable is a
**Hashtable**. If no grouping or capturing is used, only one key is populated.
The `0` key represents all text that was matched. For more information about
grouping and capturing using regular expressions, see
[about_Regular_Expressions](about_Regular_Expressions.md).

```powershell
PS> "Sunday" -match "sun"
True

PS> $Matches

Name                           Value
----                           -----
0                              Sun
```

It is important to note that the `$Matches` hashtable will only contain the
first occurrence of any matching pattern.

```powershell
PS> "Banana" -match "na"
True

PS> $Matches

Name                           Value
----                           -----
0                              na
```

> [!IMPORTANT]
> The `0` key is an **Integer**. You can use any **Hashtable** method to access
> the value stored.
>
> ```powershell
> PS> "Good Dog" -match "Dog"
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

The `-notmatch` operator populates the `$Matches` automatic variable when the
input is scalar and the result is False, that it, when it detects a match.

```powershell
PS> "Sunday" -notmatch "rain"
True

PS> $matches
PS>

PS> "Sunday" -notmatch "day"
False

PS> $matches

Name                           Value
----                           -----
0                              day
```

#### -notmatch

Description: Does not match a string. Uses regular expressions. When the input
is scalar, it populates the `$Matches` automatic variable.

Example:

```powershell
PS> "Sunday" -notmatch "sun"
False

PS> $matches
Name Value
---- -----
0    sun

PS> "Sunday", "Monday" -notmatch "sun"
Monday
```

### Containment Operators

The containment operators (`-contains` and `-notcontains`) are similar to the
equality operators. However, the containment operators always return a Boolean
value, even when the input is a collection.

Also, unlike the equality operators, the containment operators return a value
as soon as they detect the first match. The equality operators evaluate all
input and then return all the matches in the collection.

#### -contains

Description: Containment operator. Tells whether a collection of reference
values includes a single test value. Always returns a Boolean value. Returns
TRUE only when the test value exactly matches at least one of the reference
values.

When the test value is a collection, the Contains operator uses reference
equality. It returns TRUE only when one of the reference values is the same
instance of the test value object.

In a very large collection, the `-contains` operator returns results quicker
than the equal to operator.

Syntax:

`<Reference-values> -contains <Test-value>`

Examples:

```powershell
PS> "abc", "def" -contains "def"
True

PS> "Windows", "PowerShell" -contains "Shell"
False  #Not an exact match

# Does the list of computers in $DomainServers include $ThisComputer?
PS> $DomainServers -contains $thisComputer
True

PS> "abc", "def", "ghi" -contains "abc", "def"
False

PS> $a = "abc", "def"
PS> "abc", "def", "ghi" -contains $a
False
PS> $a, "ghi" -contains $a
True
```

#### -notcontains

Description: Containment operator. Tells whether a collection of reference
values includes a single test value. Always returns a Boolean value. Returns
TRUE when the test value is not an exact matches for at least one of the
reference values.

When the test value is a collection, the NotContains operator uses reference
equality.

Syntax:

`<Reference-values> -notcontains <Test-value>`

Examples:

```powershell
PS> "Windows", "PowerShell" -notcontains "Shell"
True  #Not an exact match

# Get cmdlet parameters, but exclude common parameters
function get-parms ($cmdlet)
{
    $Common = "Verbose", "Debug", "WarningAction", "WarningVariable",
      "ErrorAction", "ErrorVariable", "OutVariable", "OutBuffer"

    $allparms = (Get-Command $Cmdlet).parametersets |
      foreach {$_.Parameters} |
        foreach {$_.Name} | Sort-Object | Get-Unique

    $allparms | where {$Common -notcontains $_ }
}

# Find unapproved verbs in the functions in my module
PS> $ApprovedVerbs = Get-Verb | foreach {$_.verb}
PS> $myVerbs = Get-Command -Module MyModule | foreach {$_.verb}
PS> $myVerbs | where {$ApprovedVerbs -notcontains $_}
ForEach
Sort
Tee
Where
```

#### -in

Description: In operator. Tells whether a test value appears in a collection
of reference values. Always return as Boolean value. Returns TRUE only when
the test value exactly matches at least one of the reference values.

When the test value is a collection, the In operator uses reference equality.
It returns TRUE only when one of the reference values is the same instance of
the test value object.

The `-in` operator was introduced in PowerShell 3.0.

Syntax:

`<Test-value> -in <Reference-values>`

Examples:

```powershell
PS> "def" -in "abc", "def"
True

PS> "Shell" -in "Windows", "PowerShell"
False  #Not an exact match

PS> "Windows" -in "Windows", "PowerShell"
True  #An exact match

PS> "Windows", "PowerShell" -in "Windows", "PowerShell", "ServerManager"
False  #Using reference equality

PS> $a = "Windows", "PowerShell"
PS> $a -in $a, "ServerManager"
True  #Using reference equality

# Does the list of computers in $DomainServers include $ThisComputer?
PS> $thisComputer -in  $domainServers
True
```

#### -notin

Description: Tells whether a test value appears in a collection of reference
values. Always returns a Boolean value. Returns TRUE when the test value is
not an exact match for at least one of the reference values.

When the test value is a collection, the In operator uses reference equality.
It returns TRUE only when one of the reference values is the same instance of
the test value object.

The `-notin` operator was introduced in PowerShell 3.0.

Syntax:

`<Test-value> -notin \<Reference-values>`

Examples:

```powershell
PS> "def" -notin "abc", "def"
False

PS> "ghi" -notin "abc", "def"
True

PS> "Shell" -notin "Windows", "PowerShell"
True  #Not an exact match

PS> "Windows" -notin "Windows", "PowerShell"
False  #An exact match

# Find unapproved verbs in the functions in my module
PS> $ApprovedVerbs = Get-Verb | foreach {$_.verb}
PS> $MyVerbs = Get-Command -Module MyModule | foreach {$_.verb}

PS> $MyVerbs | where {$_ -notin $ApprovedVerbs}
ForEach
Sort
Tee
Where
```

### Replacement Operator

The `-replace` operator replaces all or part of a value with the specified
value using regular expressions. You can use the `-replace` operator for many
administrative tasks, such as renaming files. For example, the following
command changes the file name extensions of all .txt files to .log:

```powershell
Get-ChildItem *.txt | Rename-Item -NewName { $_.name -replace '\.txt$','.log' }
```

The syntax of the `-replace` operator is as follows, where the \<original>
placeholder represents the characters to be replaced, and the \<substitute>
placeholder represents the characters that will replace them:

`<input> <operator> <original>, <substitute>`

By default, the `-replace` operator is case-insensitive. To make it case
sensitive, use `-creplace`. To make it explicitly case-insensitive, use
`-ireplace`.

Consider the following examples:

```powershell
PS> "book" -replace "B", "C"
```

```output
Cook
```

```powershell
"book" -ireplace "B", "C"
```

```output
Cook
```

```powershell
"book" -creplace "B", "C"
```

```output
book
```

It is also possible to use capturing groups, and substitutions with the
`-replace` operator. For more information, see [about_Regular_Expressions](about_Regular_Expressions.md).

### Type comparison

The type comparison operators (`-is` and `-isnot`) are used to determine if an
object is a specific type.

#### -is

Syntax:

`<object> -is <type reference>`

Example:

```powershell
PS> $a = 1
PS> $b = "1"
PS> $a -is [int]
True
PS> $a -is $b.GetType()
False
```

#### -isnot

Syntax:

`<object> -isnot <type reference>`

Example:

```powershell
PS> $a = 1
PS> $b = "1"
PS> $a -isnot $b.GetType()
True
PS> $b -isnot [int]
True
```

## SEE ALSO

- [about_Operators](about_Operators.md)
- [about_Regular_Expressions](about_Regular_Expressions.md)
- [about_Wildcards](about_Wildcards.md)
- [Compare-Object](../../Microsoft.PowerShell.Utility/Compare-Object.md)
- [Foreach-Object](../ForEach-Object.md)
- [Where-Object](../Where-Object.md)
