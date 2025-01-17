---
description: Describes how you can use classes to create your own custom types.
Locale: en-US
ms.date: 01/23/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_classes?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Classes
---
# about_Classes

## Short description

Describes how you can use classes to create your own custom types.

## Long description

Starting with version 5.0, PowerShell has a formal syntax to define classes and
other user-defined types. The addition of classes enables developers and IT
professionals to embrace PowerShell for a wider range of use cases.

A class declaration is a blueprint used to create instances of objects at run
time. When you define a class, the class name is the name of the type. For
example, if you declare a class named **Device** and initialize a variable
`$dev` to a new instance of **Device**, `$dev` is an object or instance of type
**Device**. Each instance of **Device** can have different values in its
properties.

## Supported scenarios

- Define custom types in PowerShell using object-oriented programming semantics
  like classes, properties, methods, inheritance, etc.
- Define DSC resources and their associated types using the PowerShell
  language.
- Define custom attributes to decorate variables, parameters, and custom type
  definitions.
- Define custom exceptions that can be caught by their type name.

## Syntax

### Definition syntax

Class definitions use the following syntax:

```Syntax
class <class-name> [: [<base-class>][,<interface-list>]] {
    [[<attribute>] [hidden] [static] <property-definition> ...]
    [<class-name>([<constructor-argument-list>])
      {<constructor-statement-list>} ...]
    [[<attribute>] [hidden] [static] <method-definition> ...]
}
```

### Instantiation syntax

To instantiate an instance of a class, use one of the following syntaxes:

```Syntax
[$<variable-name> =] New-Object -TypeName <class-name> [
  [-ArgumentList] <constructor-argument-list>]
```

```Syntax
[$<variable-name> =] [<class-name>]::new([<constructor-argument-list>])
```

```Syntax
[$<variable-name> =] [<class-name>]@{[<class-property-hashtable>]}
```

> [!NOTE]
> When using the `[<class-name>]::new()` syntax, brackets around the class name
> are mandatory. The brackets signal a type definition for PowerShell.
>
> The hashtable syntax only works for classes that have a default constructor
> that doesn't expect any parameters. It creates an instance of the class with
> the default constructor and then assigns the key-value pairs to the instance
> properties. If any key in the hashtable isn't a valid property name,
> PowerShell raises an error.

## Examples

### Example 1 - Minimal definition

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

### Example 2 - Class with instance members

This example defines a **Book** class with several properties, constructors,
and methods. Every defined member is an _instance_ member, not a static member.
The properties and methods can only be accessed through a created instance of
the class.

```powershell
class Book {
    # Class properties
    [string]   $Title
    [string]   $Author
    [string]   $Synopsis
    [string]   $Publisher
    [datetime] $PublishDate
    [int]      $PageCount
    [string[]] $Tags
    # Default constructor
    Book() { $this.Init(@{}) }
    # Convenience constructor from hashtable
    Book([hashtable]$Properties) { $this.Init($Properties) }
    # Common constructor for title and author
    Book([string]$Title, [string]$Author) {
        $this.Init(@{Title = $Title; Author = $Author })
    }
    # Shared initializer method
    [void] Init([hashtable]$Properties) {
        foreach ($Property in $Properties.Keys) {
            $this.$Property = $Properties.$Property
        }
    }
    # Method to calculate reading time as 2 minutes per page
    [timespan] GetReadingTime() {
        if ($this.PageCount -le 0) {
            throw 'Unable to determine reading time from page count.'
        }
        $Minutes = $this.PageCount * 2
        return [timespan]::new(0, $Minutes, 0)
    }
    # Method to calculate how long ago a book was published
    [timespan] GetPublishedAge() {
        if (
            $null -eq $this.PublishDate -or
            $this.PublishDate -eq [datetime]::MinValue
        ) { throw 'PublishDate not defined' }

        return (Get-Date) - $this.PublishDate
    }
    # Method to return a string representation of the book
    [string] ToString() {
        return "$($this.Title) by $($this.Author) ($($this.PublishDate.Year))"
    }
}
```

The following snippet creates an instance of the class and shows how it
behaves. After creating an instance of the **Book** class, the example
uses the `GetReadingTime()` and `GetPublishedAge()` methods to write
a message about the book.

