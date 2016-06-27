---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293974
schema: 2.0.0
---

# Get-Random
## SYNOPSIS
Gets a random number, or selects objects randomly from a collection.

## SYNTAX

### RandomNumberParameterSet (Default)
```
Get-Random [-SetSeed <Int32>] [[-Maximum] <Object>] [-Minimum <Object>] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

### RandomListItemParameterSet
```
Get-Random [-SetSeed <Int32>] [-InputObject] <Object[]> [-Count <Int32>]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The Get-Random cmdlet gets a randomly selected number.
If you submit a collection of objects to Get-Random, it gets one or more randomly selected objects from the collection.

Without parameters or input, a Get-Random command returns a randomly selected 32-bit unsigned integer between 0 (zero) and Int32.MaxValue (0x7FFFFFFF, 2,147,483,647).

You can use the parameters of Get-Random to specify a seed number, minimum and maximum values, and the number of objects returned from a submitted collection.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Get-Random
3951433
```

This command gets a random integer between 0 (zero) and Int32.MaxValue.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>Get-Random -Maximum 100
47
```

This command gets a random integer between 0 (zero) and 99.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>Get-Random -Minimum -100 -Maximum 100
56
```

This command gets a random integer between -100 and 99.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>Get-Random -Minimum 10.7 -Maximum 20.93
18.08467273887
```

This command gets a random floating-point number greater than or equal to 10.7 and less than 20.92.

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>Get-Random -InputObject 1, 2, 3, 5, 8, 13
8
```

This command gets a randomly selected number from the specified array.

### -------------------------- EXAMPLE 6 --------------------------
```
PS C:\>Get-Random -InputObject 1, 2, 3, 5, 8, 13 -Count 3
3
1
13
```

This command gets three randomly selected numbers in random order from the array.

### -------------------------- EXAMPLE 7 --------------------------
```
PS C:\>Get-Random -InputObject 1, 2, 3, 5, 8, 13 -Count ([int]::MaxValue)
2
3
5
1
8
13
```

This command returns the entire collection in random order.
The value of the Count parameter is the MaxValue static property of integers.

To return an entire collection in random order, enter any number that is greater than or equal to the number of objects in the collection.

### -------------------------- EXAMPLE 8 --------------------------
```
PS C:\>Get-Random -InputObject "red", "yellow", "blue"
yellow
```

This command returns a random value from a non-numeric collection.

### -------------------------- EXAMPLE 9 --------------------------
```
PS C:\>get-process | Get-Random

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
144           4     2080        488    36     0.48   3164 wmiprvse
```

This command gets a randomly selected process from the collection of processes on the computer.

### -------------------------- EXAMPLE 10 --------------------------
```
PS C:\>Get-Content Servers.txt | Get-Random -Count (Get-Content Servers.txt).Count | foreach {Invoke-Command -ComputerName $_ -Command 'Get-Process PowerShell'}
```

This command runs a command on a series of remote computers in random order.

### -------------------------- EXAMPLE 11 --------------------------
```
PS C:\>Get-Random -Maximum 100 -SetSeed 23

# Commands with the default seed are pseudorandom

PS C:\>Get-Random -Maximum 100
59
PS C:\>Get-Random -Maximum 100
65
PS C:\>Get-Random -Maximum 100
21

# Commands with the same seed are not random

PS C:\>Get-Random -Maximum 100 -SetSeed 23
74
PS C:\>Get-Random -Maximum 100 -SetSeed 23
74
PS C:\>Get-Random -Maximum 100 -SetSeed 23
74

# SetSeed results in a repeatable series

PS C:\>Get-Random -Maximum 100 -SetSeed 23
74
PS C:\>Get-Random -Maximum 100
56
PS C:\>Get-Random -Maximum 100
84
PS C:\>Get-Random -Maximum 100
46
PS C:\>Get-Random -Maximum 100 -SetSeed 23
74
PS C:\>Get-Random -Maximum 100
56
PS C:\>Get-Random -Maximum 100
84
PS C:\>Get-Random -Maximum 100
46
```

This example shows the effect of using the SetSeed parameter.
Because SetSeed produces non-random behavior, it is typically used only to reproduce results, such as when debugging or analyzing a script.

### -------------------------- EXAMPLE 12 --------------------------
```
PS C:\>$files = dir -Path C:\* -Recurse
PS C:\>$sample = $files | Get-Random -Count 50
```

These commands get a randomly selected sample of 50 files from the C: drive of the local computer.

### -------------------------- EXAMPLE 13 --------------------------
```
PS C:\>Get-Random 10001
7600
```

This command gets a random integer less than 10001.
Because the Maximum parameter has position 1, you can omit the parameter name when the value is the first or only unnamed parameter in the command.

### -------------------------- EXAMPLE 14 --------------------------
```
PS C:\>Get-Random -Minimum ([Int64]::MinValue)3738173363251507200
PS C:\>Get-Random -Minimum ([Int32]::MaxValue)

