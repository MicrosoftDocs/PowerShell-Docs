---
description:  Describes WMI Query Language (WQL), which can be used to get WMI objects in Windows PowerShell. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 01/03/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_wql?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_WQL
---

# About WQL

## SHORT DESCRIPTION

Describes WMI Query Language (WQL), which can be used to get WMI objects in
Windows PowerShell.

## LONG DESCRIPTION

WQL is the Windows Management Instrumentation (WMI) query language, which is
the language used to get information from WMI.

You are not required to use WQL to perform a WMI query in Windows PowerShell.
Instead, you can use the parameters of the Get-WmiObject or Get-CimInstance
cmdlets. WQL queries are somewhat faster than standard Get-WmiObject commands
and the improved performance is evident when the commands run on hundreds of
systems. However, be sure that the time you spend to write a successful WQL
query doesn't outweigh the performance improvement.

The basic WQL statements you need to use WQL are Select, Where, and From.

## WHEN TO USE WQL

When working with WMI, and especially with WQL, do not forget that you are
also using Windows PowerShell. Often, if a WQL query does not work as
expected, it's easier to use a standard Windows PowerShell command than to
debug the WQL query.

Unless you are returning massive amounts of data from across
bandwidth-constrained remote systems, it is rarely productive to spend hours
trying to perfect a complicated and convoluted WQL query when there is a
perfectly acceptable Windows cmdlet that does the same thing, if a bit more
slowly.

## USING THE SELECT STATEMENT

A typical WMI query begins with a Select statement that gets all properties or
particular properties of a WMI class. To select all properties of a WMI class,
use an asterisk (\*). The From keyword specifies the WMI class.

A Select statement has the following format:

```
Select <property> from <WMI-class>
```

For example, the following Select statement selects all properties (*) from
the instances of the Win32_Bios WMI class.

```
Select * from Win32_Bios
```

To select a particular property of a WMI class, place the property name
between the Select and From keywords.

The following query selects only the name of the BIOS from the Win32_Bios WMI
class. The command saves the query in the $queryName variable.

```
Select Name from Win32_Bios
```

To select more than one property, use commas to separate the property names.
The following WMI query selects the name and the version of the Win32_Bios WMI
class. The command saves the query in the $queryNameVersion variable.

```
Select name, version from Win32_Bios
```

## USING THE WQL QUERY

There are three ways to use WQL query in Windows PowerShell command.

- Use the Get-WmiObject cmdlet
- Use the Get-CimInstance cmdlet
- Use the [wmisearcher] type accelerator.

## USING THE GET-WMIOBJECT CMDLET

The most basic way to use the WQL query is to enclose it in quotation marks
(as a string) and then use the query string as the value of the Query
parameter of the Get-WmiObject cmdlet, as shown in the following example.

```powershell
Get-WmiObject -Query "Select * from Win32_Bios"
```

```output
SMBIOSBIOSVersion : 8BET56WW (1.36 )
Manufacturer      : LENOVO
Name              : Default System BIOS
SerialNumber      : R9FPY3P
Version           : LENOVO - 1360
```

You can also save the WQL statement in a variable and then use the variable as
the value of the Query parameter, as shown in the following command.

```powershell
$query = "Select * from Win32_Bios"
Get-WmiObject -Query $query
```

You can use either format with any WQL statement. The following command uses
the query in the $queryName variable to get only the name and version
properties of the system BIOS.

```powershell
$queryNameVersion = "Select Name, Version from Win32_Bios"
Get-WmiObject -Query $queryNameVersion
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
Name             : Default System BIOS
Version          : LENOVO - 1360
```

Remember that you can use the parameters of the Get-WmiObject cmdlet to get
the same result. For example, the following command also gets the values of
the Name and Version properties of instances of the Win32_Bios WMI class.

```powershell
Get-WmiObject -Class Win32_Bios -Property Name, Version
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
Name             : Default System BIOS
Version          : LENOVO - 1360
```

## USING THE GET-CIMINSTANCE CMDLET

Beginning in Windows PowerShell 3.0, you can use the Get-CimInstance cmdlet to
run WQL queries.

Get-CimInstance gets instances of CIM-compliant classes, including WMI
classes. The CIM cmdlets, introduced Windows PowerShell 3.0, perform the same
tasks as the WMI cmdlets. The CIM cmdlets comply with WS-Management (WSMan)
standards and with the Common Information Model (CIM) standard, which enables
the cmdlets to use the same techniques to manage Windows computers and
computers that are running other operating systems.

The following command uses the Get-CimInstance cmdlet to run a WQL query.

