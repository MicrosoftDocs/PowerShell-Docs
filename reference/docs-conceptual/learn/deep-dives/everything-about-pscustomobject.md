---
description: PSCustomObject is a simple way to create structured data.
ms.custom: contributor-KevinMarquette
ms.date: 06/20/2024
title: Everything you wanted to know about PSCustomObject
---
# Everything you wanted to know about PSCustomObject

`PSCustomObject` is a great tool to add into your PowerShell tool belt. Let's start with the basics
and work our way into the more advanced features. The idea behind using a `PSCustomObject` is to
have a simple way to create structured data. Take a look at the first example and you'll have a
better idea of what that means.

> [!NOTE]
> The [original version][10] of this article appeared on the blog written by
> [@KevinMarquette][13]. The PowerShell team thanks Kevin for sharing this content with
> us. Please check out his blog at [PowerShellExplained.com][09].

## Creating a PSCustomObject

I love using `[pscustomobject]` in PowerShell. Creating a usable object has never been easier.
Because of that, I'm going to skip over all the other ways you can create an object but I need
to mention that most of these examples are PowerShell v3.0 and newer.

```powershell
$myObject = [pscustomobject]@{
    Name     = 'Kevin'
    Language = 'PowerShell'
    State    = 'Texas'
}
```

This method works well for me because I use hashtables for just about everything. But there are
times when I would like PowerShell to treat hashtables more like an object. The first place you
notice the difference is when you want to use `Format-Table` or `Export-Csv` and you realize that a
hashtable is just a collection of key/value pairs.

You can then access and use the values like you would a normal object.

```powershell
$myObject.Name
```

### Converting a hashtable

While I am on the topic, did you know you could do this:

```powershell
$myHashtable = @{
    Name     = 'Kevin'
    Language = 'PowerShell'
    State    = 'Texas'
}
$myObject = [pscustomobject]$myHashtable
```

I do prefer to create the object from the start but there are times you have to work with a
hashtable first. This example works because the constructor takes a hashtable for the object
properties. One important note is that while this method works, it isn't an exact equivalent. The
biggest difference is that the order of the properties isn't preserved.

If you want to preserve the order, see
[Ordered hashtables][05].

### Legacy approach

You may have seen people use `New-Object` to create custom objects.

```powershell
$myHashtable = @{
    Name     = 'Kevin'
    Language = 'PowerShell'
    State    = 'Texas'
}

$myObject = New-Object -TypeName psobject -Property $myHashtable
```

This way is quite a bit slower but it may be your best option on early versions of PowerShell.

### Saving to a file

I find the best way to save a hashtable to a file is to save it as JSON. You can import it back into
a `[pscustomobject]`

```powershell
$myObject | ConvertTo-Json -Depth 1 | Set-Content -Path $Path
$myObject = Get-Content -Path $Path | ConvertFrom-Json
```

I cover more ways to save objects to a file in my article on
[The many ways to read and write to files][11].

## Working with properties

### Adding properties

You can still add new properties to your `PSCustomObject` with `Add-Member`.

```powershell
$myObject | Add-Member -MemberType NoteProperty -Name 'ID' -Value 'KevinMarquette'

$myObject.ID
```

### Remove properties

You can also remove properties off of an object.

```powershell
$myObject.psobject.Properties.Remove('ID')
```

The `.psobject` is an intrinsic member that gives you access to base object metadata. For more
information about intrinsic members, see
[about_Intrinsic_Members][03].

### Enumerating property names

Sometimes you need a list of all the property names on an object.

```powershell
$myObject | Get-Member -MemberType NoteProperty | select -ExpandProperty Name
```

We can get this same list off of the `psobject` property too.

```powershell
$myobject.psobject.Properties.Name
```

> [!NOTE]
> `Get-Member` returns the properties in alphabetical order. Using the member-access operator to
> enumerate the property names returns the properties in the order they were defined on the object.

### Dynamically accessing properties

I already mentioned that you can access property values directly.

```powershell
$myObject.Name
```

