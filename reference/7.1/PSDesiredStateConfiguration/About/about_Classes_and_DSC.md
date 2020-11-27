---
description:  Describes how you can use classes to develop in PowerShell with Desired State Configuration (DSC). 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 1/11/2019
online version: https://docs.microsoft.com/powershell/module/psdesiredstateconfiguration/about/about_classes_and_dsc?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Classes_and_DSC
---
# About Classes and Desired State Configuration

## Short description

Describes how you can use classes to develop in PowerShell with Desired State
Configuration (DSC).

## Long description

Starting in Windows PowerShell 5.0, language was added to define classes and
other user-defined types, by using formal syntax and semantics that are
similar to other object-oriented programming languages. The goal is to enable
developers and IT professionals to embrace PowerShell for a wider
range of use cases, simplify development of PowerShell artifacts such as DSC
resources, and accelerate coverage of management surfaces.

## Supported scenarios

The following scenarios are supported:

- Define DSC resources and their associated types by using the PowerShell
  language.
- Define custom types in PowerShell by using familiar object-oriented
  programming constructs, such as classes, properties, methods, and inheritance.
- Debug types by using the PowerShell language.
- Generate and handle exceptions by using formal mechanisms, and at the right
  level.

## Define DSC resources with classes

Apart from syntax changes, the major differences between a class-defined DSC
resource and a cmdlet DSC resource provider are the following items:

- A Management Object Format (MOF) file is not required.
- A DSCResource subfolder in the module folder is not required.
- A PowerShell module file can contain multiple DSC resource classes.

## Create a class-defined DSC resource provider

The following example is a class-defined DSC resource provider that is saved
as a module, MyDSCResource.psm1. You must always include a key property in a
class-defined DSC resource provider.

```powershell
enum Ensure
{
    Absent
    Present
}

<#
    This resource manages the file in a specific path.
    [DscResource()] indicates the class is a DSC resource
#>

[DscResource()]
class FileResource
{
    <#
        This property is the fully qualified path to the file that is
        expected to be present or absent.

        The [DscProperty(Key)] attribute indicates the property is a
        key and its value uniquely identifies a resource instance.
        Defining this attribute also means the property is required
        and DSC will ensure a value is set before calling the resource.

        A DSC resource must define at least one key property.
    #>
    [DscProperty(Key)]
    [string]$Path

    <#
        This property indicates if the settings should be present or absent
        on the system. For present, the resource ensures the file pointed
        to by $Path exists. For absent, it ensures the file point to by
        $Path does not exist.

        The [DscProperty(Mandatory)] attribute indicates the property is
        required and DSC will guarantee it is set.

        If Mandatory is not specified or if it is defined as
        Mandatory=$false, the value is not guaranteed to be set when DSC
        calls the resource.  This is appropriate for optional properties.
    #>
    [DscProperty(Mandatory)]
    [Ensure] $Ensure

    <#
        This property defines the fully qualified path to a file that will
        be placed on the system if $Ensure = Present and $Path does not
        exist.

        NOTE: This property is required because [DscProperty(Mandatory)] is
        set.
    #>
    [DscProperty(Mandatory)]
    [string] $SourcePath

    <#
        This property reports the file's create timestamp.

        [DscProperty(NotConfigurable)] attribute indicates the property is
        not configurable in DSC configuration.  Properties marked this way
        are populated by the Get() method to report additional details
        about the resource when it is present.

    #>
    [DscProperty(NotConfigurable)]
    [Nullable[datetime]] $CreationTime

    <#
        This method is equivalent of the Set-TargetResource script function.
        It sets the resource to the desired state.
    #>
    [void] Set()
    {
        $fileExists = $this.TestFilePath($this.Path)
        if($this.ensure -eq [Ensure]::Present)
        {
            if(-not $fileExists)
            {
                $this.CopyFile()
            }
        }
        else
        {
            if($fileExists)
            {
                Write-Verbose -Message "Deleting the file $($this.Path)"
                Remove-Item -LiteralPath $this.Path -Force
            }
        }
    }

    <#

        This method is equivalent of the Test-TargetResource script
        function. It should return True or False, showing whether the
        resource is in a desired state.
    #>
    [bool] Test()
    {
        $present = $this.TestFilePath($this.Path)

        if($this.Ensure -eq [Ensure]::Present)
        {
            return $present
        }
        else
{
            return -not $present
        }
    }

    <#
        This method is equivalent of the Get-TargetResource script function.
        The implementation should use the keys to find appropriate
        resources. This method returns an instance of this class with the
        updated key properties.
    #>
    [FileResource] Get()
    {
        $present = $this.TestFilePath($this.Path)

        if ($present)
        {
            $file = Get-ChildItem -LiteralPath $this.Path
            $this.CreationTime = $file.CreationTime
            $this.Ensure = [Ensure]::Present
        }
        else
        {
            $this.CreationTime = $null
            $this.Ensure = [Ensure]::Absent
        }
        return $this
    }

    <#
        Helper method to check if the file exists and it is correct file
    #>
    [bool] TestFilePath([string] $location)
    {
        $present = $true

        $item = Get-ChildItem -LiteralPath $location -ea Ignore
        if ($null -eq $item)
        {
            $present = $false
        }
        elseif( $item.PSProvider.Name -ne "FileSystem")
        {
            throw "Path $($location) is not a file path."
        }
        elseif($item.PSIsContainer)
        {
            throw "Path $($location) is a directory path."
        }
        return $present
    }

    <#
        Helper method to copy file from source to path
    #>
    [void] CopyFile()
    {
        if(-not $this.TestFilePath($this.SourcePath))
        {
            throw "SourcePath $($this.SourcePath) is not found."
        }

        [System.IO.FileInfo]
        $destFileInfo = new-object System.IO.FileInfo($this.Path)

        if (-not $destFileInfo.Directory.Exists)
        {
            $FullName = $destFileInfo.Directory.FullName
            $Message = "Creating directory $FullName"

            Write-Verbose -Message $Message

            #use CreateDirectory instead of New-Item to avoid code
            # to handle the non-terminating error
            [System.IO.Directory]::CreateDirectory($FullName)
        }

        if(Test-Path -LiteralPath $this.Path -PathType Container)
        {
            throw "Path $($this.Path) is a directory path"
        }

        Write-Verbose -Message "Copying $this.SourcePath to $this.Path"

        #DSC engine catches and reports any error that occurs
        Copy-Item -Path $this.SourcePath -Destination $this.Path -Force
    }
}
```

