---
description: Describes WMI Query Language (WQL), which can be used to get WMI objects in Windows PowerShell.
Locale: en-US
ms.date: 03/04/2022
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_wql?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_WQL
---

# about_WQL

## Short description

Describes WMI Query Language (WQL), which can be used to get WMI objects in
Windows PowerShell.

## Long description

WQL is the Windows Management Instrumentation (WMI) query language, which is
the language used to get information from WMI.

You aren't required to use WQL to perform a WMI query in Windows PowerShell.
Instead, you can use the parameters of the `Get-WmiObject` or `Get-CimInstance`
cmdlets. WQL queries are somewhat faster than standard `Get-WmiObject` commands
and the improved performance is evident when the commands run on hundreds of
systems. However, be sure that the time you spend to write a successful WQL
query doesn't outweigh the performance improvement.

The basic WQL statements you need to use WQL are `SELECT`, `WHERE`, and `FROM`.

## When to use WQL

When working with WMI, and especially with WQL, don't forget that you are
also using Windows PowerShell. Often, if a WQL query doesn't work as
expected, it's easier to use a standard Windows PowerShell command than to
debug the WQL query.

Unless you are returning massive amounts of data from across
bandwidth-constrained remote systems, it's rarely productive to spend hours
trying to perfect a complicated WQL query when there is an acceptable
PowerShell cmdlet that does the same thing.

## Using the SELECT statement

A typical WMI query begins with a `SELECT` statement that gets all properties
or particular properties of a WMI class. To select all properties of a WMI
class, use an asterisk (`*`). The `FROM` keyword specifies the WMI class.

A `SELECT` statement has the following format:

```
SELECT <property> FROM <WMI-class>
```

For example, the following `SELECT` statement selects all properties (`*`) from
the instances of the **Win32_Bios** WMI class.

```
SELECT * FROM Win32_Bios
```

> [!NOTE]
> PowerShell only displays the default object properties. These properties are
> defined in the `Types.ps1xml` file. Use the `Select-Object` cmdlet or a
> `Format-*` cmdlet to display additional properties.

To select a particular property of a WMI class, place the property name
between the `SELECT` and `FROM` keywords.

The following query selects only the name of the BIOS from the **Win32_Bios**
WMI class. The command saves the query in the `$queryName` variable.

```
SELECT Name FROM Win32_Bios
```

To select more than one property, use commas to separate the property names.
The following WMI query selects the name and the version of the **Win32_Bios**
WMI class. The command saves the query in the `$queryNameVersion` variable.

```WQL
SELECT name, version FROM Win32_Bios
```

## Using the WQL query

There are three ways to use WQL query in Windows PowerShell command.

- Use the `Get-WmiObject` cmdlet
- Use the `Get-CimInstance` cmdlet
- Use the `[wmisearcher]` type accelerator.

## Using the Get-WmiObject cmdlet

The most basic way to use the WQL query is to enclose it in quotation marks (as
a string) and then use the query string as the value of the **Query** parameter
of the `Get-WmiObject` cmdlet, as shown in the following example.

```powershell
Get-WmiObject -Query "SELECT * FROM Win32_Bios"
```

```output
SMBIOSBIOSVersion : 8BET56WW (1.36 )
Manufacturer      : LENOVO
Name              : Default System BIOS
SerialNumber      : R9FPY3P
Version           : LENOVO - 1360
```

You can also save the WQL statement in a variable and then use the variable as
the value of the **Query** parameter, as shown in the following command.

```powershell
$query = "SELECT * FROM Win32_Bios"
Get-WmiObject -Query $query
```

You can use either format with any WQL statement. The following command uses
the query in the `$queryName` variable to get only the **Name** and **Version**
properties of the system BIOS.

```powershell
$queryNameVersion = "SELECT Name, Version FROM Win32_Bios"
Get-WmiObject -Query $queryNameVersion
```

```output
__GENUS          : 2
__CLASS          : Win32_BIOS
__SUPERCLASS     :
__DYNASTY        :
__RELPATH        :
__PROPERTY_COUNT : 2
__DERIVATION     : {}
__SERVER         :
__NAMESPACE      :
__PATH           :
Name             : S03KT39A
Version          : LENOVO - 1270
PSComputerName   :
```

