---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Using Format Commands to Change Output View
ms.assetid:  63515a06-a6f7-4175-a45e-a0537f4f6d05
---
# Using Format Commands to Change Output View

Windows PowerShell has a set of cmdlets that allow you to control which properties are displayed for particular objects. The names of all the cmdlets begin with the verb **Format**. They let you select one or more properties to show.

The **Format** cmdlets are **Format-Wide**, **Format-List**, **Format-Table**, and **Format-Custom**. We will only describe the **Format-Wide**, **Format-List**, and **Format-Table** cmdlets in this user's guide.

Each format cmdlet has default properties that will be used if you do not specify specific properties to display. Each cmdlet also uses the same parameter name, **Property**, to specify which properties you want to display. Because **Format-Wide** only shows a single property, its **Property** parameter only takes a single value, but the property parameters of **Format-List** and **Format-Table** will accept a list of property names.

If you use the command **Get-Process -Name powershell** with two instances of Windows PowerShell running, you get output that looks like this:

```output
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    995       9    30308      27996   152     2.73   2760 powershell
    331       9    23284      29084   143     1.06   3448 powershell
```

In the rest of this section, we will explore how to use **Format** cmdlets to change the way the output of this command is displayed.

## Using Format-Wide for Single-Item Output

The `Format-Wide` cmdlet, by default, displays only the default property of an object.
The information associated with each object is displayed in a single column:

```powershell
Get-Command -Verb Format | Format-Wide
```

```output
Format-Custom                          Format-Hex
Format-List                            Format-Table
Format-Wide
```

You can also specify a non-default property:

```powershell
Get-Command -Verb Format | Format-Wide -Property Noun
```

```output
Custom                                 Hex
List                                   Table
Wide
```

### Controlling Format-Wide Display with Column

With the `Format-Wide` cmdlet, you can only display a single property at a time.
This makes it useful for displaying simple lists that show only one element per line.
To get a simple listing, set the value of the **Column** parameter to 1 by typing:

```powershell
Get-Command -Verb Format | Format-Wide -Property Noun -Column 1
```

```output
Custom
Hex
List
Table
Wide
```

## Using Format-List for a List View

The **Format-List** cmdlet displays an object in the form of a listing, with each property labeled and displayed on a separate line:

```
PS> Get-Process -Name powershell | Format-List

Id      : 2760
Handles : 1242
CPU     : 3.03125
Name    : powershell

Id      : 3448
Handles : 328
CPU     : 1.0625
Name    : powershell
```

You can specify as many properties as you want:

```
PS> Get-Process -Name powershell | Format-List -Property ProcessName,FileVersion
,StartTime,Id

ProcessName : powershell
FileVersion : 1.0.9567.1
StartTime   : 2006-05-24 13:42:00
Id          : 2760

ProcessName : powershell
FileVersion : 1.0.9567.1
StartTime   : 2006-05-24 13:54:28
Id          : 3448
```

### Getting Detailed Information by Using Format-List with Wildcards

The **Format-List** cmdlet lets you use a wildcard as the value of its **Property** parameter. This lets you display detailed information. Often, objects include more information than you need, which is why Windows PowerShell does not show all property values by default. To show all of properties of an object, use the **Format-List -Property \&#42;** command. The following command generates over 60 lines of output for a single process:

```powershell
Get-Process -Name powershell | Format-List -Property *
```

Although the **Format-List** command is useful for showing detail, if you want an overview of output that includes many items, a simpler tabular view is often more useful.

## Using Format-Table for Tabular Output

If you use the **Format-Table** cmdlet with no property names specified to format the output of the **Get-Process** command, you get exactly the same output as you do without performing any formatting. The reason is that processes are usually displayed in a tabular format, as are most Windows PowerShell objects.

```
PS> Get-Process -Name powershell | Format-Table

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
   1488       9    31568      29460   152     3.53   2760 powershell
    332       9    23140        632   141     1.06   3448 powershell
```

### Improving Format-Table Output (AutoSize)

Although a tabular view is useful for displaying a lot of comparable information, it may be difficult to interpret if the display is too narrow for the data. For example, if you try to display process path, ID, name, and company, you get truncated output for the process path and the company column:

```
PS> Get-Process -Name powershell | Format-Table -Property Path,Name,Id,Company

Path                Name                                 Id Company
----                ----                                 -- -------
C:\Program Files... powershell                         2836 Microsoft Corpor...
```

