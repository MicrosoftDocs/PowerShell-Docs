---
description: Describes how to define methods for PowerShell classes.
Locale: en-US
ms.date: 11/13/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_classes_methods?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Classes_Methods
---

# about_Classes_Methods

## Short description

Describes how to define methods for PowerShell classes.

## Long description

Methods define the actions that a class can perform. Methods can take
parameters that specify input data. Methods always define an output type. If a
method doesn't return any output, it must have the **Void** output type. If a
method doesn't explicitly define an output type, the method's output type is
**Void**.

In class methods, no objects get sent to the pipeline except those specified in
the `return` statement. There's no accidental output to the pipeline from the
code.

> [!NOTE]
> This is fundamentally different from how PowerShell functions handle output,
> where everything goes to the pipeline.

Nonterminating errors written to the error stream from inside a class method
aren't passed through. You must use `throw` to surface a terminating error.
Using the `Write-*` cmdlets, you can still write to PowerShell's output streams
from within a class method. The cmdlets respect the [preference variables][01]
in the calling scope. However, you should avoid using the `Write-*` cmdlets so
that the method only outputs objects using the `return` statement.

Class methods can reference the current instance of the class object by using
the `$this` automatic variable to access properties and other methods defined
in the current class. The `$this` automatic variable isn't available in static
methods.

Class methods can have any number of attributes, including the [hidden][02] and
[static][03] attributes.

## Syntax

Class methods use the following syntaxes:

### One-line syntax

```Syntax
[[<attribute>]...] [hidden] [static] [<output-type>] <method-name> ([<method-parameters>]) { <body> }
```

### Multiline syntax

```Syntax
[[<attribute>]...]
[hidden]
[static]
[<output-type>] <method-name> ([<method-parameters>]) {
  <body>
}
```

## Examples

### Example 1 - Minimal method definition

The `GetVolume()` method of the **ExampleCube1** class returns the volume of
the cube. It defines the output type as a floating number and returns the
result of multiplying the **Height**, **Length**, and **Width** properties of
the instance.

```powershell
class ExampleCube1 {
    [float]   $Height
    [float]   $Length
    [float]   $Width

    [float] GetVolume() { return $this.Height * $this.Length * $this.Width }
}

$box = [ExampleCube1]@{
    Height = 2
    Length = 2
    Width  = 3
}

$box.GetVolume()
```

```Output
12
```

### Example 2 - Method with parameters

The `GeWeight()` method takes a floating number input for the density of the
cube and returns the weight of the cube, calculated as volume multiplied by
density.

```powershell
class ExampleCube2 {
    [float]   $Height
    [float]   $Length
    [float]   $Width

    [float] GetVolume() { return $this.Height * $this.Length * $this.Width }
    [float] GetWeight([float]$Density) {
        return $this.GetVolume() * $Density
    }
}

$cube = [ExampleCube2]@{
    Height = 2
    Length = 2
    Width  = 3
}

$cube.GetWeight(2.5)
```

```Output
30
```

### Example 3 - Method without output

This example defines the `Validate()` method with the output type as
**System.Void**. This method returns no output. Instead, if the validation
fails, it throws an error. The `GetVolume()` method calls `Validate()` before
calculating the volume of the cube. If validation fails, the method terminates
before the calculation.

```powershell
class ExampleCube3 {
    [float]   $Height
    [float]   $Length
    [float]   $Width

    [float] GetVolume() {
        $this.Validate()

        return $this.Height * $this.Length * $this.Width
    }

    [void] Validate() {
        $InvalidProperties = @()
        foreach ($Property in @('Height', 'Length', 'Width')) {
            if ($this.$Property -le 0) {
                $InvalidProperties += $Property
            }
        }

        if ($InvalidProperties.Count -gt 0) {
            $Message = @(
                'Invalid cube properties'
                "('$($InvalidProperties -join "', '")'):"
                "Cube dimensions must all be positive numbers."
            ) -join ' '
            throw $Message
        }
    }
}

$Cube = [ExampleCube3]@{ Length = 1 ; Width = -1 }
$Cube

$Cube.GetVolume()
```

