---
description: Describes how to define properties for PowerShell classes.
Locale: en-US
ms.date: 11/13/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_classes_properties?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Classes_Properties
---

# about_Classes_Properties

## Short description

Describes how to define properties for PowerShell classes.

## Long description

Properties are members of the class that contain data. Properties are declared
as variables in the class scope. A property can be of any built-in type or an
instance of another class. Classes can zero or more properties. Classes don't
have a maximum property count.

Class properties can have any number of attributes, including the [hidden][01]
and [static][02] attributes. Every property definition must include a type for
the property. You can define a default value for a property.

## Syntax

Class properties use the following syntaxes:

### One-line syntax

```Syntax
[[<attribute>]...] [<property-type>] $<property-name> [= <default-value>]
```

### Multiline syntax

```Syntax
[[<attribute>]...]
[<property-type>]
$<property-name> [= <default-value>]
```

## Examples

### Example 1 - Minimal class properties

The properties of the **ExampleProject1** class use built-in types without any
attributes or default values.

```powershell
class ExampleProject1 {
    [string]   $Name
    [int]      $Size
    [bool]     $Completed
    [string]   $Assignee
    [datetime] $StartDate
    [datetime] $EndDate
    [datetime] $DueDate
}

[ExampleProject1]::new()

$null -eq ([ExampleProject1]::new()).Name
```

```Output
Name      :
Size      : 0
Completed : False
StartDate : 1/1/0001 12:00:00 AM
EndDate   : 1/1/0001 12:00:00 AM
DueDate   : 1/1/0001 12:00:00 AM

True
```

The default value for the **Name** and **Assignee** properties is `$null`
because they're typed as strings, which is a reference type. The other
properties have the default value for their defined type, because they're
value type properties. For more information on the default values for
properties, see [Default property values][03].

### Example 2 - Class properties with custom types

The properties for **ExampleProject2** include a custom enumeration and class
defined in PowerShell before the **ExampleProject2** class.

```powershell
enum ProjectState {
    NotTriaged
    ReadyForWork
    Committed
    Blocked
    InProgress
    Done
}

class ProjectAssignee {
    [string] $DisplayName
    [string] $UserName

    [string] ToString() {
        return "$($this.DisplayName) ($($this.UserName))"
    }
}

class ExampleProject2 {
    [string]          $Name
    [int]             $Size
    [ProjectState]    $State
    [ProjectAssignee] $Assignee
    [datetime]        $StartDate
    [datetime]        $EndDate
    [datetime]        $DueDate
}

[ExampleProject2]@{
    Name     = 'Class Property Documentation'
    Size     = 8
    State    = 'InProgress'
    Assignee = @{
        DisplayName = 'Mikey Lombardi'
        UserName    = 'michaeltlombardi'
    }
    StartDate = '2023-10-23'
    DueDate   = '2023-10-27'
}
```

```Output
Name      : Class Property Documentation
Size      : 8
State     : InProgress
Assignee  : Mikey Lombardi (michaeltlombardi)
StartDate : 10/23/2023 12:00:00 AM
EndDate   : 1/1/0001 12:00:00 AM
DueDate   : 10/27/2023 12:00:00 AM
```

### Example 3 - Class property with a validation attribute

The **ExampleProject3** class defines the **Size** property as an integer that
must be greater than or equal to 0 and less than or equal to 16. It uses the
**ValidateRange** attribute to limit the value.

```powershell
class ExampleProject3 {
                           [string]   $Name
    [ValidateRange(0, 16)] [int]      $Size
                           [bool]     $Completed
                           [string]   $Assignee
                           [datetime] $StartDate
                           [datetime] $EndDate
                           [datetime] $DueDate
}

$project = [ExampleProject3]::new()
$project
```

```Output
Name      :
Size      : 0
Completed : False
Assignee  :
StartDate : 1/1/0001 12:00:00 AM
EndDate   : 1/1/0001 12:00:00 AM
DueDate   : 1/1/0001 12:00:00 AM
```

When **ExampleProject3** instantiates, the **Size** defaults to 0. Setting the
property to a value within the valid range updates the value.

```powershell
$project.Size = 8
$project
```

```Output
Name      :
Size      : 8
Completed : False
Assignee  :
StartDate : 1/1/0001 12:00:00 AM
EndDate   : 1/1/0001 12:00:00 AM
DueDate   : 1/1/0001 12:00:00 AM
```

