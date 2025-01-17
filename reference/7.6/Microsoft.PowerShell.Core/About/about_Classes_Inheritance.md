---
description: Describes how you can define classes that extend other types.
Locale: en-US
ms.date: 11/10/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_classes_inheritance?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Classes_Inheritance
---

# about_Classes_Inheritance

## Short description

Describes how you can define classes that extend other types.

## Long description

PowerShell classes support _inheritance_, which allows you to define a child
class that reuses (inherits), extends, or modifies the behavior of a parent
class. The class whose members are inherited is called the _base class_. The
class that inherits the members of the base class is called the _derived
class_.

PowerShell supports single inheritance only. A class can only inherit from a
single class. However, inheritance is transitive, which allows you to define an
inheritance hierarchy for a set of types. In other words, type **D** can
inherit from type **C**, which inherits from type **B**, which inherits from
the base class type **A**. Because inheritance is transitive, the members of
type **A** are available to type **D**.

Derived classes don't inherit all members of the base class. The following
members aren't inherited:

- Static constructors, which initialize the static data of a class.
- Instance constructors, which you call to create a new instance of the class.
  Each class must define its own constructors.

You can extend a class by creating a new class that derives from an existing
class. The derived class inherits the properties and methods of the base class.
You can add or override the base class members as required.

Classes can also inherit from interfaces, which define a contract. A class that
inherits from an interface must implement that contract. When it does, the
class is usable like any other class implementing that interface. If a class
inherits from an interface but doesn't implement the interface, PowerShell
raises a parsing error for the class.

Some PowerShell operators depend on a class implementing a specific interface.
For example, the `-eq` operator only checks for reference equality unless the
class implements the **System.IEquatable** interface. The `-le`, `-lt`, `-ge`,
and `-gt` operators only work on classes that implement the
**System.IComparable** interface.

A derived class uses the `:` syntax to extend a base class or implement
interfaces. The derived class should always be leftmost in the class
declaration.

This example shows the basic PowerShell class inheritance syntax.

```powershell
Class Derived : Base {...}
```

This example shows inheritance with an interface declaration coming after the
base class.

```powershell
Class Derived : Base, Interface {...}
```

## Syntax

Class inheritance uses the following syntaxes:

### One line syntax

```Syntax
class <derived-class-name> : <base-class-or-interface-name>[, <interface-name>...] {
    <derived-class-body>
}
```

For example:

```powershell
# Base class only
class Derived : Base {...}
# Interface only
class Derived : System.IComparable {...}
# Base class and interface
class Derived : Base, System.IComparable {...}
```

### Multiline syntax

```Syntax
class <derived-class-name> : <base-class-or-interface-name>[,
    <interface-name>...] {
    <derived-class-body>
}
```

For example:

```powershell
class Derived : Base,
                System.IComparable,
                System.IFormattable,
                System.IConvertible {
    # Derived class definition
}
```

## Examples

### Example 1 - Inheriting and overriding from a base class

The following example shows the behavior of inherited properties with and
without overriding. Run the code blocks in order after reading their
description.

#### Defining the base class

The first code block defines **PublishedWork** as a base class. It has two
static properties, **List** and **Artists**. Next, it defines the static
`RegisterWork()` method to add works to the static **List** property and the
artists to the **Artists** property, writing a message for each new entry in
the lists.

The class defines three instance properties that describe a published work.
Finally, it defines the `Register()` and `ToString()` instance methods.

```powershell
class PublishedWork {
    static [PublishedWork[]] $List    = @()
    static [string[]]        $Artists = @()

    static [void] RegisterWork([PublishedWork]$Work) {
        $wName   = $Work.Name
        $wArtist = $Work.Artist
        if ($Work -notin [PublishedWork]::List) {
            Write-Verbose "Adding work '$wName' to works list"
            [PublishedWork]::List += $Work
        } else {
            Write-Verbose "Work '$wName' already registered."
        }
        if ($wArtist -notin [PublishedWork]::Artists) {
            Write-Verbose "Adding artist '$wArtist' to artists list"
            [PublishedWork]::Artists += $wArtist
        } else {
            Write-Verbose "Artist '$wArtist' already registered."
        }
    }

    static [void] ClearRegistry() {
        Write-Verbose "Clearing PublishedWork registry"
        [PublishedWork]::List    = @()
        [PublishedWork]::Artists = @()
    }

    [string] $Name
    [string] $Artist
    [string] $Category

    [void] Init([string]$WorkType) {
        if ([string]::IsNullOrEmpty($this.Category)) {
            $this.Category = "${WorkType}s"
        }
    }

    PublishedWork() {
        $WorkType = $this.GetType().FullName
        $this.Init($WorkType)
        Write-Verbose "Defined a published work of type [$WorkType]"
    }

    PublishedWork([string]$Name, [string]$Artist) {
        $WorkType    = $this.GetType().FullName
        $this.Name   = $Name
        $this.Artist = $Artist
        $this.Init($WorkType)

        Write-Verbose "Defined '$Name' by $Artist as a published work of type [$WorkType]"
    }

    PublishedWork([string]$Name, [string]$Artist, [string]$Category) {
        $WorkType    = $this.GetType().FullName
        $this.Name   = $Name
        $this.Artist = $Artist
        $this.Init($WorkType)

        Write-Verbose "Defined '$Name' by $Artist ($Category) as a published work of type [$WorkType]"
    }

    [void]   Register() { [PublishedWork]::RegisterWork($this) }
    [string] ToString() { return "$($this.Name) by $($this.Artist)" }
}
```

#### Defining a derived class without overrides

The first derived class is **Album**. It doesn't override any properties or
methods. It adds a new instance property, **Genres**, that doesn't exist on the
base class.

```powershell
class Album : PublishedWork {
    [string[]] $Genres   = @()
}
```

The following code block shows the behavior of the derived **Album** class.
First, it sets the `$VerbosePreference` so that the messages from the class
methods emit to the console. It creates three instances of the class, shows
them in a table, and then registers them with the inherited static
`RegisterWork()` method. It then calls the same static method on the base class
directly.