```Output
Height Length Width
------ ------ -----
  0.00   1.00 -1.00

Invalid cube properties ('Height', 'Width'): Cube dimensions must all be
positive numbers.
At C:\code\classes.examples.ps1:26 char:13
+             throw $Message
+             ~~~~~~~~~~~~~~
    + CategoryInfo          : OperationStopped: (Invalid cube pr...sitive
    numbers.:String) [], RuntimeException
    + FullyQualifiedErrorId : Invalid cube properties ('Height', 'Width')
   : Cube dimensions must all be positive numbers.
```

The method throws an exception because the **Height** and **Width** properties
are invalid, preventing the class from calculating the current volume.

### Example 4 - Static method with overloads

The **ExampleCube4** class defines the static method `GetVolume()` with two
overloads. The first overload has parameters for the dimensions of the cube and
a flag to indicate whether the method should validate the input.

The second overload only includes the numeric inputs. It calls the first
overload with `$Static` as `$true`. The second overload gives users a way to
call the method without always having to define whether to strictly validate
the input.

The class also defines `GetVolume()` as an instance (nonstatic) method. This
method calls the second static overload, ensuring that the instance
`GetVolume()` method always validates the cube's dimensions before returning
the output value.

```powershell
class ExampleCube4 {
    [float]   $Height
    [float]   $Length
    [float]   $Width

    static [float] GetVolume(
        [float]$Height,
        [float]$Length,
        [float]$Width,
        [boolean]$Strict
    ) {
        $Signature = "[ExampleCube4]::GetVolume({0}, {1}, {2}, {3})"
        $Signature = $Signature -f $Height, $Length, $Width, $Strict
        Write-Verbose "Called $Signature"

        if ($Strict) {
            [ValidateScript({$_ -gt 0 })]$Height = $Height
            [ValidateScript({$_ -gt 0 })]$Length = $Length
            [ValidateScript({$_ -gt 0 })]$Width  = $Width
        }

        return $Height * $Length * $Width
    }

    static [float] GetVolume([float]$Height, [float]$Length, [float]$Width) {
        $Signature = "[ExampleCube4]::GetVolume($Height, $Length, $Width)"
        Write-Verbose "Called $Signature"

        return [ExampleCube4]::GetVolume($Height, $Length, $Width, $true)
    }

    [float] GetVolume() {
        Write-Verbose "Called `$this.GetVolume()"
        return [ExampleCube4]::GetVolume(
            $this.Height,
            $this.Length,
            $this.Width
        )
    }
}

$VerbosePreference = 'Continue'
$Cube = [ExampleCube4]@{ Height = 2 ; Length = 2 }
$Cube.GetVolume()
```

```Output
VERBOSE: Called $this.GetVolume()
VERBOSE: Called [ExampleCube4]::GetVolume(2, 2, 0)
VERBOSE: Called [ExampleCube4]::GetVolume(2, 2, 0, True)

The variable cannot be validated because the value 0 is not a valid value
for the Width variable.
At C:\code\classes.examples.ps1:19 char:13
+             [ValidateScript({$_ -gt 0 })]$Width  = $Width
+             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : MetadataError: (:) [], ValidationMetadataEx
   ception
    + FullyQualifiedErrorId : ValidateSetFailure
```

The verbose messages in the method definitions show how the initial call to
`$this.GetVolume()` calls the static method.

Calling the static method directly with the **Strict** parameter as `$false`
returns `0` for the volume.

```powershell
[ExampleCube4]::GetVolume($Cube.Height, $Cube.Length, $Cube.Width, $false)
```

```Output
VERBOSE: Called [ExampleCube4]::GetVolume(2, 2, 0, False)
0
```

## Method signatures and overloads

Every class method has a unique signature that defines how to call the method.
The method's output type, name, and parameters define the method signature.

When a class defines more than one method with the same name, the definitions
of that method are _overloads_. Overloads for a method must have different
parameters. A method can't define two implementations with the same parameters,
even if the output types are different.

The following class defines two methods, `Shuffle()` and `Deal()`. The `Deal()`
method defines two overloads, one without any parameters and the other with the
**Count** parameter.

```powershell
class CardDeck {
    [string[]]$Cards  = @()
    hidden [string[]]$Dealt  = @()
    hidden [string[]]$Suits  = @('Clubs', 'Diamonds', 'Hearts', 'Spades')
    hidden [string[]]$Values = 2..10 + @('Jack', 'Queen', 'King', 'Ace')