## Create a module manifest

After creating the class-defined DSC resource provider, and saving it as a
module, create a module manifest for the module. To make a class-based
resource available to the DSC engine, you must include a `DscResourcesToExport`
statement in the manifest file that instructs the module to export the
resource. In this example, the following module manifest is saved as
MyDscResource.psd1.

```powershell
@{

# Script module or binary module file associated with this manifest.
RootModule = 'MyDscResource.psm1'

DscResourcesToExport = 'FileResource'

# Version number of this module.
ModuleVersion = '1.0'

# ID used to uniquely identify this module
GUID = '81624038-5e71-40f8-8905-b1a87afe22d7'

# Author of this module
Author = 'Microsoft Corporation'

# Company or vendor of this module
CompanyName = 'Microsoft Corporation'

# Copyright statement for this module
Copyright = '(c) 2014 Microsoft. All rights reserved.'

# Description of the functionality provided by this module
# Description = ''

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.0'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

}
```

## Deploy a DSC resource provider

Deploy the new DSC resource provider by creating a MyDscResource folder in
`$pshome\Modules` or `$env:SystemDrive\ProgramFiles\WindowsPowerShell\Modules`.

You do not need to create a DSCResource subfolder. Copy the module and module
manifest files (MyDscResource.psm1 and MyDscResource.psd1) to the
MyDscResource folder.

From this point, you create and run a configuration script as you would with
any DSC resource.

## Create a DSC configuration script

After saving the class and manifest files in the folder structure as described
earlier, you can create a configuration that uses the new resource. The
following configuration references the MyDSCResource module. Save the
configuration as a script, MyResource.ps1.

For information about how to run a DSC configuration,
see [Windows PowerShell Desired State Configuration Overview](/powershell/scripting/dsc/overview/dscforengineers).

Before you run the configuration, create `C:\test.txt`. The configuration
checks if the file exists at `c:\test\test.txt`. If the file does not exist,
the configuration copies the file from `C:\test.txt`.

```powershell
Configuration Test
{
    Import-DSCResource -module MyDscResource
    FileResource file
    {
        Path = "C:\test\test.txt"
        SourcePath = "C:\test.txt"
        Ensure = "Present"
    }
}
Test
Start-DscConfiguration -Wait -Force Test
```

Run this script as you would any DSC configuration script. To start the
configuration, in an elevated PowerShell console, run the following:

`PS C:\test> .\MyResource.ps1`

## Inheritance in PowerShell classes

### Declare base classes for PowerShell classes

You can declare a PowerShell class as a base type for another PowerShell
class, as shown in the following example, in which **fruit** is a base type
for **apple**.

```powershell
class fruit
{
    [int]sold() {return 100500}
}

class apple : fruit {}
    [apple]::new().sold() # return 100500
```

### Declare implemented interfaces for PowerShell classes

You can declare implemented interfaces after base types, or immediately after
a colon (`:`) if there is no base type specified. Separate all type names by
using commas. This is similar to C# syntax.

