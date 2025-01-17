---
description: Describes how to define constructors for PowerShell classes.
Locale: en-US
ms.date: 11/13/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_classes_constructors?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Classes_Constructors
---

# about_Classes_Constructors

## Short description

Describes how to define constructors for PowerShell classes.

## Long description

Constructors enable you to set default values and validate object logic at the
moment of creating the instance of the class. Constructors have the same name
as the class. Constructors might have parameters, to initialize the data
members of the new object.

PowerShell class constructors are defined as special methods on the class. They
behave the same as PowerShell class methods with the following exceptions:

- Constructors don't have an output type. They can't use the `return` keyword.
- Constructors always have the same name as the class.
- Constructors can't be called directly. They only run when an instance is
  created.
- Constructors never appear in the output for the `Get-Member` cmdlet.

For more information about PowerShell class methods, see
[about_Classes_Methods][01].

The class can have zero or more constructors defined. If no constructor is
defined, the class is given a default parameterless constructor. This
constructor initializes all members to their default values. Object types and
strings are given null values. When you define constructor, no default
parameterless constructor is created. Create a parameterless constructor if one
is needed.

You can also define a parameterless [static constructor][02].

## Syntax

Class constructors use the following syntaxes:

### Default constructor syntax

```Syntax
<class-name> () [: base([<params>])] {
    <body>
}
```

### Static constructor syntax

```Syntax
static <class-name> () [: base([<params>])] {
    <body>
}
```

### Parameterized constructor syntax (one-line)

```Syntax
<class-name> ([[<parameter-type>]$<parameter-name>[, [<parameter-type>]$<parameter-name>...]]) [: base([<params>])] {
    <body>
}
```

### Parameterized constructor syntax (multiline)

```Syntax
<class-name> (
    [<parameter-type>]$<parameter-name>[,
    [<parameter-type>]$<parameter-name>...]
) [: base([<params>])] {
    <body>
}
```

## Examples

### Example 1 - Defining a class with the default constructor

The **ExampleBook1** class doesn't define a constructor. Instead, it uses the
automatic default constructor.

```powershell
class ExampleBook1 {
    [string]   $Name
    [string]   $Author
    [int]      $Pages
    [datetime] $PublishedOn
}

[ExampleBook1]::new()
```

```Output
Name Author Pages PublishedOn
---- ------ ----- -----------
                0 1/1/0001 12:00:00 AM
```

> [!NOTE]
> The default value for the **Name** and **Author** properties is `$null`
> because they're typed as strings, which is a reference type. The other
> properties have the default value for their defined type, because they're
> value type properties. For more information on the default values for
> properties, see ["Default property values" in about_Classes_Properties][03].

### Example 2 - Overriding the default constructor

**ExampleBook2** explicitly defines the default constructor, setting the values
for **PublishedOn** to the current date and **Pages** to `1`.

```powershell
class ExampleBook2 {
    [string]   $Name
    [string]   $Author
    [int]      $Pages
    [datetime] $PublishedOn

    ExampleBook2() {
        $this.PublishedOn = (Get-Date).Date
        $this.Pages       = 1
    }
}

[ExampleBook2]::new()
```

```Output
Name Author Pages PublishedOn
---- ------ ----- -----------
                1 11/1/2023 12:00:00 AM
```

### Example 3 - Defining constructor overloads

The **ExampleBook3** class defines three constructor overloads, enabling users
to create an instance of the class from a hashtable, by passing every property
value, and by passing the name of the book and author. The class doesn't define
the default constructor.

