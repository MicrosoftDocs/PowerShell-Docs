---
description: Describes how you can use classes to create your own custom types.
Locale: en-US
ms.date: 07/13/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_classes?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about Classes
---
# about_Classes

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
- Define DSC resources and their associated types using the PowerShell
  language.

## Syntax

Classes are declared using the following syntax:

```syntax
class <class-name> [: [<base-class>][,<interface-list>]] {
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
$dev.Brand = "Fabrikam, Inc."
$dev
```

```Output
Brand
-----
Fabrikam, Inc.
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
$device.Brand = "Fabrikam, Inc."
$device.Model = "Fbk5040"
$device.VendorSku = "5072641000"

$device
```

```Output
Brand          Model   VendorSku
-----          -----   ---------
Fabrikam, Inc. Fbk5040 5072641000
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
      return ('{0}|{1}|{2}' -f $this.Brand, $this.Model, $this.VendorSku)
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

$device = [Device]::new()
$device.Brand = "Fabrikam, Inc."
$device.Model = "Fbk5040"
$device.VendorSku = "5072641000"

$rack.AddDevice($device, 2)

$rack
$rack.GetAvailableSlots()
```

```Output

Slots     : 8
Devices   : {$null, $null, Fabrikam, Inc.|Fbk5040|5072641000, $null…}
Brand     :
Model     :
VendorSku :
AssetId   :

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
aren't passed through. You must use `throw` to surface a terminating error.
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

[Device]$device = [Device]::new(
    "Fabrikam, Inc.",
    "Fbk5040",
    "5072641000"
)

$device
```

```Output
Brand          Model   VendorSku
-----          -----   ---------
Fabrikam, Inc. Fbk5040 5072641000
```

### Example with multiple constructors

In this example, the **Device** class is defined with properties, a default
constructor, and a constructor to initialize the instance.

The default constructor sets the **brand** to **Undefined**, and leaves
**model** and **vendor-sku** with null values.

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

[Device]$someDevice = [Device]::new()
[Device]$server = [Device]::new(
    "Fabrikam, Inc.",
    "Fbk5040",
    "5072641000"
)

$someDevice, $server
```

```Output
Brand          Model   VendorSku
-----          -----   ---------
Undefined
Fabrikam, Inc. Fbk5040 5072641000
```

## Hidden keyword

The `hidden` keyword hides a property or method. The property or method is
still accessible to the user and is available in all scopes in which the object
is available. Hidden members are hidden from the `Get-Member` cmdlet and can't
be displayed using tab completion or IntelliSense outside the class definition.

For more information, see [about_Hidden][04].

### Example using hidden keywords

When a **Rack** object is created, the number of slots for devices is a fixed
value that shouldn't be changed at any time. This value is known at creation
time.

Using the hidden keyword allows the developer to keep the number of slots
hidden and prevents unintentional changes to the size of the rack.

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

[Rack]$r1 = [Rack]::new("Fabrikam, Inc.", "Fbk5040", 16)

$r1
$r1.Devices.Length
$r1.Slots
```

```Output
Devices                       Brand          Model
-------                       -----          -----
{$null, $null, $null, $null…} Fabrikam, Inc. Fbk5040
16
16
```

Notice **Slots** property isn't shown in `$r1` output. However, the size was
changed by the constructor.

## Static keyword

The `static` keyword defines a property or a method that exists in the class
and needs no instance.

A static property is always available, independent of class instantiation. A
static property is shared across all instances of the class. A static method is
available always. All static properties live for the entire session span.

### Example using static properties and methods

Assume the racks instantiated here exist in your data center and you want to
keep track of the racks in your code.

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

## Using property attributes

PowerShell includes several attribute classes that you can use to enhance data
type information and validate the data assigned to a property. Validation
attributes allow you to test that values given to properties meet defined
requirements. Validation is triggered the moment that the value is assigned.

```powershell
class Device {
    [ValidateNotNullOrEmpty()] [string]$Brand
    [ValidateNotNullOrEmpty()] [string]$Model
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
argument that isn't null or empty, and then try the command again."
At C:\tmp\Untitled-5.ps1:11 char:1
+ $dev.Brand = ""
+ ~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [], SetValueInvocationException
    + FullyQualifiedErrorId : ExceptionWhenSetting
```

For more information on available attributes, see
[about_Functions_Advanced_Parameters][03].

## Inheritance in PowerShell classes

You can extend a class by creating a new class that derives from an existing
class. The derived class inherits the properties of the base class. You can add
or override methods and properties as required.

PowerShell doesn't support multiple inheritance. Classes can't inherit from
more than one class. However, you can use interfaces for that purpose.

An inheritance implementation is defined using the `:` syntax to extend the
class or implement interfaces. The derived class should always be leftmost in
the class declaration.

This example shows the basic PowerShell class inheritance syntax.

```powershell
Class Derived : Base {...}
```

This example shows inheritance with an interface declaration coming after the
base class.

```powershell
Class Derived : Base, Interface {...}
```

### Example of inheritance in PowerShell classes

In this example the **Rack** and **Device** classes used in the previous
examples are better defined to: avoid property repetitions, better align common
properties, and reuse common business logic.

