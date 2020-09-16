---
description: Describes how you can use classes to create your own custom types.
keywords: powershell,cmdlet
Locale: en-US
ms.date: 09/16/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_classes?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Classes
---
# About Classes

## Short description
Describes how you can use classes to create your own custom types.

## Long description

PowerShell 5.0 adds a formal syntax to define classes and other user-defined
types. The addition of classes enables developers and IT professionals to
embrace PowerShell for a wider range of use cases. It simplifies development of
PowerShell artifacts and accelerates coverage of management surfaces.

A class declaration is a blueprint used to create instances of objects at run
time. When you define a class, the class name is the name of the type. For
example, if you declare a class named **Device** and initialize a variable
`$dev` to a new instance of **Device**, `$dev` is an object or instance of type
**Device**. Each instance of **Device** can have different values in its
properties.

## Supported scenarios

- Define custom types in PowerShell using familiar object-oriented programming
  semantics like classes, properties, methods, inheritance, etc.
- Debug types using the PowerShell language.
- Generate and handle exceptions using formal mechanisms.
- Define DSC resources and their associated types by using the PowerShell
  language.

## Syntax

Classes are declared using the following syntax:

```syntax
class <class-name> [: [<base-class>][,<interface-list]] {
    [[<attribute>] [hidden] [static] <property-definition> ...]
    [<class-name>([<constructor-argument-list>])
      {<constructor-statement-list>} ...]
    [[<attribute>] [hidden] [static] <method-definition> ...]
}
```

Classes are instantiated using either of the following syntaxes:

```syntax
[$<variable-name> =] New-Object -TypeName <class-name> [
  [-ArgumentList] <constructor-argument-list>]
```

```syntax
[$<variable-name> =] [<class-name>]::new([<constructor-argument-list>])
```

> [!NOTE]
> When using the `[<class-name>]::new()` syntax, brackets around the class name
> are mandatory. The brackets signal a type definition for PowerShell.

### Example syntax and usage

This example shows the minimum syntax needed to create a usable class.

```powershell
class Device {
    [string]$Brand
}

$dev = [Device]::new()
$dev.Brand = "Microsoft"
$dev
```

```Output
Brand
-----
Microsoft
```

## Class properties

Properties are variables declared at class scope. A property may be of any
built-in type or an instance of another class. Classes have no restriction in
the number of properties they have.

### Example class with simple properties

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

```Output
Brand     Model         VendorSku
-----     -----         ---------
Microsoft Surface Pro 4 5072641000
```

### Example complex types in class properties

This example defines an empty **Rack** class using the **Device** class. The
examples, following this one, show how to add devices to the rack and how to
start with a pre-loaded rack.

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

```Output

Brand     :
Model     :
VendorSku :
AssetId   :
Devices   : {$null, $null, $null, $null...}


```

## Class methods

Methods define the actions that a class can perform. Methods may take
parameters that provide input data. Methods can return output. Data returned by
a method can be any defined data type.

When defining a method for a class, you reference the current class object by
using the `$this` automatic variable. This allows you to access properties and
other methods defined in the current class.

### Example simple class with properties and methods

Extending the **Rack** class to add and remove devices
to or from it.

```powershell
class Device {
    [string]$Brand
    [string]$Model
    [string]$VendorSku

    [string]ToString(){
        return ("{0}|{1}|{2}" -f $this.Brand, $this.Model, $this.VendorSku)
    }
}

class Rack {
    [int]$Slots = 8
    [string]$Brand
    [string]$Model
    [string]$VendorSku
    [string]$AssetId
    [Device[]]$Devices = [Device[]]::new($this.Slots)

    [void] AddDevice([Device]$dev, [int]$slot){
        ## Add argument validation logic here
        $this.Devices[$slot] = $dev
    }

    [void]RemoveDevice([int]$slot){
        ## Add argument validation logic here
        $this.Devices[$slot] = $null
    }

    [int[]] GetAvailableSlots(){
        [int]$i = 0
        return @($this.Devices.foreach{ if($_ -eq $null){$i}; $i++})
    }
}

$rack = [Rack]::new()

$surface = [Device]::new()
$surface.Brand = "Microsoft"
$surface.Model = "Surface Pro 4"
$surface.VendorSku = "5072641000"

$rack.AddDevice($surface, 2)

$rack
$rack.GetAvailableSlots()
```