You can use a string for the property name and it will still work.

```powershell
$myObject.'Name'
```

We can take this one more step and use a variable for the property name.

```powershell
$property = 'Name'
$myObject.$property
```

I know that looks strange, but it works.

### Convert PSCustomObject into a hashtable

To continue on from the last section, you can dynamically walk the properties and create a hashtable
from them.

```powershell
$hashtable = @{}
foreach( $property in $myobject.psobject.Properties.Name )
{
    $hashtable[$property] = $myObject.$property
}
```

### Testing for properties

If you need to know if a property exists, you could just check for that property to have a value.

```powershell
if( $null -ne $myObject.ID )
```

But if the value could be `$null` you can check to see if it exists by checking the
`psobject.Properties` for it.

```powershell
if( $myobject.psobject.Properties.Match('ID').Count )
```

## Adding object methods

If you need to add a script method to an object, you can do it with `Add-Member` and a
`ScriptBlock`. You have to use the `this` automatic variable reference the current object. Here is a
`scriptblock` to turn an object into a hashtable. (same code form the last example)

```powershell
$ScriptBlock = {
    $hashtable = @{}
    foreach( $property in $this.psobject.Properties.Name )
    {
        $hashtable[$property] = $this.$property
    }
    return $hashtable
}
```

Then we add it to our object as a script property.

```powershell
$memberParam = @{
    MemberType = "ScriptMethod"
    InputObject = $myobject
    Name = "ToHashtable"
    Value = $scriptBlock
}
Add-Member @memberParam
```

Then we can call our function like this:

```powershell
$myObject.ToHashtable()
```

### Objects vs Value types

Objects and value types don't handle variable assignments the same way. If you assign value types to
each other, only the value get copied to the new variable.

```powershell
$first = 1
$second = $first
$second = 2
```

In this case, `$first` is 1 and `$second` is 2.

Object variables hold a reference to the actual object. When you assign one object to a new
variable, they still reference the same object.

```powershell
$third = [pscustomobject]@{Key=3}
$fourth = $third
$fourth.Key = 4
```

Because `$third` and `$fourth` reference the same instance of an object, both `$third.key` and
`$fourth.Key` are 4.

### psobject.Copy()

If you need a true copy of an object, you can clone it.

```powershell
$third = [pscustomobject]@{Key=3}
$fourth = $third.psobject.Copy()
$fourth.Key = 4
```

Clone creates a shallow copy of the object. They have different instances now and `$third.key` is 3
and `$fourth.Key` is 4 in this example.

I call this a shallow copy because if you have nested objects (objects with properties contain other
objects), only the top-level values are copied. The child objects will reference each other.

### PSTypeName for custom object types

Now that we have an object, there are a few more things we can do with it that may not be nearly as
obvious. First thing we need to do is give it a `PSTypeName`. This is the most common way I see
people do it:

```powershell
$myObject.psobject.TypeNames.Insert(0,"My.Object")
```

I recently discovered another way to do this from Redditor `u/markekraus`. He talks about this
approach that allows you to define it inline.

```powershell
$myObject = [pscustomobject]@{
    PSTypeName = 'My.Object'
    Name       = 'Kevin'
    Language   = 'PowerShell'
    State      = 'Texas'
}
```

I love how nicely this just fits into the language. Now that we have an object with a proper type
name, we can do some more things.

> [!NOTE]
> You can also create custom PowerShell types using PowerShell classes. For more information, see
> [PowerShell Class Overview][01].

## Using DefaultPropertySet (the long way)

PowerShell decides for us what properties to display by default. A lot of the native commands have a
`.ps1xml` [formatting file][08] that does all the heavy lifting. From this
[post by Boe Prox][07], there's another way for us to do this on our custom object
using just PowerShell. We can give it a `MemberSet` for it to use.

