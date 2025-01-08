---
description: A variable represents a storage location for a value, and that value has a type.
ms.date: 05/19/2021
title: Variables
---
# 5. Variables

[!INCLUDE [Disclaimer](../../includes/language-spec.md)]

A variable represents a storage location for a value, and that value has a type. Traditional
procedural programming languages are statically typed; that is, the runtime type of a variable is
that with which it was declared at compile time. Object-oriented languages add the idea of
inheritance, which allows the runtime type of a variable to be that with which it was declared at
compile time or some type derived from that type. Being a dynamically typed language, PowerShell's
variables do not have types, per se. In fact, variables are not defined; they simply come into being
when they are first assigned a value. And while a variable may be constrained ([§5.3][§5.3]) to holding
a value of a given type, type information in an assignment cannot always be verified statically.

At different times, a variable may be associated with values of different types either through
assignment ([§7.11][§7.11]) or the use of the `++` and `‑‑` operators ([§7.1.5][§7.1.5], [§7.2.6][§7.2.6]). When the
value associated with a variable is changed, that value's type may change. For example,

```powershell
$i = "abc"        # $i holds a value of type string
$i = 2147483647   # $i holds a value of type int
++$i              # $i now holds a value of type double because
                  # 2147483648 is too big to fit in type int
```

Any use of a variable that has not been created results in the value $null. To see if a variable has
been defined, use the [Test-Path](xref:Microsoft.PowerShell.Management.Test-Path) cmdlet.

## 5.1 Writable location

A *writable location* is an expression that designates a resource to which a command has both read
and write access. A writable location may be a variable ([§5][§5]), an array element ([§9][§9]), an associated
value in a Hashtable accessed via a subscript ([§10][§10]), a property ([§7.1.2][§7.1.2]), or storage managed by
a provider ([§3.1][§3.1]).

## 5.2 Variable categories

PowerShell defines the following categories of variables: static variables, instance variables,
array elements, Hashtable key/value pairs, parameters, ordinary variables, and variables on provider
drives. The subsections that follow describe each of these categories.

In the following example

```powershell
function F ($p1, $p2) {
    $radius = 2.45
    $circumference = 2 * ([Math]::PI) * $radius

    $date = Get-Date -Date "2010-2-1 10:12:14 pm"
    $month = $date.Month

    $values = 10, 55, 93, 102
    $value = $values[2]

    $h1 = @{ FirstName = "James"; LastName = "Anderson" }
    $h1.FirstName = "Smith"

    $Alias:A = "Help"
    $Env:MyPath = "e:\Temp"
    ${E:output.txt} = 123
    $function:F = { "Hello there" }
    $Variable:v = 10
}
```

