---
ms.date:  06/12/2017
keywords:  wmf,powershell,setup
title: Creating Custom Types using PowerShell Classes
---

# Creating Custom Types using PowerShell Classes

PowerShell 5.0 added the ability to define classes and other user-defined types using formal syntax
and semantics like other object-oriented programming languages. The goal is to enable developers and
IT professionals to embrace PowerShell for a wider range of use cases, simplify development of
PowerShell artifacts (such as DSC resources), and accelerate coverage of management surfaces.

## Supported scenarios in this release

- Define DSC resources and their associated types by using the PowerShell language
- Define custom types in PowerShell by using familiar object-oriented programming constructs, such
  as classes, properties, methods, etc.
- Inheritance support with class in PowerShell and class base DSC resource
- Debug types by using the PowerShell language
- Generate and handle exceptions by using formal mechanisms, and at the right level

# Declare Base Class

You can declare a PowerShell class as a base type for another PowerShell class.

```powershell
class bar
{
   [int]foo()
       {
           return 100500
       }
}

class baz : bar {}

[baz]::new().foo() # return 100500
```

You can also use existing .NET Framework types as base classes:

```powershell
class MyIntList : system.collections.generic.list[int]
{

}

$list = [MyIntList]::new()

$list.Add(100)

$list[0] # return 100
```

# Call Base Class Constructor

To call a base class constructor from a subclass, use the keyword **base**:

```powershell
class A
{
    [int]$a

    A([int]$a)
    {
        $this.a = $a
    }
}

class B : A
{
    B() : base(103) {}
}

[B]::new().a # return 103
```

If a base class has a default (no parameter) constructor, you can omit an explicit constructor call:

```powershell
class C : B
{
    C([int]$c) {}
}
```

# Call Base Class Method

You can override existing methods in subclasses. To do this, declare methods by using the same name
and signature:

```powershell
class baseClass
{
    [int]foo() {return 100500}
}

class childClass1 : baseClass
{
    [int]foo() {return 200600}
}

[childClass1]::new().foo() # return 200600
```

To call base class methods from overridden implementations, cast to the base class
(`[baseClass]$this`) on invocation:

```powershell
class childClass2 : baseClass
{
    [int]foo()
    {
        return 3 * ([baseClass]$this).foo()
    }
}

[childClass2]::new().foo() # return 301500
```

All PowerShell methods are virtual. You can hide non-virtual .NET methods in a subclass by using the
same syntax as you do for an override, by declaring methods with same name and signature.

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

# Declare Implemented Interface

You can declare implemented interfaces after base types, or immediately after a colon (:), if there
is no base type specified. Separate all type names by using commas. It's similar to C# syntax.

```powershell
class MyComparable : system.IComparable
{
    [int] CompareTo([object] $obj)
    {
        return 0;
    }
}

class MyComparableBar : bar, system.IComparable
{
    [int] CompareTo([object] $obj)
    {
        return 0;
    }
}
```

# New language features in PowerShell 5.0

PowerShell 5.0 introduces the following new language elements in PowerShell:

## Class keyword

The `class` keyword defines a new class. This is a true .NET Framework type. Class members are
public, but only public within the module scope. You can't refer to the type name as a string (for
example, `New-Object` doesn't work), and in this release, you can't use a type literal (for example,
`[MyClass]`) outside the script or module file in which the class is defined.

```powershell
class MyClass
{
    ...
}
```

## Enum keyword and enumerations

Support for the `enum` keyword has been added, which uses newline as the delimiter. Currently, you
cannot define an enumerator in terms of itself. However, you can initialize an enum in terms of
another enum, as shown in the following example. Also, the base type cannot be specified; it is
always `[int]`.

```powershell
enum Color2
{
    Yellow = [Color]::Blue
}
```

An enumerator value must be a parse time constant. You cannot set it to the result of an invoked
command.

```powershell
enum MyEnum
{
    Enum1
    Enum2
    Enum3 = 42
    Enum4 = [int]::MaxValue
}
```