Remember that you can use the parameters of the `Get-WmiObject` cmdlet to get
the same result. For example, the following command also gets the values of the
**Name** and **Version** properties of instances of the **Win32_Bios** WMI
class.

```powershell
Get-WmiObject -Class Win32_Bios -Property Name, Version
```

```output
__GENUS          : 2
__CLASS          : Win32_BIOS
__SUPERCLASS     :
__DYNASTY        :
__RELPATH        :
__PROPERTY_COUNT : 2
__DERIVATION     : {}
__SERVER         :
__NAMESPACE      :
__PATH           :
Name             : S03KT39A
Version          : LENOVO - 1270
PSComputerName   :
```

## Using the Get-CimInstance cmdlet

Beginning in Windows PowerShell 3.0, you can use the `Get-CimInstance` cmdlet
to run WQL queries.

`Get-CimInstance` gets instances of CIM-compliant classes, including WMI
classes. The CIM cmdlets, introduced Windows PowerShell 3.0, perform the same
tasks as the WMI cmdlets. The CIM cmdlets comply with WS-Management (WSMan)
standards and with the Common Information Model (CIM) standard, which enables
the cmdlets to use the same techniques to manage Windows computers and
computers that are running other operating systems.

The following command uses the `Get-CimInstance` cmdlet to run a WQL query.

Any WQL query that can be used with `Get-WmiObject` can also be used with
`Get-CimInstance`.

```powershell
Get-CimInstance -Query "SELECT * FROM Win32_Bios"
```

```output
SMBIOSBIOSVersion : S03KT39A
Manufacturer      : LENOVO
Name              : S03KT39A
SerialNumber      : MJ0AETTX
Version           : LENOVO - 1270
```

`Get-CimInstance` returns a **CimInstance** object, instead of the
**ManagementObject** that `Get-WmiObject` returns, but the objects are quite
similar.

```powershell
PS> (Get-CimInstance -Query "SELECT * FROM Win32_Bios").GetType().FullName
Microsoft.Management.Infrastructure.CimInstance

PS> (Get-WmiObject -Query "SELECT * FROM Win32_Bios").GetType().FullName
System.Management.ManagementObject
```

## Using the wmisearcher type accelerator

The `[wmisearcher]` type accelerator creates a **ManagementObjectSearcher**
object from a WQL statement string. The **ManagementObjectSearcher** object has
many properties and methods, but the most basic method is the Get method, which
invokes the specified WMI query and returns the resulting objects.

Using `[wmisearcher]`, you gain easy access to the **ManagementObjectSearcher**
.NET class. This lets you query WMI and to configure the way the query is
conducted.

To use the `[wmisearcher]` type accelerator:

1. Cast the  WQL string into a **ManagementObjectSearcher** object.
1. Call the Get method of the **ManagementObjectSearcher** object.

For example, the following command casts the "select all" query, saves the
result in the `$bios` variable, and then calls the `Get()` method of the
**ManagementObjectSearcher** object in the `$bios` variable.

```powershell
$bios = [wmisearcher]"SELECT * FROM Win32_Bios"
$bios.Get()
```

```output
SMBIOSBIOSVersion : 8BET56WW (1.36 )
Manufacturer      : LENOVO
Name              : Default System BIOS
SerialNumber      : R9FPY3P
Version           : LENOVO - 1360
```

You can use the `[wmisearcher]` type accelerator to cast the query or the
variable. In the following example, the `[wmisearcher]` type accelerator is
used to cast the variable. The result is the same.

```powershell
[wmisearcher]$bios = "SELECT * FROM Win32_Bios"
$bios.Get()
```

```output
SMBIOSBIOSVersion : S03KT39A
Manufacturer      : LENOVO
Name              : S03KT39A
SerialNumber      : MJ0AETTX
Version           : LENOVO - 1270
```

When you use the `[wmisearcher]` type accelerator, it changes the query string
into a **ManagementObjectSearcher** object, as shown in the following commands.

```powershell
$a = "SELECT * FROM Win32_Bios"
$a.GetType().FullName
System.String

$a = [wmisearcher]"SELECT * FROM Win32_Bios"
$a.GetType().FullName
System.Management.ManagementObjectSearcher
```

This command format works on any query. The following command gets the value
of the **Name** property of the **Win32_Bios** WMI class.