Any WQL query that can be used with Get-WmiObject can also be used with
Get-CimInstance.

```powershell
Get-CimInstance -Query "Select * from Win32_Bios"
```

```output
SMBIOSBIOSVersion : 8BET56WW (1.36 )
Manufacturer      : LENOVO
Name              : Default System BIOS
SerialNumber      : R9FPY3P
Version           : LENOVO - 1360
```

Get-CimInstance returns a CimInstance object, instead of the ManagementObject
that Get-WmiObject returns, but the objects are quite similar.

```
(Get-CimInstance -Query "Select * from Win32_Bios").GetType().FullName
Microsoft.Management.Infrastructure.CimInstance
(Get-WmiObject -Query "Select * from Win32_Bios").GetType().FullName
System.Management.ManagementObject
```

## USING THE [wmisearcher] TYPE ACCELERATOR

The [wmisearcher] type accelerator creates a ManagementObjectSearcher object
from a WQL statement string. The ManagementObjectSearcher object has many
properties and methods, but the most basic method is the Get method, which
invokes the specified WMI query and returns the resulting objects.

By using the [wmisearcher], you gain easy access to the
ManagementObjectSearcher .NET Framework class. This lets you query WMI and to
configure the way the query is conducted.

To use the [wmisearcher] type accelerator:

1. Cast the  WQL string into a ManagementObjectSearcher object.
2. Call the Get method of the ManagementObjectSearcher object.

For example, the following command casts the "select all" query, saves the
result in the $bios variable, and then calls the Get method of the
ManagementObjectSearcher object in the $bios variable.

```powershell
$bios = [wmisearcher]"Select * from Win32_Bios"
$bios.Get()
```

```output
SMBIOSBIOSVersion : 8BET56WW (1.36 )
Manufacturer      : LENOVO
Name              : Default System BIOS
SerialNumber      : R9FPY3P
Version           : LENOVO - 1360
```

NOTE: Only selected object properties are displayed by default. These
properties are defined in the Types.ps1xml file.

You can use the [wmisearcher] type accelerator to cast the query or the
variable. In the following example, the [wmisearcher] type accelerator is used
to cast the variable. The result is the same.

```powershell
[wmisearcher]$bios = "Select * from Win32_Bios"
$bios.Get()
```

```output
SMBIOSBIOSVersion : 8BET56WW (1.36 )
Manufacturer      : LENOVO
Name              : Default System BIOS
SerialNumber      : R9FPY3P
Version           : LENOVO - 1360
```

When you use the [wmisearcher] type accelerator, it changes the query string
into a ManagementObjectSearcher object, as shown in the following commands.

```
$a = "Select * from Win32_Bios"
$a.GetType().FullName
System.String

$a = [wmisearcher]"Select * from Win32_Bios"
$a.GetType().FullName
System.Management.ManagementObjectSearcher
```

This command format works on any query. The following command gets the value
of the Name property of the Win32_Bios WMI class.

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
Name             : Default System BIOS
```

You can perform this operation in a single command, although the command is a
bit more difficult to interpret.

In this format, you use the [wmisearcher] type accelerator to cast the WQL
query string to a ManagementObjectSearcher, and then call the Get method on
the object -- all in a single command. The parentheses () that enclose the
casted string direct Windows PowerShell to cast the string before calling the
method.

```powershell
([wmisearcher]"Select name from Win32_Bios").Get()
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
Name             : Default System BIOS
```

## USING THE BASIC WQL WHERE STATEMENT

A Where statement establishes conditions for the data that a Select statement
returns.

The Where statement has the following format:

```
where <property> <operator> <value>
```

For example:

```
where Name = 'Notepad.exe'
```

The Where statement is used with the Select statement, as shown in the
following example.

```
Select * from Win32_Process where Name = 'Notepad.exe'
```

When using the Where statement, the property name and value must be accurate.

For example, the following command gets the Notepad processes on the local
computer.

```powershell
Get-WmiObject -Query "Select * from Win32_Process where name='Notepad.exe'"
```

However, the following command fails, because the process name includes the
".exe" file name extension.

```powershell
Get-WmiObject -Query "Select * from Win32_Process where name='Notepad'"
```

## WHERE STATEMENT COMPARISON OPERATORS

The following operators are valid in a WQL Where statement.

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

For example, the following query selects the Name and Priority properties from
processes in the Win32_Process class where the process priority is greater
than or equal to 11. The Get-WmiObject cmdlet runs the query.

```powershell
$highPriority = "Select Name, Priority from Win32_Process " +
  "where Priority >= 11"