    CardDeck() {
        foreach($Suit in $this.Suits) {
            foreach($Value in $this.Values) {
                $this.Cards += "$Value of $Suit"
            }
        }
        $this.Shuffle()
    }

    [void] Shuffle() {
        $this.Cards = $this.Cards + $this.Dealt | Where-Object -FilterScript {
             -not [string]::IsNullOrEmpty($_)
        } | Get-Random -Count $this.Cards.Count
    }

    [string] Deal() {
        if ($this.Cards.Count -eq 0) { throw "There are no cards left." }

        $Card        = $this.Cards[0]
        $this.Cards  = $this.Cards[1..$this.Cards.Count]
        $this.Dealt += $Card

        return $Card
    }

    [string[]] Deal([int]$Count) {
        if ($Count -gt $this.Cards.Count) {
            throw "There are only $($this.Cards.Count) cards left."
        } elseif ($Count -lt 1) {
            throw "You must deal at least 1 card."
        }

        return (1..$Count | ForEach-Object { $this.Deal() })
    }
}
```

## Method output

By default, methods don't have any output. If a method signature includes an
explicit output type other than **Void**, the method must return an object of
that type. Methods don't emit any output except when the `return` keyword
explicitly returns an object.

## Method parameters

Class methods can define input parameters to use in the method body. Method
parameters are enclosed in parentheses and are separated by commas. Empty
parentheses indicate that the method requires no parameters.

Parameters can be defined on a single line or multiple lines. The following
blocks show the syntax for method parameters.

```Syntax
([[<parameter-type>]]$<parameter-name>[, [[<parameter-type>]]$<parameter-name>])
```

```Syntax
(
    [[<parameter-type>]]$<parameter-name>[,
    [[<parameter-type>]]$<parameter-name>]
)
```

Method parameters can be strongly typed. If a parameter isn't typed, the method
accepts any object for that parameter. If the parameter is typed, the method
tries to convert the value for that parameter to the correct type, throwing an
exception if the input can't be converted.

Method parameters can't define default values. All method parameters are
mandatory.

Method parameters can't have any other attributes. This prevents methods from
using parameters with the `Validate*` attributes. For more information about
the validation attributes, see [about_Functions_Advanced_Parameters][04].

You can use one of the following patterns to add validation to method
parameters:

1. Reassign the parameters to the same variables with the required validation
   attributes. This works for both static and instance methods. For an example
   of this pattern, see [Example 4][05].
1. Use `Update-TypeData` to define a `ScriptMethod` that uses validation
   attributes on the parameters directly. This only works for instance methods.
   For more information, see the
   [Defining instance methods with Update-TypeData][06] section.

## Automatic variables in methods

Not all automatic variables are available in methods. The following list
includes automatic variables and suggestions for whether and how to use them in
PowerShell class methods. Automatic variables not included in the list aren't
available to class methods.

- `$?` - Access as normal.
- `$_` - Access as normal.
- `$args` - Use the explicit parameter variables instead.
- `$ConsoleFileName` - Access as `$Script:ConsoleFileName` instead.
- `$Error` - Access as normal.
- `$Event` - Access as normal.
- `$EventArgs` - Access as normal.
- `$EventSubscriber` - Access as normal.
- `$ExecutionContext` - Access as `$Script:ExecutionContext` instead.
- `$false` - Access as normal.
- `$foreach` - Access as normal.
- `$HOME` - Access as `$Script:HOME` instead.
- `$Host` - Access as `$Script:Host` instead.
- `$input` - Use the explicit parameter variables instead.
- `$LASTEXITCODE` - Access as normal.
- `$Matches` - Access as normal.
- `$MyInvocation` - Access as normal.
- `$NestedPromptLevel` - Access as normal.
- `$null` - Access as normal.
- `$PID` - Access as `$Script:PID` instead.
- `$PROFILE` - Access as `$Script:PROFILE` instead.
- `$PSBoundParameters` - Don't use this variable. It's intended for cmdlets and
  functions. Using it in a class may have unexpected side effects.
- `$PSCmdlet` - Don't use this variable. It's intended for cmdlets and
  functions. Using it in a class may have unexpected side effects.
- `$PSCommandPath` - Access as normal.
- `$PSCulture` - Access as `$Script:PSCulture` instead.
- `$PSEdition` - Access as `$Script:PSEdition` instead.
- `$PSHOME` - Access as `$Script:PSHOME` instead.
- `$PSItem` - Access as normal.
- `$PSScriptRoot` - Access as normal.
- `$PSSenderInfo` - Access as `$Script:PSSenderInfo` instead.
- `$PSUICulture` - Access as `$Script:PSUICulture` instead.
- `$PSVersionTable` - Access as `$Script:PSVersionTable` instead.
- `$PWD` - Access as normal.
- `$Sender` - Access as normal.
- `$ShellId` - Access as `$Script:ShellId` instead.
- `$StackTrace` - Access as normal.
- `$switch` - Access as normal.
- `$this` - Access as normal. In a class method, `$this` is always the current
  instance of the class. You can access the class properties and methods with
  it. It's not available in static methods.
- `$true` - Access as normal.

For more information about automatic variables, see
[about_Automatic_Variables][07].

## Hidden methods

You can hide methods of a class by declaring them with the `hidden` keyword.
Hidden class methods are:

- Not included in the list of class members returned by the `Get-Member`
  cmdlet. To show hidden methods with `Get-Member`, use the **Force**
  parameter.
- Not displayed in tab completion or IntelliSense unless the completion occurs
  in the class that defines the hidden method.
- Public members of the class. They can be called and inherited. Hiding a
  method doesn't make it private. It only hides the method as described in the
  previous points.

> [!NOTE]
> When you hide any overload for a method, that method is removed from
> IntelliSense, completion results, and the default output for `Get-Member`.

For more information about the `hidden` keyword, see [about_Hidden][08].

## Static methods

You can define a method as belonging to the class itself instead of instances
of the class by declaring the method with the `static` keyword. Static class
methods:

- Are always available, independent of class instantiation.
- Are shared across all instances of the class.
- Are always available.
- Can't access instance properties of the class. They can only access static
  properties.
- Live for the entire session span.

## Derived class methods

When a class derives from a base class, it inherits the methods of the base
class and their overloads. Any method overloads defined on the base class,
including hidden methods, are available on the derived class.

A derived class can override an inherited method overload by redefining it in
the class definition. To override the overload, the parameter types must be the
same as for the base class. The output type for the overload can be different.

Unlike constructors, methods can't use the `: base(<parameters>)` syntax to
invoke a base class overload for the method. The redefined overload on the
derived class completely replaces the overload defined by the base class.

The following example shows the behavior for static and instance methods on
derived classes.

The base class defines:

- The static methods `Now()` for returning the current time and `DaysAgo()` for
  returning a date in the past.
- The instance property **TimeStamp** and a `ToString()` instance method that
  returns the string representation of that property. This ensures that when an
  instance is used in a string it converts to the datetime string instead of
  the class name.
- The instance method `SetTimeStamp()` with two overloads. When the method is
  called without parameters, it sets the **TimeStamp** to the current time.
  When the method is called with a **DateTime**, it sets the **TimeStamp** to
  that value.

```powershell
class BaseClass {
    static [datetime] Now() {
        return Get-Date
    }
    static [datetime] DaysAgo([int]$Count) {
        return [BaseClass]::Now().AddDays(-$Count)
    }

