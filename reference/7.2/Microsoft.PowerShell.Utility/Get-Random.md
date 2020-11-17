---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 05/20/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/get-random?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-Random
---

# Get-Random

## SYNOPSIS
Gets a random number, or selects objects randomly from a collection.

## SYNTAX

### RandomNumberParameterSet (Default)

```
Get-Random [-SetSeed <Int32>] [[-Maximum] <Object>] [-Minimum <Object>] [-Count <Int32>] [<CommonParameters>]
```

### RandomListItemParameterSet

```
Get-Random [-SetSeed <Int32>] [-InputObject] <Object[]> [-Count <Int32>] [<CommonParameters>]
```

### ShuffleParameterSet

```
Get-Random [-SetSeed <Int32>] [-InputObject] <Object[]> [-Shuffle] [<CommonParameters>]
```

## DESCRIPTION

The `Get-Random` cmdlet gets a randomly selected number. If you submit a collection of objects to
`Get-Random`, it gets one or more randomly selected objects from the collection.

Without parameters or input, a `Get-Random` command returns a randomly selected 32-bit unsigned
integer between 0 (zero) and **Int32.MaxValue** (`0x7FFFFFFF`, `2,147,483,647`).

You can use the parameters of `Get-Random` to specify a seed number, minimum and maximum values, the
number of objects returned from a submitted collection, and the entire collection in a random order.

## EXAMPLES

### Example 1: Get a random integer

This command gets a random integer between 0 (zero) and **Int32.MaxValue**.

```powershell
Get-Random
```

```Output
3951433
```

### Example 2: Get a random integer between 0 and 99

```powershell
Get-Random -Maximum 100
```

```Output
47
```

### Example 3: Get a random integer between -100 and 99

```powershell
Get-Random -Minimum -100 -Maximum 100
```

```Output
56
```

### Example 4: Get a random floating-point number

This command gets a random floating-point number greater than or equal to 10.7 and less than 20.92.

```powershell
Get-Random -Minimum 10.7 -Maximum 20.93
```

```Output
18.08467273887
```

### Example 5: Get a random integer from an array

This command gets a randomly selected number from the specified array.

```powershell
1, 2, 3, 5, 8, 13 | Get-Random
```

```Output
8
```

### Example 6: Get several random integers from an array

This command gets three randomly selected numbers in random order from an array.

```powershell
1, 2, 3, 5, 8, 13 | Get-Random -Count 3
```

```Output
3
1
13
```

### Example 7: Randomize an entire collection

Starting in PowerShell 7.1, you can use the **Shuffle** parameter to return the entire collection in
a random order.

```powershell
1, 2, 3, 5, 8, 13 | Get-Random -Shuffle
```

```Output
2
3
5
1
8
13
```

### Example 8: Get a random non-numeric value

This command returns a random value from a non-numeric collection.

```powershell
"red", "yellow", "blue" | Get-Random
```

```Output
yellow
```

### Example 9: Use the SetSeed parameter

This example shows the effect of using the **SetSeed** parameter.

Because **SetSeed** produces non-random behavior, it's typically used only to reproduce results,
such as when debugging or analyzing a script.

```powershell
# Commands with the default seed are pseudorandom
Get-Random -Maximum 100 -SetSeed 23
Get-Random -Maximum 100
Get-Random -Maximum 100
Get-Random -Maximum 100
```

```Output
74
56
84
46
```

```powershell
# Commands with the same seed are not random
Get-Random -Maximum 100 -SetSeed 23
Get-Random -Maximum 100 -SetSeed 23
Get-Random -Maximum 100 -SetSeed 23
```

```Output
74
74
74
```

```powershell
# SetSeed results in a repeatable series
Get-Random -Maximum 100 -SetSeed 23
Get-Random -Maximum 100
Get-Random -Maximum 100
Get-Random -Maximum 100
```

```Output
74
56
84
46
```

### Example 10: Get random files

These commands get a randomly selected sample of 50 files from the `C:` drive of the local computer.

```powershell
$Files = Get-ChildItem -Path C:\* -Recurse
$Sample = $Files | Get-Random -Count 50
```

### Example 11: Roll fair dice

This example rolls a fair die 1200 times and counts the outcomes. The first command, `For-EachObject`
repeats the call to `Get-Random` from the piped in numbers (1-6). The results are grouped by their
value with `Group-Object` and formatted as a table with `Select-Object`.

```powershell
1..1200 | ForEach-Object {
    1..6 | Get-Random
} | Group-Object | Select-Object Name,Count
```

```Output
Name Count
---- -----
1      206
2      199
3      196
4      226
5      185
6      188
```

### Example 12: Use the Count parameter

