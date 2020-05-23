---
layout: post
title: "Powershell: Everything you wanted to know about hashtables"
date: 2016-11-06
tags: [PowerShell,Hashtables,Everything]
share-img: "/img/share-img/2016-11-06-powershell-hashtable-everything-you-wanted-to-know-about.png"
---

I want to take a step back and talk about [hashtables](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_hash_tables). I use these all the time now. I was teaching someone about them after our user group meeting last night and I realized I had the same confusion about them at first that he had. Hashtables are really important in Powershell so it is good to have a solid understanding of them.<!--more-->

# Index

* TOC
{:toc}

# Hashtable as a collection of things
I want you to first see a Hashtable as a collection in the traditional definition of a hashtable. This gives you a fundamental understanding of how they work when they get used for more advanced stuff later. Skipping this understanding is often a source of confusion.

## What is an array?
Before I jump into what a Hashtable is, I need to mention [arrays](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_arrays) first. For the purpose of this discussion, an array is a list or collection of values or objects.

    $array = @(1,2,3,5,7,11)

Once you have your items into an array, you can either use `foreach` to iterate over the list or use an index to access individual elements in the array.

    foreach($item in $array)
    {
        Write-Output $item
    }

    Write-Output $array[3]

You can also update values using an index in the same way.

    $array[2] = 13

I just scratched the surface on arrays but that should put them into the right context as I move onto hashtables.

## What is a hashtable?
I am going to start with a basic technical description of what hashtables are in the general sense as used by most programming languages before I shift into the other ways Powershell makes use of them.

A hashtable is a data structure much like an array, except you store each value (object) using a key. It is a basic key/value store. First, we create an empty hashtable.

    $ageList = @{}

Notice the braces vs the parentheses used when defining an array above. Then we add an item by using a key like this:

    $key = 'Kevin'
    $value = 36
    $ageList.add( $key, $value )

    $ageList.add( 'Alex', 9 )

The person's name is the key and their age is the value that I want to save.

## Using the brackets for access
Once you add your values to the hashtable, you can pull them back out using that same key (instead of using a numeric index like you would have for an array).

    $ageList['Kevin']
    $ageList['Alex']

When I want Kevin's age, I use his name to access it.
We can use this approach to add or update values into the hashtable too. This is just like using the `add()` function above.

    $ageList = @{}

    $key = 'Kevin'
    $value = 36
    $ageList[$key] = $value

    $ageList['Alex'] = 9


There is another syntax you can use for accessing and updating values that I will cover in a later section. If you are coming to Powershell from another language, these existing examples should fit in with how you may have used hashtables before.


## Creating hashtables with values

So far I have just created an empty hashtable for these examples. You can pre-populate the keys and values when you create them.

    $ageList = @{
        Kevin = 36
        Alex  = 9
    }

## As a lookup table
The real value of this type of a hashtable is that you can use them as a lookup table. Here is a simple example.

    $environments = @{
        Prod = 'SrvProd05'
        QA   = 'SrvQA02'
        Dev  = 'SrvDev12'
    }

    $server = $environments[$env]

In this example, you specify an environment for the `$env` variable and it will pick the correct server. You could use a `switch($env){...}` for something like this but this is a nice option.

This gets even better when you dynamically build the lookup table to use it later. So think about using this approach when you need to cross reference something. I think we would see this a lot more if Powershell was not so good at filtering on the pipe with `Where-Object`. If you are ever in a situation where performance matters, this is an approach that needs to be considered.

I won't say that it is faster, but it does fit into the rule of [If performance matters, test it](https://github.com/PoshCode/PowerShellPracticeAndStyle/blob/master/Best%20Practices/Performance.md).

### Multiselection

Generally, you think of a hashtable as a key/value pair where you provide one key and get one value. PowerShell allows you to provide an array of keys to get multiple values.

    $environments[@('QA','DEV')]
    $environments[('QA','DEV')]
    $environments['QA','DEV']

In this example I use the same lookup hashtable from above and provide 3 different array styles to get the matches. This is a hidden gem in PowerShell that most people are not aware of.

## Iterating hashtables
Because a hashtable is a collection of key/value pairs, you have to iterate over it differently than you would an array or a normal list of items.

The first thing to notice is that if you pipe your hashtable, the pipe treats it like one object.

    PS:\> $ageList | Measure-Object
    count : 1

Even though the `.count` property tells you how many values it contains.

    PS:\> $ageList.count
    2