```powershell
$biosname = [wmisearcher]"Select Name from Win32_Bios"
$biosname.Get()
```

```output
__GENUS          : 2
__CLASS          : Win32_BIOS
__SUPERCLASS     :
__DYNASTY        :
__RELPATH        :
__PROPERTY_COUNT : 1
__DERIVATION     : {}
__SERVER         :
__NAMESPACE      :
__PATH           :
Name             : S03KT39A
PSComputerName   :
```

## Using the basic WQL WHERE statement

A `WHERE` statement establishes conditions for the data that a `SELECT`
statement returns.

The `WHERE` statement has the following format:

```
WHERE <property> <operator> <value>
```

For example:

```
WHERE Name = 'Notepad.exe'
```

The `WHERE` statement is used with the `SELECT` statement, as shown in the
following example.

```
SELECT * FROM Win32_Process WHERE Name = 'Notepad.exe'
```

When using the `WHERE` statement, the property name and value must be accurate.

For example, the following command gets the Notepad processes on the local
computer.

```powershell
Get-WmiObject -Query "SELECT * FROM Win32_Process WHERE name='Notepad.exe'"
```

However, the following command fails, because the process name includes the
`.exe` file extension.

```powershell
Get-WmiObject -Query "SELECT * FROM Win32_Process WHERE name='Notepad'"
```

## WHERE statement comparison operators

The following operators are valid in a WQL `WHERE` statement.

```
Operator    Description
-----------------------
=           Equal
!=          Not equal
<>          Not equal
<           Less than
>           Greater than
<=          Less than or equal
>=          Greater than or equal
LIKE        Wildcard match
IS          Evaluates null
ISNOT       Evaluates not null
ISA         Evaluates a member of a WMI class
```

There are other operators, but these are the ones used for making comparisons.

For example, the following query selects the **Name** and **Priority**
properties from processes in the **Win32_Process** class where the process
priority is greater than or equal to 11. The `Get-WmiObject` cmdlet runs the
query.

```powershell
$highPriority = "Select Name, Priority from Win32_Process " +
  "WHERE Priority >= 11"
Get-WmiObject -Query $highPriority
```

## Using the WQL operators in the -Filter parameter

The WQL operators can also be used in the value of the **Filter** parameter of
the `Get-WmiObject` or `Get-CimInstance` cmdlets, as well as in the value of
the **Query** parameters of these cmdlets.

For example, the following command gets the **Name** and **ProcessID**
properties of the last five processes that have **ProcessID** values greater
than 1004. The command uses the **Filter** parameter to specify the
**ProcessID** condition.

```powershell
$getWmiObjectSplat = @{
    Class = 'Win32_Process'
    Property = 'Name', 'ProcessID'
    Filter = "ProcessID >= 1004"
}
Get-WmiObject @getWmiObjectSplat |
    Sort-Object ProcessID |
    Select-Object Name, ProcessID -Last 5
```

```output
Name                                 ProcessID
----                                 ---------
SROSVC.exe                                4220
WINWORD.EXE                               4664
TscHelp.exe                               4744
SnagIt32.exe                              4748
WmiPrvSE.exe                              5056
```

## using the LIKE operator

The `LIKE` operator lets you use wildcard characters to filter the results of a
WQL query.

```
Like Operator  Description
--------------------------------------------------
[]             Character in a range [a-f] or a set
               of characters [abcdef]. The items in
               a set don't need to be consecutive or
               listed in alphabetical order.

^              Character not in a range [^a-f] or
               not in a set [^abcdef]. The items in
               a set don't need to be consecutive or
               listed in alphabetical order.

%              A string of zero or more characters

_              One character.
(underscore)   NOTE: To use a literal underscore
               in a query string, enclose it in
               square brackets [_].
```

When the `LIKE` operator is used without any wildcard characters or range
operators, it behaves like the equality operator (`=`) and returns objects only
when they're an exact match for the pattern.

You can combine the range operation with the percent (`%`) wildcard character
to create simple, yet powerful filters.

### LIKE operator examples

#### Example 1: [\<range>]

The following commands start Notepad and then search for an instance of the
**Win32_Process** class that has a name that starts with a letter between "H"
and "N" (case-insensitive).

The query should return any process from `Hotepad.exe` through `Notepad.exe`.