When **Size** is set to an invalid value outside the range, PowerShell raises
an exception and the value isn't changed.

```powershell
$project.Size = 32
$project.Size = -1

$project
```

```Output
SetValueInvocationException:
Line |
   1 |  $project.Size = 32
     |  ~~~~~~~~~~~~~~~~~~
     | Exception setting "Size": "The 32 argument is greater than the
     | maximum allowed range of 16. Supply an argument that is less than
     | or equal to 16 and then try the command again."

SetValueInvocationException:
Line |
   2 |  $project.Size = -1
     |  ~~~~~~~~~~~~~~~~~~
     | Exception setting "Size": "The -1 argument is less than the minimum
     | allowed range of 0. Supply an argument that is greater than or
     | equal to 0 and then try the command again."

Name      :
Size      : 8
Completed : False
Assignee  :
StartDate : 1/1/0001 12:00:00 AM
EndDate   : 1/1/0001 12:00:00 AM
DueDate   : 1/1/0001 12:00:00 AM
```

### Example 4 - Class property with an explicit default value

The **ExampleProject4** class defaults the value for the **StartDate** property
to the current date.

```powershell
class ExampleProject4 {
    [string]   $Name
    [int]      $Size
    [bool]     $Completed
    [string]   $Assignee
    [datetime] $StartDate = (Get-Date).Date
    [datetime] $EndDate
    [datetime] $DueDate
}

[ExampleProject4]::new()

[ExampleProject4]::new().StartDate -eq (Get-Date).Date
```

```Output
Name      :
Size      : 0
Completed : False
Assignee  :
StartDate : 10/23/2023 12:00:00 AM
EndDate   : 1/1/0001 12:00:00 AM
DueDate   : 1/1/0001 12:00:00 AM

True
```

### Example 5 - Hidden class property

The **Guid** property of the **ExampleProject5** class has the `hidden`
keyword. The **Guid** property doesn't show in the default output for the
class or in the list of properties returned by `Get-Member`.

```powershell
class ExampleProject5 {
           [string]   $Name
           [int]      $Size
           [bool]     $Completed
           [string]   $Assignee
           [datetime] $StartDate
           [datetime] $EndDate
           [datetime] $DueDate
    hidden [string]   $Guid      = (New-Guid).Guid
}

$project = [ExampleProject5]::new()

"Project GUID: $($project.Guid)"

$project

$project | Get-Member -MemberType Properties | Format-Table
```

```Output
Project GUID: c72cef84-057c-4649-8940-13490dcf72f0

Name      :
Size      : 0
Completed : False
Assignee  :
StartDate : 1/1/0001 12:00:00 AM
EndDate   : 1/1/0001 12:00:00 AM
DueDate   : 1/1/0001 12:00:00 AM


   TypeName: ExampleProject5

Name      MemberType Definition
----      ---------- ----------
Assignee  Property   string Assignee {get;set;}
Completed Property   bool Completed {get;set;}
DueDate   Property   datetime DueDate {get;set;}
EndDate   Property   datetime EndDate {get;set;}
Name      Property   string Name {get;set;}
Size      Property   int Size {get;set;}
StartDate Property   datetime StartDate {get;set;}
```

### Example 6 - Static class property

The **ExampleProject6** class defines the static **Projects** property as a
list of all created projects. The default constructor for the class adds the
new instance to the list of projects.

```powershell
class ExampleProject6 {
           [string]            $Name
           [int]               $Size
           [bool]              $Completed
           [string]            $Assignee
           [datetime]          $StartDate
           [datetime]          $EndDate
           [datetime]          $DueDate
    hidden [string]            $Guid     = (New-Guid).Guid
    static [ExampleProject6[]] $Projects = @()

    ExampleProject6() {
        [ExampleProject6]::Projects += $this
    }
}

"Project Count: $([ExampleProject6]::Projects.Count)"

$project1 = [ExampleProject6]@{ Name = 'Project_1' }
$project2 = [ExampleProject6]@{ Name = 'Project_2' }

[ExampleProject6]::Projects | Select-Object -Property Name, Guid
```

```Output
Project Count: 0

Name      Guid
----      ----
Project_1 75e7c8a0-f8d1-433a-a5be-fd7249494694
Project_2 6c501be4-e68c-4df5-8fce-e49dd8366afe
```

### Example 7 - Defining a property in the constructor

