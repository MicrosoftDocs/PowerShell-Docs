---
description: Describes the operators that compare values in PowerShell.
Locale: en-US
ms.date: 01/19/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Comparison_Operators
---
# about_Comparison_Operators

## Short description

The comparison operators in PowerShell can either compare two values or filter
elements of a collection against an input value.

## Long description

Comparison operators let you compare values or finding values that match
specified patterns. PowerShell includes the following comparison operators:

**Equality**

- `-eq`, `-ieq`, `-ceq` - equals
- `-ne`, `-ine`, `-cne` - not equals
- `-gt`, `-igt`, `-cgt` - greater than
- `-ge`, `-ige`, `-cge` - greater than or equal
- `-lt`, `-ilt`, `-clt` - less than
- `-le`, `-ile`, `-cle` - less than or equal

**Matching**

- `-like`, `-ilike`, `-clike` - string matches wildcard pattern
- `-notlike`, `-inotlike`, `-cnotlike` - string doesn't match wildcard pattern
- `-match`, `-imatch`, `-cmatch` - string matches regex pattern
- `-notmatch`, `-inotmatch`, `-cnotmatch` - string doesn't match regex pattern

**Replacement**

- `-replace`, `-ireplace`, `-creplace` - replaces strings matching a regex
  pattern

**Containment**

- `-contains`, `-icontains`, `-ccontains` - collection contains a value
- `-notcontains`, `-inotcontains`, `-cnotcontains` - collection doesn't
  contain a value
- `-in`, `-iin`, `-cin` - value is in a collection
- `-notin`, `-inotin`, `-cnotin` - value isn't in a collection

**Type**

- `-is` - both objects are the same type
- `-isnot` - the objects aren't the same type

## Common features

String comparisons are case-insensitive unless you use the explicit
case-sensitive operator. To make a comparison operator case-sensitive, add a
`c` after the `-`. For example, `-ceq` is the case-sensitive version of `-eq`.
To make the case-insensitivity explicit, add an `i` after `-`. For example,
`-ieq` is the explicitly case-insensitive version of `-eq`.

String comparisons use the [InvariantCulture][01] for both case-sensitive and
case-insensitive comparisons. The comparisons are between unicode code points
and don't use culture-specific collation ordering. The results are the same
regardless of the current culture.

When the left-hand value in the comparison expression is a [scalar][15] value,
the operator returns a **Boolean** value. When the left-hand value in the
expression is a collection, the operator returns the elements of the collection
that match the right-hand value of the expression. Right-hand values are always
treated as singleton instances, even when they're collections. The comparison
operators can't effectively compare collections to collections.

If there are no matches in the collection, comparison operators return an empty
array. For example:

```powershell
$a = (1, 2) -eq 3
$a.GetType().Name
$a.Count
```

```output
Object[]
0
```

There are a few exceptions:

- The containment and type operators always return a **Boolean** value
- The `-replace` operator returns the replacement result
- The `-match` and `-notmatch` operators also populate the `$Matches` automatic
  variable unless the left-hand side of the expression is a collection.

## Equality operators

### -eq and -ne

When the left-hand side is scalar, `-eq` returns **True** if the right-hand
side is equivalent, otherwise, `-eq` returns **False**. `-ne` does the
opposite; it returns **False** when both sides are equivalent; otherwise, `-ne`
returns **True**.

Example:

```powershell
2 -eq 2                 # Output: True
2 -eq 3                 # Output: False
"abc" -eq "abc"         # Output: True
"abc" -eq "abc", "def"  # Output: False
"abc" -ne "def"         # Output: True
"abc" -ne "abc"         # Output: False
"abc" -ne "abc", "def"  # Output: True
```

When the left-hand side is a collection, `-eq` returns those members that match
the right-hand side, while `-ne` filters them out.

Example:

```powershell
1,2,3 -eq 2             # Output: 2
"abc", "def" -eq "abc"  # Output: abc
"abc", "def" -ne "abc"  # Output: def
```

These operators process all elements of the collection. Example:

```powershell
"zzz", "def", "zzz" -eq "zzz"
```

```output
zzz
zzz
```

The equality operator can compare objects of different types. It's important to
understand that the value on the right-hand side of the comparison can be
converted to the type of the left-hand side value for comparison.

