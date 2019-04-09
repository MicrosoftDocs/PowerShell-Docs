---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Removing Objects from the Pipeline Where Object
ms.assetid:  01df8b22-2d22-4e2c-a18d-c004cd3cc284
---
# Removing Objects from the Pipeline (Where-Object)

In Windows PowerShell, you often generate and pass along more objects to a pipeline than you want. You can specify the properties of particular objects to display by using the **Format** cmdlets, but this does not help with the problem of removing entire objects from the display. You may want to filter objects before the end of a pipeline, so you can perform actions on only a subset of the initially-generated objects.

Windows PowerShell includes a `Where-Object` cmdlet that allows you to test each object in the pipeline and only pass it along the pipeline if it meets a particular test condition. Objects that do not pass the test are removed from the pipeline. You supply the test condition as the value of the `Where-Object` **FilterScript** parameter.

## Performing Simple Tests with Where-Object

The value of **FilterScript** is a *script block* -  one or more Windows PowerShell commands surrounded by braces {} - that evaluates to true or false. These script blocks can be very simple, but creating them requires knowing about another Windows PowerShell concept, comparison operators. A comparison operator compares the items that appear on each side of it. Comparison operators begin with a '-' character and are followed by a name. Basic comparison operators work on almost any kind of object. The more advanced comparison operators might only work on text or arrays.

> [!NOTE]
> By default, when working with text, Windows PowerShell comparison operators are case-insensitive.

Due to parsing considerations, symbols such as <,>, and = are not used as comparison operators. Instead, comparison operators are comprised of letters. The basic comparison operators are listed in the following table.

|Comparison Operator|Meaning|Example (returns true)|
|-----------------------|-----------|--------------------------|
|-eq|is equal to|1 -eq 1|
|-ne|Is not equal to|1 -ne 2|
|-lt|Is less than|1 -lt 2|
|-le|Is less than or equal to|1 -le 2|
|-gt|Is greater than|2 -gt 1|
|-ge|Is greater than or equal to|2 -ge 1|
|-like|Is like (wildcard comparison for text)|"file.doc" -like "f\*.do?"|
|-notlike|Is not like (wildcard comparison for text)|"file.doc" -notlike "p\*.doc"|
|-contains|Contains|1,2,3 -contains 1|
|-notcontains|Does not contain|1,2,3 -notcontains 4|

Where-Object script blocks use the special variable `$_` to refer to the current object in the pipeline. Here is an example of how it works. If you have a list of numbers, and only want to return the ones that are less than 3, you can use Where-Object to filter the numbers by typing:

```
PS> 1,2,3,4 | Where-Object -FilterScript {$_ -lt 3}
1
2
```

## Filtering Based on Object Properties

Since `$_` refers to the current pipeline object, we can access its properties for our tests.

As an example, we can look at the Win32_SystemDriver class in WMI. There might be hundreds of system drivers on a particular system, but you might only be interested in a particular set of the system drivers, such as those which are currently running. If you use Get-Member to view Win32_SystemDriver members (**Get-WmiObject -Class Win32_SystemDriver | Get-Member -MemberType Property**) you will see that the relevant property is State, and that it has a value of "Running" when the driver is running. You can filter the system drivers, selecting only the running ones by typing:

```powershell
Get-WmiObject -Class Win32_SystemDriver | Where-Object -FilterScript {$_.State -eq 'Running'}
```

This still produces a long list. You may want to filter to only select the drivers set to start automatically by testing the StartMode value as well:

```
PS> Get-WmiObject -Class Win32_SystemDriver | Where-Object -FilterScript {$_.State -eq "Running"} | Where-Object -FilterScript {$_.StartMode -eq "Auto"}

DisplayName : RAS Asynchronous Media Driver
Name        : AsyncMac
State       : Running
Status      : OK
Started     : True

DisplayName : Audio Stub Driver
Name        : audstub
State       : Running
Status      : OK
Started     : True
```

This gives us a lot of information we no longer need because we know that the drivers are running. In fact, the only information we probably need at this point are the name and the display name. The following command includes only those two properties, resulting in much simpler output:

```
PS> Get-WmiObject -Class Win32_SystemDriver | Where-Object -FilterScript {$_.State -eq "Running"} | Where-Object -FilterScript {$_.StartMode -eq "Manual"} | Format-Table -Property Name,DisplayName

Name                                    DisplayName
----                                    -----------
AsyncMac                                RAS Asynchronous Media Driver
Fdc                                     Floppy Disk Controller Driver
Flpydisk                                Floppy Disk Driver
Gpc                                     Generic Packet Classifier
IpNat                                   IP Network Address Translator
mouhid                                  Mouse HID Driver
MRxDAV                                  WebDav Client Redirector
mssmbios                                Microsoft System Management BIOS Driver
```

There are two Where-Object elements in the above command, but they can be expressed in a single Where-Object element by using the -and logical operator, like this:

```powershell
Get-WmiObject -Class Win32_SystemDriver | Where-Object -FilterScript { ($_.State -eq 'Running') -and ($_.StartMode -eq 'Manual') } | Format-Table -Property Name,DisplayName
```

The standard logical operators are listed in the following table.

|Logical Operator|Meaning|Example (returns true)|
|--------------------|-----------|--------------------------|
|-and|Logical and; true if both sides are true|(1 -eq 1) -and (2 -eq 2)|
|-or|Logical or; true if either side is true|(1 -eq 1) -or (1 -eq 2)|
|-not|Logical not; reverses true and false|-not (1 -eq 2)|
|\!|Logical not; reverses true and false|\!(1 -eq 2)|