Enums support arithmetic operations, as shown in the following example.

```powershell
enum SomeEnum { Max = 42 }
enum OtherEnum { Max = [SomeEnum]::Max + 1 }
```

## Import-DscResource

`Import-DscResource` is now a true dynamic keyword. PowerShell parses the specified module's root
module, searching for classes that contain the **DscResource** attribute.

## ImplementingAssembly

A new field, **ImplementingAssembly**, has been added to **ModuleInfo**. It is set to the dynamic
assembly created for a script module if the script defines classes, or the loaded assembly for
binary modules. It is not set when **ModuleType** is **Manifest**.

Reflection on the **ImplementingAssembly** field discovers resources in a module. This means you can
discover resources written in either PowerShell or other managed languages.

Fields with initializers:

```powershell
[int] $i = 5
```

`Static` is supported. It works like an attribute, as do the type constraints. It can be specified in
any order.

```powershell
static [int] $count = 0
```

A type is optional.

```powershell
$s = "hello"
```

All members are public.

## Constructors and instantiation

PowerShell classes can have constructors. They have the same name as their class. Constructors can
be overloaded. Static constructors are supported. Properties with initialization expressions are
initialized before running any code in a constructor. Static properties are initialized before the
body of a static constructor, and instance properties are initialized before the body of the
non-static constructor. Currently, there is no syntax for calling a constructor from another
constructor (like the C\# syntax ": this()"). The workaround is to define a common `Init()` method.

### Creating instances

> [!NOTE]
> In PowerShell 5.0, `New-Object` does not work with classes defined in PowerShell. Also, the type
> name is only visible lexically, meaning it is not visible outside of the module or script that
> defines the class. Functions can return instances of a class defined in PowerShell. Those
> instances work outside of the module or script.

1. Instantiating by using the default constructor.

   ```powershell
   $a = [MyClass]::new()
   ```

1. Calling a constructor with a parameter

   ```powershell
   $b = [MyClass]::new(42)
   ```

1. Passing an array to a constructor with multiple parameters.

   ```powershell
   $c = [MyClass]::new(@(42,43,44), "Hello")
   ```

The pseudo-static method `new()` works with .NET types, as shown in the following example.

```powershell
[hashtable]::new()
```

### Discovering constructors

You can now see constructor overloads with `Get-Member`, or as shown in this example:

```powershell
PS> [hashtable]::new
OverloadDefinitions
-------------------
hashtable new()
hashtable new(int capacity)
hashtable new(int capacity, float loadFactor)
```

`Get-Member -Static` lists constructors, so you can view overloads like any other method. The performance of this syntax is also considerably faster than `New-Object`.

## Methods

A PowerShell class method is implemented as a **ScriptBlock** that has only an end block. All
methods are public. The following shows an example of defining a method named **DoSomething**.

```powershell
class MyClass
{
    DoSomething($x)
    {
        $this._doSomething($x) # method syntax
    }
    private _doSomething($a) {}
}
```

Method invocation:

```powershell
$b = [MyClass]::new()
$b.DoSomething(42)
```

Overloaded methods are also supported.

## Properties

All properties are public. Properties require either a newline or semicolon. If no object type is
specified, the property type is object.

Properties that use validation or argument transformation attributes (like `[ValidateSet("aaa")]`)
work as expected.

## Hidden

A new keyword, `Hidden`, has been added. `Hidden` can be applied to properties and methods
(including constructors).

Hidden members are public, but do not appear in the output of `Get-Member` unless the -Force
parameter is added. Hidden members are not included when tab completing or using Intellisense unless the completion
occurs in the class defining the hidden member.

A new attribute, **System.Management.Automation.HiddenAttribute** has been added so that C\# code
can have the same semantics within PowerShell.

## Return types

Return type is a contract. The return value is converted to the expected type. If no return type is
specified, the return type is **void**. There is no streaming of objects. Bbjects cannot be written
to the pipeline either intentionally or by accident.

## Attributes

Two new attributes, **DscResource** and **DscProperty** have been added.

## Lexical scoping of variables

The following shows an example of how lexical scoping works in this release.

```powershell
$d = 42 # Script scope

function bar
{
    $d = 0 # Function scope
    [MyClass]::DoSomething()
}

class MyClass
{
    static [object] DoSomething()
    {
        return $d # error, not found dynamically
        return $script:d # no error
        $d = $script:d
        return $d # no error, found lexically
    }
}

$v = bar
$v -eq $d # true
```

## End-to-End Example

The following example creates some custom classes to implement an HTML dynamic style sheet language
(DSL). Then, the example adds helper functions to create specific element types as part of the
element class, such as heading styles and tables, because types cannot be used outside the scope of
a module.

```powershell
# Classes that define the structure of the document
#
class Html
{
    [string] $docType
    [HtmlHead] $Head
    [Element[]] $Body

    [string] Render()
    {
        $text = "<html>`n<head>`n"
        $text += $this.Head
        $text += "`n</head>`n<body>`n"
        $text += $this.Body -join "`n" # Render all of the body elements
        $text += "</body>`n</html>"
        return $text
    }
    [string] ToString() { return $this.Render() }
}