```powershell
$VerbosePreference = 'Continue'
$Albums = @(
    [Album]@{
        Name   = 'The Dark Side of the Moon'
        Artist = 'Pink Floyd'
        Genres = 'Progressive rock', 'Psychedelic rock'
    }
    [Album]@{
        Name   = 'The Wall'
        Artist = 'Pink Floyd'
        Genres = 'Progressive rock', 'Art rock'
    }
    [Album]@{
        Name   = '36 Chambers'
        Artist = 'Wu-Tang Clan'
        Genres = 'Hip hop'
    }
)

$Albums | Format-Table
$Albums | ForEach-Object { [Album]::RegisterWork($_) }
$Albums | ForEach-Object { [PublishedWork]::RegisterWork($_) }
```

```Output
VERBOSE: Defined a published work of type [Album]
VERBOSE: Defined a published work of type [Album]
VERBOSE: Defined a published work of type [Album]

Genres                               Name                      Artist       Category
------                               ----                      ------       --------
{Progressive rock, Psychedelic rock} The Dark Side of the Moon Pink Floyd   Albums
{Progressive rock, Art rock}         The Wall                  Pink Floyd   Albums
{Hip hop}                            36 Chambers               Wu-Tang Clan Albums

VERBOSE: Adding work 'The Dark Side of the Moon' to works list
VERBOSE: Adding artist 'Pink Floyd' to artists list
VERBOSE: Adding work 'The Wall' to works list
VERBOSE: Artist 'Pink Floyd' already registered.
VERBOSE: Adding work '36 Chambers' to works list
VERBOSE: Adding artist 'Wu-Tang Clan' to artists list

VERBOSE: Work 'The Dark Side of the Moon' already registered.
VERBOSE: Artist 'Pink Floyd' already registered.
VERBOSE: Work 'The Wall' already registered.
VERBOSE: Artist 'Pink Floyd' already registered.
VERBOSE: Work '36 Chambers' already registered.
VERBOSE: Artist 'Wu-Tang Clan' already registered.
```

Notice that even though the **Album** class didn't define a value for
**Category** or any constructors, the property was defined by the default
constructor of the base class.

In the verbose messaging, the second call to the `RegisterWork()` method
reports that the works and artists are already registered. Even though the
first call to `RegisterWork()` was for the derived **Album** class, it used the
inherited static method from the base **PublishedWork** class. That method
updated the static **List** and **Artist** properties on the base class, which
the derived class didn't override.

The next code block clears the registry and calls the `Register()` instance
method on the **Album** objects.

```powershell
[PublishedWork]::ClearRegistry()
$Albums.Register()
```

```Output
VERBOSE: Clearing PublishedWork registry

VERBOSE: Adding work 'The Dark Side of the Moon' to works list
VERBOSE: Adding artist 'Pink Floyd' to artists list
VERBOSE: Adding work 'The Wall' to works list
VERBOSE: Artist 'Pink Floyd' already registered.
VERBOSE: Adding work '36 Chambers' to works list
VERBOSE: Adding artist 'Wu-Tang Clan' to artists list
```

The instance method on the **Album** objects has the same effect as calling the
static method on the derived or base class.

The following code block compares the static properties for the base class and
the derived class, showing that they're the same.

```powershell
[pscustomobject]@{
    '[PublishedWork]::List'    = [PublishedWork]::List -join ",`n"
    '[Album]::List'            = [Album]::List -join ",`n"
    '[PublishedWork]::Artists' = [PublishedWork]::Artists -join ",`n"
    '[Album]::Artists'         = [Album]::Artists -join ",`n"
    'IsSame::List'             = (
        [PublishedWork]::List.Count -eq [Album]::List.Count -and
        [PublishedWork]::List.ToString() -eq [Album]::List.ToString()
    )
    'IsSame::Artists'          = (
        [PublishedWork]::Artists.Count -eq [Album]::Artists.Count -and
        [PublishedWork]::Artists.ToString() -eq [Album]::Artists.ToString()
    )
} | Format-List
```

```Output
[PublishedWork]::List    : The Dark Side of the Moon by Pink Floyd,
                           The Wall by Pink Floyd,
                           36 Chambers by Wu-Tang Clan
[Album]::List            : The Dark Side of the Moon by Pink Floyd,
                           The Wall by Pink Floyd,
                           36 Chambers by Wu-Tang Clan
[PublishedWork]::Artists : Pink Floyd,
                           Wu-Tang Clan
[Album]::Artists         : Pink Floyd,
                           Wu-Tang Clan
IsSame::List             : True
IsSame::Artists          : True
```

#### Defining a derived class with overrides

The next code block defines the **Illustration** class inheriting from the base
**PublishedWork** class. The new class extends the base class by defining the
**Medium** instance property with a default value of `Unknown`.

Unlike the derived **Album** class, **Illustration** overrides the following
properties and methods:

- It overrides the static **Artists** property. The definition is the same, but
  the **Illustration** class declares it directly.
- It overrides the **Category** instance property, setting the default value to
  `Illustrations`.
- It overrides the `ToString()` instance method so the string representation of
  an illustration includes the medium it was created with.

The class also defines the static `RegisterIllustration()` method to first call
the base class `RegisterWork()` method and then add the artist to the
overridden **Artists** static property on the derived class.

Finally, the class overrides all three constructors:

1. The default constructor is empty except for a verbose message indicating it
   created an illustration.
1. The next constructor takes two string values for the name and artist that
   created the illustration. Instead of implementing the logic for setting the
   **Name** and **Artist** properties, the constructor calls the appropriate
   constructor from the base class.
1. The last constructor takes three string values for the name, artist, and
   medium of the illustration. Both constructors write a verbose message
   indicating that they created an illustration.

```powershell
class Illustration : PublishedWork {
    static [string[]] $Artists = @()

    static [void] RegisterIllustration([Illustration]$Work) {
        $wArtist = $Work.Artist

        [PublishedWork]::RegisterWork($Work)

        if ($wArtist -notin [Illustration]::Artists) {
            Write-Verbose "Adding illustrator '$wArtist' to artists list"
            [Illustration]::Artists += $wArtist
        } else {
            Write-Verbose "Illustrator '$wArtist' already registered."
        }
    }

