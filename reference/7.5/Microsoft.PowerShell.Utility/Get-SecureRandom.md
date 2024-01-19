---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/25/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/get-securerandom?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-SecureRandom
---

# Get-SecureRandom

## SYNOPSIS
Gets a random number, or selects objects randomly from a collection.

## SYNTAX

### RandomNumberParameterSet (Default)

```
Get-SecureRandom [[-Maximum] <Object>] [-Minimum <Object>] [-Count <Int32>] [<CommonParameters>]
```

### RandomListItemParameterSet

```
Get-SecureRandom [-InputObject] <Object[]> [-Count <Int32>] [<CommonParameters>]
```

### ShuffleParameterSet

```
Get-SecureRandom [-InputObject] <Object[]> [-Shuffle] [<CommonParameters>]
```

## DESCRIPTION

The `Get-SecureRandom` cmdlet gets a randomly selected number. If you submit a collection of objects
to `Get-SecureRandom`, it gets one or more randomly selected objects from the collection.

Without parameters or input, a `Get-SecureRandom` command returns a randomly selected 32-bit
unsigned integer between 0 (zero) and `[int32]::MaxValue`.

You can use the parameters of `Get-SecureRandom` to specify the minimum and maximum values and the
number of objects returned from a collection.

`Get-SecureRandom` generates cryptographically secure randomness using the
[RandomNumberGenerator](/dotnet/api/system.security.cryptography.randomnumbergenerator) class.

## EXAMPLES

### Example 1: Get a random integer

This command gets a random integer between 0 (zero) and **Int32.MaxValue**.

```powershell
Get-SecureRandom
```

```Output
3951433
```

### Example 2: Get a random integer between 0 and 99

```powershell
Get-SecureRandom -Maximum 100
```

```Output
47
```

### Example 3: Get a random integer between -100 and 99

```powershell
Get-SecureRandom -Minimum -100 -Maximum 100
```

```Output
56
```

### Example 4: Get a random floating-point number

This command gets a random floating-point number greater than or equal to 10.7 and less than 20.93.

```powershell
Get-SecureRandom -Minimum 10.7 -Maximum 20.93
```

```Output
18.08467273887
```

### Example 5: Get a random integer from an array

This command gets a randomly selected number from the specified array.

```powershell
1, 2, 3, 5, 8, 13 | Get-SecureRandom
```

```Output
8
```

### Example 6: Get several random integers from an array

This command gets three randomly selected numbers in random order from an array.

```powershell
1, 2, 3, 5, 8, 13 | Get-SecureRandom -Count 3
```

```Output
3
1
13
```

### Example 7: Randomize an entire collection

You can use the **Shuffle** parameter to return the entire collection in
a random order.

```powershell
1, 2, 3, 5, 8, 13 | Get-SecureRandom -Shuffle
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
"red", "yellow", "blue" | Get-SecureRandom
```

```Output
yellow
```

### Example 9: Get random files

These commands get a randomly selected sample of 50 files from the `C:` drive of the local computer.

```powershell
$Files = Get-ChildItem -Path C:\* -Recurse
$Sample = $Files | Get-SecureRandom -Count 50
```

### Example 10: Roll fair dice

This example rolls a fair die 1200 times and counts the outcomes. The first command,
`ForEach-Object` repeats the call to `Get-SecureRandom` from the piped in numbers (1-6). The results
are grouped by their value with `Group-Object` and formatted as a table with `Select-Object`.

```powershell
1..1200 | ForEach-Object {
    1..6 | Get-SecureRandom
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

### Example 11: Use the Count parameter

You can use the **Count** parameter without piping objects to `Get-SecureRandom`. The following
example gets three random numbers less than 10.

```powershell
Get-SecureRandom -Count 3 -Maximum 10
```

```Output
9
0
8
```

### Example 12: Use the InputObject parameter with an empty string or $null

In this example, the **InputObject** parameter specifies an array that contains an empty string
(`''`) and `$null`.

```powershell
Get-SecureRandom -InputObject @('a','',$null)
```

`Get-SecureRandom` returns either `a`, empty string, or `$null`. The empty sting displays as a blank
line and `$null` returns to a PowerShell prompt.

## PARAMETERS

### -Count

Specifies the number of random objects to return. The default is 1.

When used with `InputObject` containing a collection:

- Each randomly selected item is returned only once.
- If the value of **Count** exceeds the number of objects in the collection, all objects in the
  collection are returned in random order.

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

Specifies a collection of objects. `Get-SecureRandom` gets randomly selected objects in random order
from the collection up to the number specified by **Count**. Enter the objects, a variable that
contains the objects, or a command or expression that gets the objects. You can also pipe a
collection of objects to `Get-SecureRandom`.

The **InputObject** parameter accepts arrays that can contain an empty
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

Specifies a maximum value for the random number. `Get-SecureRandom` returns a value that's less than
the maximum (not equal). Enter an integer, a double-precision floating-point number, or an object
that can be converted to an integer or double, such as a numeric string ("100").

The value of **Maximum** must be greater than (not equal to) the value of **Minimum**. If the value
of **Maximum** or **Minimum** is a floating-point number, `Get-SecureRandom` returns a randomly
selected floating-point number.

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
**Maximum** or **Minimum** is a floating-point number, `Get-SecureRandom` returns a randomly
selected floating-point number.

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
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object

You can pipe any object to this cmdlet. It selects values randomly from the piped objects.

## OUTPUTS

### System.Int32

### System.Int64

### System.Double

### System.Management.Automation.PSObject

This cmdlet returns an integer or floating-point number, or an object selected randomly from a
submitted collection.

## NOTES

`Get-SecureRandom` doesn't always return the same data type as the input value. The following table
shows the output type for each of the numeric input types.

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

## RELATED LINKS

[Get-Random](Get-Random.md)