You get around this issue by using the `.values` property if all you need is just the values.

    PS:\> $ageList.values | Measure-Object -Average
    Count   : 2
    Average : 22.5

It is often more useful to enumerate the keys and use them to access the values.

    PS:\> $ageList.keys | ForEach-Object{
            $message = '{0} is {1} years old!' -f $_, $ageList[$_]
            Write-Output $message
    }
    Kevin is 36 years old
    Alex is 9 years old

Here is the same example with a `foreach(){...}` loop.

    foreach($key in $ageList.keys)
    {
        $message = '{0} is {1} years old' -f $key, $ageList[$key]
        Write-Output $message
    }

We are walking each key in the hashtable and then using it to access the value. This is a common pattern when working with hashtables as a collection.

## GetEnumerator()
That brings us to `GetEnumerator()` for iterating over our hashtable.

    $ageList.GetEnumerator() | ForEach-Object{
            $message = '{0} is {1} years old!' -f $_.key, $_.value
            Write-Output $message
    }

The enumerator gives you each key/value pair one after another. It was designed specifically for this use case. Thank you to [Mark Kraus](https://get-powershellblog.blogspot.com) for reminding me of this one.

## BadEnumeration

One important detail is that you cannot modify a hashtable while it is being enumerated. If we start with our basic `$environments` example:

    $environments = @{
        Prod = 'SrvProd05'
        QA   = 'SrvQA02'
        Dev  = 'SrvDev12'
    }

And if we decide to set every server to the same value, this will fail.

    $environments.Keys | ForEach-Object {
        $environments[$_] = 'SrvDev03'
    }

    An error occurred while enumerating through a collection: Collection was modified; enumeration operation may not execute.
    + CategoryInfo          : InvalidOperation: tableEnumerator:HashtableEnumerator) [], RuntimeException
    + FullyQualifiedErrorId : BadEnumeration

This will also fail even though it looks like it should also be fine:

    foreach($key in $environments.keys) {
        $environments[$key] = 'SrvDev03'
    }

    Collection was modified; enumeration operation may not execute.
        + CategoryInfo          : OperationStopped: (:) [], InvalidOperationException
        + FullyQualifiedErrorId : System.InvalidOperationException

The trick to this situation is to clone the keys before doing the enumeration.

    $environments.Keys.Clone() | ForEach-Object {
        $environments[$_] = 'SrvDev03'
    }


# Hashtable as a collection of properties

So far the type of objects we placed in our hashtable were all the same type of object. I used ages in all those examples and the key was the person's name. This is a great way to look at it when your collection of objects each have a name. Another common way to use hashtables in Powershell is to hold a collection of properties where the key is the name of the property. I'll step into that idea in this next example.


## Property based access
The use of property based access changes the dynamics of hashtables and how you can use them in Powershell. Here is our usual example from above treating the keys as properties.

    $ageList = @{}
    $ageList.Kevin = 35
    $ageList.Alex = 9

Just like the examples above, this will add those keys if they don't exist in the hashtable already. Depending on what how you defined your keys and what your values are, this is either a little strange or a perfect fit. The age list example has worked great up until this point. We need a new example for this to feel right going forward.

    $person = @{
        name = 'Kevin'
        age  = 36
    }

And we can add and access attributes on the `$person` like this.

    $person.city = 'Austin'
    $person.state = 'TX'

All of a sudden this hashtable starts to feel and act like an object. It is still a collection of things, so all the examples above still apply. We just approach it from a different point of view.

## Checking for keys and values
In most cases, you can just test for the value with something like this:

    if( $person.age ){...}

It is simple but has been the source of many bugs for me because I was overlooking one important detail in my logic. I started to use it to test if a key was present. When the value was `$false` or zero, that statement would return `$false` unexpectedly.

    if( $person.age -ne $null ){...}

This works around that issue for zero values but not $null vs non-existent keys. Most of the time you don't need to make that distinction but there are functions for when you do.

    if( $person.ContainsKey('age') ){...}

We also have a `ContainsValue()` for the situation where you need to test for a value without knowing the key or iterating the whole collection.

## Removing and clearing keys
You can remove keys with the `.Remove()` function.

    $person.remove('age')

Assigning them a `$null` value just leaves you with a key that has a `$null` value.

A common way to clear a hahstable is to just initalize it to an empty hashtable.

    $person = @{}

While that does work, try to use the `clear()` function instead.

    $person.clear()

This is one of those instances where using the function creates self documenting code and it makes the intentions of the code very clean.


# All the fun stuff