For example, the string `'1.0'` is converted to an integer to be compared to
the value `1`. This example returns `True`.

```powershell
PS> 1 -eq '1.0'
True
```

In this example, the value `1` is converted to a string to be compared to
string `'1.0'`. This example returns `False`.

```powershell
PS> '1.0' -eq 1
False
```

The equality operators accept any two objects, not just a scalar or collection.
But the comparison result isn't guaranteed to be meaningful for the end-user.
The following example demonstrates the issue.

```powershell
class MyFileInfoSet {
    [String]$File
    [Int64]$Size
}
$a = [MyFileInfoSet]@{File = "C:\Windows\explorer.exe"; Size = 4651032}
$b = [MyFileInfoSet]@{File = "C:\Windows\explorer.exe"; Size = 4651032}
$a -eq $b
```

```Output
False
```

In this example, we created two objects with identical properties. Yet, the
equality test result is **False** because they're different objects. To create
comparable classes, you need to implement [System.IEquatable\<T>][03] in your
class. The following example demonstrates the partial implementation of a
**MyFileInfoSet** class that implements [System.IEquatable\<T>][03] and has two
properties, **File** and **Size**. The `Equals()` method returns **True** if
the File and Size properties of two **MyFileInfoSet** objects are the same.

```powershell
class MyFileInfoSet : System.IEquatable[Object] {
    [String]$File
    [Int64]$Size

    [bool] Equals([Object] $obj) {
        return ($this.File -eq $obj.File) -and ($this.Size -eq $obj.Size)
    }
}
$a = [MyFileInfoSet]@{File = "C:\Windows\explorer.exe"; Size = 4651032}
$b = [MyFileInfoSet]@{File = "C:\Windows\explorer.exe"; Size = 4651032}
$a -eq $b
```

```Output
True
```

A prominent example of comparing arbitrary objects is to find out if they're
null. But if you need to determine whether a variable is `$null`, you must put
`$null` on the left-hand side of the equality operator. Putting it on the
right-hand side doesn't do what you expect.

For example, let `$a` be an array containing null elements:

```powershell
$a = 1, 2, $null, 4, $null, 6
```

The following tests that `$a` isn't null.

```powershell
$null -ne $a
```

```output
True
```

The following, however, filers out all null elements from `$a`:

```powershell
$a -ne $null # Output: 1, 2, 4, 6
```

```output
1
2
4
6
```

### -gt, -ge, -lt, and -le

`-gt`, `-ge`, `-lt`, and `-le` behave very similarly. When both sides are
scalar they return **True** or **False** depending on how the two sides
compare:

| Operator | Returns True when...                   |
| -------- | -------------------------------------- |
| `-gt`    | The left-hand side is greater          |
| `-ge`    | The left-hand side is greater or equal |
| `-lt`    | The left-hand side is smaller          |
| `-le`    | The left-hand side is smaller or equal |

In the following examples, all statements return **True**.

```powershell
8 -gt 6  # Output: True
8 -ge 8  # Output: True
6 -lt 8  # Output: True
8 -le 8  # Output: True
```

> [!NOTE]
> In most programming languages the greater-than operator is `>`. In
> PowerShell, this character is used for redirection. For details, see
> [about_Redirection][09].

When the left-hand side is a collection, these operators compare each member of
the collection with the right-hand side. Depending on their logic, they either
keep or discard the member.

Example:

```powershell
$a=5, 6, 7, 8, 9

Write-Output "Test collection:"
$a

Write-Output "`nMembers greater than 7"
$a -gt 7

Write-Output "`nMembers greater than or equal to 7"
$a -ge 7

Write-Output "`nMembers smaller than 7"
$a -lt 7

Write-Output "`nMembers smaller than or equal to 7"
$a -le 7
```

```output
Test collection:
5
6
7
8
9

Members greater than 7
8
9

Members greater than or equal to 7
7
8
9

Members smaller than 7
5
6

Members smaller than or equal to 7
5
6
7
```

These operators work with any class that implements [System.IComparable][02].

Examples:

```powershell
# Date comparison
[DateTime]'2001-11-12' -lt [DateTime]'2020-08-01' # True