- `[Math::PI]` is a static variable
- `$date.Month` is an instance variable
- `$values[2]` is an array element
- `$h1.FirstName` is a `Hashtable` key whose corresponding value is $h1['FirstName']`
- `$p1` and `$p2` are parameters
- `$radius`, `$circumference`, `$date`, `$month`, `$values`, `$value`, and `$h1` are ordinary
  variables
- `$Alias:A`, `$Env:MyPath`, `${E:output.txt}`, and `$function:F` are variables on the corresponding
  provider drives.
- `$Variable:v` is actually an ordinary variable written with its fully qualified provider drive.

### 5.2.1 Static variables

A data member of an object that belongs to the object's type rather than to that particular instance
of the type is called a *static variable*. See [§4.2.3][§4.2.3], [§4.2.4.1][§4.2.4.1], and [§4.3.8][§4.3.8] for some
examples.

PowerShell provides no way to create new types that contain static variables; however, objects of
such types may be provided by the host environment.

Memory for creating and deleting objects containing static variables is managed by the host
environment and the garbage collection system.

See [§7.1.2][§7.1.2] for information about accessing a static variable.

A static data member can be a field or a property.

### 5.2.2 Instance variables

A data member of an object that belongs to a particular instance of the object's type rather than to
the type itself is called an *instance variable*. See [§4.3.1][§4.3.1], [§4.3.2][§4.3.2], and [§4.3.3][§4.3.3] for
some examples.

A PowerShell host environment might provide a way to create new types that contain instance
variables or to add new instance variables to existing types.

Memory for creating and deleting objects containing static variables is managed by the host
environment and the garbage collection system.

See [§7.1.2][§7.1.2] for information about accessing an instance variable.

An instance data member can be a field or a property.

### 5.2.3 Array elements

An array can be created via a unary comma operator ([§7.2.1][§7.2.1]), *sub-expression* ([§7.1.6][§7.1.6]),
*array-expression* ([§7.1.7][§7.1.7]), binary comma operator ([§7.3][§7.3]), range operator ([§7.4][§7.4]), or
[New-Object](xref:Microsoft.PowerShell.Utility.New-Object) cmdlet.

Memory for creating and deleting arrays is managed by the host environment and the garbage
collection system.

Arrays and array elements are discussed in [§9][§9].

### 5.2.4 Hashtable key/value pairs

A Hashtable is created via a hash literal ([§2.3.5.6][§2.3.5.6]) or the
[New-Object](xref:Microsoft.PowerShell.Utility.New-Object) cmdlet. A new key/value pair can be added
via the `[]` operator ([§7.1.4.3][§7.1.4.3]).

Memory for creating and deleting Hashtables is managed by the host environment and the garbage
collection system.

Hashtables are discussed in [§10][§10].

### 5.2.5 Parameters

A parameter is created when its parent command is invoked, and it is initialized with the value of
the argument provided in the invocation or by the host environment. A parameter ceases to exist when
its parent command terminates.

Parameters are discussed in [§8.10][§8.10].

### 5.2.6 Ordinary variables

An *ordinary variable* is defined by an *assignment-expression* ([§7.11][§7.11]) or a *foreach-statement*
([§8.4.4][§8.4.4]). Some ordinary variables are predefined by the host environment while others are
transient, coming and going as needed at runtime.

The lifetime of an ordinary variable is that part of program execution during which storage is
guaranteed to be reserved for it. This lifetime begins at entry into the scope with which it is
associated, and ends no sooner than the end of the execution of that scope. If the parent scope is
entered recursively or iteratively, a new instance of the local variable is created each time.

The storage referred to by an ordinary variable is reclaimed independently of the lifetime of that
variable.

An ordinary variable can be named explicitly with a **Variable:** namespace prefix ([§5.2.7][§5.2.7]).

### 5.2.7 Variables on provider drives

The concept of providers and drives is introduced in [§3.1][§3.1], with each provider being able to
provide its own namespace drive(s). This allows resources on those drives to be accessed as though
they were ordinary variables ([§5.2.6][§5.2.6]). In fact, an ordinary variable is stored on the file
system provider drive Variable: ([§3.1.5][§3.1.5]) and can be accessed by its ordinary name or its fully
qualified namespace name.

Some namespace variable types are constrained implicitly ([§5.3][§5.3]).

## 5.3 Constrained variables

By default, a variable may designate a value of any type. However, a variable may be *constrained*
to designating values of a given type by specifying that type as a type literal before its name in
an assignment or a parameter. For example,

```powershell
[int]$i = 10   # constrains $i to designating ints only
$i = "Hello"   # error, no conversion to int
$i = "0x10"    # ok, conversion to int
$i = $true     # ok, conversion to int

function F ([int]$p1, [switch]$p2, [regex]$p3) { ... }
```

Any variable belonging to the namespace **Env:**, **Alias:**, or to the file system namespace
([§2.3.2][§2.3.2], [§3.1][§3.1]) is constrained implicitly to the type `string`. Any variable belonging to the
namespace **Function:** ([§2.3.2][§2.3.2], [§3.1][§3.1]) is constrained implicitly to the type `scriptblock`.

<!-- reference links -->
[§2.3.2]: chapter-02.md#232-variables
[§2.3.5.6]: chapter-02.md#2356-hash-literals
[§3.1.5]: chapter-03.md#315-variables
[§3.1]: chapter-03.md#31-providers-and-drives
[§4.2.3]: chapter-04.md#423-integer
[§4.2.4.1]: chapter-04.md#4241-float-and-double
[§4.3.1]: chapter-04.md#431-strings
[§4.3.2]: chapter-04.md#432-arrays
[§4.3.3]: chapter-04.md#433-hashtables
[§4.3.8]: chapter-04.md#438-the-math-type
[§5]: chapter-05.md#5-variables
[§5.2.6]: chapter-05.md#526-ordinary-variables
[§5.2.7]: chapter-05.md#527-variables-on-provider-drives
[§5.3]: chapter-05.md#53-constrained-variables
[§7.1.2]: chapter-07.md#712-member-access
[§7.1.4.3]: chapter-07.md#7143-subscripting-a-hashtable
[§7.1.5]: chapter-07.md#715-postfix-increment-and-decrement-operators
[§7.1.6]: chapter-07.md#716--operator
[§7.1.7]: chapter-07.md#717--operator
[§7.11]: chapter-07.md#711-assignment-operators
[§7.2.1]: chapter-07.md#721-unary-comma-operator
[§7.2.6]: chapter-07.md#726-prefix-increment-and-decrement-operators
[§7.3]: chapter-07.md#73-binary-comma-operator
[§7.4]: chapter-07.md#74-range-operator
[§8.10]: chapter-08.md#810-function-definitions
[§8.4.4]: chapter-08.md#844-the-foreach-statement
[§9]: chapter-09.md#9-arrays
[§10]: chapter-10.md#10-hashtables