Get-WmiObject -Query $highPriority
```

## USING THE WQL OPERATORS IN THE FILTER PARAMETER

The WQL operators can also be used in the value of the Filter parameter of the
Get-WmiObject or Get-CimInstance cmdlets, as well as in the value of the Query
parameters of these cmdlets.

For example, the following command gets the Name and ProcessID properties of
the last five processes that have ProcessID values greater than 1004. The
command uses the Filter parameter to specify the ProcessID condition.

```powershell
Get-WmiObject -Class Win32_Process `
-Property Name, ProcessID -Filter "ProcessID >= 1004" |
Sort ProcessID | Select Name, ProcessID -Last 5
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

## USING THE LIKE OPERATOR

The Like operator lets you use wildcard characters to filter the results of a
WQL query.

```
Like Operator  Description
--------------------------------------------------
[]             Character in a range [a-f] or a set
               of characters [abcdef]. The items in
               a set do not need to be consecutive or
               listed in alphabetical order.

^              Character not in a range [^a-f] or
               not in a set [^abcdef]. The items in
               a set do not need to be consecutive or
               listed in alphabetical order.

%              A string of zero or more characters

_              One character.
(underscore)   NOTE: To use a literal underscore
               in a query string, enclose it in
               square brackets [_].
```

When the Like operator is used without any wildcard characters or range
operators, it behaves like the equality operator (=) and returns objects only
when they are an exact match for the pattern.

You can combine the range operation with the percent wildcard character to
create simple, yet powerful filters.

### LIKE OPERATOR EXAMPLES

#### EXAMPLE 1: [\<range>]

The following commands start Notepad and then search for an instance of the
Win32_Process class that has a name that starts with a letter between "H" and
"N" (case-insensitive).

The query should return any process from Hotpad.exe through Notepad.exe.

```powershell
Notepad   # Starts Notepad
$query = "Select * from win32_Process where Name LIKE '[H-N]otepad.exe'"
Get-WmiObject -Query $query | Select Name, ProcessID
```

```output
Name                                ProcessID
----                                ---------
notepad.exe                              1740
```

#### EXAMPLE 2: [\<range>] and %

The following commands select all process that have a name that begins with a
letter between A and P (case-insensitive) followed by zero or more letters in
any combination.

The Get-WmiObject cmdlet runs the query, the Select-Object cmdlet gets the
Name and ProcessID properties, and the Sort-Object cmdlet sorts the results in
alphabetical order by name.

```powershell
$query = "Select * from win32_Process where name LIKE '[A-P]%'"
Get-WmiObject -Query $query |
Select-Object -Property Name, ProcessID |
Sort-Object -Property Name
```

#### EXAMPLE 3: Not in Range (^)

The following command gets processes whose names do not begin with any of the
following letters: A, S, W, P, R, C, U, N

and followed zero or more letters.

```powershell
$query = "Select * from win32_Process where name LIKE '[^ASWPRCUN]%'"
Get-WmiObject -Query $query |
Select-Object -Property Name, ProcessID |
Sort-Object -Property Name
```

#### EXAMPLE 4: Any characters -- or none (%)

The following commands get processes that have names that begin with "calc".
The % symbol in WQL is equivalent to the asterisk (\*) symbol in regular
expressions.

```powershell
$query = "Select * from win32_Process where Name LIKE 'calc%'"
Get-WmiObject -Query $query | Select-Object -Property Name, ProcessID
```

```output
Name                               ProcessID
----                               ---------
calc.exe                                4424
```

#### EXAMPLE 5: One character (_)

The following commands get processes that have names that have the following
pattern, "c_lc.exe" where the underscore character represents any one
character. This pattern matches any name from calc.exe through czlc.exe, or
c9lc.exe, but does not match names in which the "c" and "l" are separated by
more than one character.

```powershell
$query = "Select * from Win32_Process where Name LIKE 'c_lc.exe'"
Get-WmiObject -Query $query | Select-Object -Property Name, ProcessID
```

```output
Name                                 ProcessID
----                                 ---------
calc.exe                                  4424
```

#### EXAMPLE 6: Exact match

The following commands get processes named WLIDSVC.exe. Even though the query
uses the Like keyword, it requires an exact match, because the value does not
include any wildcard characters.

```powershell
$query = "Select * from win32_Process where name LIKE 'WLIDSVC.exe'"
Get-WmiObject -Query $query | Select-Object -Property Name, ProcessID
```powershell

```output
Name                                 ProcessID
----                                 ---------
WLIDSVC.exe                                84
```

## USING THE OR OPERATOR

To specify multiple independent conditions, use the Or keyword. The Or keyword
appears in the Where clause. It performs an inclusive OR operation on two (or
more) conditions and returns items that meet any of the conditions.

The Or operator has the following format:

```
Where <property> <operator> <value> or <property> <operator> <value> ...
```

For example, the following commands get all instances of the Win32_Process WMI
class but returns them only if the process name is winword.exe or excel.exe.

```powershell
$q = "Select * from Win32_Process where Name='winword.exe'" +
  " or Name='excel.exe'"