# Sorting order comparison
'a' -lt 'z'           # True; 'a' comes before 'z'
'macOS' -ilt 'MacOS'  # False
'MacOS' -ilt 'macOS'  # False
'macOS' -clt 'MacOS'  # True; 'm' comes before 'M'
```

The following example demonstrates that there is no symbol on an American
QWERTY keyboard that gets sorted after 'a'. It feeds a set containing all such
symbols to the `-gt` operator to compare them against 'a'. The output is an
empty array.

```powershell
$a=' ','`','~','!','@','#','$','%','^','&','*','(',')','_','+','-','=',
   '{','}','[',']',':',';','"','''','\','|','/','?','.','>',',','<'
$a -gt 'a'
# Output: Nothing
```

If the two sides of the operators aren't reasonably comparable, these operators
raise a non-terminating error.

## Matching operators

The matching operators (`-like`, `-notlike`, `-match`, and `-notmatch`) find
elements that match or don't match a specified pattern. The pattern for `-like`
and `-notlike` is a wildcard expression (containing `*`, `?`, and `[ ]`), while
`-match` and `-notmatch` accept a regular expression (Regex).

The syntax is:

```
<string[]> -like    <wildcard-expression>
<string[]> -notlike <wildcard-expression>
<string[]> -match    <regular-expression>
<string[]> -notmatch <regular-expression>
```

When the input of these operators is a scalar value, they return a **Boolean**
value.

When the input is a collection of values, each item in the collection is
converted to a string for comparison. The `-match` and `-notmatch` operators
return any matching and non-matching members respectively. However, the `-like`
and `-notlike` operators return the members as strings. The string returned for
a member of the collection by `-like` and `-notlike` is the string the operator
used for the comparison and is obtained by casting the member to a string.

### -like and -notlike

`-like` and `-notlike` behave similarly to `-eq` and `-ne`, but the right-hand
side could be a string containing [wildcards][11].

Example:

```powershell
"PowerShell" -like    "*shell"           # Output: True
"PowerShell" -notlike "*shell"           # Output: False
"PowerShell" -like    "Power?hell"       # Output: True
"PowerShell" -notlike "Power?hell"       # Output: False
"PowerShell" -like    "Power[p-w]hell"   # Output: True
"PowerShell" -notlike "Power[p-w]hell"   # Output: False

"PowerShell", "Server" -like "*shell"    # Output: PowerShell
"PowerShell", "Server" -notlike "*shell" # Output: Server
```

### -match and -notmatch

`-match` and `-notmatch` use regular expressions to search for pattern in the
left-hand side values. Regular expressions can match complex patterns like
email addresses, UNC paths, or formatted phone numbers. The right-hand side
string must adhere to the [regular expressions][10] rules.

Scalar examples:

```powershell
# Partial match test, showing how differently -match and -like behave
"PowerShell" -match 'shell'        # Output: True
"PowerShell" -like  'shell'        # Output: False

# Regex syntax test
"PowerShell" -match    '^Power\w+' # Output: True
'bag'        -notmatch 'b[iou]g'   # Output: True
```

If the input is a collection, the operators return the matching members of that
collection.

Collection examples:

```powershell
"PowerShell", "Super PowerShell", "Power's hell" -match '^Power\w+'
# Output: PowerShell

"Rhell", "Chell", "Mel", "Smell", "Shell" -match "hell"
# Output: Rhell, Chell, Shell

"Bag", "Beg", "Big", "Bog", "Bug"  -match 'b[iou]g'
#Output: Big, Bog, Bug

"Bag", "Beg", "Big", "Bog", "Bug"  -notmatch 'b[iou]g'
#Output: Bag, Beg
```

`-match` and `-notmatch` support regex capture groups. Each time they run on
scalar input, and the `-match` result is **True**, or the `-notmatch` result is
**False**, they overwrite the `$Matches` automatic variable. `$Matches` is a
**Hashtable** that always has a key named '0', which stores the entire match.
If the regular expression contains capture groups, the `$Matches` contains
additional keys for each group.

It's important to note that the `$Matches` hashtable contains only the first
occurrence of any matching pattern.

Example:

```powershell
$string = 'The last logged on user was CONTOSO\jsmith'
$string -match 'was (?<domain>.+)\\(?<user>.+)'

$Matches

Write-Output "`nDomain name:"
$Matches.domain

Write-Output "`nUser name:"
$Matches.user
```

```output
True

Name                           Value
----                           -----
domain                         CONTOSO
user                           jsmith
0                              was CONTOSO\jsmith

Domain name:
CONTOSO

User name:
jsmith
```

When the `-match` result is **False**, or the `-notmatch` result is **True**,
or when the input is a collection, the `$Matches` automatic variable isn't
overwritten. Consequently, it will contain the previously set value, or `$null`
if the variable hasn't been set. When referencing `$Matches` after invoking one
of these operators, consider verifying that the variable was set by the current
operator invocation using a condition statement.

Example:

```powershell
if ("<version>1.0.0</version>" -match '<version>(.*?)</version>') {
    $Matches
}
```

For details, see [about_Regular_Expressions][10] and
[about_Automatic_Variables][06].

## Replacement operator

### Replacement with regular expressions

Like `-match`, the `-replace` operator uses regular expressions to find the
specified pattern. But unlike `-match`, it replaces the matches with another
specified value.

Syntax:

```
<input> -replace <regular-expression>, <substitute>
```

The operator replaces all or part of a value with the specified value using
regular expressions. You can use the operator for many administrative tasks,
such as renaming files. For example, the following command changes the file
name extensions of all `.txt` files to `.log`:

```powershell
Get-ChildItem *.txt | Rename-Item -NewName { $_.name -replace '\.txt$','.log' }
```

By default, the `-replace` operator is case-insensitive. To make it case
sensitive, use `-creplace`. To make it explicitly case-insensitive, use
`-ireplace`.

Examples:

```powershell
"book" -ireplace "B", "C" # Case insensitive
"book" -creplace "B", "C" # Case-sensitive; hence, nothing to replace
```

```Output
Cook
book
```

### Regular expressions substitutions

It's also possible to use regular expressions to dynamically replace text using
capturing groups, and substitutions. Capture groups can be referenced in the
`<substitute>` string using the dollar sign (`$`) character before the group
identifier.

In the following example, the `-replace` operator accepts a username in the
form of `DomainName\Username` and converts to the `Username@DomainName` format:

```powershell
$SearchExp = '^(?<DomainName>[\w-.]+)\\(?<Username>[\w-.]+)$'
$ReplaceExp = '${Username}@${DomainName}'

'Contoso.local\John.Doe' -replace $SearchExp, $ReplaceExp
```

```output
John.Doe@Contoso.local
```

> [!WARNING]
> The `$` character has syntactic roles in both PowerShell and regular
> expressions:
>
> - In PowerShell, between double quotation marks, it designates variables and
>   acts as a subexpression operator.
> - In Regex search strings, it denotes end of the line.
> - In Regex substitution strings, it denotes captured groups. Be sure
>   to either put your regular expressions between single quotation marks or
>   insert a backtick (`` ` ``) character before them.

For example:

```powershell
$1 = 'Goodbye'

'Hello World' -replace '(\w+) \w+', "$1 Universe"
# Output: Goodbye Universe

'Hello World' -replace '(\w+) \w+', '$1 Universe'
# Output: Hello Universe
```

`$$` in Regex denotes a literal `$`. This `$$` in the substitution string to
include a literal `$` in the resulting replacement. For example:

```powershell
'5.72' -replace '(.+)', '$ $1' # Output: $ 5.72
'5.72' -replace '(.+)', '$$$1' # Output: $5.72
'5.72' -replace '(.+)', '$$1'  # Output: $1
```

To learn more, see [about_Regular_Expressions][10] and
[Substitutions in Regular Expressions][05].

### Substituting in a collection

When the `<input>` to the `-replace` operator is a collection, PowerShell
applies the replacement to every value in the collection. For example:

```powershell
"B1","B2","B3","B4","B5" -replace "B", 'a'
a1
a2
a3
a4
a5
```

## Containment operators

The containment operators (`-contains`, `-notcontains`, `-in`, and `-notin`)
are similar to the equality operators, except that they always return a
**Boolean** value, even when the input is a collection. These operators stop
comparing as soon as they detect the first match, whereas the equality
operators evaluate all input members. In a very large collection, these
operators return quicker than the equality operators.

### -contains and -notcontains

Syntax:

```Syntax
<Collection> -contains <scalar-object>
<Collection> -notcontains <scalar-object>
```

These operators tell whether a set includes a certain element. `-contains`
returns **True** when the right-hand side (scalar-object) matches one of the
elements in the set. `-notcontains` returns False instead.

Examples:

```powershell
"abc", "def" -contains "def"                  # Output: True
"abc", "def" -notcontains "def"               # Output: False
"Windows", "PowerShell" -contains "Shell"     # Output: False
"Windows", "PowerShell" -notcontains "Shell"  # Output: True
"abc", "def", "ghi" -contains "abc", "def"    # Output: False
"abc", "def", "ghi" -notcontains "abc", "def" # Output: True
```

More complex examples:

```powershell
$DomainServers = "ContosoDC1","ContosoDC2","ContosoFileServer","ContosoDNS",
                 "ContosoDHCP","ContosoWSUS"
$thisComputer  = "ContosoDC2"

$DomainServers -contains $thisComputer
# Output: True
```

When the right-hand side operand is a collection, these operators convert the
value to its string representation before comparing it to the left-hand side
collection.

```powershell
$a = "abc", "def"
"abc", "def", "ghi" -contains $a # Output: False

# The following statements are equivalent
$a, "ghi" -contains $a           # Output: True
"$a", "ghi" -contains $a         # Output: True
"abc def", "ghi" -contains $a    # Output: True
```

### -in and -notin

Syntax:

```Syntax
<scalar-object> -in <Collection>
<scalar-object> -notin <Collection>
```

The `-in` and `-notin` operators were introduced in PowerShell 3 as the
syntactic reverse of the of `-contains` and `-notcontains` operators. `-in`
returns **True** when the left-hand side `<scalar-object>` matches one of the
elements in the collection. `-notin` returns **False** instead.

The following examples do the same thing that the examples for `-contains` and
`-notcontains` do, but they're written with `-in` and `-notin` instead.

```powershell
"def" -in "abc", "def"                  # Output: True
"def" -notin "abc", "def"               # Output: False
"Shell" -in "Windows", "PowerShell"     # Output: False
"Shell" -notin "Windows", "PowerShell"  # Output: True
"abc", "def" -in "abc", "def", "ghi"    # Output: False
"abc", "def" -notin "abc", "def", "ghi" # Output: True
```

More complex examples:

```powershell
$DomainServers = "ContosoDC1","ContosoDC2","ContosoFileServer","ContosoDNS",
                 "ContosoDHCP","ContosoWSUS"
$thisComputer  = "ContosoDC2"

$thisComputer -in $DomainServers
# Output: True
```

When the left-hand side operand is a collection, these operators convert the
value to its string representation before comparing it to the right-hand side
collection.

```powershell
$a = "abc", "def"
$a -in "abc", "def", "ghi" # Output: False

# The following statements are equivalent
$a -in $a, "ghi"           # Output: True
$a -in "$a", "ghi"         # Output: True
$a -in "abc def", "ghi"    # Output: True
```

## Type comparison

The type comparison operators (`-is` and `-isnot`) are used to determine if an
object is a specific type.

Syntax:

```powershell
<object> -is <type-reference>
<object> -isnot <type-reference>
```

Example:

```powershell
$a = 1
$b = "1"
$a -is [int]           # Output: True
$a -is $b.GetType()    # Output: False
$b -isnot [int]        # Output: True
$a -isnot $b.GetType() # Output: True
```

## See also

- [about_Booleans][07]
- [about_Operators][08]
- [about_Regular_Expressions][10]
- [about_Wildcards][11]
- [Compare-Object][14]
- [Foreach-Object][12]
- [Where-Object][13]

<!-- link references -->
[01]: /dotnet/api/system.globalization.cultureinfo.invariantculture
[02]: /dotnet/api/system.icomparable
[03]: /dotnet/api/system.iequatable-1
[04]: /dotnet/api/system.text.regularexpressions.match
[05]: /dotnet/standard/base-types/substitutions-in-regular-expressions
[06]: about_Automatic_Variables.md
[07]: about_Booleans.md
[08]: about_Operators.md
[09]: about_Redirection.md#potential-confusion-with-comparison-operators
[10]: about_Regular_Expressions.md
[11]: about_Wildcards.md
[12]: xref:Microsoft.PowerShell.Core.ForEach-Object
[13]: xref:Microsoft.PowerShell.Core.Where-Object
[14]: xref:Microsoft.PowerShell.Utility.Compare-Object
[15]: /powershell/scripting/learn/glossary#scalar-value