    [string] $Category = 'Illustrations'
    [string] $Medium   = 'Unknown'

    [string] ToString() {
        return "$($this.Name) by $($this.Artist) ($($this.Medium))"
    }

    Illustration() {
        Write-Verbose 'Defined an illustration'
    }

    Illustration([string]$Name, [string]$Artist) : base($Name, $Artist) {
        Write-Verbose "Defined '$Name' by $Artist ($($this.Medium)) as an illustration"
    }

    Illustration([string]$Name, [string]$Artist, [string]$Medium) {
        $this.Name = $Name
        $this.Artist = $Artist
        $this.Medium = $Medium

        Write-Verbose "Defined '$Name' by $Artist ($Medium) as an illustration"
    }
}
```

The following code block shows the behavior of the derived **Illustration**
class. It creates three instances of the class, shows them in a table, and then
registers them with the inherited static `RegisterWork()` method. It then calls
the same static method on the base class directly. Finally, it writes messages
showing the list of registered artists for the base class and the derived
class.

```powershell
$Illustrations = @(
    [Illustration]@{
        Name   = 'The Funny Thing'
        Artist = 'Wanda Gág'
        Medium = 'Lithography'
    }
    [Illustration]::new('Millions of Cats', 'Wanda Gág')
    [Illustration]::new(
      'The Lion and the Mouse',
      'Jerry Pinkney',
      'Watercolor'
    )
)

$Illustrations | Format-Table
$Illustrations | ForEach-Object { [Illustration]::RegisterIllustration($_) }
$Illustrations | ForEach-Object { [PublishedWork]::RegisterWork($_) }
"Published work artists: $([PublishedWork]::Artists -join ', ')"
"Illustration artists: $([Illustration]::Artists -join ', ')"
```

```Output
VERBOSE: Defined a published work of type [Illustration]
VERBOSE: Defined an illustration
VERBOSE: Defined 'Millions of Cats' by Wanda Gág as a published work of type [Illustration]
VERBOSE: Defined 'Millions of Cats' by Wanda Gág (Unknown) as an illustration
VERBOSE: Defined a published work of type [Illustration]
VERBOSE: Defined 'The Lion and the Mouse' by Jerry Pinkney (Watercolor) as an illustration

Category      Medium      Name                   Artist
--------      ------      ----                   ------
Illustrations Lithography The Funny Thing        Wanda Gág
Illustrations Unknown     Millions of Cats       Wanda Gág
Illustrations Watercolor  The Lion and the Mouse Jerry Pinkney

VERBOSE: Adding work 'The Funny Thing' to works list
VERBOSE: Adding artist 'Wanda Gág' to artists list
VERBOSE: Adding illustrator 'Wanda Gág' to artists list
VERBOSE: Adding work 'Millions of Cats' to works list
VERBOSE: Artist 'Wanda Gág' already registered.
VERBOSE: Illustrator 'Wanda Gág' already registered.
VERBOSE: Adding work 'The Lion and the Mouse' to works list
VERBOSE: Adding artist 'Jerry Pinkney' to artists list
VERBOSE: Adding illustrator 'Jerry Pinkney' to artists list

VERBOSE: Work 'The Funny Thing' already registered.
VERBOSE: Artist 'Wanda Gág' already registered.
VERBOSE: Work 'Millions of Cats' already registered.
VERBOSE: Artist 'Wanda Gág' already registered.
VERBOSE: Work 'The Lion and the Mouse' already registered.
VERBOSE: Artist 'Jerry Pinkney' already registered.

Published work artists: Pink Floyd, Wu-Tang Clan, Wanda Gág, Jerry Pinkney

Illustration artists: Wanda Gág, Jerry Pinkney
```

The verbose messaging from creating the instances shows that:

- When creating the first instance, the base class default constructor was
  called before the derived class default constructor.
- When creating the second instance, the explicitly inherited constructor was
  called for the base class before the derived class constructor.
- When creating the third instance, the base class default constructor was
  called before the derived class constructor.

The verbose messages from the `RegisterWork()` method indicate that the works
and artists were already registered. This is because the
`RegisterIllustration()` method called the `RegisterWork()` method internally.

However, when comparing the value of the static **Artist** property for both
the base class and derived class, the values are different. The **Artists**
property for the derived class only includes illustrators, not the album
artists. Redefining the **Artist** property in the derived class prevents the
class from returning the static property on the base class.

The final code block calls the `ToString()` method on the entries of the
static **List** property on the base class.

```powershell
[PublishedWork]::List | ForEach-Object -Process { $_.ToString() }
```

```Output
The Dark Side of the Moon by Pink Floyd
The Wall by Pink Floyd
36 Chambers by Wu-Tang Clan
The Funny Thing by Wanda Gág (Lithography)
Millions of Cats by Wanda Gág (Unknown)
The Lion and the Mouse by Jerry Pinkney (Watercolor)
```

The **Album** instances only return the name and artist in their string. The
**Illustration** instances also included the medium in parentheses, because
that class overrode the `ToString()` method.

### Example 2 - Implementing interfaces

The following example shows how a class can implement one or more interfaces.
The example extends the definition of a **Temperature** class to support more
operations and behaviors.

#### Initial class definition

Before implementing any interfaces, the **Temperature** class is defined with
two properties, **Degrees** and **Scale**. It defines constructors and three
instance methods for returning the instance as degrees of a particular scale.

The class defines the available scales with the **TemperatureScale**
enumeration.

```powershell
class Temperature {
    [float]            $Degrees
    [TemperatureScale] $Scale

    Temperature() {}
    Temperature([float] $Degrees)          { $this.Degrees = $Degrees }
    Temperature([TemperatureScale] $Scale) { $this.Scale = $Scale }
    Temperature([float] $Degrees, [TemperatureScale] $Scale) {
        $this.Degrees = $Degrees
        $this.Scale   = $Scale
    }

