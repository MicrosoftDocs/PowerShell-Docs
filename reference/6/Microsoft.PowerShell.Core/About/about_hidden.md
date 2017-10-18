---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Hidden
---

# about_Hidden

## SHORT DESCRIPTION

Describes the Hidden keyword, which hides class members from default
Get-Member results.

## LONG DESCRIPTION

When you use the Hidden keyword in a script, you hide the members of a class
by default. The Hidden keyword can hide properties, methods (including
constructors, events, alias properties, and other member types, including
static members, from the default results of the Get-Member cmdlet, and from
IntelliSense and tab completion results. To display members that you have
hidden with the Hidden keyword, add the -Force parameter to a Get-Member
command.

Hidden members are not displayed by using tab completion or IntelliSense,
unless the completion occurs in the class that defines the hidden member.

A new attribute, System.Management.Automation.HiddenAttribute, has been added,
so that C# code can have the same semantics within Windows PowerShell.

The Hidden keyword is useful for creating properties and methods within a
class that you do not necessarily want other users of the class to see, or
readily be able to edit.

The Hidden keyword has no effect on how you can view or make changes to
members of a class. Like all language keywords in Windows PowerShell, Hidden
is not case-sensitive, and hidden members are still public.

Hidden, along with custom classes, was introduced in Windows PowerShell 5.0.

## EXAMPLE

The following example shows how to use the Hidden keyword in a class
definition. The Car class method, Drive, has a property, rides, that does not
need to be viewed or changed (it merely tallies the number of times that Drive
is called on the Car class, a metric that is not important to users of the
class; consider, for example, that when you are buying a car, you do not ask
the seller on how many drives the car has been taken).

Because there is little need for users of the class to change this property,
we can hide the property from Get-Member and automatic completion results by
using the Hidden keyword.

Add the Hidden keyword by entering it on the same statement line as the
property and its data type. Although the keyword can be in any order on this
line, starting the statement with the Hidden keyword makes it easier for you
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

Now, create a new instance of the Car class, and save it in a variable,
$TestCar.

```powershell
$TestCar = [Car]::new()
```

After you create the new instance, pipe the contents of the $TestCar variable
to Get\-Member. Observe that the rides property is not among the members
listed in the Get\-Member command results.

```powershell
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

Now, try running Get\-Member again, but this time, add the –Force parameter.
Note that the results contain the hidden rides property, among other members
that are hidden by default.

```powershell
PS C:\Windows\system32> $TestCar | Get-Member -Force

   TypeName: Car

Name          MemberType   Definition
----          ----------   ----------
pstypenames   CodeProperty System.Collections.ObjectModel.Collection`1…
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

## SEE ALSO

- [about_Classes](about_Classes.md)
- [about_Language_Keywords](about_Language_Keywords.md)
- [about_Wildcards](about_Wildcards.md)
- [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md)