```powershell
class ExampleBook3 {
    [string]   $Name
    [string]   $Author
    [int]      $Pages
    [datetime] $PublishedOn

    ExampleBook3([hashtable]$Info) {
        switch ($Info.Keys) {
            'Name'        { $this.Name        = $Info.Name }
            'Author'      { $this.Author      = $Info.Author }
            'Pages'       { $this.Pages       = $Info.Pages }
            'PublishedOn' { $this.PublishedOn = $Info.PublishedOn }
        }
    }

    ExampleBook3(
        [string]   $Name,
        [string]   $Author,
        [int]      $Pages,
        [datetime] $PublishedOn
    ) {
        $this.Name        = $Name
        $this.Author      = $Author
        $this.Pages       = $Pages
        $this.PublishedOn = $PublishedOn
    }

    ExampleBook3([string]$Name, [string]$Author) {
        $this.Name   = $Name
        $this.Author = $Author
    }
}

[ExampleBook3]::new(@{
    Name        = 'The Hobbit'
    Author      = 'J.R.R. Tolkien'
    Pages       = 310
    PublishedOn = '1937-09-21'
})
[ExampleBook3]::new('The Hobbit', 'J.R.R. Tolkien', 310, '1937-09-21')
[ExampleBook3]::new('The Hobbit', 'J.R.R. Tolkien')
[ExampleBook3]::new()
```

```Output
Name       Author         Pages PublishedOn
----       ------         ----- -----------
The Hobbit J.R.R. Tolkien   310 9/21/1937 12:00:00 AM
The Hobbit J.R.R. Tolkien   310 9/21/1937 12:00:00 AM
The Hobbit J.R.R. Tolkien     0 1/1/0001 12:00:00 AM

MethodException:
Line |
  42 |  [ExampleBook3]::new()
     |  ~~~~~~~~~~~~~~~~~~~~~
     | Cannot find an overload for "new" and the argument count: "0".
```

Calling the default constructor returns a method exception. The automatic
default constructor is only defined for a class when the class doesn't define
any constructors. Because **ExampleBook3** defines multiple overloads, the
default constructor isn't automatically added to the class.

### Example 4 - Chaining constructors with a shared method

This example shows how you can write reusable shared code for constructors.
PowerShell classes can't use constructor chaining, so this example class
defines an `Init()` method instead. The method has several overloads. The
overloads with fewer parameters call the more explicit overloads with default
values for the unspecified parameters.

```powershell
class ExampleBook4 {
    [string]   $Name
    [string]   $Author
    [datetime] $PublishedOn
    [int]      $Pages

    ExampleBook4() {
        $this.Init()
    }
    ExampleBook4([string]$Name) {
        $this.Init($Name)
    }
    ExampleBook4([string]$Name, [string]$Author) {
        $this.Init($Name, $Author)
    }
    ExampleBook4([string]$Name, [string]$Author, [datetime]$PublishedOn) {
        $this.Init($Name, $Author, $PublishedOn)
    }
    ExampleBook4(
      [string]$Name,
      [string]$Author,
      [datetime]$PublishedOn,
      [int]$Pages
    ) {
        $this.Init($Name, $Author, $PublishedOn, $Pages)
    }

    hidden Init() {
        $this.Init('Unknown')
    }
    hidden Init([string]$Name) {
        $this.Init($Name, 'Unknown')
    }
    hidden Init([string]$Name, [string]$Author) {
        $this.Init($Name, $Author, (Get-Date).Date)
    }
    hidden Init([string]$Name, [string]$Author, [datetime]$PublishedOn) {
        $this.Init($Name, $Author, $PublishedOn, 1)
    }
    hidden Init(
        [string]$Name,
        [string]$Author,
        [datetime]$PublishedOn,
        [int]$Pages
      ) {
        $this.Name        = $Name
        $this.Author      = $Author
        $this.PublishedOn = $PublishedOn
        $this.Pages       = $Pages
    }
}

[ExampleBook4]::new()
[ExampleBook4]::new('The Hobbit')
[ExampleBook4]::new('The Hobbit', 'J.R.R. Tolkien')
[ExampleBook4]::new('The Hobbit', 'J.R.R. Tolkien', (Get-Date '1937-9-21'))
[ExampleBook4]::new(
    'The Hobbit',
    'J.R.R. Tolkien',
    (Get-Date '1937-9-21'),
    310
)
```