## Ordered hashtables
By default, hashtables are not ordered (or sorted). In the traditional context, the order does not matter when you always use a key to access values. You may find that when using it to hold properties that you may want them to stay in the order that you define them. Thankfully, there is a way to do that with the `ordered` keyword.

    $person = [ordered]@{
        name = 'Kevin'
        age  = 36
    }

Now when you enumerate the keys and values, they will stay in that order.

## Inline hashtables
When you are defining a hashtable on one line, you can separate the key/value pairs with a semicolon.

    $person = @{ name = 'kevin'; age = 36; }

This will come in handy if you are creating them on the pipe.

## Custom expressions in common pipeline commands
There are a few cmdlets that support the use of hashtables to create custom or calculated properties. You will most commonly see this with `Select-Object` and `Format-Table`. The hashtables have a special syntax that looks like this when fully expanded.

    $property = @{
        name = 'totalSpaceGB'
        expression = { ($_.used + $_.free) / 1GB }
    }

The `name` is what the cmdlet would label that column. The `expression` is a script block that is executed where `$_` is the value of the object on the pipe. Here is that script in action:

    PS:\> $drives = Get-PSDrive | Where Used
    PS:\> $drives | Select-Object -Properties name, $property

    Name     totalSpaceGB
    ----     ------------
    C    238.472652435303

I placed that in a variable but it could just as easily be defined inline and you can shorten `name` to `n` and `expression` to `e` while you are at it.

    $drives | Select-Object -properties name, @{n='totalSpaceGB';e={($_.used + $_.free) / 1GB}}

I personally don't like how long that makes commands and it often promotes some bad behaviors that I won't get into. I am more likely to create a new hashtable or `pscustomobject` with all the fields and properties that I want instead of using this approach in scripts. But there is a lot of code out there that does this so I wanted you to be aware of it. I talk about creating a `pscustomobject` later on.

## Custom sort expression

It is easy to sort a collection if the objects have the data that you want to sort on. You can either add the data to the object before you sort it or create a custom expression for `Sort-Object`.

    Get-ADUser | Sort-Object -Parameter @{ e={ Get-TotalSales $_.Name } }

In this example I am taking a list of users and using some custom cmdlet to get additional information just for the sort.

### Sort a list of Hashtables

If you have a list of hashtables that you want to sort, you will find that the `Sort-Object` does not treat your keys as properties. We can get a round that by using a custom sort expressions.

    $data = @(
        @{name='a'}
        @{name='c'}
        @{name='e'}
        @{name='f'}
        @{name='d'}
        @{name='b'}
    )

    $data | Sort-Object -Property @{e={$_.name}}

## Splatting hashtables at cmdlets
This is one of my favorite things about hashtables that many people don't discover very early on. The idea is that instead of providing all the properties to a cmdlet on one line, you can instead pack them into a hashtable first. Then you can give the hashtable to the function in a special way. Here is an example of creating a DHCP scope the normal way.

    Add-DhcpServerv4Scope -Name 'TestNetwork' -StartRange'10.0.0.2' -EndRange '10.0.0.254' -SubnetMask '255.255.255.0' -Description 'Network for testlab A' -LeaseDuration (New-TimeSpan -Days 8) -Type "Both"

Without using [splatting](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_splatting), all those things need to be defined on a single line. It either scrolls off the screen or will wrap where ever it feels like. Now compare that to a command that uses splatting.

    $DHCPScope = @{
        Name        = 'TestNetwork'
        StartRange  = '10.0.0.2'
        EndRange    = '10.0.0.254'
        SubnetMask  = '255.255.255.0'
        Description = 'Network for testlab A'
        LeaseDuration = (New-TimeSpan -Days 8)
        Type = "Both"
    }
    Add-DhcpServerv4Scope @DHCPScope

The use of the `@` sign instead of the `$` is what invokes the splat operation.

Just take a moment to appreciate how easy that example is to read. They are the exact same command with all the same values. The second one will be easier to understand and maintain going forward.

I use splatting any time the command gets too long. I define too long as causing my window to scroll right. If I hit 3 properties for a function, odds are that I will rewrite it using a splatted hashtable.

### Splatting for optional parameters
One of the most common ways I use spatting is to deal with optional parameters that come from someplace else in my script. Let's say I have a function that wraps a `Get-CIMInstance` call that has an optional `$Credential` argument.

    $CIMParams = @{
        ClassName = 'Win32_Bios'
        ComputerName = $ComputerName
    }

    if($Credential)
    {
        $CIMParams.Credential = $Credential
    }

    Get-CIMInstance @CIMParams