    [float] ToKelvin() {
        switch ($this.Scale) {
            Celsius    { return $this.Degrees + 273.15 }
            Fahrenheit { return ($this.Degrees + 459.67) * 5/9 }
        }
        return $this.Degrees
    }
    [float] ToCelsius() {
        switch ($this.Scale) {
            Fahrenheit { return ($this.Degrees - 32) * 5/9 }
            Kelvin     { return $this.Degrees - 273.15 }
        }
        return $this.Degrees
    }
    [float] ToFahrenheit() {
        switch ($this.Scale) {
            Celsius    { return $this.Degrees * 9/5 + 32 }
            Kelvin     { return $this.Degrees * 9/5 - 459.67 }
        }
        return $this.Degrees
    }
}

enum TemperatureScale {
    Celsius    = 0
    Fahrenheit = 1
    Kelvin     = 2
}
```

However, in this basic implementation, there's a few limitations as shown in
the following example output:

```powershell
$Celsius    = [Temperature]::new()
$Fahrenheit = [Temperature]::new([TemperatureScale]::Fahrenheit)
$Kelvin     = [Temperature]::new(0, 'Kelvin')

$Celsius, $Fahrenheit, $Kelvin

"The temperatures are: $Celsius, $Fahrenheit, $Kelvin"

[Temperature]::new() -eq $Celsius

$Celsius -gt $Kelvin
```

```Output
Degrees      Scale
-------      -----
   0.00    Celsius
   0.00 Fahrenheit
   0.00     Kelvin

The temperatures are: Temperature, Temperature, Temperature

False

InvalidOperation:
Line |
  11 |  $Celsius -gt $Kelvin
     |  ~~~~~~~~~~~~~~~~~~~~
     | Cannot compare "Temperature" because it is not IComparable.
```

The output shows that instances of **Temperature**:

- Don't display correctly as strings.
- Can't be checked properly for equivalency.
- Can't be compared.

These three problems can be addressed by implementing interfaces for the class.

#### Implementing IFormattable

The first interface to implement for the **Temperature** class is
**System.IFormattable**. This interface enables formatting an instance of the
class as different strings. To implement the interface, the class needs to
inherit from **System.IFormattable** and define the `ToString()` instance
method.

The `ToString()` instance method needs to have the following signature:

```powershell
[string] ToString(
    [string]$Format,
    [System.IFormatProvider]$FormatProvider
) {
    # Implementation
}
```

The signature that the interface requires is listed in the
[reference documentation][01].

For **Temperature**, the class should support three formats: `C` to return the
instance in Celsius, `F` to return it in Fahrenheit, and `K` to return it in
Kelvin. For any other format, the method should throw a
**System.FormatException**.

```powershell
[string] ToString(
    [string]$Format,
    [System.IFormatProvider]$FormatProvider
) {
    # If format isn't specified, use the defined scale.
    if ([string]::IsNullOrEmpty($Format)) {
        $Format = switch ($this.Scale) {
            Celsius    { 'C' }
            Fahrenheit { 'F' }
            Kelvin     { 'K' }
        }
    }
    # If format provider isn't specified, use the current culture.
    if ($null -eq $FormatProvider) {
        $FormatProvider = [CultureInfo]::CurrentCulture
    }
    # Format the temperature.
    switch ($Format) {
        'C' {
            return $this.ToCelsius().ToString('F2', $FormatProvider) + '°C'
        }
        'F' {
            return $this.ToFahrenheit().ToString('F2', $FormatProvider) + '°F'
        }
        'K' {
            return $this.ToKelvin().ToString('F2', $FormatProvider) + '°K'
        }
    }
    # If we get here, the format is invalid.
    throw [System.FormatException]::new(
        "Unknown format: '$Format'. Valid Formats are 'C', 'F', and 'K'"
    )
}
```

In this implementation, the method defaults to the instance scale for
format and the current culture when formatting the numerical degree value
itself. It uses the `To<Scale>()` instance methods to convert the degrees,
formats them to two-decimal places, and appends the appropriate degree symbol
to the string.

With the required signature implemented, the class can also define overloads to
make it easier to return the formatted instance.

```powershell
[string] ToString([string]$Format) {
    return $this.ToString($Format, $null)
}

[string] ToString() {
    return $this.ToString($null, $null)
}
```

The following code shows the updated definition for **Temperature**:

```powershell
class Temperature : System.IFormattable {
    [float]            $Degrees
    [TemperatureScale] $Scale

    Temperature() {}
    Temperature([float] $Degrees)          { $this.Degrees = $Degrees }
    Temperature([TemperatureScale] $Scale) { $this.Scale = $Scale }
    Temperature([float] $Degrees, [TemperatureScale] $Scale) {
        $this.Degrees = $Degrees
        $this.Scale = $Scale
    }

    [float] ToKelvin() {
        switch ($this.Scale) {
            Celsius { return $this.Degrees + 273.15 }
            Fahrenheit { return ($this.Degrees + 459.67) * 5 / 9 }
        }
        return $this.Degrees
    }
    [float] ToCelsius() {
        switch ($this.Scale) {
            Fahrenheit { return ($this.Degrees - 32) * 5 / 9 }
            Kelvin { return $this.Degrees - 273.15 }
        }
        return $this.Degrees
    }
    [float] ToFahrenheit() {
        switch ($this.Scale) {
            Celsius { return $this.Degrees * 9 / 5 + 32 }
            Kelvin { return $this.Degrees * 9 / 5 - 459.67 }
        }
        return $this.Degrees
    }

    [string] ToString(
        [string]$Format,
        [System.IFormatProvider]$FormatProvider
    ) {
        # If format isn't specified, use the defined scale.
        if ([string]::IsNullOrEmpty($Format)) {
            $Format = switch ($this.Scale) {
                Celsius    { 'C' }
                Fahrenheit { 'F' }
                Kelvin     { 'K' }
            }
        }
        # If format provider isn't specified, use the current culture.
        if ($null -eq $FormatProvider) {
            $FormatProvider = [CultureInfo]::CurrentCulture
        }
        # Format the temperature.
        switch ($Format) {
            'C' {
                return $this.ToCelsius().ToString('F2', $FormatProvider) + '°C'
            }
            'F' {
                return $this.ToFahrenheit().ToString('F2', $FormatProvider) + '°F'
            }
            'K' {
                return $this.ToKelvin().ToString('F2', $FormatProvider) + '°K'
            }
        }
        # If we get here, the format is invalid.
        throw [System.FormatException]::new(
            "Unknown format: '$Format'. Valid Formats are 'C', 'F', and 'K'"
        )
    }

