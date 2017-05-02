---
description: Describes how you can use classes to create your own custom types. 
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2017-04-04
title:  about_Classes
ms.technology:  powershell
---

# About Classes
## about\_Classes

# SHORT DESCRIPTION

Describes how you can use classes to create your own custom types.

# LONG DESCRIPTION

Starting in Windows PowerShell 5.0, Windows PowerShell adds language
for defining classes and other user-defined types, by using formal syntax
and semantics that are similar to other object-oriented programming
languages. The goal is to enable developers and IT professionals to
embrace Windows PowerShell for a wider range of use cases, simplify
development of Windows PowerShell artifacts and accelerate coverage
of management surfaces.

A class declaration is like a blueprint that is used to create instances or
objects at run time.
If you define a class called *Device*, *Device* is the name of the type.
If you declare and initialize a variable *d* of type *Device*,
*d* is said to be an object or instance of *Device*.
Multiple instances of the *Device* type can be created,
and each instance can have different values in its properties.

## SUPPORTED SCENARIOS

- Define custom types in Windows PowerShell by using familiar object-oriented programming constructs, such as classes, properties, methods, inheritance, etc.
- Debug types by using the Windows PowerShell language.
- Generate and handle exceptions by using formal mechanisms, and at the right level.
- Define DSC resources and their associated types by using the Windows PowerShell language.

## SYNTAX

Classes are declared using the following syntax:

```syntax
class <class-name> [: <base-class-list>] {
    [[<attribute>] [hidden] [static] <property-definition> ...]
    [<class-name>([<constructor-argument-list>]) {<constructor-statement-list>} ...]
    [[<attribute>] [hidden] [static] <method-definition> ...]
}
```

Classes are instantiated using the following syntax:

```syntax
[$<variable-name> =] [<class-name>]::new([<constructor-argument-list>])
```

> **Note** Brackets around the class name are mandatory!
> The brackets signal a type definition for PowerShell.

### EXAMPLE: Minimum syntax and usage

This is the minimum needed to create a 'useful' class.

```powershell
class Device {
    [string]$Brand
}

$dev = [Device]::new()

$dev

$dev.Brand = "Microsoft"

$dev
```

```output

Brand
-----

Microsoft
```

> **Note**: the first invocation of $dev returns the empty object
> with the header of the  empty property *Brand*.
> After updating the property, on the second invocation,
> PowerShell removes the header when displaying the object.

## CLASS PROPERTIES

Properties are variables declared at class scope.
A property may be any built-in type or an instance of another class.
Classes have no restriction in the number of properties they have;
the only limitation is the available memory to instantiate the class.

## EXAMPLE: Class with simple properties

```powershell
class Device {
    [string]$Brand
    [string]$Model
    [string]$VendorSku
}

$device = [Device]::new()
$device.Brand = "Microsoft"
$device.Model = "Surface Pro 4"
$device.VendorSku = "5072641000"

$device
```

```output


Brand     Model         VendorSku
-----     -----         ---------
Microsoft Surface Pro 4 5072641000

```

### EXAMPLE: Complex types in class properties

This example defines an empty **Rack** class using the **Device** class.
The examples, following this one, show how to add devices to the rack
and how to start with a pre-loaded rack.

```powershell
class Device {
    [string]$Brand
    [string]$Model
    [string]$VendorSku
}

class Rack {
    [string]$Brand
    [string]$Model
    [string]$VendorSku
    [string]$AssetId
    [Device[]]$Devices = [Device[]]::new(8)

}

$rack = [Rack]::new()

$rack
```

```output

Brand     :
Model     :
VendorSku :
AssetId   :
Devices   : {$null, $null, $null, $null...}


```

## CLASS METHODS

Methods define the actions that a class can perform.
Methods can take parameters that provide input data, and can return  an output;
the returned data can be of any defined data type.
Methods can be paramterless and return an output.

### EXAMPLE: A simple class with properties and methods

Extending the **Rack** class to add and remove devices
to or from it.

```powershell
class Device {
    [string]$Brand
    [string]$Model
    [string]$VendorSku
}

class Rack {
    [int]$Slots = 8
    [string]$Brand
    [string]$Model
    [string]$VendorSku
    [string]$AssetId
    [Device[]]$Devices = [Device[]]::new($this.Slots)

    AddDevice([Device]$dev, [int]$slot){
        ## Add argument validation logic here
        $this.Devices[$slot] = $dev
    }

    RemoveDevice([int]$slot){
        ## Add argument validation logic here
        $this.Devices[$slot] = $null
    }
}

$rack = [Rack]::new()


$surface = [Device]::new()
$surface.Brand = "Microsoft"
$surface.Model = "Surface Pro 4"
$surface.VendorSku = "5072641000"

$rack.AddDevice($surface, 2)

$rack
```