I start by creating my hashtable with common parameters. Then I add the `$Credential` if it exists. Because I am using splatting here, I only need to have the call to `Get-CIMInstance` in my code once. This design pattern is very clean and can handle lots of optional parameters very easily.

To be fair, you could write your commands to allow `$null` values for parameters. You just don't always have control over the other commands you are calling.

### Multiple splats
You can splat multiple hashtables to the same cmdlet. If we revisit our original splatting example:

    $Common = @{
        SubnetMask  = '255.255.255.0'
        LeaseDuration = (New-TimeSpan -Days 8)
        Type = "Both"
    }

    $DHCPScope = @{
        Name        = 'TestNetwork'
        StartRange  = '10.0.0.2'
        EndRange    = '10.0.0.254'
        Description = 'Network for testlab A'
    }

    Add-DhcpServerv4Scope @DHCPScope @Common

I'll use this when I have a common set of parameters that I am passing to lots of commands.


### Splatting for clean code
There is nothing wrong with splatting a single parameter if makes you code cleaner.

    $log = @{Path = '.\logfile.log'}

    Add-Content "logging this command" @log


### Splatting executables
Splatting also works on some executables that use a `/param:value` syntax. Robocopy for example has some parameters like this.

    $robo = @{R=1;W=1;MT=8}
    robocopy source destination @robo

I don't know that this is all that usefull, but I found it interesting.

## Adding hashtables
Hashtables support the addition opperator to combine two hashtables.

    $person += @{Zip = '78701'}

This only works if the two hashtables do not share a key.

## Nested hashtables
We can use hashtables as values inside a hashtable.

    $person = @{
        name = 'Kevin'
        age  = 36
    }
    $person.location = @{}
    $person.location.city = 'Austin'
    $person.location.state = 'TX'

I started with a basic hashtable containing 2 keys. I added a key called `location` with an empty hashtable. Then I added the last two items to that `location` hashtable. We can do this all inline too.

    $person = @{
        name = 'Kevin'
        age  = 36
        location = @{
            city  = 'Austin'
            state = 'TX'
        }
    }

This creates the same hashtable that we saw above and can access the properties the same way.

    PS:> $person.location.city
    Austin

There are many ways to approach the structure of your objects. Here is a second way to look at a nested hashtable.

    $people = @{
        Kevin = @{
            age  = 36
            city = 'Austin'
        }
        Alex = @{
            age  = 9
            city = 'Austin'
        }
    }

This mixes the concept of using hashtables as a collection of objects and a collection of properties. The values are still easy to access even when they are nested using whatever approach you prefer.

    PS:\> $people.kevin.age
    36
    PS:\> $people.kevin['city']
    Austin
    PS:\> $people['Alex'].age
    9
    PS:\> $people['Alex']['City']
    Austin

I tend to use the dot property when I am treating it like a property. Those are generally things I have defined statically in my code and I know them off the top of my head. If I need to walk the list or programmatically access the keys, I will use the brackets to provide the key name.

    foreach($name in $people.keys)
    {
        $person = $people[$name]
        '{0}, age {1}, is in {2}' -f $name, $person.age, $person.city
    }

Having the ability to nest hashtables gives you a lot of flexibility and options.

## Looking at nested hashtables
As soon as you start nesting hashtables, you are going to need an easy way to look at them from the console. If I take that last hashtable, I get an output that looks like this and it only goes so deep:

    ps:\> $people
    Name                           Value
    ----                           -----
    Kevin                          {age, city}
    Alex                           {age, city}

My go to command for looking at these things is `ConvertTo-JSON` because it is very clean and I frequently use JSON on other things.

    PS:\> $people | ConvertTo-JSON
    {
        "Kevin":  {
                    "age":  36,
                    "city":  "Austin"
                },
        "Alex":  {
                    "age":  9,
                    "city":  "Austin"
                }
    }

Even if you don't know JSON, you should be able to see what you are looking for. There is a `Format-Custom` command for structured data like this but I still like the JSON view better.


## Creating objects
Sometimes you just need to have an object and using a hashtable to hold properties just is not getting the job done. Most commonly you want to see the keys as column names. A `pscustomobject` makes that easy.

    $person = [pscustomobject]@{
        name = 'Kevin'
        age  = 36
    }

     PS:\> $person

    name  age
    ----  ---
    Kevin  36