If you specify the **AutoSize** parameter when you run the **Format-Table** command, Windows PowerShell will calculate column widths based on the actual data you are going to display. This makes the **Path** column readable, but the company column remains truncated:

```
PS> Get-Process -Name powershell | Format-Table -Property Path,Name,Id,Company -
AutoSize

Path                                                    Name         Id Company
----                                                    ----         -- -------
C:\Program Files\Windows PowerShell\v1.0\powershell.exe powershell 2836 Micr...
```

The **Format-Table** cmdlet might still truncate data, but it will only do so at the end of the screen. Properties, other than the last one displayed, are given as much size as they need for their longest data element to display correctly. You can see that company name is visible but path is truncated if you swap the locations of **Path** and **Company** in the **Property** value list:

```
PS> Get-Process -Name powershell | Format-Table -Property Company,Name,Id,Path -
AutoSize

Company               Name         Id Path
-------               ----         -- ----
Microsoft Corporation powershell 2836 C:\Program Files\Windows PowerShell\v1...
```

The **Format-Table** command assumes that the nearer a property is to the beginning of the property list, the more important it is. So it attempts to display the properties nearest the beginning completely. If the **Format-Table** command cannot display all the properties, it will remove some columns from the display and provide a warning. You can see this behavior if you make **Name** the last property in the list:

```
PS> Get-Process -Name powershell | Format-Table -Property Company,Path,Id,Name -
AutoSize

WARNING: column "Name" does not fit into the display and was removed.

Company               Path                                                    I
                                                                              d
-------               ----                                                    -
Microsoft Corporation C:\Program Files\Windows PowerShell\v1.0\powershell.exe 6
```

In the output above, the ID column is truncated to make it fit into the listing, and the column headings are stacked up. Automatically resizing the columns does not always do what you want.

### Wrapping Format-Table Output in Columns (Wrap)

You can force lengthy **Format-Table** data to wrap within its display column by using the **Wrap** parameter. Using the **Wrap** parameter alone will not necessarily do what you expect, since it uses default settings if you do not also specify **AutoSize**:

```
PS> Get-Process -Name powershell | Format-Table -Wrap -Property Name,Id,Company,
Path

Name                                 Id Company             Path
----                                 -- -------             ----
powershell                         2836 Microsoft Corporati C:\Program Files\Wi
                                        on                  ndows PowerShell\v1
                                                            .0\powershell.exe
```

An advantage of using the **Wrap** parameter by itself is that it does not slow down processing very much. If you perform a recursive file listing of a large directory system, it might take a very long time and use a lot of memory before displaying the first output items if you use **AutoSize**.

If you are not concerned about system load, then **AutoSize** works well with the **Wrap** parameter. The initial columns are always allotted as much width as they need to display items on one line, just as when you specify **AutoSize** without the **Wrap** parameter. The only difference is that the final column will be wrapped if necessary:

```
PS> Get-Process -Name powershell | Format-Table -Wrap -AutoSize -Property Name,I
d,Company,Path

Name         Id Company               Path
----         -- -------               ----
powershell 2836 Microsoft Corporation C:\Program Files\Windows PowerShell\v1.0\
                                      powershell.exe
```

Some columns might not be displayed if you specify the widest columns first, so it is safest to specify the smallest data elements first. In the following example, we specify the extremely wide path element first, and even with wrapping, we still lose the final **Name** column:

```
PS> Get-Process -Name powershell | Format-Table -Wrap -AutoSize -Property Path,I
d,Company,Name

WARNING: column "Name" does not fit into the display and was removed.

Path                                                      Id Company
----                                                      -- -------
C:\Program Files\Windows PowerShell\v1.0\powershell.exe 2836 Microsoft Corporat
                                                             ion
```

### Organizing Table Output (-GroupBy)

Another useful parameter for tabular output control is **GroupBy**. Longer tabular listings in particular may be hard to compare. The **GroupBy** parameter groups output based on a property value. For example, we can group processes by company for easier inspection, omitting the company value from the property listing:

```
PS> Get-Process -Name powershell | Format-Table -Wrap -AutoSize -Property Name,I
d,Path -GroupBy Company

   Company: Microsoft Corporation

Name         Id Path
----         -- ----
powershell 1956 C:\Program Files\Windows PowerShell\v1.0\powershell.exe
powershell 2656 C:\Program Files\Windows PowerShell\v1.0\powershell.exe
```