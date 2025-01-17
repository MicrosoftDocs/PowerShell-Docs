---
description: Describes the `hidden` keyword, which hides class members from default `Get-Member` results.
Locale: en-US
ms.date: 03/07/2022
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_hidden?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Hidden
---
# about_Hidden

## Short description

Describes the `hidden` keyword, which hides class members from default
`Get-Member` results.

## Long description

When you use the `hidden` keyword in a script, you hide the members of a class
by default. Hidden members do not display in the default results of the
`Get-Member` cmdlet, IntelliSense, or tab completion results. To display members
that you have hidden with the `hidden` keyword, add the **Force** parameter to a
`Get-Member` command.

The `hidden` keyword can hide:

- methods (including constructors)
- events
- alias properties
- other member types (including static members)

Hidden members are not displayed in tab completion or IntelliSense unless the
completion occurs in the class that defines the hidden member.

The new attribute, **System.Management.Automation.HiddenAttribute**, enables C#
code to have the same semantics within PowerShell.

The `hidden` keyword is useful for creating properties and methods within a
class that you do not necessarily want users of the class to see or readily be
able to edit.

The `hidden` keyword has no effect on how you can view or make changes to
members of a class. Like all language keywords in PowerShell, `hidden` is not
case-sensitive, and hidden members are still public.

The `hidden` keyword, along with custom classes, was introduced in Windows
PowerShell 5.0.

## EXAMPLE

The following example shows how to use the `hidden` keyword in a class
definition. The **Car** class method, **Drive**, has a property, **rides**, that
does not need to be viewed or changed as it merely tallies the number of times
that **Drive** is called on the **Car** class. That metric that is not important
to users of the class (consider, for example, that when you are buying a car,
you do not ask the seller on how many drives the car has been taken).

Because there is little need for users of the class to change this property, we
can hide the property from `Get-Member` and automatic completion results by
using the `hidden` keyword.

Add the `hidden` keyword by entering it on the same statement line as the
property and its data type. Although the keyword can be in any order on this
line, starting the statement with the `hidden` keyword makes it easier for you
later to identify all members that you have hidden.

```powershell
class Car
{
   # Properties
   [String] $Color
   [String] $ModelYear
   [int] $Distance

   # Method
   [int] Drive ([int]$miles)
   {
      $this.Distance += $miles
      $this.rides++
      return $this.Distance
   }

   # Hidden property of the Drive method
    hidden [int] $rides = 0
}
```

Now, create a new instance of the **Car** class, and save it in a variable,
`$TestCar`.

```powershell
$TestCar = [Car]::new()
```

After you create the new instance, pipe the contents of the `$TestCar` variable
to `Get-Member`. Observe that the **rides** property is not among the members
listed in the `Get-Member` command results.

```output
PS C:\Windows\system32> $TestCar | Get-Member

   TypeName: Car

Name        MemberType Definition
----        ---------- ----------
Drive       Method     int Drive(int miles)
Equals      Method     bool Equals(System.Object obj)
GetHashCode Method     int GetHashCode()
GetType     Method     type GetType()
ToString    Method     string ToString()
Color       Property   string Color {get;set;}
Distance    Property   int Distance {get;set;}
ModelYear   Property   string ModelYear {get;set;}

```

Now, try running `Get-Member` again, but this time, add the `-Force` parameter.
Note that the results contain the hidden **rides** property, among other members
that are hidden by default.

```output
PS C:\Windows\system32> $TestCar | Get-Member -Force

   TypeName: Car

Name          MemberType   Definition
----          ----------   ----------
pstypenames   CodeProperty System.Collections.ObjectModel.Collection`1
psadapted     MemberSet    psadapted {Color, ModelYear, Distance,
psbase        MemberSet    psbase {Color, ModelYear, Distance,...
psextended    MemberSet    psextended {}
psobject      MemberSet    psobject {BaseObject, Members,...
Drive         Method       int Drive(int miles)
Equals        Method       bool Equals(System.Object obj)
GetHashCode   Method       int GetHashCode()
GetType       Method       type GetType()
get_Color     Method       string get_Color()
get_Distance  Method       int get_Distance()
get_ModelYear Method       string get_ModelYear()
get_rides     Method       int get_rides()
set_Color     Method       void set_Color(string )
set_Distance  Method       void set_Distance(int )
set_ModelYear Method       void set_ModelYear(string )
set_rides     Method       void set_rides(int )
ToString      Method       string ToString()
Color         Property     string Color {get;set;}
Distance      Property     int Distance {get;set;}
ModelYear     Property     string ModelYear {get;set;}
rides         Property     int rides {get;set;}

```

## See also

- [about_Classes](about_Classes.md)
- [about_Language_Keywords](about_Language_Keywords.md)
- [about_Wildcards](about_Wildcards.md)
- [Get-Member](xref:Microsoft.PowerShell.Utility.Get-Member)