The **ExampleProject7** class defines the **Duration** script property in the
static class constructor with the `Update-TypeData` cmdlet. Using the
`Update-TypeData` or `Add-Member` cmdlet is the only way to define advanced
properties for PowerShell classes.

The **Duration** property returns a value of `$null` unless both the
**StartDate** and **EndDate** properties are set and **StartDate** is defined
to be earlier than the **EndDate**.

```powershell
class ExampleProject7 {
    [string]   $Name
    [int]      $Size
    [bool]     $Completed
    [string]   $Assignee
    [datetime] $StartDate
    [datetime] $EndDate
    [datetime] $DueDate

    static [hashtable[]] $MemberDefinitions = @(
        @{
            MemberName = 'Duration'
            MemberType = 'ScriptProperty'
            Value      = {
                [datetime]$UnsetDate = 0

                $StartNotSet   = $this.StartDate -eq $UnsetDate
                $EndNotSet     = $this.EndDate   -eq $UnsetDate
                $StartAfterEnd = $this.StartDate -gt $this.EndDate

                if ($StartNotSet -or $EndNotSet -or $StartAfterEnd) {
                    return $null
                }

                return $this.EndDate - $this.StartDate
            }
        }
    )

    static ExampleProject7() {
        $TypeName = [ExampleProject7].Name
        foreach ($Definition in [ExampleProject7]::MemberDefinitions) {
            Update-TypeData -TypeName $TypeName @Definition
        }
    }

    ExampleProject7() {}

    ExampleProject7([string]$Name) {
        $this.Name = $Name
    }
}

$Project = [ExampleProject7]::new()
$Project

$null -eq $Project.Duration
```

```Output
Duration  :
Name      :
Size      : 0
Completed : False
Assignee  :
StartDate : 1/1/0001 12:00:00 AM
EndDate   : 1/1/0001 12:00:00 AM
DueDate   : 1/1/0001 12:00:00 AM

True
```

The default view for an instance of the **ExampleProject7** class includes the
duration. Because the **StartDate** and **EndDate** properties aren't set, the
**Duration** property is `$null`.

```powershell
$Project.StartDate = '2023-01-01'
$Project.EndDate   = '2023-01-08'

$Project
```

```Output
Duration  : 7.00:00:00
Name      :
Size      : 0
Completed : False
Assignee  :
StartDate : 1/1/2023 12:00:00 AM
EndDate   : 1/8/2023 12:00:00 AM
DueDate   : 1/1/0001 12:00:00 AM
```

With the properties set correctly, the **Duration** property returns a timespan
representing how long the project ran.

## Default property values

Every class property has an implicit default value depending on the type of the
property.

If a property is a [reference type][04], like a string or an object, the
implicit default value is `$null`. If a property is a [value type][05], like a
number, boolean, or enumeration, the property has a default value depending on
the type:

- Numeric types, like integers and floating-point numbers, default to `0`
- Boolean values default to `$false`
- Enumerations default to `0`, even the enumeration doesn't define a label for
  `0`.