class HtmlHead
{
    $Title
    $Base
    $Link
    $Style
    $Meta
    $Script
    [string] Render() { return "<title>$($this.Title)</title>" }
    [string] ToString() { return $this.Render() }
}

class Element
{
    [string] $Tag
    [string] $Text
    [hashtable] $Attributes
    [string] Render() {
        $attributesText= ""
        if ($this.Attributes)
        {
            foreach ($attr in $this.Attributes.Keys)
            {
                #BUGBUG - need to validate keys against attribute
                $attributesText += " $attr=`"$($this.Attributes[$attr])\`""
            }
        }
        return "<$($this.tag)${attributesText}>$($this.text)</$($this.tag)>`n"
    }
[string] ToString() { return $this.Render() }
}

#
# Helper functions for creating specific element types on top of the classes.
# These are required because types aren't visible outside of the module.
#

function H1 { [Element] @{ Tag = "H1" ; Text = $args.foreach{$_} -join " " }}
function H2 { [Element] @{ Tag = "H2" ; Text = $args.foreach{$_} -join " " }}
function H3 { [Element] @{ Tag = "H3" ; Text = $args.foreach{$_} -join " " }}
function P { [Element] @{ Tag = "P" ; Text = $args.foreach{$_} -join " " }}
function B { [Element] @{ Tag = "B" ; Text = $args.foreach{$_} -join " " }}
function I { [Element] @{ Tag = "I" ; Text = $args.foreach{$_} -join " " }}
function HREF
{
    param (
        $Name,
        $Link
    )
    return [Element] @{
        Tag = "A"
        Attributes = @{ HREF = $link }
        Text = $name
    }
}
function Table
{
    param (
    [Parameter(Mandatory)]
    [object[]]
        $Data,
    [Parameter()]
    [string[]]
        $Properties = "*",
    [Parameter()]
    [hashtable]
        $Attributes = @{ border=2; cellpadding=2; cellspacing=2 }
    )
$bodyText = ""
# Add the header tags
$bodyText += $Properties.foreach{TH $_}
# Add the rows
$bodyText += foreach ($row in $Data)
    {
        TR (-join $Properties.Foreach{ TD ($row.$_) } )
    }

    $table = [Element] @{
        Tag = "Table"
        Attributes = $Attributes
        Text = $bodyText
    }
$table
}
function TH { ([Element] @{ Tag = "TH" ; Text = $args.foreach{$_} -join " " }) }
function TR { ([Element] @{ Tag = "TR" ; Text = $args.foreach{$_} -join " " }) }
function TD { ([Element] @{ Tag = "TD" ; Text = $args.foreach{$_} -join " " }) }
function Style

{
    return [Element] @{
        Tag = "style"
        Text = "$args"
    }
}

# Takes a hash table, casts it to and HTML document
# and then returns the resulting type.
#
function Html ([HTML] $doc) { return $doc }
```