```powershell
Notepad   # Starts Notepad
$query = "SELECT * FROM Win32_Process WHERE Name LIKE '[H-N]otepad.exe'"
Get-WmiObject -Query $query | Select Name, ProcessID
```

```output
Name                                ProcessID
----                                ---------
notepad.exe                              1740
```

#### Example 2: [\<range>] and %

The following commands select all process that have a name that begins with a
letter between A and P (case-insensitive) followed by zero or more letters in
any combination.

The `Get-WmiObject` cmdlet runs the query, the `Select-Object` cmdlet gets the
**Name** and **ProcessID** properties, and the `Sort-Object` cmdlet sorts the
results in alphabetical order by name.

```powershell
$query = "SELECT * FROM Win32_Process WHERE name LIKE '[A-P]%'"
Get-WmiObject -Query $query |
    Select-Object -Property Name, ProcessID |
    Sort-Object -Property Name
```

#### Example 3: Not in Range (^)

The following command gets processes whose names don't begin with any of the
following letters: A, S, W, P, R, C, U, N

and followed zero or more letters.

```powershell
$query = "SELECT * FROM Win32_Process WHERE name LIKE '[^ASWPRCUN]%'"
Get-WmiObject -Query $query |
    Select-Object -Property Name, ProcessID |
    Sort-Object -Property Name
```

#### Example 4: Any characters -- or none (%)

The following commands get processes that have names that begin with `calc`.
The percent (`%`) symbol is the WQL wildcard character. It's equivalent to the
asterisk (`*`) wildcard in PowerShell.

```powershell
$query = "SELECT * FROM Win32_Process WHERE Name LIKE 'calc%'"
Get-WmiObject -Query $query | Select-Object -Property Name, ProcessID
```

```output
Name                               ProcessID
----                               ---------
calc.exe                                4424
```

#### Example 5: One character (_)

The following commands get processes that have names that have the following
pattern, `c_lc.exe` where the underscore character represents any one
character. This pattern matches any name from `calc.exe` through `czlc.exe`, or
`c9lc.exe`, but doesn't match names in which the "c" and "l" are separated by
more than one character.

```powershell
$query = "SELECT * FROM Win32_Process WHERE Name LIKE 'c_lc.exe'"
Get-WmiObject -Query $query | Select-Object -Property Name, ProcessID
```

```output
Name                                 ProcessID
----                                 ---------
calc.exe                                  4424
```

#### Example 6: Exact match

The following commands get processes named `WLIDSVC.exe`. Even though the query
uses the `LIKE` keyword, it requires an exact match, because the value doesn't
include any wildcard characters.

```powershell
$query = "SELECT * FROM Win32_Process WHERE name LIKE 'WLIDSVC.exe'"
Get-WmiObject -Query $query | Select-Object -Property Name, ProcessID
```powershell

```output
Name                                 ProcessID
----                                 ---------
WLIDSVC.exe                                84
```

## Using the OR operator

To specify multiple independent conditions, use the `OR` keyword. The `OR`
keyword appears in the `WHERE` clause. It performs an inclusive `OR` operation
on two (or more) conditions and returns items that meet any of the conditions.

The `OR` operator has the following format:

```
WHERE <property> <operator> <value> OR <property> <operator> <value> ...
```

For example, the following commands get all instances of the **Win32_Process**
WMI class but returns them only if the process name is `winword.exe` or
`excel.exe`.

```powershell
$q = "SELECT * FROM Win32_Process WHERE Name='winword.exe'" +
  " OR Name='excel.exe'"
Get-WmiObject -Query $q
```

The `OR` statement can be used with more than two conditions. In the following
query, the `OR` statement gets `Winword.exe`, `Excel.exe`, or `Powershell.exe`.

```powershell
$q = "SELECT * FROM Win32_Process WHERE Name='winword.exe'" +
  " OR Name='excel.exe' OR Name='powershell.exe'"
```

## Using the AND operator

To specify multiple related conditions, use the `AND` keyword. The `AND`
keyword appears in the `WHERE` clause. It returns items that meet all the
conditions.

The `AND` operator has the following format:

```
WHERE <property> <operator> <value> `AND` <property> <operator> <value> ...
```

For example, the following commands get processes that have a name of
`Winword.exe` and the process ID of 6512.