    [string] ToString([string]$Format) {
        return $this.ToString($Format, $null)
    }

    [string] ToString() {
        return $this.ToString($null, $null)
    }
}

enum TemperatureScale {
    Celsius    = 0
    Fahrenheit = 1
    Kelvin     = 2
}
```

The output for the method overloads is shown in the following block.

```powershell
$Temp = [Temperature]::new()
"The temperature is $Temp"
$Temp.ToString()
$Temp.ToString('K')
$Temp.ToString('F', $null)
```

```Output
The temperature is 0.00°C

0.00°C

273.15°K

32.00°F
```

#### Implementing IEquatable

Now that the **Temperature** class can be formatted for readability, users need
be able to check whether two instances of the class are equal. To support this
test, the class needs to implement the **System.IEquatable** interface.

To implement the interface, the class needs to inherit from
**System.IEquatable** and define the `Equals()` instance method. The `Equals()`
method needs to have the following signature:

```powershell
[bool] Equals([object]$Other) {
    # Implementation
}
```

The signature that the interface requires is listed in the
[reference documentation][02].

For **Temperature**, the class should only support comparing two instances of
the class. For any other value or type, including `$null`, it should return
`$false`. When comparing two temperatures, the method should convert both
values to Kelvin, since temperatures can be equivalent even with different
scales.

```powershell
[bool] Equals([object]$Other) {
    # If the other object is null, we can't compare it.
    if ($null -eq $Other) {
        return $false
    }

    # If the other object isn't a temperature, we can't compare it.
    $OtherTemperature = $Other -as [Temperature]
    if ($null -eq $OtherTemperature) {
        return $false
    }

    # Compare the temperatures as Kelvin.
    return $this.ToKelvin() -eq $OtherTemperature.ToKelvin()
}
```

With the interface method implemented, the updated definition for
**Temperature** is:

```powershell
class Temperature : System.IFormattable, System.IEquatable[object] {
    [float]            $Degrees
    [TemperatureScale] $Scale

    Temperature() {}
    Temperature([float] $Degrees)          { $this.Degrees = $Degrees }
    Temperature([TemperatureScale] $Scale) { $this.Scale = $Scale }
    Temperature([float] $Degrees, [TemperatureScale] $Scale) {
        $this.Degrees = $Degrees
        $this.Scale = $Scale
    }

    [float] ToKelvin() {
        switch ($this.Scale) {
            Celsius { return $this.Degrees + 273.15 }
            Fahrenheit { return ($this.Degrees + 459.67) * 5 / 9 }
        }
        return $this.Degrees
    }
    [float] ToCelsius() {
        switch ($this.Scale) {
            Fahrenheit { return ($this.Degrees - 32) * 5 / 9 }
            Kelvin { return $this.Degrees - 273.15 }
        }
        return $this.Degrees
    }
    [float] ToFahrenheit() {
        switch ($this.Scale) {
            Celsius { return $this.Degrees * 9 / 5 + 32 }
            Kelvin { return $this.Degrees * 9 / 5 - 459.67 }
        }
        return $this.Degrees
    }

    [string] ToString(
        [string]$Format,
        [System.IFormatProvider]$FormatProvider
    ) {
        # If format isn't specified, use the defined scale.
        if ([string]::IsNullOrEmpty($Format)) {
            $Format = switch ($this.Scale) {
                Celsius    { 'C' }
                Fahrenheit { 'F' }
                Kelvin     { 'K' }
            }
        }
        # If format provider isn't specified, use the current culture.
        if ($null -eq $FormatProvider) {
            $FormatProvider = [CultureInfo]::CurrentCulture
        }
        # Format the temperature.
        switch ($Format) {
            'C' {
                return $this.ToCelsius().ToString('F2', $FormatProvider) + '°C'
            }
            'F' {
                return $this.ToFahrenheit().ToString('F2', $FormatProvider) + '°F'
            }
            'K' {
                return $this.ToKelvin().ToString('F2', $FormatProvider) + '°K'
            }
        }
        # If we get here, the format is invalid.
        throw [System.FormatException]::new(
            "Unknown format: '$Format'. Valid Formats are 'C', 'F', and 'K'"
        )
    }

    [string] ToString([string]$Format) {
        return $this.ToString($Format, $null)
    }

    [string] ToString() {
        return $this.ToString($null, $null)
    }

    [bool] Equals([object]$Other) {
        # If the other object is null, we can't compare it.
        if ($null -eq $Other) {
            return $false
        }

        # If the other object isn't a temperature, we can't compare it.
        $OtherTemperature = $Other -as [Temperature]
        if ($null -eq $OtherTemperature) {
            return $false
        }

        # Compare the temperatures as Kelvin.
        return $this.ToKelvin() -eq $OtherTemperature.ToKelvin()
    }
}

enum TemperatureScale {
    Celsius    = 0
    Fahrenheit = 1
    Kelvin     = 2
}
```

The following block shows how the updated class behaves:

```powershell
$Celsius    = [Temperature]::new()
$Fahrenheit = [Temperature]::new(32, 'Fahrenheit')
$Kelvin     = [Temperature]::new([TemperatureScale]::Kelvin)

@"
Temperatures are: $Celsius, $Fahrenheit, $Kelvin
`$Celsius.Equals(`$Fahrenheit) = $($Celsius.Equals($Fahrenheit))
`$Celsius -eq `$Fahrenheit     = $($Celsius -eq $Fahrenheit)
`$Celsius -ne `$Kelvin         = $($Celsius -ne $Kelvin)
"@
```

```Output
Temperatures are: 0.00°C, 32.00°F, 0.00°K