```Output

Slots     : 8
Brand     :
Model     :
VendorSku :
AssetId   :
Devices   : {$null, $null, Microsoft|Surface Pro 4|5072641000, $null...}

0
1
3
4
5
6
7

```

## Output in class methods

Methods should have a return type defined. If a method doesn't return output,
then the output type should be `[void]`.

In class methods, no objects get sent to the pipeline except those mentioned in
the `return` statement. There's no accidental output to the pipeline from the
code.

> [!NOTE]
> This is fundamentally different from how PowerShell functions handle output,
> where everything goes to the pipeline.

Non-terminating errors written to the error stream from inside a class method
are not passed through. You must use `throw` to surface a terminating error.
Using the `Write-*` cmdlets, you can still write to PowerShell's output streams
from within a class method. However, this should be avoided so that the method
emits objects using only the `return` statement.

### Method output

This example demonstrates no accidental output to the pipeline from class
methods, except on the `return` statement.

```powershell
class FunWithIntegers
{
    [int[]]$Integers = 0..10

    [int[]]GetOddIntegers(){
        return $this.Integers.Where({ ($_ % 2) })
    }

    [void] GetEvenIntegers(){
        # this following line doesn't go to the pipeline
        $this.Integers.Where({ ($_ % 2) -eq 0})
    }

    [string]SayHello(){
        # this following line doesn't go to the pipeline
        "Good Morning"

        # this line goes to the pipeline
        return "Hello World"
    }
}

$ints = [FunWithIntegers]::new()
$ints.GetOddIntegers()
$ints.GetEvenIntegers()
$ints.SayHello()
```

```Output
1
3
5
7
9
Hello World

```

## Constructor

Constructors enable you to set default values and validate object logic at the
moment of creating the instance of the class. Constructors have the same name
as the class. Constructors might have arguments, to initialize the data members
of the new object.

The class can have zero or more constructors defined. If no constructor is
defined, the class is given a default parameterless constructor. This
constructor initializes all members to their default values. Object types and
strings are given null values. When you define constructor, no default
parameterless constructor is created. Create a parameterless constructor if one
is needed.

### Constructor basic syntax

In this example, the Device class is defined with properties and a constructor.
To use this class, the user is required to provide values for the parameters
listed in the constructor.

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

```Output
Brand     Model         VendorSku
-----     -----         ---------
Microsoft Surface Pro 4 5072641000
```

### Example with multiple constructors

In this example, the **Device** class is defined with properties, a default
constructor, and a constructor to initialize the instance.

The default constructor sets the **brand** to **Undefined**, and leaves **model**
and **vendor-sku** with null values.

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

```Output
Brand       Model           VendorSku
-----       -----           ---------
Undefined
Microsoft   Surface Pro 4   5072641000
```

## Hidden attribute

The `hidden` attribute hides a property or method. The property or method is
still accessible to the user and is available in all scopes in which the object
is available. Hidden members are hidden from the `Get-Member` cmdlet and can't
be displayed using tab completion or IntelliSense outside the class definition.

For more information, see [About_hidden](About_hidden.md).

### Example using hidden attributes

When a **Rack** object is created, the number of slots for devices is a fixed
value that shouldn't be changed at any time. This value is known at creation
time.

Using the hidden attribute allows the developer to keep the number of slots
hidden and prevents unintentional changes the size of the rack.

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

```Output
Brand     Model         Devices
-----     -----         -------
Microsoft Surface Pro 4 {$null, $null, $null, $null...}
16
16
```

Notice **Slots** property isn't shown in `$r1` output. However, the size was
changed by the constructor.

## Static attribute

The `static` attribute defines a property or a method that exists in the class
and needs no instance.

A static property is always available, independent of class instantiation. A
static property is shared across all instances of the class. A static method is
available always. All static properties live for the entire session span.

### Example using static attributes and methods

Assume the racks instantiated here exist in your data center. So, you would
like to keep track of the racks in your code.

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
```

### Testing static property and method exist

```
PS> [Rack]::InstalledRacks.Length
0

PS> [Rack]::PowerOffRacks()

PS> (1..10) | ForEach-Object {
>>   [Rack]::new("Adatum Corporation", "Standard-16",
>>     $_.ToString("Std0000"), 16)
>> } > $null

PS> [Rack]::InstalledRacks.Length
10

