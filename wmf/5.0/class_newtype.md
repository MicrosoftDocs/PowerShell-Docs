# New language features in PowerShell 5.0 

PowerShell 5.0 introduces the following new language elements in Windows PowerShell:

## Class keyword

The **class** keyword defines a new class. This is a true .NET Framework type. 
Class members are public, but only public within the module scope.
You can't refer to the type name as a string (for example, `New-Object` doesn't work), and in this release, you can't use a type literal (for example, `[MyClass]`) outside the script/module file in which the class is defined.

```powershell
class MyClass
{
    ...
}
```

## Enum keyword and enumerations

Support for the **enum** keyword has been added, which uses newline as the delimiter.
Current limitations: you cannot define an enumerator in terms of itself, but you can initialize an enum in terms of another enum, as shown in the following example.
Also, the base type cannot currently be specified; it is always [int].

```powershell
enum Color2
{
    Yellow = [Color]::Blue
}
```

An enumerator value must be a parse time constant; you cannot set it to the result of an invoked command.

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

**Import-DscResource** is now a true dynamic keyword.
PowerShell parses the specified module’s root module, searching for classes that contain the **DscResource** attribute.

## ImplementingAssembly

A new field, **ImplementingAssembly**, has been added to ModuleInfo. It is set to the dynamic assembly created for a script module if the script defines classes, or the loaded assembly for binary modules. It is not set when ModuleType = Manifest. 

Reflection on the **ImplementingAssembly** field discovers resources in a module. This means you can discover resources written in either PowerShell or other managed languages.

Fields with initializers:      

```powershell
[int] $i = 5
```

Static is supported; it works like an attribute, as do the type constraints, so it can be specified in any order.

```powershell
static [int] $count = 0
```

A type is optional.

```powershell
$s = "hello"
```

All members are public. 

## Constructors and instantiation

Windows PowerShell classes can have constructors; they have the same name as their class. Constructors can be overloaded. Static constructors are supported. Properties with initialization expressions are initialized before running any code in a constructor. Static properties are initialized before the body of a static constructor, and instance properties are initialized before the body of the non-static constructor. Currently, there is no syntax for calling a constructor from another constructor (like the C\# syntax ": this()"). The workaround is to define a common Init method. 

The following are ways of instantiating classes in this release.

Instantiating by using the default constructor. Note that New-Object is not supported in this release.

```powershell
$a = [MyClass]::new()
```

Calling a constructor with a parameter

```powershell
$b = [MyClass]::new(42)
```

Passing an array to a constructor with multiple parameters
```powershell
$c = [MyClass]::new(@(42,43,44), "Hello")
```

In this release, New-Object does not work with classes defined in Windows PowerShell. Also for this release, the type name is only visible lexically, meaning it is not visible outside of the module or script that defines the class. Functions can return instances of a class defined in Windows PowerShell, and instances work well outside of the module or script.

`Get-Member -Static` lists constructors, so you can view overloads like any other method. The performance of this syntax is also considerably faster than New-Object.

The pseudo-static method named **new** works with .NET types, as shown in the following example.

```powershell
[hashtable]::new()
```

You can now see constructor overloads with Get-Member, or as shown in this example:

```powershell
PS> [hashtable]::new
OverloadDefinitions
-------------------
hashtable new()
hashtable new(int capacity)
hashtable new(int capacity, float loadFactor)
```

## Methods

A Windows PowerShell class method is implemented as a ScriptBlock that has only an end block. All methods are public. The following shows an example of defining a method named **DoSomething**.

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

Overloaded methods--that is, those that are named the same as an existing method, but differentiated by their specified values--are also supported.

## Properties 

All properties are public. Properties require either a newline or semicolon. If no object type is specified, the property type is object.

Properties that use validation attributes or argument transformation attributes (e.g. `[ValidateSet("aaa")]`) work as expected.

## Hidden

A new keyword, **Hidden**, has been added. **Hidden** can be applied to properties and methods (including constructors).

Hidden members are public, but do not appear in the output of Get-Member unless the -Force parameter is added.

Hidden members are not included when tab completing or using Intellisense unless the completion occurs in the class defining the hidden member.

A new attribute, **System.Management.Automation.HiddenAttribute** has been added so that C# code can have the same semantics within Windows PowerShell.

## Return types

Return type is a contract; the return value is converted to the expected type. If no return type is specified, the return type is void. There is no streaming of objects; objects cannot be written to the pipeline either intentionally or by accident.

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

The following example creates several new, custom classes to implement an HTML dynamic style sheet language (DSL). 
Then, the example adds helper functions to create specific element types as part of the element class, such as heading styles and tables, because types cannot be used outside the scope of a module.

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
# These are required because types aren’t visible outside of the module.
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
        TR (-join $Properties.Foreach{ TD ($row.$\_) } )
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