Get-WmiObject -Query $q
```

The Or statement can be used with more than two conditions. In the following
query, the Or statement gets Winword.exe, Excel.exe, or Powershell.exe.

```powershell
$q = "Select * from Win32_Process where Name='winword.exe'" +
  " or Name='excel.exe' or Name='powershell.exe'"
```

## USING THE AND OPERATOR

To specify multiple related conditions, use the And keyword. The And keyword
appears in the Where clause. It returns items that meet all of the conditions.

The And operator has the following format:

```
Where <property> <operator> <value> and <property> <operator> <value> ...
```

For example, the following commands get processes that have a name of
"Winword.exe" and the process ID of 6512.

Note that the commands use the Get-CimInstance cmdlet.

```powershell
$q = "Select * from Win32_Process where Name = 'winword.exe' " +
  "and ProcessID =6512"
Get-CimInstance -Query $q
```

```output
ProcessId   Name             HandleCount      WorkingSetSize   VirtualSize
---------   ----             -----------      --------------   -----------
# 6512      WINWORD.EXE      768              117170176        633028608
```

All operators, including the Like operators are valid with the Or and And
operators. And, you can combine the Or and And operators in a single query
with parentheses that tell Windows PowerShell which clauses to process first.

This command uses the Windows PowerShell continuation character (`) divide the
command into two lines.

```powershell
$q = "Select * from Win32_Process `
where (Name = 'winword.exe' or Name = 'excel.exe') and HandleCount > 700"
Get-CimInstance -Query $q
```

```output
ProcessId    Name             HandleCount      WorkingSetSize   VirtualSize
---------    ----             -----------      --------------   -----------
     6512    WINWORD.EXE      797              117268480        634425344
     9610    EXCEL.EXE        727               38858752        323227648
```

## SEARCHING FOR NULL VALUES

Searching for null values in WMI is challenging, because it can lead to
unpredictable results. Null is not zero and it is not equivalent or to an
empty string. Some WMI class properties are initialized and others are not, so
a search for null might not work for all properties.

To search for null values, use the Is operator with a value of "null".

For example, the following commands get processes that have a null value for
the IntallDate property. The commands return many processes.

```powershell
$q = "Select * from Win32_Process where InstallDate is null"
Get-WmiObject -Query $q
```

In contrast, the following command, gets user accounts that have a null value
for the Description property. This command does not return any user accounts,
even though most user accounts do not have any value for the Description
property.

```powershell
$q = "Select * from Win32_UserAccount where Description is null"
Get-WmiObject -Query $q
```

To find the user accounts that have no value for the Description property, use
the equality operator to get an empty string. To represent the empty string,
use two consecutive single quotation marks.

```powershell
$q = "Select * from Win32_UserAccount where Description = '' "
```

## USING TRUE OR FALSE

To get Boolean values in the properties of WMI objects, use True and False.
They are not case sensitive.

The following WQL query returns only local user accounts from a domain joined
computer.

```powershell
$q = "Select * from Win32_UserAccount where LocalAccount = True"
Get-CimInstance -Query $q
```

To find domain accounts, use a value of False, as shown in the following
example.

```powershell
$q = "Select * from Win32_UserAccount where LocalAccount = False"
Get-CimInstance -Query $q
```

## USING THE ESCAPE CHARACTER

WQL uses the backslash (\) as its escape character. This is different from
Windows PowerShell, which uses the backtick character (`).

Quotation marks, and the characters used for quotation marks, often need to be
escaped so that they are not misinterpreted.

To find a user whose name includes a single quotation mark, use a backslash to
escape the single quotation mark, as shown in the following command.

```powershell
$q = "Select * from Win32_UserAccount where Name = 'Tim O\'Brian'"
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
$q = "Select * from Win32_UserAccount where Caption = 'Fabrikam\TimO'"
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
$q = "Select * from Win32_UserAccount where Caption = 'Fabrikam\\TimO'"
Get-CimInstance -Query $q
```

## SEE ALSO

[about_Special_Characters](about_Special_Characters.md)

[about_Quoting_Rules](about_Quoting_Rules.md)

[about_WMI](about_WMI.md)

[about_WMI_Cmdlets](about_WMI_Cmdlets.md)
