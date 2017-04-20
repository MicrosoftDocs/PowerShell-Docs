---
description:  
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

Describes how you can use classes to develop in Windows PowerShell

# LONG DESCRIPTION

Starting in Windows PowerShell 5.0, Windows PowerShell adds language
for defining classes and other user-defined types, by using formal syntax
and semantics that are similar to other object-oriented programming
languages. The goal is to enable developers and IT professionals to
embrace Windows PowerShell for a wider range of use cases, simplify
development of Windows PowerShell artifacts and accelerate coverage
of management surfaces.


## SUPPORTED SCENARIOS

- Define custom types in Windows PowerShell by using familiar object-oriented programming constructs, such as classes, properties, methods, inheritance, etc.
- Debug types by using the Windows PowerShell language.
- Generate and handle exceptions by using formal mechanisms, and at the right level.
- Define DSC resources and their associated types by using the Windows PowerShell language.

## 

## INHERITANCE IN POWERSHELL CLASSES

    Declare base classes for Windows PowerShell classes
      You can declare a Windows PowerShell class as a base type for another Windows
      PowerShell class, as shown in the following example, in which "fruit" is a
      base type for "apple".

        class fruit 
        {
            [int]sold() {return 100500}
        }

        class apple : fruit {}
         [apple]::new().sold() # return 100500 

    Declare implemented interfaces for Windows PowerShell classes
      You can declare implemented interfaces after base types, or immediately
      after a colon (:) if there is no base type specified. Separate all type
      names by using commas. This is similar to C# syntax.

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

    Call base class constructors
      To call a base class constructor from a subclass, add the "base" keyword,
      as shown in the following example.

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
 
      If a base class has a default constructor (that is, no parameters),
      you can omit an explicit constructor call, as shown.
        class C : B
        {
            C([int]$c) {}
        } 
 
    Call base class methods
      You can override existing methods in subclasses. To do this, declare
      methods by using the same name and signature.

        class baseClass 
        {
            [int]days() {return 100500}
        }
        class childClass1 : baseClass 
        {
            [int]days () {return 200600}
        } 

         [childClass1]::new().days() # return 200600 

      To call base class methods from overridden implementations, cast to the
      base class ([baseclass]$this) on invocation.

        class childClass2 : baseClass 
        {
            [int]days() 
            {
                return 3 * ([baseClass]$this).days() 
            }
        } 

         [childClass2]::new().days() # return 301500 

      All Windows PowerShell methods are virtual. You can hide non-virtual .NET
      methods in a subclass by using the same syntax as you do for an override:  
      declare methods with same name and signature.
 
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

    Current limitations with inheritance
      The following are known issues with class inheritance:

      -- At this time, there is no syntax to declare interfaces in Windows PowerShell.
 
 