Even if you don't create it as a `pscustomobject` initially, you can always cast it later when needed.

    $person = @{
        name = 'Kevin'
        age  = 36
    }

     PS:\> [pscustomobject]$person

    name  age
    ----  ---
    Kevin  36

I already have very detailed write up for [pscustomobject](/2016-10-28-powershell-everything-you-wanted-to-know-about-pscustomobject/) that you should go read after this one. It builds on a lot of the thing learned here.

## Saving to CSV
Struggling with getting a hashtable to save to a CSV is one of the difficulties that I was referring to above. Convert your hashtable to a `pscustomobject` and it will save correctly to CSV. It helps if you start with a `pscustomobject` so the column order is preserved. But you can cast it to a `pscustomobject` inline if needed.

    $person | ForEach-Object{ [pscustomobject]$_ } | Export-CSV -Path $path

Again, check out my write up on using a [pscustomobject](2016-10-28-powershell-everything-you-wanted-to-know-about-pscustomobject).

## Saving a nested hashtable to file

If I need to save a nested hashtable to a file and then read it back in again, I use the JSON cmdlets to do it.

    $people | ConvertTo-JSON | Set-Content -Path $path
    $people = Get-Content -Path $path -Raw | ConvertFrom-JSON

There are two important points about this method. First is that the JSON is written out multiline so I need to use the `-Raw` option to read it back into a single string. The Second is that the imported object is no longer a `[hashtable]`. It is now a `[pscustomobject]` and that can cause issues if you don't expect it.

If you need it to be a `[hashtable]` on import, then you need to use the `Export-CliXml` and `Import-CliXml` commands.

## Converting JSON to Hashtable