```Output
Name       Author         PublishedOn           Pages
----       ------         -----------           -----
Unknown    Unknown        11/1/2023 12:00:00 AM     1
The Hobbit Unknown        11/1/2023 12:00:00 AM     1
The Hobbit J.R.R. Tolkien 11/1/2023 12:00:00 AM     1
The Hobbit J.R.R. Tolkien 9/21/1937 12:00:00 AM     1
The Hobbit J.R.R. Tolkien 9/21/1937 12:00:00 AM   310
```

### Example 5 - Derived class constructors

The following examples use classes that define the static, default, and
parameterized constructors for a base class and a derived class that inherits
from the base class.

```powershell
class BaseExample {
    static [void] DefaultMessage([type]$Type) {
        Write-Verbose "[$($Type.Name)] default constructor"
    }

    static [void] StaticMessage([type]$Type) {
        Write-Verbose "[$($Type.Name)] static constructor"
    }

    static [void] ParamMessage([type]$Type, [object]$Value) {
        Write-Verbose "[$($Type.Name)] param constructor ($Value)"
    }

    static BaseExample() { [BaseExample]::StaticMessage([BaseExample])  }
    BaseExample()        { [BaseExample]::DefaultMessage([BaseExample]) }
    BaseExample($Value)  { [BaseExample]::ParamMessage([BaseExample], $Value) }
}

class DerivedExample : BaseExample {
    static DerivedExample() { [BaseExample]::StaticMessage([DerivedExample])  }
           DerivedExample() { [BaseExample]::DefaultMessage([DerivedExample]) }

    DerivedExample([int]$Number) : base($Number) {
        [BaseExample]::ParamMessage([DerivedExample], $Number)
    }
    DerivedExample([string]$String) {
        [BaseExample]::ParamMessage([DerivedExample], $String)
    }
}
```

The following block shows the verbose messaging for calling the base class
constructors. The static constructor message is only emitted the first time an
instance of the class is created.

```powershell
PS> $VerbosePreference = 'Continue'
PS> $b = [BaseExample]::new()

VERBOSE: [BaseExample] static constructor
VERBOSE: [BaseExample] default constructor

PS> $b = [BaseExample]::new()

VERBOSE: [BaseExample] default constructor

PS> $b = [BaseExample]::new(1)

VERBOSE: [BaseExample] param constructor (1)
```

The next block shows the verbose messaging for calling the derived class
constructors in a new session. The first time a derived class constructor is
called, the static constructors for the base class and derived class are
called. Those constructors aren't called again in the session. The constructors
for the base class always run before the constructors for the derived class.

```powershell
PS> $VerbosePreference = 'Continue'
PS> $c = [DerivedExample]::new()

VERBOSE: [BaseExample] static constructor
VERBOSE: [DerivedExample] static constructor
VERBOSE: [BaseExample] default constructor
VERBOSE: [DerivedExample] default constructor

PS> $c = [DerivedExample]::new()

VERBOSE: [BaseExample] default constructor
VERBOSE: [DerivedExample] default constructor

PS> $c = [DerivedExample]::new(1)

VERBOSE: [BaseExample] param constructor (1)
VERBOSE: [DerivedExample] param constructor (1)

PS> $c = [DerivedExample]::new('foo')

VERBOSE: [BaseExample] default constructor
VERBOSE: [DerivedExample] param constructor (foo)
```

## Constructor run ordering

When a class instantiates, the code for one or more constructors executes.

For classes that don't inherit from another class, the ordering is:

1. The static constructor for the class.
1. The applicable constructor overload for the class.

For derived classes that inherit from another class, the ordering is:

1. The static constructor for the base class.
1. The static constructor for the derived class.
1. If the derived class constructor explicitly calls a base constructor
   overload, it runs that constructor for the base class. If it doesn't
   explicitly call a base constructor, it runs the default constructor for the
   base class.
1. The applicable constructor overload for the derived class.

In all cases, static constructors only run once in a session.

For an example of constructor behavior and ordering, see [Example 5][06].

## Hidden constructors

You can hide constructors of a class by declaring them with the `hidden`
keyword. Hidden class constructors are:

- Not included in the default output for the class.
- Not included in the list of class members returned by the `Get-Member`
  cmdlet. To show hidden properties with `Get-Member`, use the **Force**
  parameter.
- Not displayed in tab completion or IntelliSense unless the completion occurs
  in the class that defines the hidden property.
- Public members of the class. They can be accessed and modified. Hiding a
  property doesn't make it private. It only hides the property as described in
  the previous points.

> [!NOTE]
> When you hide any constructor, the `new()` option is removed from
> IntelliSense and completion results.

For more information about the `hidden` keyword, see [about_Hidden][04].

## Static constructors

You can define a constructor as belonging to the class itself instead of
instances of the class by declaring the constructor with the `static` keyword.
Static class constructors:

- Only invoke the first time an instance of the class is created in the
  session.
- Can't have any parameters.
- Can't access instance properties or methods with the `$this` variable.

## Constructors for derived classes

When a class inherits from another class, constructors can invoke a constructor
from the base class with the `base` keyword. If the derived class doesn't
explicitly invoke a constructor from the base class, it invokes the default
constructor for the base class instead.

To invoke a nondefault base constructor, add `: base(<parameters>)` after the
constructor parameters and before the body block.

```Syntax
class <derived-class> : <base-class> {
    <derived-class>(<derived-parameters>) : <base-class>(<base-parameters>) {
        # initialization code
    }
}
```

When defining a constructor that calls a base class constructor, the parameters
can be any of the following items:

- The variable of any parameter on the derived class constructor.
- Any static value.
- Any expression that evaluates to a value of the parameter type.

For an example of constructors on a derived class, see [Example 5][06].

## Chaining constructors

Unlike C#, PowerShell class constructors can't use chaining with the
`: this(<parameters>)` syntax. To reduce code duplication, use a hidden
`Init()` method with multiple overloads to the same effect. [Example 4][05]
shows a class using this pattern.

## Adding instance properties and methods with Update-TypeData

Beyond declaring properties and methods directly in the class definition, you
can define properties for instances of a class in the static constructor using
the `Update-TypeData` cmdlet.

Use this snippet as a starting point for the pattern. Replace the placeholder
text in angle brackets as needed.

```powershell
class <class-name> {
    static [hashtable[]] $MemberDefinitions = @(
        @{
            Name       = '<member-name>'
            MemberType = '<member-type>'
            Value      = <member-definition>
        }
    )

    static <class-name>() {
        $TypeName = [<class-name>].Name
        foreach ($Definition in [<class-name>]::MemberDefinitions) {
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

For more information about defining instance methods with `Update-TypeData`,
see [about_Classes_Methods][07]. For more information about defining instance
properties with `Update-TypeData`, see [about_Classes_Properties][08].

## Limitations

PowerShell class constructors have the following limitations:

- Constructor chaining isn't implemented.

  Workaround: Define hidden `Init()` methods and call them from within the
  constructors.
- Constructor parameters can't use any attributes, including validation
  attributes.

  Workaround: Reassign the parameters in the constructor body with the
  validation attribute.
- Constructor parameters can't define default values. The parameters are always
  mandatory.

  Workaround: None.
- If any overload of a constructor is hidden, every overload for the
  constructor is treated as hidden too.

  Workaround: None.

## See also

- [about_Classes][10]
- [about_Classes_Inheritance][11]
- [about_Classes_Methods][01]
- [about_Classes_Properties][09]

<!-- Link reference definitions -->
[01]: about_Classes_Methods.md
[02]: #static-constructors
[03]: about_Classes_Properties.md#default-property-values
[04]: about_Hidden.md
[05]: #example-4---chaining-constructors-with-a-shared-method
[06]: #example-5---derived-class-constructors
[07]: about_Classes_Methods.md#defining-instance-methods-with-update-typedata
[08]: about_Classes_Properties.md#defining-instance-properties-with-update-typedata
[09]: about_Classes_Properties.md
[10]: about_Classes.md
[11]: about_Classes_Inheritance.md