$Celsius.Equals($Fahrenheit) = True
$Celsius -eq $Fahrenheit     = True
$Celsius -ne $Kelvin         = True
```

#### Implementing IComparable

The last interface to implement for the **Temperature** class is
**System.IComparable**. When the class implements this interface, users can use
the `-lt`, `-le`, `-gt`, and `-ge` operators to compare instances of the class.

To implement the interface, the class needs to inherit from
**System.IComparable** and define the `Equals()` instance method. The `Equals()`
method needs to have the following signature:

```powershell
[int] CompareTo([Object]$Other) {
    # Implementation
}
```

The signature that the interface requires is listed in the
[reference documentation][03].

For **Temperature**, the class should only support comparing two instances of
the class. Because the underlying type for the **Degrees** property, even when
converted to a different scale, is a floating point number, the method can rely
on the underlying type for the actual comparison.

```powershell
[int] CompareTo([object]$Other) {
    # If the other object's null, consider this instance "greater than" it
    if ($null -eq $Other) {
        return 1
    }
    # If the other object isn't a temperature, we can't compare it.
    $OtherTemperature = $Other -as [Temperature]
    if ($null -eq $OtherTemperature) {
        throw [System.ArgumentException]::new(
            "Object must be of type 'Temperature'."
        )
    }
    # Compare the temperatures as Kelvin.
    return $this.ToKelvin().CompareTo($OtherTemperature.ToKelvin())
}
```

The final definition for the **Temperature** class is:

```powershell
class Temperature : System.IFormattable,
                    System.IComparable,
                    System.IEquatable[object] {
    # Instance properties
    [float]            $Degrees
    [TemperatureScale] $Scale

    # Constructors
    Temperature() {}
    Temperature([float] $Degrees)          { $this.Degrees = $Degrees }
    Temperature([TemperatureScale] $Scale) { $this.Scale = $Scale }
    Temperature([float] $Degrees, [TemperatureScale] $Scale) {
        $this.Degrees = $Degrees
        $this.Scale = $Scale
    }

    [float] ToKelvin() {
        switch ($this.Scale) {
            Celsius { return $this.Degrees + 273.15 }
            Fahrenheit { return ($this.Degrees + 459.67) * 5 / 9 }
        }
        return $this.Degrees
    }
    [float] ToCelsius() {
        switch ($this.Scale) {
            Fahrenheit { return ($this.Degrees - 32) * 5 / 9 }
            Kelvin { return $this.Degrees - 273.15 }
        }
        return $this.Degrees
    }
    [float] ToFahrenheit() {
        switch ($this.Scale) {
            Celsius { return $this.Degrees * 9 / 5 + 32 }
            Kelvin { return $this.Degrees * 9 / 5 - 459.67 }
        }
        return $this.Degrees
    }

    [string] ToString(
        [string]$Format,
        [System.IFormatProvider]$FormatProvider
    ) {
        # If format isn't specified, use the defined scale.
        if ([string]::IsNullOrEmpty($Format)) {
            $Format = switch ($this.Scale) {
                Celsius    { 'C' }
                Fahrenheit { 'F' }
                Kelvin     { 'K' }
            }
        }
        # If format provider isn't specified, use the current culture.
        if ($null -eq $FormatProvider) {
            $FormatProvider = [CultureInfo]::CurrentCulture
        }
        # Format the temperature.
        switch ($Format) {
            'C' {
                return $this.ToCelsius().ToString('F2', $FormatProvider) + '°C'
            }
            'F' {
                return $this.ToFahrenheit().ToString('F2', $FormatProvider) + '°F'
            }
            'K' {
                return $this.ToKelvin().ToString('F2', $FormatProvider) + '°K'
            }
        }
        # If we get here, the format is invalid.
        throw [System.FormatException]::new(
            "Unknown format: '$Format'. Valid Formats are 'C', 'F', and 'K'"
        )
    }

    [string] ToString([string]$Format) {
        return $this.ToString($Format, $null)
    }

    [string] ToString() {
        return $this.ToString($null, $null)
    }

    [bool] Equals([object]$Other) {
        # If the other object is null, we can't compare it.
        if ($null -eq $Other) {
            return $false
        }
        # If the other object isn't a temperature, we can't compare it.
        $OtherTemperature = $Other -as [Temperature]
        if ($null -eq $OtherTemperature) {
            return $false
        }
        # Compare the temperatures as Kelvin.
        return $this.ToKelvin() -eq $OtherTemperature.ToKelvin()
    }
    [int] CompareTo([object]$Other) {
        # If the other object's null, consider this instance "greater than" it
        if ($null -eq $Other) {
            return 1
        }
        # If the other object isn't a temperature, we can't compare it.
        $OtherTemperature = $Other -as [Temperature]
        if ($null -eq $OtherTemperature) {
            throw [System.ArgumentException]::new(
                "Object must be of type 'Temperature'."
            )
        }
        # Compare the temperatures as Kelvin.
        return $this.ToKelvin().CompareTo($OtherTemperature.ToKelvin())
    }
}

enum TemperatureScale {
    Celsius    = 0
    Fahrenheit = 1
    Kelvin     = 2
}
```

With the full definition, users can format and compare instances of the class
in PowerShell like any builtin type.

```powershell
$Celsius    = [Temperature]::new()
$Fahrenheit = [Temperature]::new(32, 'Fahrenheit')
$Kelvin     = [Temperature]::new([TemperatureScale]::Kelvin)

@"
Temperatures are: $Celsius, $Fahrenheit, $Kelvin
`$Celsius.Equals(`$Fahrenheit)    = $($Celsius.Equals($Fahrenheit))
`$Celsius.Equals(`$Kelvin)        = $($Celsius.Equals($Kelvin))
`$Celsius.CompareTo(`$Fahrenheit) = $($Celsius.CompareTo($Fahrenheit))
`$Celsius.CompareTo(`$Kelvin)     = $($Celsius.CompareTo($Kelvin))
`$Celsius -lt `$Fahrenheit        = $($Celsius -lt $Fahrenheit)
`$Celsius -le `$Fahrenheit        = $($Celsius -le $Fahrenheit)
`$Celsius -eq `$Fahrenheit        = $($Celsius -eq $Fahrenheit)
`$Celsius -gt `$Kelvin            = $($Celsius -gt $Kelvin)
"@
```

```Output
Temperatures are: 0.00°C, 32.00°F, 0.00°K
$Celsius.Equals($Fahrenheit)    = True
$Celsius.Equals($Kelvin)        = False
$Celsius.CompareTo($Fahrenheit) = 0
$Celsius.CompareTo($Kelvin)     = 1
$Celsius -lt $Fahrenheit        = False
$Celsius -le $Fahrenheit        = True
$Celsius -eq $Fahrenheit        = True
$Celsius -gt $Kelvin            = True
```

### Example 3 - Inheriting from a generic base class

This example shows how you can derive from a generic class like
**System.Collections.Generic.List**.

#### Using a built-in class as the type parameter

Run the following code block. It shows how a new class can inherit from a
generic type as long as the type parameter is already defined at parse time.

```powershell
class ExampleStringList : System.Collections.Generic.List[string] {}