Note that the commands use the `Get-CimInstance` cmdlet.

```powershell
$q = "SELECT * FROM Win32_Process WHERE Name = 'winword.exe' " +
  "AND ProcessID =6512"
Get-CimInstance -Query $q
```

```output
ProcessId   Name             HandleCount      WorkingSetSize   VirtualSize
---------   ----             -----------      --------------   -----------
# 6512      WINWORD.EXE      768              117170176        633028608
```

All operators, including the `LIKE` operators are valid with the `OR` and `AND`
operators. And, you can combine the `OR` and `AND` operators in a single query
with parentheses that tell WMI which clauses to process first.

This command uses the Windows PowerShell continuation character (`` ` ``)
divide the command into two lines.

## Searching for null values

Searching for null values in WMI is challenging, because it can lead to
unpredictable results. `Null` isn't zero and it isn't equivalent to an empty
string. Some WMI class properties are initialized and others aren't, so a
search for null might not work for all properties.

To search for null values, use the Is operator with a value of `null`.

For example, the following commands get processes that have a null value for
the **IntallDate** property. The commands return many processes.

```powershell
$q = "SELECT * FROM Win32_Process WHERE InstallDate is null"
Get-WmiObject -Query $q
```

In contrast, the following command, gets user accounts that have a null value
for the **Description** property. This command doesn't return any user
accounts, even though most user accounts don't have any value for the
**Description** property.

```powershell
$q = "SELECT * FROM Win32_UserAccount WHERE Description is null"
Get-WmiObject -Query $q
```

To find the user accounts that have no value for the **Description** property,
use the equality operator to get an empty string. To represent the empty
string, use two consecutive single quotation marks.

```powershell
$q = "SELECT * FROM Win32_UserAccount WHERE Description = '' "
```

## Using true or false

To get boolean values in the properties of WMI objects, use `True` and `False`.
They aren't case sensitive.

The following WQL query returns only local user accounts from a domain joined
computer.

```powershell
$q = "SELECT * FROM Win32_UserAccount WHERE LocalAccount = True"
Get-CimInstance -Query $q
```

To find domain accounts, use a value of False, as shown in the following
example.

```powershell
$q = "SELECT * FROM Win32_UserAccount WHERE LocalAccount = False"
Get-CimInstance -Query $q
```

## Using the escape character

WQL uses the backslash (`\`) as its escape character. This is different from
Windows PowerShell, which uses the backtick character (`` ` ``).

Quotation marks, and the characters used for quotation marks, often need to be
escaped so that they aren't misinterpreted.

To find a user whose name includes a single quotation mark, use a backslash to
escape the single quotation mark, as shown in the following command.

```powershell
$q = "SELECT * FROM Win32_UserAccount WHERE Name = 'Tim O\'Brian'"
Get-CimInstance -Query $q
```

```output
Name             Caption          AccountType      SID              Domain
----             -------          -----------      ---              ------
Tim O'Brian      FABRIKAM\TimO    512              S-1-5-21-1457... FABRIKAM
```

In some case, the backslash also needs to be escaped. For example, the
following commands generate an Invalid Query error due to the backslash in the
Caption value.

```powershell
$q = "SELECT * FROM Win32_UserAccount WHERE Caption = 'Fabrikam\TimO'"
Get-CimInstance -Query $q
```

```output
Get-CimInstance : Invalid query
At line:1 char:1
+ Get-CimInstance -Query $q
+ ~~~~~~~~~~~
  + CategoryInfo          : InvalidArgument: (:) [Get-CimInstance], CimExcep
  + FullyQualifiedErrorId : HRESULT 0x80041017,Microsoft.Management.Infrastr
```

To escape the backslash, use a second backslash character, as shown in the
following command.

```powershell
$q = "SELECT * FROM Win32_UserAccount WHERE Caption = 'Fabrikam\\TimO'"
Get-CimInstance -Query $q
```

## See also

- [about_Special_Characters][02]
- [about_Quoting_Rules][01]
- [about_WMI][04]
- [about_WMI_Cmdlets][03]

<!-- link references -->
[01]: about_Quoting_Rules.md
[02]: about_Special_Characters.md
[03]: about_WMI_Cmdlets.md
[04]: about_WMI.md