CONFIGURATION TEST
    After saving the class and manifest files in the folder structure as described
    earlier, you can create a configuration that uses the new resource. For
    information about how to run a DSC configuration, see Get Started with Windows 
    PowerShell Desired State Configuration (http://technet.microsoft.com/library/dn249918.aspx).
    The following configuration will check to see whether the file at c:\test\test.txt
    exists, and, if not, copies the file from c:\test.txt (you should create c:\test.txt
    before you run the configuration).
 
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


    Run this as you would any DSC configuration script. To start the configuration,
    in an elevated Windows PowerShell console, run the following.

      PS C:\test> .\MyResource.ps1

DEFINING CUSTOM TYPES IN WINDOWS POWERSHELL
    Windows PowerShell 5.0 introduces the following language elements.

      Class keyword
           Defines a new class. This is a true .NET Framework type.
           Class members are public.
              class MyClass
              {
              }

      Enum keyword and enumerations
           Support for the enum keyword has been added; this is a breaking change.
           The enum delimiter is currently a newline. A workaround for those who 
           are already using enum is to insert an ampersand (&) before the word.
           Current limitations:  you cannot define an enumerator in terms of itself,
           but you can initialize enum in terms of another enum, as shown in the 
           following example. The base type cannot currently be specified; it is always
           [int].
              enum Color2
              {
                  Yellow = [Color]::Blue
              }
           An enumerator value must be a parse time constant; you cannot set it to
           the result of an invoked command.
              enum MyEnum
              {
                  Enum1
                  Enum2
                  Enum3 = 42
                  Enum4 = [int]::MaxValue
              }
           Enums support arithmetic operations, as shown in the following example.
              enum SomeEnum { Max = 42 }
              enum OtherEnum { Max = [SomeEnum]::Max + 1 } 

      Hidden keyword
           The Hidden keyword, new in Windows PowerShell 5.0, hides class members
           from default Get-Member results. Specify the hidden property as shown
           in the following line:
                 hidden [type] $classmember = <value>

           Hidden members are not displayed by using tab completion or IntelliSense,
           unless the completion occurs in the class that defines the hidden member.

           A new attribute, System.Management.Automation.HiddenAttribute, has been
           added, so that C# code can have the same semantics within Windows PowerShell.

           For more information about Hidden, see about_Hidden.

      Import-DscResource
           Import-DscResource is now a true dynamic keyword. Windows PowerShell 
           parses the specified module’s root module, searching for classes that
           contain the DscResource attribute.

      Properties
           A new field, ImplementingAssembly, has been added to ModuleInfo. It 
           is set to the dynamic assembly created for a script module if the script
           defines classes, or the loaded assembly for binary modules. It is not
           set when ModuleType = Manifest.

           Reflection on the ImplementingAssembly field discovers resources in a
           module. This means you can discover resources written in either 
           Windows PowerShell or other managed languages.

           Fields with initializers:
               [int] $i = 5 
           Static is supported; it works like an attribute, as do the type constraints,
           so it can be specified in any order.
              static [int] $count = 0
           A type is optional.
              $s = "hello" 

           All members are public. Properties require either a newline or semicolon. 
           If no object type is specified, the property type is “object.”

      Constructors and instantiation
           Windows PowerShell classes can have constructors; they have the same 
           name as their class. Constructors can be overloaded. Static constructors
           are supported. Properties with initialization expressions are initialized
           before running any code in a constructor. Static properties are initialized
           before the body of a static constructor, and instance properties are 
           initialized before the body of the non-static constructor. Currently, there
           is no syntax for calling a constructor from another constructor (like the
           C# syntax  ": this()"). The workaround is to define a common Init method.

           The following are ways of instantiating classes.
              Instantiating by using the default constructor. Note that New-Object is not
                supported in this release.
              $a = [MyClass]::new()

              Calling a constructor with a parameter
              $b = [MyClass]::new(42)

              Passing an array to a constructor with multiple parameters
              $c = [MyClass]::new(@(42,43,44), "Hello")

           For this release, the type name is only visible lexically,
           meaning it is not visible outside of the module or script that defines the 
           class. Functions can return instances of a class defined in Windows
           PowerShell, and instances work well outside of the module or script.

           Get-Member -Static lists constructors, so you can view overloads like
           any other method. The performance of this syntax is also considerably 
           faster than New-Object.

           The pseudo-static method named new works with .Net types, as shown in
           the following example.

               [hashtable]::new()

           You can now see constructor overloads with Get-Member, or as shown in 
           this example:

               PS> [hashtable]::new
               OverloadDefinitions
               -------------------
               hashtable new()
               hashtable new(int capacity)
               hashtable new(int capacity, float loadFactor)

      Methods
           A Windows PowerShell class method is implemented as a ScriptBlock that 
           has only an end block. All methods are public. The following shows an
           example of defining a method named DoSomething.
               class MyClass
               {
                   DoSomething($x)
                   {
                       $this._doSomething($x)       # method syntax
                   }
                   private _doSomething($a) {}
               }

           Method invocation:
               $b = [MyClass]::new()
               $b.DoSomething(42) 

           Overloaded methods--that is, those that are named the same as an 
           existing method, but differentiated by their specified values--are also supported.

      Invocation
           See "Method invocation" in this list.

      Attributes
           Three new attributes, DscResource, DscResourceKey, and DscResourceMandatory,
           have been added.

      Return types
           Return type is a contract; the return value is converted to the expected
           type. If no return type is specified, the return type is void. There 
           is no streaming of objects; objects cannot be written to the pipeline
           either intentionally or by accident.

      Lexical scoping of variables
           The following shows an example of how lexical scoping works in this
           release.
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


EXAMPLE
    The following example creates several new, custom classes to implement
    an HTML dynamic stylesheet language (DSL). Then, the example adds helper
    functions to create specific element types as part of the element class,
    such as heading styles and tables, because types cannot be used outside 
    the scope of a module.

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
      # These are required because types aren’t visible outside of the module.
      #
      function H1 { [Element] @{ Tag = "H1" ; Text = $args.foreach{$_} -join " " }}
      function H2 { [Element] @{ Tag = "H2" ; Text = $args.foreach{$_} -join " " }}
      function H3 { [Element] @{ Tag = "H3" ; Text = $args.foreach{$_} -join " " }}
      function P  { [Element] @{ Tag = "P"  ; Text = $args.foreach{$_} -join " " }}
      function B  { [Element] @{ Tag = "B"  ; Text = $args.foreach{$_} -join " " }}
      function I  { [Element] @{ Tag = "I"  ; Text = $args.foreach{$_} -join " " }}
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
      function TH  { ([Element] @{ Tag = "TH"  ; Text = $args.foreach{$_} -join " " }) }
      function TR  { ([Element] @{ Tag = "TR"  ; Text = $args.foreach{$_} -join " " }) }
      function TD  { ([Element] @{ Tag = "TD"  ; Text = $args.foreach{$_} -join " " }) }

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

SEE ALSO
    about_DesiredStateConfiguration
    about_Language_Keywords
    about_Methods
    Writing a custom DSC resource with PowerShell classes (http://technet.microsoft.com/library/dn948461.aspx) 