For more information about default values in .NET, see
[Default values of C# types (C# reference)][06].

To define an explicit default value for a property, declare the property with
an assignment to the default value.

For example, this definition for the **ProjectTask** class defines an explicit
default value for the **Guid** property, assigning a random GUID to each new
instance.

```powershell
class ProjectTask {
    [string] $Name
    [string] $Description
    [string] $Guid = (New-Guid).Guid
}

[ProjectTask]::new()
```

```Output
Name Description Guid
---- ----------- ----
                 aa96350c-358d-465c-96d1-a49949219eec
```

Hidden and static properties can also have default values.

## Hidden properties

You can hide properties of a class by declaring them with the `hidden` keyword.
Hidden class properties are:

- Not included in the default output for the class.
- Not included in the list of class members returned by the `Get-Member`
  cmdlet. To show hidden properties with `Get-Member`, use the **Force**
  parameter.
- Not displayed in tab completion or IntelliSense unless the completion occurs
  in the class that defines the hidden property.
- Public members of the class. They can be accessed and modified. Hiding a
  property doesn't make it private. It only hides the property as described in
  the previous points.

For more information about the `hidden` keyword, see [about_Hidden][07].

## Static properties

You can define a property as belonging to the class itself instead of instances
of the class by declaring the property with the `static` keyword. Static class
properties:

- Are always available, independent of class instantiation.
- Are shared across all instances of the class.
- Are always available.
- Are modifiable. Static properties can be updated. They aren't immutable by
  default.
- Live for the entire session span.

> [!IMPORTANT]
> Static properties for classes defined in PowerShell aren't immutable. They
> can

## Derived class properties

When a class derives from a base class, it inherits the properties of the base
class. Any properties defined on the base class, including hidden properties,
are available on the derived class.

A derived class can override an inherited property by redefining it in the
class definition. The property on the derived class uses the redefined type and
default value, if any. If the inherited property defined a default value and
the redefined property doesn't, the inherited property has no default value.

If a derived class doesn't override a static property, accessing the static
property through the derived class accesses the static property of the base
class. Modifying the property value through the derived class modifies the
value on the base class. Any other derived class that doesn't override the
static property also uses the value of the property on the base class. Updating
the value of an inherited static property in a class that doesn't override the
property might have unintended effects for classes derived from the same base
class.

The following example shows the behavior for static and instance properties on
derived classes.

```powershell
class BaseClass {
    static [string] $StaticProperty = 'Static'
    [string] $InstanceProperty = 'Instance'
}
class DerivedClassA : BaseClass     {}
class DerivedClassB : BaseClass     {}
class DerivedClassC : DerivedClassB {
    [string] $InstanceProperty
}
class DerivedClassD : BaseClass {
    static [string] $StaticProperty = 'Override'
    [string] $InstanceProperty = 'Override'
}

"Base instance      => $([BaseClass]::new().InstanceProperty)"
"Derived instance A => $([DerivedClassA]::new().InstanceProperty)"
"Derived instance B => $([DerivedClassB]::new().InstanceProperty)"
"Derived instance C => $([DerivedClassC]::new().InstanceProperty)"
"Derived instance D => $([DerivedClassD]::new().InstanceProperty)"
```

```Output
Base instance      => Instance
Derived instance A => Instance
Derived instance B => Instance
Derived instance C =>
Derived instance D => Override
```

The **InstanceProperty** for **DerivedClassC** is an empty string because the
class redefined the property without setting a default value. For
**DerivedClassD** the value is `Override` because the class redefined the
property with that string as the default value.

```powershell
"Base static        => $([BaseClass]::StaticProperty)"
"Derived static A   => $([DerivedClassA]::StaticProperty)"
"Derived static B   => $([DerivedClassB]::StaticProperty)"
"Derived static C   => $([DerivedClassC]::StaticProperty)"
"Derived static D   => $([DerivedClassD]::StaticProperty)"
```

```Output
Base static        => Static
Derived static A   => Static
Derived static B   => Static
Derived static C   => Static
Derived static D   => Override
```

Except for **DerivedClassD**, the value of the static property for the derived
classes is the same as the base class, because they don't redefine the
property. This applies even to **DerivedClassC**, which inherits from
**DerivedClassB** instead of directly from **BaseClass**.

```powershell
[DerivedClassA]::StaticProperty = 'Updated from A'
"Base static        => $([BaseClass]::StaticProperty)"
"Derived static A   => $([DerivedClassA]::StaticProperty)"
"Derived static B   => $([DerivedClassB]::StaticProperty)"
"Derived static C   => $([DerivedClassC]::StaticProperty)"
"Derived static D   => $([DerivedClassD]::StaticProperty)"
```

```Output
Base static        => Updated from A
Derived static A   => Updated from A
Derived static B   => Updated from A
Derived static C   => Updated from A
Derived static D   => Override
```

When **StaticProperty** is accessed and modified through **DerivedClassA**, the
changed value affects every class except for **DerivedClassD**.

For more information about class inheritance, including a comprehensive
example, see [about_Classes_Inheritance][08].

## Using property attributes

PowerShell includes several attribute classes that you can use to enhance data
type information and validate the data assigned to a property. Validation
attributes allow you to test that values given to properties meet defined
requirements. Validation is triggered the moment that the value is assigned.

For more information on available attributes, see
[about_Functions_Advanced_Parameters][09].

## Defining instance properties with Update-TypeData

Beyond declaring properties directly in the class definition, you can define
properties for instances of a class in the static constructor using the
`Update-TypeData` cmdlet.

Use this snippet as a starting point for the pattern. Replace the placeholder
text in angle brackets as needed.

```powershell
class <ClassName> {
    static [hashtable[]] $MemberDefinitions = @(
        @{
            MemberName = '<PropertyName>'
            MemberType = '<PropertyType>'
            Value      = <ValueDefinition>
        }
    )

    static <ClassName>() {
        $TypeName = [<ClassName>].Name
        foreach ($Definition in [<ClassName>]::MemberDefinitions) {
            Update-TypeData -TypeName $TypeName @Definition
        }
    }
}
```

> [!TIP]
> The `Add-Member` cmdlet can add properties and methods to a class in
> non-static constructors, but the cmdlet is run every time the constructor
> is called. Using `Update-TypeData` in the static constructor ensures that the
> code for adding the members to the class only needs to run once in a session.
>
> Only add properties to the class in non-static constructors when they can't
> be defined with `Update-TypeData`, like read-only properties.

### Defining alias properties

The **Alias** attribute has no effect when used on a class property
declaration. PowerShell only uses that attribute to define aliases for cmdlet,
parameter, and function names.

To define an alias for a class property, use `Update-TypeData` with the
`AliasProperty` **MemberType**.

For example, this definition of the **OperablePair** class defines two integer
properties **x** and **y** with the aliases **LeftHandSide** and
**RightHandSide** respectively.

```powershell
class OperablePair {
    [int] $x
    [int] $y

    static [hashtable[]] $MemberDefinitions = @(
            @{
                MemberType = 'AliasProperty'
                MemberName = 'LeftHandSide'
                Value      = 'x'
            }
            @{
                MemberType = 'AliasProperty'
                MemberName = 'RightHandSide'
                Value      = 'y'
            }
    )

    static OperablePair() {
        $TypeName = [OperablePair].Name
        foreach ($Definition in [OperablePair]::MemberDefinitions) {
            Update-TypeData -TypeName $TypeName @Definition
        }
    }

    OperablePair() {}

    OperablePair([int]$x, [int]$y) {
        $this.x = $x
        $this.y = $y
    }

    # Math methods for the pair of values
    [int]   GetSum()        { return $this.x + $this.y }
    [int]   GetProduct()    { return $this.x * $this.y }
    [int]   GetDifference() { return $this.x - $this.y }
    [float] GetQuotient()   { return $this.x / $this.y }
    [int]   GetModulus()    { return $this.x % $this.y }
}
```

With the aliases defined, users can access the properties with either name.

```powershell
$pair = [OperablePair]@{ x = 8 ; RightHandSide = 3 }

"$($pair.x) % $($pair.y) = $($pair.GetModulus())"

$pair.LeftHandSide  = 3
$pair.RightHandSide = 2
"$($pair.x) x $($pair.y) = $($pair.GetProduct())"
```

```Output
8 % 3 = 2

3 x 2 = 6
```

### Defining calculated properties

To define a property that references the values of other properties, use the
`Update-TypeData` cmdlet with the `ScriptProperty` **MemberType**.

For example, this definition of the **Budget** class defines the **Expenses**
and **Revenues** properties as arrays of floating-point numbers. It uses the
`Update-TypeData` cmdlet to define calculated properties for total expenses,
total revenues, and net income.

```powershell
class Budget {
    [float[]] $Expenses
    [float[]] $Revenues

    static [hashtable[]] $MemberDefinitions = @(
        @{
            MemberType = 'ScriptProperty'
            MemberName = 'TotalExpenses'
            Value      = { ($this.Expenses | Measure-Object -Sum).Sum }
        }
        @{
            MemberType = 'ScriptProperty'
            MemberName = 'TotalRevenues'
            Value      = { ($this.Revenues | Measure-Object -Sum).Sum }
        }
        @{
            MemberType = 'ScriptProperty'
            MemberName = 'NetIncome'
            Value      = { $this.TotalRevenues - $this.TotalExpenses }
        }
    )

    static Budget() {
        $TypeName = [Budget].Name
        foreach ($Definition in [Budget]::MemberDefinitions) {
            Update-TypeData -TypeName $TypeName @Definition
        }
    }

    Budget() {}

    Budget($Expenses, $Revenues) {
        $this.Expenses = $Expenses
        $this.Revenues = $Revenues
    }
}

[Budget]::new()

[Budget]@{
    Expenses = @(2500, 1931, 3700)
    Revenues = @(2400, 2100, 4150)
}
```

```Output
TotalExpenses : 0
TotalRevenues : 0
NetIncome     : 0
Expenses      :
Revenues      :

TotalExpenses : 8131
TotalRevenues : 8650
NetIncome     : 519
Expenses      : {2500, 1931, 3700}
Revenues      : {2400, 2100, 4150}
```

### Defining properties with custom get and set logic

PowerShell class properties can't define custom getter and setter logic
directly. You can approximate this functionality by defining a backing property
with the `hidden` keyword and using `Update-TypeData` to define a visible
property with custom logic for getting and setting the value.

By convention, define the hidden backing property name with an underscore
prefix and use camel casing. For example, instead of `TaskCount`, name the
hidden backing property `_taskCount`.

In this example, the **ProjectSize** class defines a hidden integer property
named **_value**. It defines **Value** as a `ScriptProperty` with custom logic
for getting and setting the **_value** property. The setter scriptblock handles
converting the string representation of the project to the correct size.

```powershell
class ProjectSize {
    hidden [ValidateSet(0, 1, 2, 3)] [int] $_value

    static [hashtable[]] $MemberDefinitions = @(
        @{
            MemberType  = 'ScriptProperty'
            MemberName  = 'Value'
            Value       = { $this._value } # Getter
            SecondValue = {                # Setter
                $ProposedValue = $args[0]

                if ($ProposedValue -is [string]) {
                    switch ($ProposedValue) {
                        'Small'  { $this._value = 1 ; break }
                        'Medium' { $this._value = 2 ; break }
                        'Large'  { $this._value = 3 ; break }
                        default  { throw "Unknown size '$ProposedValue'" }
                    }
                } else {
                    $this._value = $ProposedValue
                }
            }
        }
    )

    static ProjectSize() {
        $TypeName = [ProjectSize].Name
        foreach ($Definition in [ProjectSize]::MemberDefinitions) {
            Update-TypeData -TypeName $TypeName @Definition
        }
    }

    ProjectSize()              {}
    ProjectSize([int]$Size)    { $this.Value = $Size }
    ProjectSize([string]$Size) { $this.Value = $Size }

    [string] ToString() {
        $Output = switch ($this._value) {
            1       { 'Small'     }
            2       { 'Medium'    }
            3       { 'Large'     }
            default { 'Undefined' }
        }

        return $Output
    }
}
```

With the custom getter and setter defined, you can set the **Value** property
as either an integer or string.

```powershell
$size = [ProjectSize]::new()
"The initial size is: $($size._value), $size"

$size.Value = 1
"The defined size is: $($size._value), $size"

$Size.Value += 1
"The updated size is: $($size._value), $size"

$Size.Value = 'Large'
"The final size is:   $($size._value), $size"
```

```Output
The initial size is: 0, Undefined

The defined size is: 1, Small

The updated size is: 2, Medium

The final size is:   3, Large
```

## Limitations

PowerShell class properties have the following limitations:

- Static properties are always mutable. PowerShell classes can't define
  immutable static properties.

  Workaround: None.
- Properties can't use the **ValidateScript** attribute, because class property
  attribute arguments must be constants.

  Workaround: Define a class that inherits from the
  **ValidateArgumentsAttribute** type and use that attribute instead.
- Directly declared properties can't define custom getter and setter
  implementations.

  Workaround: Define a hidden property and use `Update-TypeData` to define the
  visible getter and setter logic.
- Properties can't use the **Alias** attribute. The attribute only applies to
  parameters, cmdlets, and functions.

  Workaround: Use the `Update-TypeData` cmdlet to define aliases in the class
  constructors.
- When a PowerShell class is converted to JSON with the `ConvertTo-Json`
  cmdlet, the output JSON includes all hidden properties and their values.

  Workaround: None

## See also

- [about_Classes][10]
- [about_Classes_Constructors][11]
- [about_Classes_Inheritance][12]
- [about_Classes_Methods][13]

[01]: #hidden-properties
[02]: #static-properties
[03]: #default-property-values
[04]: /dotnet/csharp/language-reference/keywords/reference-types
[05]: /dotnet/csharp/language-reference/builtin-types/value-types
[06]: /dotnet/csharp/language-reference/builtin-types/default-values
[07]: about_Hidden.md
[08]: about_Classes_Inheritance.md
[09]: about_functions_advanced_parameters.md#parameter-and-variable-validation-attributes
[10]: about_Classes.md
[11]: about_Classes_Constructors.md
[12]: about_Classes_Inheritance.md
[13]: about_Classes_Methods.md