```output

Slots     : 8
Brand     :
Model     :
VendorSku :
AssetId   :
Devices   : {$null, $null, Device, $null...}

```

## CONSTRUCTOR

Constructors enable to set default values and validate object logic at the
moment of creating the instance of the class. Constructors have the same name
as the class. Constructors might have arguments, to initialize the data
members of the new object.

The class can have no constructor defined, one or more constructors.
If no constructor is defined, the class is given a default parameterless
constructor; this constructor instantiates all members to their default
values (null values for object type classes, including string).
If a constructor is defined, then no default parameterless constructor
is available; if needed, it has to be explicitly added to the class.

### EXAMPLE: Constructor basic syntax

In this example the Device class is defined with properties and a constructor.
In order to use this class, the user is required to provide minimum values
to create the device.


```powershell
class Device {
    [string]$Brand
    [string]$Model
    [string]$VendorSku

    Device(
        [string]$b,
        [string]$m,
        [string]$vsk
    ){
        $this.Brand = $b
        $this.Model = $m
        $this.VendorSku = $vsk
    }
}

[Device]$surface = [Device]::new("Microsoft", "Surface Pro 4", "5072641000")

$surface
```

```output
Brand     Model         VendorSku
-----     -----         ---------
Microsoft Surface Pro 4 5072641000

```

### EXAMPLE: Multiple Constructors

In this example the Device class is defined with properties, a default
constructor, and a constructor to initialize the instance.

The default constructor sets the brand to *Undefined*,
and leaves model and vendor-sku with null values.


```powershell
class Device {
    [string]$Brand
    [string]$Model
    [string]$VendorSku

    Device(){
        $this.Brand = 'Undefined'
    }

    Device(
        [string]$b,
        [string]$m,
        [string]$vsk
    ){
        $this.Brand = $b
        $this.Model = $m
        $this.VendorSku = $vsk
    }
}

[Device]$somedevice = [Device]::new()
[Device]$surface = [Device]::new("Microsoft", "Surface Pro 4", "5072641000")

$somedevice
$surface
```

```output

Brand     Model         VendorSku
-----     -----         ---------
Undefined
Microsoft Surface Pro 4 5072641000

```

## HIDDEN ATTRIBUTE

The `hidden` attribute allows to make less visible a property or a method.
That doesn't mean the property or method isn't accessible to the user,
or its value protected.
It is a developer's convenience, to provide class encapsulation; what it makes
is to hide the members from the `Get-Member` cmdlet.
Hidden members are not displayed by using tab completion or IntelliSense,
unless the completion occurs in the class that defines the hidden member.

### EXAMPLE: Hidden attribute

When a 'rack' is created, the number of slots (for devices) is a fixed value
that should not be changed at any time; this value is known at creation time.

Using the hidden attribute allows the developer to keep the number of slots
out of sight; so, nobody, inadvertently, changes the size of the rack.

```powershell
class Device {
    [string]$Brand
    [string]$Model
}

class Rack {
    [int] hidden $Slots = 8
    [string]$Brand
    [string]$Model
    [Device[]]$Devices = [Device[]]::new($this.Slots)

    Rack ([string]$b, [string]$m, [int]$capacity){
        ## argument validation here

        $this.Brand = $b
        $this.Model = $m
        $this.Slots = $capacity

        ## reset rack size to new capacity
        $this.Devices = [Device[]]::new($this.Slots)
    }
}

[Rack]$r1 = [Rack]::new("Microsoft", "Surface Pro 4", 16)

$r1
$r1.Devices.Length
$r1.Slots
```

```output

Brand     Model         Devices
-----     -----         -------
Microsoft Surface Pro 4 {$null, $null, $null, $null...}
16
16

```

Notice `Slots` property is not reported in `$r1` output; but, the size was changed.
Also, the property is available in all scopes the object is available.

## STATIC ATTRIBUTE

The `static` attribute defines a property or a method that exists in the class
and needs no instance or instantiation.

A static property is always available, independent of class instantiation.
A static property is shared across all instances of the class.
A static method is available always.

> **NOTE**: All static properties live for the entire session span.

### EXAMPLE: Static attribute and method