Minimum (2147483647) cannot be greater than or equal to Maximum (2147483647).
    + CategoryInfo          : InvalidArgument: (:) [Get-Random], ArgumentException
    + FullyQualifiedErrorId : MinGreaterThanOrEqualMax,Microsoft.PowerShell.Commands.GetRandomCommand
```

These commands attempt to get randomly generated 64-bit numbers.

The first command succeeds, but the second command fails.
When the value of Minimum is a 32-bit integer, the default value of Maximum is Int32.MaxValues.
The command fails because the value of Maximum must be greater than the value of Minimum.

## PARAMETERS

### -Count
Determines how many objects are returned.
The default is 1.
If the value of Count exceeds the number of objects in the collection, Get-Random returns all of the objects in random order.

```yaml
Type: Int32
Parameter Sets: RandomListItemParameterSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationAction
@{Text=}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
@{Text=}

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies a collection of objects.
Get-Random gets randomly selected objects in random order from the collection.
Enter the objects, a variable that contains the objects, or a command or expression that gets the objects.
You can also pipe a collection of objects to Get-Random.

```yaml
Type: Object[]
Parameter Sets: RandomListItemParameterSet
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Maximum
Specifies a maximum value for the random number.
Get-Random returns a value that is less than the maximum (not equal).
Enter a 32-bit integer or a double-precision floating-point number, or an object that can be converted to an integer or double, such as a numeric string ("100").
On a 64-bit computer, you can also enter a 64-bit integer.

The value of Maximum must be greater than (not equal to) the value of Minimum.

If the value of Maximum or Minimum is a floating-point number, Get-Random returns a randomly selected floating-point number.
If the value of Minimum is a double (a floating-point number), the default value of Maximum is Double.MaxValue.
Otherwise, the default value is Int32.MaxValue.

On a 64-bit computer, if the value of Minimum is a 32-bit integer, the  default value of Maximum is Int32.MaxValue.
If the value of Minimum is a double (a floating-point number), the default value of Maximum is Double.MaxValue.
Otherwise, the default value is Int64.MaxValue.

```yaml
Type: Object
Parameter Sets: RandomNumberParameterSet
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Minimum
Specifies a minimum value for the random number.
Enter a 32-bit integer or a double-precision floating-point number, or an object that can be converted to an integer or double, such as a numeric string ("100").
On a 64-bit computer, you can enter a 64-bit integer.
The default value is 0 (zero).

The value of Minimum must be less than (not equal to) the value of Maximum.
If the value of Maximum or Minimum is a floating-point number, Get-Random returns a randomly selected floating-point number.

```yaml
Type: Object
Parameter Sets: RandomNumberParameterSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SetSeed
Specifies a seed value for the random number generator.
This seed value is used for the current command and for all subsequent Get-Random commands in the current session until you use SetSeed again or close the session.
You cannot reset the seed to its default, clock-based value.

The SetSeed parameter is not required.
By default, Get-Random uses the system clock to generate a seed value.
Because SetSeed results in non-random behavior, it is typically used only when trying to reproduce behavior, such as when debugging or analyzing a script that includes Get-Random commands.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Object
You can pipe one or more objects to Get-Random.
Get-Random selects values randomly from the piped objects.

## OUTPUTS

### System.Int32, System.Int64, System.Double
Get-Random returns an integer or floating-point number, or an object selected randomly from a submitted collection.

## NOTES
Get-Random sets a default seed for each session based on the system time clock when the session starts.

Beginning in Windows PowerShell 3.0, Get-Random supports 64-bit integers.
In Windows PowerShell 2.0, all values are cast to System.Int32.

## RELATED LINKS