```powershell
class MyComparable : system.IComparable
{
    [int] CompareTo([object] $obj)
    {
        return 0;
    }
}

class MyComparableTest : test, system.IComparable
{
    [int] CompareTo([object] $obj)
    {
        return 0;
    }
}
```

### Call base class constructors

To call a base class constructor from a subclass, add the `base` keyword, as
shown in the following example:

```powershell
class A {
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

If a base class has a default constructor (no parameters), you can omit an
explicit constructor call, as shown.

```powershell
class C : B
{
    C([int]$c) {}
}
```

### Call base class methods

You can override existing methods in subclasses. To do the override, declare
methods by using the same name and signature.

```powershell
class baseClass
{
    [int]days() {return 100500}
}
class childClass1 : baseClass
{
    [int]days () {return 200600}
}

    [childClass1]::new().days() # return 200600
```

To call base class methods from overridden implementations, cast to the base
class `([baseclass]$this)` on invocation.

```powershell
class childClass2 : baseClass
{
    [int]days()
    {
        return 3 * ([baseClass]$this).days()
    }
}

    [childClass2]::new().days() # return 301500
```

All PowerShell methods are virtual. You can hide non-virtual .NET methods in a
subclass by using the same syntax as you do for an override: declare methods
with same name and signature.

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

### Current limitations with class inheritance

A limitation with class inheritance is that there is no syntax to declare
interfaces in PowerShell.

## Defining custom types in PowerShell

Windows PowerShell 5.0 introduced several language elements.

### Class keyword

Defines a new class.
The `class` keyword is a true .NET Framework type.
Class members are public.

```powershell
class MyClass
{
}
```

### Enum keyword and enumerations

Support for the `enum` keyword was added and is a breaking change. The `enum`
delimiter is currently a newline. A workaround for those who are already using
`enum` is to insert an ampersand (`&`) before the word. Current limitations:
you cannot define an enumerator in terms of itself, but you can initialize
`enum` in terms of another `enum`, as shown in the following example:

The base type cannot currently be specified. The base type is always [int].

```powershell
enum Color2
{
    Yellow = [Color]::Blue
}
```

An enumerator value must be a parse time constant. The enumerator value cannot
be set to the result of an invoked command.

```powershell
enum MyEnum
{
    Enum1
    Enum2
    Enum3 = 42
    Enum4 = [int]::MaxValue
}
```

`Enum` supports arithmetic operations, as shown in the following example:

```powershell
enum SomeEnum { Max = 42 }
enum OtherEnum { Max = [SomeEnum]::Max + 1 }
```

### Hidden keyword

The `hidden` keyword, introduced in Windows PowerShell 5.0, hides class
members from default `Get-Member` results. Specify the hidden property as
shown in the following line:

```powershell
hidden [type] $classmember = <value>
```

Hidden members are not displayed by using tab completion or IntelliSense,
unless the completion occurs in the class that defines the hidden member.

A new attribute, **System.Management.Automation.HiddenAttribute**, was added,
so that C# code can have the same semantics within PowerShell.

For more information, see
[about_Hidden](../../Microsoft.PowerShell.Core/About/about_hidden.md).

### Import-DscResource

`Import-DscResource` is now a true dynamic keyword. PowerShell parses the
specified module's root module, searching for classes that contain the
DscResource attribute.

### Properties

A new field, `ImplementingAssembly`, was added to `ModuleInfo`. If the script
defines classes, or the loaded assembly for binary modules
`ImplementingAssembly` is set to the dynamic assembly created for a script
module. It is not set when ModuleType = Manifest.

Reflection on the `ImplementingAssembly` field discovers resources in a
module. This means you can discover resources written in either PowerShell or
other managed languages.

Fields with initializers.

`[int] $i = 5`

Static is supported and works like an attribute, similar to the type
constraints, so it can be specified in any order.

`static [int] $count = 0`

A type is optional.

`$s = "hello"`

All members are public. Properties require either a newline or semicolon. If
no object type is specified, the property type is **Object**.

### Constructors and instantiation

PowerShell classes can have constructors that have the same name as their
class. Constructors can be overloaded. Static constructors are supported.
Properties with initialization expressions are initialized before running any
code in a constructor. Static properties are initialized before the body of a
static constructor, and instance properties are initialized before the body of
the non-static constructor. Currently, there is no syntax for calling a
constructor from another constructor such as the C# syntax: `": this()")`. The
workaround is to define a common Init method.

The following are ways of instantiating classes:

- Instantiating by using the default constructor. Note that `New-Object` is
  not supported in this release.

  `$a = [MyClass]::new()`

- Calling a constructor with a parameter.

  `$b = [MyClass]::new(42)`

- Passing an array to a constructor with multiple parameters

  `$c = [MyClass]::new(@(42,43,44), "Hello")`

For this release, the type name is only visible lexically, meaning it is not
visible outside of the module or script that defines the class. Functions can
return instances of a class defined in PowerShell, and instances work well
outside of the module or script.

The `Get-Member` **Static** parameter lists constructors, so you can view
overloads like any other method. The performance of this syntax is also
considerably faster than `New-Object`.

The pseudo-static method named **new** works with .NET types, as shown in the
following example. `[hashtable]::new()`

You can now see constructor overloads with `Get-Member`, or as shown in this
example:

```powershell
[hashtable]::new
OverloadDefinitions
-------------------
hashtable new()
hashtable new(int capacity)
hashtable new(int capacity, float loadFactor)
```

### Methods

A PowerShell class method is implemented as a **ScriptBlock** that has only an
end block. All methods are public. The following shows an example of defining
a method named **DoSomething**.

```powershell
class MyClass
{
    DoSomething($x)
    {
        $this._doSomething($x)       # method syntax
    }
    private _doSomething($a) {}
}
```

### Method invocation

Overloaded methods are supported. Overloaded methods are named the same as an
existing method but differentiated by their specified values.

```powershell
$b = [MyClass]::new()
$b.DoSomething(42)
```

### Invocation

See [Method invocation](#method-invocation).

### Attributes

Three new attributes were added: `DscResource`, `DscResourceKey`, and
`DscResourceMandatory`.

### Return types

Return type is a contract. The return value is converted to the expected type.
If no return type is specified, the return type is void. There is no streaming
of objects and objects cannot be written to the pipeline either intentionally
or by accident.

### Lexical scoping of variables

The following shows an example of how lexical scoping works in this release.

```powershell
$d = 42  # Script scope