You can now use the **Count** parameter without piping objects to `Get-Random`.
The following example gets three random numbers less than 10.

```powershell
Get-Random -Count 3 -Maximum 10
```

```Output
9
0
8
```

### Example 13: Use the InputObject parameter with an empty string or $null

In this example, the **InputObject** parameter specifies an array that contains an empty string
(`''`) and `$null`.

```powershell
Get-Random -InputObject @('a','',$null)
```

`Get-Random` will return either `a`, empty string, or `$null`. The empty sting displays as a blank
line and `$null` returns to a PowerShell prompt.

## PARAMETERS

### -Count

Specifies the number of random objects or numbers to return. The default is 1.

When used with `InputObject`, if the value of **Count** exceeds the number of objects in the
collection, `Get-Random` returns all of the objects in random order.

```yaml
Type: System.Int32
Parameter Sets: RandomNumberParameterSet, RandomListItemParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies a collection of objects. `Get-Random` gets randomly selected objects in random order from
the collection up to the number specified by **Count**. Enter the objects, a variable that contains
the objects, or a command or expression that gets the objects. You can also pipe a collection of
objects to `Get-Random`.

Beginning in PowerShell 7, the **InputObject** parameter accepts arrays that can contain an empty
string or `$null`. The array can be sent down the pipeline or as an **InputObject** parameter value.

```yaml
Type: System.Object[]
Parameter Sets: RandomListItemParameterSet, ShuffleParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Maximum

Specifies a maximum value for the random number. `Get-Random` returns a value that is less than the
maximum (not equal). Enter an integer, a double-precision floating-point number, or an object that
can be converted to an integer or double, such as a numeric string ("100").

The value of **Maximum** must be greater than (not equal to) the value of **Minimum**. If the value
of **Maximum** or **Minimum** is a floating-point number, `Get-Random` returns a randomly selected
floating-point number.

On a 64-bit computer, if the value of **Minimum** is a 32-bit integer, the default value of
**Maximum** is **Int32.MaxValue**.

If the value of **Minimum** is a double (a floating-point number), the default value of **Maximum**
is **Double.MaxValue**. Otherwise, the default value is **Int32.MaxValue**.

```yaml
Type: System.Object
Parameter Sets: RandomNumberParameterSet
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Minimum

Specifies a minimum value for the random number. Enter an integer, a double-precision floating-point
number, or an object that can be converted to an integer or double, such as a numeric string
("100"). The default value is 0 (zero).

The value of **Minimum** must be less than (not equal to) the value of **Maximum**. If the value of
**Maximum** or **Minimum** is a floating-point number, `Get-Random` returns a randomly selected
floating-point number.

```yaml
Type: System.Object
Parameter Sets: RandomNumberParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SetSeed

Specifies a seed value for the random number generator. This seed value is used for the current
command and for all subsequent `Get-Random` commands in the current session until you use
**SetSeed** again or close the session. You can't reset the seed to its default value.

The **SetSeed** parameter is not required. By default, `Get-Random` uses the
[RandomNumberGenerator()](/dotnet/api/system.security.cryptography.randomnumbergenerator)
method to generate a seed value. Because **SetSeed** results in non-random behavior, it's typically
used only when trying to reproduce behavior, such as when debugging or analyzing a script that
includes `Get-Random` commands.

```yaml
Type: System.Nullable`1[System.Int32]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Shuffle

Returns the entire collection in a randomized order.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: ShuffleParameterSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object

You can pipe one or more objects. `Get-Random` selects values randomly from the piped objects.

## OUTPUTS

### System.Int32, System.Int64, System.Double

`Get-Random` returns an integer or floating-point number, or an object selected randomly from a
submitted collection.

## NOTES

`Get-Random` sets a default seed for each session based on the system time clock when the session
starts.

`Get-Random` does not alway return the same data type as the input value. The following table shows
the output type for each of the numeric input types.

| Input Type | Output Type |
| :--------: | :---------: |
|   SByte    |   Double    |
|    Byte    |   Double    |
|   Int16    |   Double    |
|   UInt16   |   Double    |
|   Int32    |    Int32    |
|   UInt32   |   Double    |
|   Int64    |    Int64    |
|   UInt64   |   Double    |
|   Double   |   Double    |
|   Single   |   Double    |

Beginning in Windows PowerShell 3.0, `Get-Random` supports 64-bit integers. In Windows PowerShell
2.0, all values are cast to **System.Int32**.

Beginning in PowerShell 7, the **InputObject** parameter in the **RandomListItemParameterSet**
parameter set accepts arrays that contain an empty string or `$null`. In earlier PowerShell
versions, only the **Maximum** parameter in the **RandomNumberParameterSet** parameter set accepted
an empty string or `$null`.

## RELATED LINKS