If you need to convert JSON to a `[hashtable]`, there is one way that I know of to do it with the [JavaScriptSerializer](https://docs.microsoft.com/dotnet/api/system.web.script.serialization.javascriptserializer?redirectedfrom=MSDN&view=netframework-4.8) in .Net.

    [Reflection.Assembly]::LoadWithPartialName("System.Web.Script.Serialization")
    $JSSerializer = [System.Web.Script.Serialization.JavaScriptSerializer]::new()
    $JSSerializer.Deserialize($json,'Hashtable')

## Reading directly from a file
If you have a file that contains a hashtable using Powershell syntax, there is a way to import it directly.

    $content = Get-Content -Path $Path -Raw -ErrorAction Stop
    $scriptBlock = [scriptblock]::Create( $content )
    $scriptBlock.CheckRestrictedLanguage( $allowedCommands, $allowedVariables, $true )
    $hashtable = ( & $scriptBlock )

It imports the contents of the file into a `scriptblock`, then checks to make sure it does not have any other PowerShell commands in it before it executes it.

On that note, did you know that a module manifest (the psd1 file) is just a hashtable?

## Keys are just strings
I didn't want to go off on this tangent earlier, but the keys are just strings. So we can put quotes around anything and make it a key.

    $person = @{
        'full name' = 'Kevin Marquette'
        '#' = 3978
    }
    $person['full name']

You can do some odd things that you may not have realized you could do.

    $person.'full name'

    $key = 'full name'
    $person.$key

Just because you can do something, it does not mean that you should. That last one just looks like a bug waiting to happen and would be easily misunderstood by anyone reading your code.

Technically your key does not have to be a string but they are easier to think about if you only use strings.

## PSBoundParameters
[PSBoundParameters](http://tommymaynard.com/quick-learn-the-psboundparameters-automatic-variable-2016/) is an automatic variable that only exists inside the context of a function. It contains all the parameters that the function was called with. This isn't exactly a hashtable but close enough that you can treat it like one.

That includes removing keys and splatting it to other functions. If you find yourself writing proxy functions, take a closer look at this one.

See [about_Automatic_Variables](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_automatic_variables) for more details.

### PSBoundParameters gotcha

One important thing to remember is that this only includes the values that are passed in as parameters. If you also have parameters with default values but are not passed in by the caller, PSBoundParameters will not contain those values. This is commonly overlooked.

## PSDefaultParameterValues
This automatic variable lets you assign default values to any cmdlet without changing the cmdlet. Take a look at this example.

    $PSDefaultParameterValues["Out-File:Encoding"] = "UTF8"

This adds an entry to the `$PSDefaultParameterValues` hashtable that sets `UTF8` as the default value for the `Out-File -Encoding` parameter. This is session specific so you should place it in your `$profile`.

I use this often to pre-assign values that I type quite often.

    $PSDefaultParameterValues[ "Connect-VIServer:Server" ] = 'VCENTER01.contoso.local'

This also accepts wildcards so you can set values in bulk. Here are some ways you can use that:

    $PSDefaultParameterValues[ "Get-*:Verbose" ] = $true
    $PSDefaultParameterValues[ "*:Credential" ] = Get-Credental

For a more in depth breakdown, see this great article on [Automatic Defaults](https://www.simple-talk.com/sysadmin/powershell/powershell-time-saver-automatic-defaults/) by [Michael Sorens](http://cleancode.sourceforge.net/wwwdoc/about.html).

## Regex $Matches

When you use the `-match` operator, an automatic variable called `$matches` is created with the results of the match. If you have any sub expressions in your regex, those sub matches are also listed.

    $message = 'My SSN is 123-45-6789.'

    $message -match 'My SSN is (.+)\.'
    $Matches[0]
    $Matches[1]

### Named matches

This is one of my favorite features that most people don't know about.If you use a named regex match, then you can access that match by name on the matches.

    $message = 'My Name is Kevin and my SSN is 123-45-6789.'

    if($message -match 'My Name is (?<Name>.+) and my SSN is (?<SSN>.+)\.')
    {
        $Matches.Name
        $Matches.SSN
    }

In the example above, the `(?<Name>.*)` is a named sub expression. This value is then placed in the `$Matches.Name` property.

## Group-Object -AsHashtable

One little known feature of `Group-Object` is that it can turn some datasets into a hashtable for you.

    Import-CSV $Path | Group-Object -AsHashtable -Property email

This will add each row into a hashtable and use the specified property as the key to access it.

## Array as indexer



# Copying Hashtables

One thing that is important to know is that hashtables are objecs and each variable is just a reference to an object. This just means that it takes a little more work to make a valid copy of a hashtable.

## Assigning reference types

When you have one hashtable and assign it to a second variable, both variables point to the same hashtable.

    PS> $orig = @{name='orig'}
    PS> $copy = $orig
    PS> $copy.name = 'copy'
    PS> 'Copy: [{0}]' -f $copy.name
    PS> 'Orig: [{0}]' -f $orig.name

    Copy: [copy]
    Orig: [copy]

This highlights that they are the same because altering the values in one will also alter the values in the other. This also applies when passing hashtables into other functions. If those functions make changes to that hashtable, your original is also altered.

## Shallow copies, single level

If we have a simple hashtable like our example above, we can use `.Clone()` to make a shallow copy.

    PS> $orig = @{name='orig'}
    PS> $copy = $orig.Clone()
    PS> $copy.name = 'copy'
    PS> 'Copy: [{0}]' -f $copy.name
    PS> 'Orig: [{0}]' -f $orig.name

    Copy: [copy]
    Orig: [orig]

This will allow us to make some basic changes to one that don't impact the other.


## Shallow copies, nested

The reason why it is called a shallow copy is because it only copies the base level properties. If one of those properties is a reference type (like another hashtable), then those nested objects will still point to eachother.

    PS> $orig = @{
            person=@{
                name='orig'
            }
        }
    PS> $copy = $orig.Clone()
    PS> $copy.person.name = 'copy'
    PS> 'Copy: [{0}]' -f $copy.person.name
    PS> 'Orig: [{0}]' -f $orig.person.name

    Copy: [copy]
    Orig: [copy]

So you can see that even though I cloned the hashtable, the reference to `person` was not cloned. We need to make a deep copy to truly have a second hashtable that is not linked to the first.

## Deep copies

At the time of writing this, I am not aware of any clever ways to just make a deep copy of a hashtable (and keep it as a hashtable). That's just one of those things that some needs to write. Here is a quick method to do that.

    function Get-DeepClone
    {
        [cmdletbinding()]
        param(
            $InputObject
        )
        process
        {
            if($InputObject -is [hashtable]) {
                $clone = @{}
                foreach($key in $InputObject.keys)
                {
                    $clone[$key] = Get-DeepClone $InputObject[$key]
                }
                return $clone
            } else {
                return $InputObject
            }
        }
    }

It doeesn't handle any other reffernece types or arrays, but it is a good starting point.

# Anything else?
I covered a lot of ground very quickly. My hope is that you walk away leaning something new or understanding it better every time you read this. Because I covered the full spectrum of this feature, there are aspects that just may not apply to you right now. That is perfectly OK and is kind of expected depending on how much you work with PowerShell.

Here is a list of everything we covered in case you want to jump back up to something. Normally, this would go at the beginning but this was written from top to bottom with examples that build on everything that came before it.