Assume the racks instantiated here exist in your data center.
So, you would like to keep track of the racks in your code.

```powershell
class Device {
    [string]$Brand
    [string]$Model
}

class Rack {
    hidden [int] $Slots = 8
    static [Rack[]]$InstalledRacks = @()
    [string]$Brand
    [string]$Model
    [string]$AssetId
    [Device[]]$Devices = [Device[]]::new($this.Slots)

    Rack ([string]$b, [string]$m, [string]$id, [int]$capacity){
        ## argument validation here

        $this.Brand = $b
        $this.Model = $m
        $this.AssetId = $id
        $this.Slots = $capacity

        ## reset rack size to new capacity
        $this.Devices = [Device[]]::new($this.Slots)

        ## add rack to installed racks
        [Rack]::InstalledRacks += $this
    }

    static [void]PowerOffRacks(){
        foreach ($rack in [Rack]::InstalledRacks) {
            Write-Warning ("Turning off rack: " + ($rack.AssetId))
        }
    }
}

## Testing static property and method exist
[Rack]::InstalledRacks.Length
[Rack]::PowerOffRacks()

(1..10).foreach({[Rack]::new("Adatum Corporation", "Standard-16", $_.ToString("Std0000"), 16)}) > $null

## Testing static property and method
[Rack]::InstalledRacks.Length

[Rack]::InstalledRacks[3]

[Rack]::PowerOffRacks()

```

```output
0
10

Brand              Model       AssetId Devices
-----              -----       ------- -------
Adatum Corporation Standard-16 Std0004 {$null, $null, $null, $null...}

WARNING: Turning off rack: Std0001
WARNING: Turning off rack: Std0002
WARNING: Turning off rack: Std0003
WARNING: Turning off rack: Std0004
WARNING: Turning off rack: Std0005
WARNING: Turning off rack: Std0006
WARNING: Turning off rack: Std0007
WARNING: Turning off rack: Std0008
WARNING: Turning off rack: Std0009
WARNING: Turning off rack: Std0010
```

Note: Messages from the different streams might come at different times
to your screen.

If you run the sample a couple of times, you will notice the number of racks
keeps increasing.

## PROPERTY VALIDATION ATTRIBUTES

Validation attributes allow to test values given to properties meet defined
requirements. Validations are triggered at the moment the property assignment
is invoked, except at moment the class is instantiated. See [about_functions_advanced_parameters](about_functions_advanced_parameters.md).

### EXAMPLE: Validation Attributes

```powershell
class Device {
    [ValidateNotNullOrEmpty()][string]$Brand
    [ValidateNotNullOrEmpty()][string]$Model
}

[Device]$dev = [Device]::new()

Write-Output "Testing dev"
$dev

$dev.Brand = ""

```

```output
Testing dev

Brand Model
----- -----

Exception setting "Brand": "The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
At C:\tmp\Untitled-5.ps1:11 char:1
+ $dev.Brand = ""
+ ~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [], SetValueInvocationException
    + FullyQualifiedErrorId : ExceptionWhenSetting


```

## INHERITANCE IN POWERSHELL CLASSES

You can extend the functionality of an existing class by creating a new class
that derives from an existing class. The derived class inherits the properties
of the base class, and you can add or override methods and properties as
required.

PowerShell does not support multiple inheritance,
meaning that classes cannot inherit from more than one class.
You can, however, use interfaces for that purpose.

Inheritance implementation is defined by the `:` operator;
which means to extend this class or implements these interfaces.
The base class should always be leftmost in the class declaration;
interface declarations always come after the base class.

### EXAMPLE: SIMPLE INHERITANCE IN POWERSHELL CLASSES

In this example the _Rack_ and _Device_ classes used in the previous examples
are better defined to: avoid property repetitions, better align common
properties, and reuse common business logic.

Most objects in the data center are company assets, which makes sense to
start tracking them as assets.
Device types are defined by the `DeviceType` enumeration, see
[about_Enum](about_Enum.md) for details on enumerations.

In our example, we're only defining `Rack` and `ComputeServer`; both
extensions to the `Device` class.