function bar
{
    $d = 0  # Function scope
    [MyClass]::DoSomething()
}

class MyClass
{
    static [object] DoSomething()
    {
        return $d  # error, not found dynamically
        return $script:d # no error

        $d = $script:d
        return $d # no error, found lexically
    }
}

$v = bar
$v -eq $d # true
```

## Example: Create custom classes

The following example creates several new, custom classes to implement an HTML
Dynamic Stylesheet Language (DSL). The example adds helper functions to create
specific element types as part of the element class, such as heading styles
and tables, because types cannot be used outside the scope of a module.

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
        $text += $Head
        $text += "`n</head>`n<body>`n"
        $text += $Body -join "`n" # Render all of the body elements
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
    [string] Render() { return "<title>$Title</title>" }
    [string] ToString() { return $this.Render() }
}

class Element
{
    [string] $Tag
    [string] $Text
    [hashtable] $Attributes
    [string] Render() {
        $attributesText= ""
        if ($Attributes)
        {
            foreach ($attr in $Attributes.Keys)
            {
                $attributesText = " $attr=`"$($Attributes[$attr])`""
            }
        }

        return "<${tag}${attributesText}>$text</$tag>`n"
    }
    [string] ToString() { return $this.Render() }
}

#
# Helper functions for creating specific element types on top of the classes.
# These are required because types aren't visible outside of the module.
#
function H1 {[Element] @{Tag = "H1"; Text = $args.foreach{$_} -join " "}}
function H2 {[Element] @{Tag = "H2"; Text = $args.foreach{$_} -join " "}}
function H3 {[Element] @{Tag = "H3"; Text = $args.foreach{$_} -join " "}}
function P  {[Element] @{Tag = "P" ; Text = $args.foreach{$_} -join " "}}
function B  {[Element] @{Tag = "B" ; Text = $args.foreach{$_} -join " "}}
function I  {[Element] @{Tag = "I" ; Text = $args.foreach{$_} -join " "}}
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
    $bodyText +=  $Properties.foreach{TH $_}
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
function TH  {([Element] @{Tag="TH"; Text=$args.foreach{$_} -join " "})}
function TR  {([Element] @{Tag="TR"; Text=$args.foreach{$_} -join " "})}
function TD  {([Element] @{Tag="TD"; Text=$args.foreach{$_} -join " "})}

function Style
{
    return  [Element]  @{
        Tag = "style"
        Text = "$args"
    }
}

# Takes a hash table, casts it to and HTML document
# and then returns the resulting type.
#
function Html ([HTML] $doc) { return $doc }
```

## See also

[about_Enum](../../Microsoft.PowerShell.Core/About/about_Enum.md)

[about_Hidden](../../Microsoft.PowerShell.Core/About/about_hidden.md)

[about_Language_Keywords](../../Microsoft.PowerShell.Core/About/about_Language_Keywords.md)

[about_Methods](../../Microsoft.PowerShell.Core/About/about_Methods.md)

[Build Custom PowerShell Desired State Configuration Resources](/powershell/scripting/dsc/resources/authoringResource)