$List = [ExampleStringList]::New()
$List.AddRange([string[]]@('a','b','c'))
$List.GetType() | Format-List -Property Name, BaseType
$List
```

```Output
Name     : ExampleStringList
BaseType : System.Collections.Generic.List`1[System.String]

a
b
c
```

#### Using a custom class as the type parameter

The next code block first defines a new class, **ExampleItem**,
with a single instance property and the `ToString()` method. Then it defines
the **ExampleItemList** class inheriting from the
**System.Collections.Generic.List** base class with **ExampleItem** as the type
parameter.

Copy the entire code block and run it as a single statement.

```powershell
class ExampleItem {
    [string] $Name
    [string] ToString() { return $this.Name }
}
class ExampleItemList : System.Collections.Generic.List[ExampleItem] {}
```

```Output
ParentContainsErrorRecordException: An error occurred while creating the pipeline.
```

Running the entire code block raises an error because PowerShell hasn't loaded
the **ExampleItem** class into the runtime yet. You can't use class name as the
type parameter for the **System.Collections.Generic.List** base class yet.

Run the following code blocks in the order they're defined.

```powershell
class ExampleItem {
    [string] $Name
    [string] ToString() { return $this.Name }
}
```

```powershell
class ExampleItemList : System.Collections.Generic.List[ExampleItem] {}
```

This time, PowerShell doesn't raise any errors. Both classes are now defined.
Run the following code block to view the behavior of the new class.

```powershell
$List = [ExampleItemList]::New()
$List.AddRange([ExampleItem[]]@(
    [ExampleItem]@{ Name = 'Foo' }
    [ExampleItem]@{ Name = 'Bar' }
    [ExampleItem]@{ Name = 'Baz' }
))
$List.GetType() | Format-List -Property Name, BaseType
$List
```

```output
Name     : ExampleItemList
BaseType : System.Collections.Generic.List`1[ExampleItem]

Name
----
Foo
Bar
Baz
```

#### Deriving a generic with a custom type parameter in a module

The following code blocks show how you can define a class that inherits from a
generic base class that uses a custom type for the type parameter.

Save the following code block as `GenericExample.psd1`.

```powershell
@{
    RootModule        = 'GenericExample.psm1'
    ModuleVersion     = '0.1.0'
    GUID              = '2779fa60-0b3b-4236-b592-9060c0661ac2'
}
```

Save the following code block as `GenericExample.InventoryItem.psm1`.

```powershell
class InventoryItem {
    [string] $Name
    [int]    $Count

    InventoryItem() {}
    InventoryItem([string]$Name) {
        $this.Name = $Name
    }
    InventoryItem([string]$Name, [int]$Count) {
        $this.Name  = $Name
        $this.Count = $Count
    }

    [string] ToString() {
        return "$($this.Name) ($($this.Count))"
    }
}
```

Save the following code block as `GenericExample.psm1`.

```powershell
using namespace System.Collections.Generic
using module ./GenericExample.InventoryItem.psm1

class Inventory : List[InventoryItem] {}