```powershell
enum DeviceType {
    Undefined = 0
    Compute = 1
    Storage = 2
    Networking = 4
    Communications = 8
    Power = 16
    Rack = 32
}

class Asset {
    [string]$Brand
    [string]$Model
}

class Device : Asset {
    hidden [DeviceType]$devtype = [DeviceType]::Undefined
    [string]$Status

    [DeviceType] GetDeviceType(){
        return $this.devtype
    }
}

class ComputeServer : Device {
    hidden [DeviceType]$devtype = [DeviceType]::Compute
    [string]$ProcessorIdentifier
    [string]$Hostname
}

class Rack : Device {
    hidden [DeviceType]$devtype = [DeviceType]::Rack
    hidden [int]$Slots = 8

    [string]$Datacenter
    [string]$Location
    [Device[]]$Devices = [Device[]]::new($this.Slots)

    Rack (){
        ## Just create the default rack with 8 slots
    }

    Rack ([int]$s){
        ## Add argument validation logic here
        $this.Devices = [Device[]]::new($s)
    }

    [void] AddDevice([Device]$dev, [int]$slot){
        ## Add argument validation logic here
        $this.Devices[$slot] = $dev
    }

    [void] RemoveDevice([int]$slot){
        ## Add argument validation logic here
        $this.Devices[$slot] = $null
    }
}

$FirstRack = [Rack]::new(16)
$FirstRack.Status = "Operational"
$FirstRack.Datacenter = "PNW"
$FirstRack.Location = "F03R02.J10"

(0..15).ForEach({
    $ComputeServer = [ComputeServer]::new()
    $ComputeServer.Brand = "Fabrikam, Inc."       ## Inherited from Asset
    $ComputeServer.Model = "Fbk5040"              ## Inherited from Asset
    $ComputeServer.Status = "Installed"           ## Inherited from Device
    $ComputeServer.ProcessorIdentifier = "x64"    ## ComputeServer property
    $ComputeServer.Hostname = ("r1s" + $_.ToString("000"))     ## ComputeServer property
    $FirstRack.AddDevice($ComputeServer, $_)
  })

$FirstRack

$FirstRack.Devices
```

```output

Datacenter : PNW
Location   : F03R02.J10
Devices    : {r1s000, r1s001, r1s002, r1s003...}
Status     : Operational
Brand      : 
Model      : 

ProcessorIdentifier : x64
Hostname            : r1s000
Status              : Installed
Brand               : Fabrikam, Inc.
Model               : Fbk5040

ProcessorIdentifier : x64
Hostname            : r1s001
Status              : Installed
Brand               : Fabrikam, Inc.
Model               : Fbk5040

<... content truncated here for brevity ...>

ProcessorIdentifier : x64
Hostname            : r1s015
Status              : Installed
Brand               : Fabrikam, Inc.
Model               : Fbk5040

```

## CALLING BASE CLASS CONSTRUCTORS

To invoke a base class constructor from a subclass, add the "base" keyword.

### EXAMPLE: Base class constructor invoked

```powershell
class Person {
    [int]$Age

    Person([int]$a)
    {
        $this.Age = $a
    }
}

class Child : Person
{
    [string]$School

    Child([int]$a, [string]$s ) : base($a) {
        $this.School = $s
    }
}

[Child]$littleone = [Child]::new(10, "Silver Fir Elementary School")

$littleone.Age
```

```output

10
```

## INVOKE BASE CLASS METHODS

You can override existing methods in subclasses. To do this, declare
methods by using the same name and signature.

```powershell
class BaseClass
{
    [int]days() {return 1}
}
class ChildClass1 : BaseClass
{
    [int]days () {return 2}
}

[ChildClass1]::new().days()
```

```output

2
```

To call base class methods from overridden implementations, cast to the
base class ([baseclass]$this) on invocation.

```powershell
class BaseClass
{
    [int]days() {return 1}
}
class ChildClass1 : BaseClass
{
    [int]days () {return 2}
    [int]basedays() {return ([BaseClass]$this).days()}
}

[ChildClass1]::new().days()
[ChildClass1]::new().basedays()
```

```output

2
1
```

## METHODS ARE VIRTUAL

All PowerShell methods are virtual. You can hide non-virtual .NET
methods in a subclass by using the same syntax as you do for an override:  
declare methods with same name and signature.

```powershell 
class MyIntList : system.collections.generic.list[int] 
{
    # Add is final in system.collections.generic.list
    [void] Add([int]$arg) 
    {
        ([system.collections.generic.list[int]]$this).Add($arg * 2)
    }
} 

$list = [MyIntList]::new()
$list.Add(100)
$list[0] # return 200
```

## INTERFACES

There is no syntax to declare interfaces in PowerShell.
 
## SEE ALSO

- [about_Enum](about_Enum.md)
- [about_Language_Keywords](about_language_keywords.md)
- [about_Methods](about_methods.md)