```powershell
$Book = [Book]::new(@{
    Title       = 'The Hobbit'
    Author      = 'J.R.R. Tolkien'
    Publisher   = 'George Allen & Unwin'
    PublishDate = '1937-09-21'
    PageCount   = 310
    Tags        = @('Fantasy', 'Adventure')
})

$Book
$Time = $Book.GetReadingTime()
$Time = @($Time.Hours, 'hours and', $Time.Minutes, 'minutes') -join ' '
$Age  = [Math]::Floor($Book.GetPublishedAge().TotalDays / 365.25)

"It takes $Time to read $Book,`nwhich was published $Age years ago."
```

```Output
Title       : The Hobbit
Author      : J.R.R. Tolkien
Synopsis    :
Publisher   : George Allen & Unwin
PublishDate : 9/21/1937 12:00:00 AM
PageCount   : 310
Tags        : {Fantasy, Adventure}

It takes 10 hours and 20 minutes to read The Hobbit by J.R.R. Tolkien (1937),
which was published 86 years ago.
```

### Example 3 - Class with static members

The **BookList** class in this example builds on the **Book** class in example
2. While the **BookList** class can't be marked static itself, the
implementation only defines the **Books** static property and a set of static
methods for managing that property.

```powershell
class BookList {
    # Static property to hold the list of books
    static [System.Collections.Generic.List[Book]] $Books
    # Static method to initialize the list of books. Called in the other
    # static methods to avoid needing to explicit initialize the value.
    static [void] Initialize()             { [BookList]::Initialize($false) }
    static [bool] Initialize([bool]$force) {
        if ([BookList]::Books.Count -gt 0 -and -not $force) {
            return $false
        }

        [BookList]::Books = [System.Collections.Generic.List[Book]]::new()

        return $true
    }
    # Ensure a book is valid for the list.
    static [void] Validate([book]$Book) {
        $Prefix = @(
            'Book validation failed: Book must be defined with the Title,'
            'Author, and PublishDate properties, but'
        ) -join ' '
        if ($null -eq $Book) { throw "$Prefix was null" }
        if ([string]::IsNullOrEmpty($Book.Title)) {
            throw "$Prefix Title wasn't defined"
        }
        if ([string]::IsNullOrEmpty($Book.Author)) {
            throw "$Prefix Author wasn't defined"
        }
        if ([datetime]::MinValue -eq $Book.PublishDate) {
            throw "$Prefix PublishDate wasn't defined"
        }
    }
    # Static methods to manage the list of books.
    # Add a book if it's not already in the list.
    static [void] Add([Book]$Book) {
        [BookList]::Initialize()
        [BookList]::Validate($Book)
        if ([BookList]::Books.Contains($Book)) {
            throw "Book '$Book' already in list"
        }

        $FindPredicate = {
            param([Book]$b)

            $b.Title -eq $Book.Title -and
            $b.Author -eq $Book.Author -and
            $b.PublishDate -eq $Book.PublishDate
        }.GetNewClosure()
        if ([BookList]::Books.Find($FindPredicate)) {
            throw "Book '$Book' already in list"
        }

        [BookList]::Books.Add($Book)
    }
    # Clear the list of books.
    static [void] Clear() {
      [BookList]::Initialize()
      [BookList]::Books.Clear()
    }
    # Find a specific book using a filtering scriptblock.
    static [Book] Find([scriptblock]$Predicate) {
        [BookList]::Initialize()
        return [BookList]::Books.Find($Predicate)
    }
    # Find every book matching the filtering scriptblock.
    static [Book[]] FindAll([scriptblock]$Predicate) {
        [BookList]::Initialize()
        return [BookList]::Books.FindAll($Predicate)
    }
    # Remove a specific book.
    static [void] Remove([Book]$Book) {
        [BookList]::Initialize()
        [BookList]::Books.Remove($Book)
    }
    # Remove a book by property value.
    static [void] RemoveBy([string]$Property, [string]$Value) {
        [BookList]::Initialize()
        $Index = [BookList]::Books.FindIndex({
            param($b)
            $b.$Property -eq $Value
        }.GetNewClosure())
        if ($Index -ge 0) {
            [BookList]::Books.RemoveAt($Index)
        }
    }
}
```

Now that **BookList** is defined, the book from the previous example can be
added to the list.

```powershell
$null -eq [BookList]::Books

[BookList]::Add($Book)

[BookList]::Books
```

```Output
True

Title       : The Hobbit
Author      : J.R.R. Tolkien
Synopsis    :
Publisher   : George Allen & Unwin
PublishDate : 9/21/1937 12:00:00 AM
PageCount   : 310
Tags        : {Fantasy, Adventure}
```

The following snippet calls the static methods for the class.

```powershell
[BookList]::Add([Book]::new(@{
    Title       = 'The Fellowship of the Ring'
    Author      = 'J.R.R. Tolkien'
    Publisher   = 'George Allen & Unwin'
    PublishDate = '1954-07-29'
    PageCount   = 423
    Tags        = @('Fantasy', 'Adventure')
}))