Most objects in the data center are company assets, which makes sense to start
tracking them as assets. The `DeviceType` enumeration defines device types
used by the class. For more information about enumerations, see
[about_Enum][02].

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
```

In our example, we're defining `Rack` and `ComputeServer` as extensions to the
`Device` class.

```powershell
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

[Child]$littleOne = [Child]::new(10, "Silver Fir Elementary School")

$littleOne.Age
```

```Output

10
```

### Invoke base class methods

To override existing methods in subclasses, declare methods using the same name
and signature.

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

To call base class methods from overridden implementations, cast to the base
class (`[baseclass]$this`) on invocation.

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
> PowerShell doesn't support declaring new interfaces in PowerShell script.

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

## NoRunspaceAffinity attribute

A runspace is the operating environment for the commands invoked by PowerShell.
This environment includes the commands and data that are currently present, and
any language restrictions that currently apply.

By default, a PowerShell class is affiliated with the **Runspace** where it's
created. Using a PowerShell class in `ForEach-Object -Parallel` is not safe.
Method invocations on the class are marshalled back to the **Runspace** where
it was created, which can corrupt the state of the **Runspace** or cause a
deadlock.

Adding the `NoRunspaceAffinity` attribute to the class definition ensures that
the PowerShell class is not affiliated with a particular runspace. Method
invocations, both instance and static, use the **Runspace** of the running
thread and the thread's current session state.

The attribute was added in PowerShell 7.4.

### Example - Class definition with Runspace affinity

The `ShowRunspaceId()` method of `[UnsafeClass]` reports different thread Ids
but the same runspace Id. Eventually, the session state is corrupted causing
an error, such as `Global scope cannot be removed`.

```powershell
# Class definition with Runspace affinity (default behavior)
class UnsafeClass {
    static [object] ShowRunspaceId($val) {
        return [PSCustomObject]@{
            ThreadId = [Threading.Thread]::CurrentThread.ManagedThreadId
            RunspaceId = [runspace]::DefaultRunspace.Id
        }
    }
}
$unsafe = [UnsafeClass]::new()
while ($true) {
    1..10 | ForEach-Object -Parallel {
        Start-Sleep -ms 100
        ($using:unsafe)::ShowRunspaceId($_)
    }
}
```

> [!NOTE]
> This example runs in an infinite loop. Enter <kbd>Ctrl</kbd>+<kbd>C</kbd> to
> stop the execution.

### Example - Class definition with NoRunspaceAffinity

The `ShowRunspaceId()` method of `[SafeClass]` reports different thread and
Runspace ids.

```powershell
# Class definition with NoRunspaceAffinity attribute
[NoRunspaceAffinity()]
class SafeClass {
    static [object] ShowRunspaceId($val) {
        return [PSCustomObject]@{
            ThreadId = [Threading.Thread]::CurrentThread.ManagedThreadId
            RunspaceId = [runspace]::DefaultRunspace.Id
        }
    }
}
$safe = [SafeClass]::new()
while ($true) {
    1..10 | ForEach-Object -Parallel {
        Start-Sleep -ms 100
        ($using:safe)::ShowRunspaceId($_)
    }
}
```

> [!NOTE]
> This example runs in an infinite loop. Enter <kbd>Ctrl</kbd>+<kbd>C</kbd> to
> stop the execution.

## Importing classes from a PowerShell module

`Import-Module` and the `#requires` statement only import the module functions,
aliases, and variables, as defined by the module. Classes aren't imported. The
`using module` statement imports the classes defined in the module. If the
module isn't loaded in the current session, the `using` statement fails. For
more information about the `using` statement, see [about_Using][07].

The `using module` statement imports classes from the root module
(`ModuleToProcess`) of a script module or binary module. It doesn't
consistently import classes defined in nested modules or classes defined in
scripts that are dot-sourced into the module. Classes that you want to be
available to users outside of the module should be defined in the root module.

## Loading newly changed code during development

During development of a script module, it's common to make changes to the code
then load the new version of the module using `Import-Module` with the
**Force** parameter. This works for changes to functions in the root module
only. `Import-Module` doesn't reload any nested modules. Also, there is no way
to load any updated classes.

To ensure that you are running the latest version, you must unload the module
using the `Remove-Module` cmdlet. `Remove-Module` removes the root module, all
nested modules, and any classes defined in the modules. Then you can reload the
module and the classes using `Import-Module` and the `using module` statement.

Another common development practice is to separate your code into different
files. If you have function in one file that use classes defined in another
module, you should using the `using module` statement to ensure that the
functions have the class definitions that are needed.

## The PSReference type isn't supported with class members

The `[ref]` type accelerator is shorthand for the **PSReference** class. Using
`[ref]` to type-cast a class member fails silently. APIs that use `[ref]`
parameters can't be used with class members. The **PSReference** class was
designed to support COM objects. COM objects have cases where you need to pass
a value in by reference.

For more information, see [PSReference Class][01].

## See also

- [about_Enum][02]
- [about_Hidden][04]
- [about_Language_Keywords][05]
- [about_Methods][06]
- [about_Using][07]

<!-- link references -->
[01]: /dotnet/api/system.management.automation.psreference
[02]: about_Enum.md
[03]: about_functions_advanced_parameters.md
[04]: about_Hidden.md
[05]: about_language_keywords.md
[06]: about_methods.md
[07]: about_Using.md