```powershell
$defaultDisplaySet = 'Name','Language'
$defaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet('DefaultDisplayPropertySet',[string[]]$defaultDisplaySet)
$PSStandardMembers = [System.Management.Automation.PSMemberInfo[]]@($defaultDisplayPropertySet)
$MyObject | Add-Member MemberSet PSStandardMembers $PSStandardMembers
```

Now when my object just falls to the shell, it will only show those properties by default.

### Update-TypeData with DefaultPropertySet

This is nice but I recently saw a better way using [Update-TypeData][04] to specify
the default properties.

```powershell
$TypeData = @{
    TypeName = 'My.Object'
    DefaultDisplayPropertySet = 'Name','Language'
}
Update-TypeData @TypeData
```

That is simple enough that I could almost remember it if I didn't have this post as a quick
reference. Now I can easily create objects with lots of properties and still give it a nice clean
view when looking at it from the shell. If I need to access or see those other properties, they're
still there.

```powershell
$myObject | Format-List *
```

### Update-TypeData with ScriptProperty

Something else I got out of that video was creating script properties for your objects. This
would be a good time to point out that this works for existing objects too.

```powershell
$TypeData = @{
    TypeName = 'My.Object'
    MemberType = 'ScriptProperty'
    MemberName = 'UpperCaseName'
    Value = {$this.Name.ToUpper()}
}
Update-TypeData @TypeData
```

You can do this before your object is created or after and it will still work. This is what makes
this different than using `Add-Member` with a script property. When you use `Add-Member` the way I
referenced earlier, it only exists on that specific instance of the object. This one applies to all
objects with this `TypeName`.

## Function parameters

You can now use these custom types for parameters in your functions and scripts. You can have one
function create these custom objects and then pass them into other functions.

```powershell
param( [PSTypeName('My.Object')]$Data )
```

PowerShell requires that the object is the type you specified. It throws a validation error if
the type doesn't match automatically to save you the step of testing for it in your code. A great
example of letting PowerShell do what it does best.

### Function OutputType

You can also define an `OutputType` for your advanced functions.

```powershell
function Get-MyObject
{
    [OutputType('My.Object')]
    [CmdletBinding()]
        param
        (
            ...
```

The **OutputType** attribute value is only a documentation note. It isn't derived from the function
code or compared to the actual function output.

The main reason you would use an output type is so that meta information about your function
reflects your intentions. Things like `Get-Command` and `Get-Help` that your development environment
can take advantage of. If you want more information, then take a look at the help for it:
[about_Functions_OutputTypeAttribute][02].

With that said, if you're using Pester to unit test your functions then it would be a good idea
to validate the output objects match your **OutputType**. This could catch variables that just fall
to the pipe when they shouldn't.

## Closing thoughts

The context of this was all about `[pscustomobject]`, but a lot of this information applies to
objects in general.

I have seen most of these features in passing before but never saw them presented as a collection of
information on `PSCustomObject`. Just this last week I stumbled upon another one and was surprised
that I had not seen it before. I wanted to pull all these ideas together so you can hopefully see
the bigger picture and be aware of them when you have an opportunity to use them. I hope you learned
something and can find a way to work this into your scripts.

<!-- link references -->
[01]: /powershell/module/Microsoft.PowerShell.Core/About/about_Classes
[02]: /powershell/module/microsoft.powershell.core/about/about_functions_outputtypeattribute
[03]: /powershell/module/microsoft.powershell.core/about/about_intrinsic_members
[04]: /powershell/module/microsoft.powershell.utility/update-typedata
[05]: everything-about-hashtable.md#ordered-hashtables
[07]: https://learn-PowerShell.net/2013/08/03/quick-hits-set-the-default-property-display-in-PowerShell-on-custom-objects/
[08]: https://mcpmag.com/articles/2014/05/13/PowerShell-properties-part-3.aspx
[09]: https://powershellexplained.com/
[10]: https://powershellexplained.com/2016-10-28-powershell-everything-you-wanted-to-know-about-pscustomobject/
[11]: https://powershellexplained.com/2017-03-18-Powershell-reading-and-saving-data-to-files
[13]: https://twitter.com/KevinMarquette