# Define the types to export with type accelerators.
$ExportableTypes =@(
    [InventoryItem]
    [Inventory]
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

> [!TIP]
> The root module adds the custom types to PowerShell's type accelerators. This
> pattern enables module users to immediately access IntelliSense and
> autocomplete for the custom types without needing to use the `using module`
> statement first.
>
> For more information about this pattern, see the "Exporting with type
> accelerators" section of [about_Classes][04].

Import the module and verify the output.

```powershell
Import-Module ./GenericExample.psd1

$Inventory = [Inventory]::new()
$Inventory.GetType() | Format-List -Property Name, BaseType

$Inventory.Add([InventoryItem]::new('Bucket', 2))
$Inventory.Add([InventoryItem]::new('Mop'))
$Inventory.Add([InventoryItem]@{ Name = 'Broom' ; Count = 4 })
$Inventory
```

```Output
Name     : Inventory
BaseType : System.Collections.Generic.List`1[InventoryItem]

Name   Count
----   -----
Bucket     2
Mop        0
Broom      4
```

The module loads without errors because the **InventoryItem** class is defined
in a different module file than the **Inventory** class. Both classes are
available to module users.

## Inheriting a base class

When a class inherits from a base class, it inherits the properties and methods
of the base class. It doesn't inherit the base class constructors directly,
but it can call them.

When the base class is defined in .NET rather than PowerShell, note that:

- PowerShell classes can't inherit from sealed classes.
- When inheriting from a generic base class, the type parameter for the generic
  class can't be the derived class. Using the derived class as the type
  parameter raises a parse error.

To see how inheritance and overriding works for derived classes, see
[Example 1][05].

### Derived class constructors

Derived classes don't directly inherit the constructors of the base class. If
the base class defines a default constructor and the derived class doesn't
define any constructors, new instances of the derived class use the base class
default constructor. If the base class doesn't define a default constructor,
derived class must explicitly define at least one constructor.

Derived class constructors can invoke a constructor from the base class with
the `base` keyword. If the derived class doesn't explicitly invoke a
constructor from the base class, it invokes the default constructor for the
base class instead.

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

The **Illustration** class in [Example 1][05] shows how a derived class can use
the base class constructors.

### Derived class methods

When a class derives from a base class, it inherits the methods of the base
class and their overloads. Any method overloads defined on the base class,
including hidden methods, are available on the derived class.

A derived class can override an inherited method overload by redefining it in
the class definition. To override the overload, the parameter types must be the
same as for the base class. The output type for the overload can be different.

Unlike constructors, methods can't use the `: base(<parameters>)` syntax to
invoke a base class overload for the method. The redefined overload on the
derived class completely replaces the overload defined by the base class. To
call the base class method for an instance, cast the instance variable
(`$this`) to the base class before calling the method.

The following snippet shows how a derived class can call the base class method.

```powershell
class BaseClass {
    [bool] IsTrue() { return $true }
}
class DerivedClass : BaseClass {
    [bool] IsTrue()     { return $false }
    [bool] BaseIsTrue() { return ([BaseClass]$this).IsTrue() }
}

@"
[BaseClass]::new().IsTrue()        = $([BaseClass]::new().IsTrue())
[DerivedClass]::new().IsTrue()     = $([DerivedClass]::new().IsTrue())
[DerivedClass]::new().BaseIsTrue() = $([DerivedClass]::new().BaseIsTrue())
"@
```

```Output
[BaseClass]::new().IsTrue()        = True
[DerivedClass]::new().IsTrue()     = False
[DerivedClass]::new().BaseIsTrue() = True
```

For an extended sample showing how a derived class can override inherited
methods, see the **Illustration** class in
[Example 1][05].

### Derived class properties

When a class derives from a base class, it inherits the properties of the base
class. Any properties defined on the base class, including hidden properties,
are available on the derived class.

A derived class can override an inherited property by redefining it in the
class definition. The property on the derived class uses the redefined type and
default value, if any. If the inherited property defined a default value and
the redefined property doesn't, the inherited property has no default value.

If a derived class doesn't override a static property, accessing the static
property through the derived class accesses the static property of the base
class. Modifying the property value through the derived class modifies the
value on the base class. Any other derived class that doesn't override the
static property also uses the value of the property on the base class. Updating
the value of an inherited static property in a class that doesn't override the
property might have unintended effects for classes derived from the same base
class.

[Example 1][05] shows how
derived classes that inherit, extend, and override the base class properties.

### Deriving from generics

When a class derives from a generic, the type parameter must already be defined
before PowerShell parses the derived class. If the type parameter for the
generic is a PowerShell class or enumeration defined in the same file or
code block, PowerShell raises an error.

To derive a class from a generic base class with a custom type as the type
parameter, define the class or enumeration for the type parameter in a
different file or module and use the `using module` statement to load the type
definition.

For an example showing how to inherit from a generic base class, see
[Example 3][06].

### Useful classes to inherit

There are a few classes that can be useful to inherit when authoring PowerShell
modules. This section lists a few base classes and what a class derived from
them can be used for.

- **System.Attribute** - Derive classes to define attributes that can be used
  for variables, parameters, class and enumeration definitions, and more.
- **System.Management.Automation.ArgumentTransformationAttribute** - Derive
  classes to handle converting input for a variable or parameter into a
  specific data type.
- **System.Management.Automation.ValidateArgumentsAttribute** - Derive classes
  to apply custom validation to variables, parameters, and class properties.
- **System.Collections.Generic.List** - Derive classes to make creating and
  managing lists of a specific data type easier.
- **System.Exception** - Derive classes to define custom errors.

## Implementing interfaces

A PowerShell class that implements an interface must implement all the members
of that interface. Omitting the implementation interface members causes a
parse-time error in the script.

> [!NOTE]
> PowerShell doesn't support declaring new interfaces in PowerShell script.
> Instead, interfaces must be declared in .NET code and added to the session
> with the `Add-Type` cmdlet or the `using assembly` statement.

When a class implements an interface, it can be used like any other class that
implements that interface. Some commands and operations limit their supported
types to classes that implement a specific interface.

To review a sample implementation of interfaces, see [Example 2][07].

### Useful interfaces to implement

There are a few interface classes that can be useful to inherit when authoring
PowerShell modules. This section lists a few base classes and what a class
derived from them can be used for.

- **System.IEquatable** - This interface enables users to compare two instances
  of the class. When a class doesn't implement this interface, PowerShell
  checks for equivalency between two instances using reference equality. In
  other words, an instance of the class only equals itself, even if the
  property values on two instances are the same.
- **System.IComparable** - This interface enables users to compare instances of
  the class with the `-le`, `-lt`, `-ge`, and `-gt` comparison operators. When
  a class doesn't implement this interface, those operators raise an error.
- **System.IFormattable** - This interface enables users to format instances of
  the class into different strings. This is useful for classes that have more
  than one standard string representation, like budget items, bibliographies,
  and temperatures.
- **System.IConvertible** - This interface enables users to convert instances
  of the class to other runtime types. This is useful for classes that have an
  underlying numerical value or can be converted to one.

## Limitations

- PowerShell doesn't support defining interfaces in script code.

  Workaround: Define interfaces in C# and reference the assembly that defines
  the interfaces.
- PowerShell classes can only inherit from one base class.

  Workaround: Class inheritance is transitive. A derived class can inherit from
  another derived class to get the properties and methods of a base class.
- When inheriting from a generic class or interface, the type parameter for the
  generic must already be defined. A class can't define itself as the type
  parameter for a class or interface.

  Workaround: To derive from a generic base class or interface, define the
  custom type in a different `.psm1` file and use the `using module` statement
  to load the type. There's no workaround for a custom type to use itself as
  the type parameter when inheriting from a generic.

## See Also

- [about_Classes][08]
- [about_Classes_Constructors][09]
- [about_Classes_Methods][10]
- [about_Classes_Properties][11]

<!-- Link reference definitions -->
[01]: /dotnet/api/system.iformattable#methods
[02]: /dotnet/api/system.iequatable-1#methods
[03]: /dotnet/api/system.icomparable#methods
[04]: about_Classes.md#exporting-classes-with-type-accelerators
[05]: #example-1---inheriting-and-overriding-from-a-base-class
[06]: #example-3---inheriting-from-a-generic-base-class
[07]: #example-2---implementing-interfaces
[08]: about_Classes.md
[09]: about_Classes_Constructors.md
[10]: about_Classes_Inheritance.md
[11]: about_Classes_Properties.md