[BookList]::Find({
    param ($b)

    $b.PublishDate -gt '1950-01-01'
}).Title

[BookList]::FindAll({
    param($b)

    $b.Author -match 'Tolkien'
}).Title

[BookList]::Remove($Book)
[BookList]::Books.Title

[BookList]::RemoveBy('Author', 'J.R.R. Tolkien')
"Titles: $([BookList]::Books.Title)"

[BookList]::Add($Book)
[BookList]::Add($Book)
```

```Output
The Fellowship of the Ring

The Hobbit
The Fellowship of the Ring

The Fellowship of the Ring

Titles:

Exception:
Line |
  84 |              throw "Book '$Book' already in list"
     |              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     | Book 'The Hobbit by J.R.R. Tolkien (1937)' already in list
```

### Example 4 - Class definition with and without Runspace affinity

The `ShowRunspaceId()` method of `[UnsafeClass]` reports different thread Ids
but the same runspace ID. Eventually, the session state is corrupted causing
an error, such as `Global scope cannot be removed`.

```powershell
# Class definition with Runspace affinity (default behavior)
class UnsafeClass {
    static [object] ShowRunspaceId($val) {
        return [PSCustomObject]@{
            ThreadId   = [Threading.Thread]::CurrentThread.ManagedThreadId
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

The `ShowRunspaceId()` method of `[SafeClass]` reports different thread and
Runspace ids.

```powershell
# Class definition with NoRunspaceAffinity attribute
[NoRunspaceAffinity()]
class SafeClass {
    static [object] ShowRunspaceId($val) {
        return [PSCustomObject]@{
            ThreadId   = [Threading.Thread]::CurrentThread.ManagedThreadId
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

## Class properties

Properties are variables declared in the class scope. A property can be of any
built-in type or an instance of another class. Classes can have zero or more
properties. Classes don't have a maximum property count.

For more information, see [about_Classes_Properties][01].

## Class methods

Methods define the actions that a class can perform. Methods can take
parameters that specify input data. Methods always define an output type. If a
method doesn't return any output, it must have the **Void** output type. If a
method doesn't explicitly define an output type, the method's output type is
**Void**.

For more information, see [about_Classes_Methods][02].

## Class constructors

Constructors enable you to set default values and validate object logic at the
moment of creating the instance of the class. Constructors have the same name
as the class. Constructors might have parameters, to initialize the data
members of the new object.

For more information, see [about_Classes_Constructors][03].

## Hidden keyword

The `hidden` keyword hides a class member. The member is still accessible to
the user and is available in all scopes in which the object is available.
Hidden members are hidden from the `Get-Member` cmdlet and can't be displayed
using tab completion or IntelliSense outside the class definition.

The `hidden` keyword only applies to class members, not a class itself.

Hidden class members are:

- Not included in the default output for the class.
- Not included in the list of class members returned by the `Get-Member`
  cmdlet. To show hidden members with `Get-Member`, use the **Force**
  parameter.
- Not displayed in tab completion or IntelliSense unless the completion occurs
  in the class that defines the hidden member.
- Public members of the class. They can be accessed, inherited, and modified.
  Hiding a member doesn't make it private. It only hides the member as
  described in the previous points.

> [!NOTE]
> When you hide any overload for a method, that method is removed from
> IntelliSense, completion results, and the default output for `Get-Member`.
> When you hide any constructor, the `new()` option is removed from
> IntelliSense and completion results.

For more information about the keyword, see [about_Hidden][04]. For more
information about hidden properties, see [about_Classes_Properties][05]. For
more information about hidden methods, see [about_Classes_Methods][06]. For
more information about hidden constructors, see
[about_Classes_Constructors][07].

## Static keyword

The `static` keyword defines a property or a method that exists in the class
and needs no instance.

A static property is always available, independent of class instantiation. A
static property is shared across all instances of the class. A static method is
available always. All static properties live for the entire session span.

The `static` keyword only applies to class members, not a class itself.

For more information about static properties, see
[about_Classes_Properties][08]. For more information about static methods, see
[about_Classes_Methods][09]. For more information about static constructors,
see [about_Classes_Constructors][10].

## Inheritance in PowerShell classes

You can extend a class by creating a new class that derives from an existing
class. The derived class inherits the properties and methods of the base class.
You can add or override the base class members as required.

PowerShell doesn't support multiple inheritance. Classes can't inherit directly
from more than one class.

Classes can also inherit from interfaces, which define a contract. A class that
inherits from an interface must implement that contract. When it does, the
class can be used like any other class implementing that interface.

For more information about deriving classes that inherit from a base class or
implement interfaces, see
[about_Classes_Inheritance][11].

## NoRunspaceAffinity attribute

A runspace is the operating environment for the commands invoked by PowerShell.
This environment includes the commands and data that are currently present, and
any language restrictions that currently apply.

By default, a PowerShell class is affiliated with the **Runspace** where it's
created. Using a PowerShell class in `ForEach-Object -Parallel` isn't safe.
Method invocations on the class are marshalled back to the **Runspace** where
it was created, which can corrupt the state of the **Runspace** or cause a
deadlock.

Adding the `NoRunspaceAffinity` attribute to the class definition ensures that
the PowerShell class isn't affiliated with a particular runspace. Method
invocations, both instance and static, use the **Runspace** of the running
thread and the thread's current session state.

The attribute was added in PowerShell 7.4.

For an illustration of the difference in behavior for classes with and without
the `NoRunspaceAffinity` attribute, see
[Example 4](#example-4---class-definition-with-and-without-runspace-affinity).

## Exporting classes with type accelerators

By default, PowerShell modules don't automatically export classes and
enumerations defined in PowerShell. The custom types aren't available outside
of the module without calling a `using module` statement.

However, if a module adds type accelerators, those type accelerators are
immediately available in the session after users import the module.

> [!NOTE]
> Adding type accelerators to the session uses an internal (not public) API.
> Using this API may cause conflicts. The pattern described below throws an
> error if a type accelerator with the same name already exists when you import
> the module. It also removes the type accelerators when you remove the module
> from the session.
>
> This pattern ensures that the types are available in a session. It doesn't
> affect IntelliSense or completion when authoring a script file in VS Code.
> To get IntelliSense and completion suggestions for custom types in VS Code,
> you need to add a `using module` statement to the top of the script.

The following pattern shows how you can register PowerShell classes and
enumerations as type accelerators in a module. Add the snippet to the root
script module after any type definitions. Make sure the `$ExportableTypes`
variable contains each of the types you want to make available to users when
they import the module. The other code doesn't require any editing.

```powershell
# Define the types to export with type accelerators.
$ExportableTypes =@(
    [DefinedTypeName]
)
# Get the internal TypeAccelerators class to use its static methods.
$TypeAcceleratorsClass = [psobject].Assembly.GetType(
    'System.Management.Automation.TypeAccelerators'
)
# Ensure none of the types would clobber an existing type accelerator.
# If a type accelerator with the same name exists, throw an exception.
$ExistingTypeAccelerators = $TypeAcceleratorsClass::Get
foreach ($Type in $ExportableTypes) {
    if ($Type.FullName -in $ExistingTypeAccelerators.Keys) {
        $Message = @(
            "Unable to register type accelerator '$($Type.FullName)'"
            'Accelerator already exists.'
        ) -join ' - '

        throw [System.Management.Automation.ErrorRecord]::new(
            [System.InvalidOperationException]::new($Message),
            'TypeAcceleratorAlreadyExists',
            [System.Management.Automation.ErrorCategory]::InvalidOperation,
            $Type.FullName
        )
    }
}
# Add type accelerators for every exportable type.
foreach ($Type in $ExportableTypes) {
    $TypeAcceleratorsClass::Add($Type.FullName, $Type)
}
# Remove type accelerators when the module is removed.
$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    foreach($Type in $ExportableTypes) {
        $TypeAcceleratorsClass::Remove($Type.FullName)
    }
}.GetNewClosure()
```

When users import the module, any types added to the type accelerators for the
session are immediately available for IntelliSense and completion. When the
module is removed, so are the type accelerators.

## Manually importing classes from a PowerShell module

`Import-Module` and the `#requires` statement only import the module functions,
aliases, and variables, as defined by the module. Classes aren't imported.

If a module defines classes and enumerations but doesn't add type accelerators
for those types, use a `using module` statement to import them.

The `using module` statement imports classes and enumerations from the root
module (`ModuleToProcess`) of a script module or binary module. It doesn't
consistently import classes defined in nested modules or classes defined in
scripts that are dot-sourced into the root module. Define classes that you want
to be available to users outside of the module directly in the root module.

For more information about the `using` statement, see [about_Using][12].

## Loading newly changed code during development

During development of a script module, it's common to make changes to the code
then load the new version of the module using `Import-Module` with the
**Force** parameter. Reloading the module only works for changes to functions
in the root module. `Import-Module` doesn't reload any nested modules. Also,
there's no way to load any updated classes.

To ensure that you're running the latest version, you must start a new session.
Classes and enumerations defined in PowerShell and imported with a `using`
statement can't be unloaded.

Another common development practice is to separate your code into different
files. If you have function in one file that use classes defined in another
module, you should use the `using module` statement to ensure that the
functions have the class definitions that are needed.

## The PSReference type isn't supported with class members

The `[ref]` type accelerator is shorthand for the **PSReference** class. Using
`[ref]` to type-cast a class member fails silently. APIs that use `[ref]`
parameters can't be used with class members. The **PSReference** class was
designed to support COM objects. COM objects have cases where you need to pass
a value in by reference.

For more information, see [PSReference Class][13].

## Limitations

The following lists include limitations for defining PowerShell classes and
workaround for those limitations, if any.

### General limitations

- Class members can't use **PSReference** as their type.

  Workaround: None.
- PowerShell classes can't be unloaded or reloaded in a session.

  Workaround: Start a new session.
- PowerShell classes defined in a module aren't automatically imported.

  Workaround: Add the defined types to the list of type accelerators in the
  root module. This makes the types available on module import.
- The `hidden` and `static` keywords only apply to class members, not a class
  definition.

  Workaround: None.
- By default, PowerShell classes aren't safe to use in parallel execution
  across runspaces. When you Invoke methods on a class, PowerShell marshalls
  the invocations back to the **Runspace** where the class was created, which
  can corrupt the state of the **Runspace** or cause a deadlock.

  Workaround: Add the `NoRunspaceAffinity` attribute to the class declaration.

### Constructor limitations

- Constructor chaining isn't implemented.

  Workaround: Define hidden `Init()` methods and call them from within the
  constructors.
- Constructor parameters can't use any attributes, including validation
  attributes.

  Workaround: Reassign the parameters in the constructor body with the
  validation attribute.
- Constructor parameters can't define default values. The parameters are
  always mandatory.

  Workaround: None.
- If any overload of a constructor is hidden, every overload for the
  constructor is treated as hidden too.

  Workaround: None.

### Method limitations

- Method parameters can't use any attributes, including validation
  attributes.

  Workaround: Reassign the parameters in the method body with the validation
  attribute or define the method in the static constructor with the
  `Update-TypeData` cmdlet.
- Method parameters can't define default values. The parameters are always
  mandatory.

  Workaround: Define the method in the static constructor with the
  `Update-TypeData` cmdlet.
- Methods are always public, even when they're hidden. They can be overridden
  when the class is inherited.

  Workaround: None.
- If any overload of a method is hidden, every overload for that method is
  treated as hidden too.

  Workaround: None.

### Property limitations

- Static properties are always mutable. PowerShell classes can't define
  immutable static properties.

  Workaround: None.
- Properties can't use the **ValidateScript** attribute, because class
  property attribute arguments must be constants.

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

### Inheritance limitations

- PowerShell doesn't support defining interfaces in script code.

  Workaround: Define interfaces in C# and reference the assembly that defines
  the interfaces.
- PowerShell classes can only inherit from one base class.

  Workaround: Class inheritance is transitive. A derived class can inherit
  from another derived class to get the properties and methods of a base
  class.
- When inheriting from a generic class or interface, the type parameter for
  the generic must already be defined. A class can't define itself as the
  type parameter for a class or interface.

  Workaround: To derive from a generic base class or interface, define the
  custom type in a different `.psm1` file and use the `using module`
  statement to load the type. There's no workaround for a custom type to use
  itself as the type parameter when inheriting from a generic.

## See also

- [about_Classes_Constructors][03]
- [about_Classes_Inheritance][11]
- [about_Classes_Methods][02]
- [about_Classes_Properties][01]
- [about_Enum][14]
- [about_Hidden][04]
- [about_Language_Keywords][15]
- [about_Methods][16]
- [about_Using][12]

<!-- link references -->
[01]: about_Classes_Properties.md
[02]: about_Classes_Methods.md
[03]: about_Classes_Constructors.md
[04]: about_Hidden.md
[05]: about_Classes_Properties.md#hidden-properties
[06]: about_Classes_Methods.md#hidden-methods
[07]: about_Classes_Constructors.md#hidden-constructors
[08]: about_Classes_Properties.md#static-properties
[09]: about_Classes_Methods.md#static-methods
[10]: about_Classes_Constructors.md#static-constructors
[11]: about_Classes_Inheritance.md
[12]: about_Using.md
[13]: /dotnet/api/system.management.automation.psreference
[14]: about_Enum.md
[15]: about_language_keywords.md
[16]: about_methods.md