PS> [Rack]::InstalledRacks[3]
Brand              Model       AssetId Devices
-----              -----       ------- -------
Adatum Corporation Standard-16 Std0004 {$null, $null, $null, $null...}

PS> [Rack]::PowerOffRacks()
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

Notice that the number of racks increases each time you run this example.

## Property validation attributes

Validation attributes allow you to test that values given to properties meet
defined requirements. Validation is triggered the moment that the value is
assigned. See [about_functions_advanced_parameters](about_functions_advanced_parameters.md).

### Example using validation attributes

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

```Output
Testing dev

Brand Model
----- -----

Exception setting "Brand": "The argument is null or empty. Provide an
argument that is not null or empty, and then try the command again."
At C:\tmp\Untitled-5.ps1:11 char:1
+ $dev.Brand = ""
+ ~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [], SetValueInvocationException
    + FullyQualifiedErrorId : ExceptionWhenSetting
```

## Inheritance in PowerShell classes

You can extend a class by creating a new class that derives from an existing
class. The derived class inherits the properties of the base class. You can add
or override methods and properties as required.

PowerShell does not support multiple inheritance. Classes cannot inherit from
more than one class. However, you can use interfaces for that purpose.

Inheritance implementation is defined by the `:` operator; which means to
extend this class or implements these interfaces. The derived class should
always be leftmost in the class declaration.

### Example using simple inheritance syntax

This example shows the simple PowerShell class inheritance syntax.

```powershell
Class Derived : Base {...}
```

This example shows inheritance with an interface declaration coming after the
base class.

```powershell
Class Derived : Base, Interface {...}
```

### Example of simple inheritance in PowerShell classes

In this example the **Rack** and **Device** classes used in the previous
examples are better defined to: avoid property repetitions, better align common
properties, and reuse common business logic.

Most objects in the data center are company assets, which makes sense to start
tracking them as assets. Device types are defined by the `DeviceType`
enumeration, see [about_Enum](about_Enum.md) for details on enumerations.

In our example, we're only defining `Rack` and `ComputeServer`; both extensions
to the `Device` class.

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
    $ComputeServer.ProcessorIdentifier = "x64"    ## ComputeServer
    $ComputeServer.Hostname = ("r1s" + $_.ToString("000")) ## ComputeServer
    $FirstRack.AddDevice($ComputeServer, $_)
  })

$FirstRack
$FirstRack.Devices
```

```Output
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

### Calling base class constructors

To invoke a base class constructor from a subclass, add the `base` keyword.

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

```Output

10
```

### Invoke base class methods

To override existing methods in subclasses, declare methods using the same
name and signature.

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

```Output

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

```Output

2
1
```

### Inheriting from interfaces

PowerShell classes can implement an interface using the same inheritance syntax
used to extend base classes. Because interfaces allow multiple inheritance, a
PowerShell class implementing an interface may inherit from multiple types, by
separating the type names after the colon (`:`) with commas (`,`). A PowerShell
class that implements an interface must implement all the members of that
interface. Omitting the implemention interface members causes a parse-time
error in the script.

> [!NOTE]
> PowerShell does not currently support declaring new interfaces in PowerShell
> script.

```powershell
class MyComparable : System.IComparable
{
    [int] CompareTo([object] $obj)
    {
        return 0;
    }
}

class MyComparableBar : bar, System.IComparable
{
    [int] CompareTo([object] $obj)
    {
        return 0;
    }
}
```

## Importing classes from a PowerShell module

`Import-Module` and the `#requires` statement only import the module functions,
aliases, and variables, as defined by the module. Classes are not imported. The
`using module` statement imports the classes defined in the module. If the
module isn't loaded in the current session, the `using` statement fails. For
more information about the `using` statement, see [about_Using](about_Using.md).

## The PSReference type is not supported with class members

Using the `[ref]` type-cast with a class member silently fails. APIs that use
`[ref]` parameters cannot be used with class members. The **PSReference** was
designed to support COM objects. COM objects have cases where you need to pass
a value in by reference.

For more information about the `[ref]` type, see
[PSReference Class](/dotnet/api/system.management.automation.psreference).

## See also

- [About_hidden](About_hidden.md)
- [about_Enum](about_Enum.md)
- [about_Language_Keywords](about_language_keywords.md)
- [about_Methods](about_methods.md)
- [about_Using](about_using.md)