    [datetime] $TimeStamp = [BaseClass]::Now()

    [string] ToString() {
        return $this.TimeStamp.ToString()
    }

    [void] SetTimeStamp([datetime]$TimeStamp) {
        $this.TimeStamp = $TimeStamp
    }
    [void] SetTimeStamp() {
        $this.TimeStamp = [BaseClass]::Now()
    }
}
```

The next block defines classes derived from **BaseClass**:

- **DerivedClassA** inherits from **BaseClass** without any overrides.
- **DerivedClassB** overrides the `DaysAgo()` static method to return a string
  representation instead of the **DateTime** object. It also overrides the
  `ToString()` instance method to return the timestamp as an ISO8601 date
  string.
- **DerivedClassC** overrides the parameterless overload of the
  `SetTimeStamp()` method so that setting the timestamp without parameters sets
  the date to 10 days before the current date.

```powershell
class DerivedClassA : BaseClass     {}
class DerivedClassB : BaseClass     {
    static [string] DaysAgo([int]$Count) {
        return [BaseClass]::DaysAgo($Count).ToString('yyyy-MM-dd')
    }
    [string] ToString() {
        return $this.TimeStamp.ToString('yyyy-MM-dd')
    }
}
class DerivedClassC : BaseClass {
    [void] SetTimeStamp() {
        $this.SetTimeStamp([BaseClass]::Now().AddDays(-10))
    }
}
```

The following block shows the output of the static `Now()` method for the
defined classes. The output is the same for every class, because the derived
classes don't override the base class implementation of the method.

```powershell
"[BaseClass]::Now()     => $([BaseClass]::Now())"
"[DerivedClassA]::Now() => $([DerivedClassA]::Now())"
"[DerivedClassB]::Now() => $([DerivedClassB]::Now())"
"[DerivedClassC]::Now() => $([DerivedClassC]::Now())"
```

```Output
[BaseClass]::Now()     => 11/06/2023 09:41:23
[DerivedClassA]::Now() => 11/06/2023 09:41:23
[DerivedClassB]::Now() => 11/06/2023 09:41:23
[DerivedClassC]::Now() => 11/06/2023 09:41:23
```

The next block calls the `DaysAgo()` static method of each class. Only the
output for **DerivedClassB** is different, because it overrode the base
implementation.

```powershell
"[BaseClass]::DaysAgo(3)     => $([BaseClass]::DaysAgo(3))"
"[DerivedClassA]::DaysAgo(3) => $([DerivedClassA]::DaysAgo(3))"
"[DerivedClassB]::DaysAgo(3) => $([DerivedClassB]::DaysAgo(3))"
"[DerivedClassC]::DaysAgo(3) => $([DerivedClassC]::DaysAgo(3))"
```

```Output
[BaseClass]::DaysAgo(3)     => 11/03/2023 09:41:38
[DerivedClassA]::DaysAgo(3) => 11/03/2023 09:41:38
[DerivedClassB]::DaysAgo(3) => 2023-11-03
[DerivedClassC]::DaysAgo(3) => 11/03/2023 09:41:38
```

The following block shows the string presentation of a new instance for each
class. The representation for **DerivedClassB** is different because it
overrode the `ToString()` instance method.

```powershell
"`$base = [BaseClass]::New()     => $($base = [BaseClass]::New(); $base)"
"`$a    = [DerivedClassA]::New() => $($a = [DerivedClassA]::New(); $a)"
"`$b    = [DerivedClassB]::New() => $($b = [DerivedClassB]::New(); $b)"
"`$c    = [DerivedClassC]::New() => $($c = [DerivedClassC]::New(); $c)"
```

```Output
$base = [BaseClass]::New()     => 11/6/2023 9:44:57 AM
$a    = [DerivedClassA]::New() => 11/6/2023 9:44:57 AM
$b    = [DerivedClassB]::New() => 2023-11-06
$c    = [DerivedClassC]::New() => 11/6/2023 9:44:57 AM
```

The next block calls the `SetTimeStamp()` instance method for each instance,
setting the **TimeStamp** property to a specific date. Each instance has the
same date, because none of the derived classes override the parameterized
overload for the method.

```powershell
[datetime]$Stamp = '2024-10-31'
"`$base.SetTimeStamp(`$Stamp) => $($base.SetTimeStamp($Stamp) ; $base)"
"`$a.SetTimeStamp(`$Stamp)    => $($a.SetTimeStamp($Stamp); $a)"
"`$b.SetTimeStamp(`$Stamp)    => $($b.SetTimeStamp($Stamp); $b)"
"`$c.SetTimeStamp(`$Stamp)    => $($c.SetTimeStamp($Stamp); $c)"
```

```Output
$base.SetTimeStamp($Stamp) => 10/31/2024 12:00:00 AM
$a.SetTimeStamp($Stamp)    => 10/31/2024 12:00:00 AM
$b.SetTimeStamp($Stamp)    => 2024-10-31
$c.SetTimeStamp($Stamp)    => 10/31/2024 12:00:00 AM
```

The last block calls `SetTimeStamp()` without any parameters. The output shows
that the value for the **DerivedClassC** instance is set to 10 days before the
others.

```powershell
"`$base.SetTimeStamp() => $($base.SetTimeStamp() ; $base)"
"`$a.SetTimeStamp()    => $($a.SetTimeStamp(); $a)"
"`$b.SetTimeStamp()    => $($b.SetTimeStamp(); $b)"
"`$c.SetTimeStamp()    => $($c.SetTimeStamp(); $c)"
```

```Output
$base.SetTimeStamp() => 11/6/2023 9:53:58 AM
$a.SetTimeStamp()    => 11/6/2023 9:53:58 AM
$b.SetTimeStamp()    => 2023-11-06
$c.SetTimeStamp()    => 10/27/2023 9:53:58 AM
```

## Defining instance methods with Update-TypeData

Beyond declaring methods directly in the class definition, you can define
methods for instances of a class in the static constructor using the
`Update-TypeData` cmdlet.

Use this snippet as a starting point for the pattern. Replace the placeholder
text in angle brackets as needed.

```powershell
class <ClassName> {
    static [hashtable[]] $MemberDefinitions = @(
        @{
            MemberName = '<MethodName>'
            MemberType = 'ScriptMethod'
            Value      = {
              param(<method-parameters>)

              <method-body>
            }
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
> non-static constructors, but the cmdlet runs every time the constructor is
> called. Using `Update-TypeData` in the static constructor ensures that the
> code for adding the members to the class only needs to run once in a session.

### Defining methods with default parameter values and validation attributes

Methods defined directly in a class declaration can't define default values or
validation attributes on the method parameters. To define class methods with
default values or validation attributes, they must be defined as
**ScriptMethod** members.

In this example, the **CardDeck** class defines a `Draw()` method that uses
both a validation attribute and a default value for the **Count** parameter.

```powershell
class CookieJar {
    [int] $Cookies = 12

    static [hashtable[]] $MemberDefinitions = @(
        @{
            MemberName = 'Eat'
            MemberType = 'ScriptMethod'
            Value      = {
                param(
                    [ValidateScript({ $_ -ge 1 -and $_ -le $this.Cookies })]
                    [int] $Count = 1
                )

                $this.Cookies -= $Count
                if ($Count -eq 1) {
                    "You ate 1 cookie. There are $($this.Cookies) left."
                } else {
                    "You ate $Count cookies. There are $($this.Cookies) left."
                }
            }
        }
    )

    static CookieJar() {
        $TypeName = [CookieJar].Name
        foreach ($Definition in [CookieJar]::MemberDefinitions) {
            Update-TypeData -TypeName $TypeName @Definition
        }
    }
}

$Jar = [CookieJar]::new()
$Jar.Eat(1)
$Jar.Eat()
$Jar.Eat(20)
$Jar.Eat(6)
```

```Output
You ate 1 cookie. There are 11 left.

You ate 1 cookie. There are 10 left.

Exception calling "Eat" with "1" argument(s): "The attribute cannot be
added because variable Count with value 20 would no longer be valid."
At line:1 char:1
+ $Jar.Eat(20)
+ ~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [], MethodInvocationExcep
   tion
    + FullyQualifiedErrorId : ScriptMethodRuntimeException

You ate 6 cookies. There are 4 left.
```

> [!NOTE]
> While this pattern works for validation attributes, notice that the exception
> is misleading, referencing an inability to add an attribute. It might be a
> better user experience to explicitly check the value for the parameter and
> raise a meaningful error instead. That way, users can understand why they're
> seeing the error and what to do about it.

## Limitations

PowerShell class methods have the following limitations:

- Method parameters can't use any attributes, including validation attributes.

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

## See also

- [about_Automatic_Variables][07]
- [about_Classes][09]
- [about_Classes_Constructors][10]
- [about_Classes_Inheritance][11]
- [about_Classes_Properties][12]
- [about_Using][13]

<!-- Link reference definitions -->
[01]: about_Preference_Variables.md
[02]: #hidden-methods
[03]: #static-methods
[04]: about_functions_advanced_parameters.md#parameter-and-variable-validation-attributes
[05]: #example-4---static-method-with-overloads
[06]: #defining-instance-methods-with-update-typedata
[07]: about_Automatic_Variables.md
[08]: about_Hidden.md
[09]: about_Classes.md
[10]: about_Classes_Constructors.md
[11]: about_Classes_Inheritance.md
[12]: about_Classes_Properties.md
[13]: about_Using.md
