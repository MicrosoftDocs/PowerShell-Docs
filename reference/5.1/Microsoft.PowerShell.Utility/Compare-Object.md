---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 08/10/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/compare-object?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Compare-Object
---
# Compare-Object

## Synopsis
Compares two sets of objects.

## Syntax

```
Compare-Object [-ReferenceObject] <PSObject[]> [-DifferenceObject] <PSObject[]>
 [-SyncWindow <Int32>] [-Property <Object[]>] [-ExcludeDifferent] [-IncludeEqual] [-PassThru]
 [-Culture <String>] [-CaseSensitive] [<CommonParameters>]
```

## Description

The `Compare-Object` cmdlet compares two sets of objects. One set of objects is the **reference**,
and the other set of objects is the **difference**.

`Compare-Object` checks for available methods of comparing a whole object. If it can't find a
suitable method, it calls the **ToString()** methods of the input objects and compares the string
results. You can provide one or more properties to be used for comparison. When properties are
provided, the cmdlet compares the values of those properties only.

The result of the comparison indicates whether a property value appeared only in the **reference**
object (`<=`) or only in the **difference** object (`=>`). If the **IncludeEqual** parameter is
used, (`==`) indicates the value is in both objects.

If the **reference** or the **difference** objects are null (`$null`), `Compare-Object` generates a
terminating error.

Some examples use splatting to reduce the line length of the code samples. For more information, see
[about_Splatting](../Microsoft.PowerShell.Core/About/about_Splatting.md).

## Examples

### Example 1 - Compare the content of two text files

This example compares the contents of two text files. The example uses the following two text files,
with each value on a separate line.

- `Testfile1.txt` contains the values: dog, squirrel, and bird.
- `Testfile2.txt` contains the values: cat, bird, and racoon.

The output displays only the lines that are different between the files. `Testfile1.txt` is the
**reference** object (`<=`) and `Testfile2.txt`is the **difference** object (`=>`). Lines with
content that appear in both files aren't displayed.

```powershell
Compare-Object -ReferenceObject (Get-Content -Path C:\Test\Testfile1.txt) -DifferenceObject (Get-Content -Path C:\Test\Testfile2.txt)
```

```Output
InputObject SideIndicator
----------- -------------
cat         =>
racoon      =>
dog         <=
squirrel    <=
```

### Example 2 - Compare each line of content and exclude the differences

This example uses the **IncludeEqual** and **ExcludeDifferent** parameters to compare each line of
content in two text files.

Because the command uses the **ExcludeDifferent** parameter, the output only contains lines
contained in both files, as shown by the **SideIndicator** (`==`).

```powershell
$objects = @{
  ReferenceObject = (Get-Content -Path C:\Test\Testfile1.txt)
  DifferenceObject = (Get-Content -Path C:\Test\Testfile2.txt)
}
Compare-Object @objects -IncludeEqual -ExcludeDifferent
```

```Output
InputObject SideIndicator
----------- -------------
bird        ==
```

<a id="ex3" />

### Example 3 - Show the difference when using the PassThru parameter

Normally, `Compare-Object` returns a **PSCustomObject** type with the following properties:

- The **InputObject** being compared
- The **SideIndicator** property showing which input object the output belongs to

When you use the **PassThru** parameter, the **Type** of the object is not changed but the instance
of the object returned has an added **NoteProperty** named **SideIndicator**. **SideIndicator**
shows which input object the output belongs to.

The following examples shows the different output types.

```powershell
$a = $True
Compare-Object -IncludeEqual $a $a
(Compare-Object -IncludeEqual $a $a) | Get-Member
```

```Output
InputObject SideIndicator
----------- -------------
       True ==

   TypeName: System.Management.Automation.PSCustomObject
Name          MemberType   Definition
----          ----------   ----------
Equals        Method       bool Equals(System.Object obj)
GetHashCode   Method       int GetHashCode()
GetType       Method       type GetType()
ToString      Method       string ToString()
InputObject   NoteProperty System.Boolean InputObject=True
SideIndicator NoteProperty string SideIndicator===
```

```powershell
Compare-Object -IncludeEqual $a $a -PassThru
(Compare-Object -IncludeEqual $a $a -PassThru) | Get-Member
```

```Output
True

   TypeName: System.Boolean
Name          MemberType   Definition
----          ----------   ----------
CompareTo     Method       int CompareTo(System.Object obj), int CompareTo(bool value), int IComparable.CompareTo(Syst
Equals        Method       bool Equals(System.Object obj), bool Equals(bool obj), bool IEquatable[bool].Equals(bool ot
GetHashCode   Method       int GetHashCode()
GetType       Method       type GetType()
GetTypeCode   Method       System.TypeCode GetTypeCode(), System.TypeCode IConvertible.GetTypeCode()
ToBoolean     Method       bool IConvertible.ToBoolean(System.IFormatProvider provider)
ToByte        Method       byte IConvertible.ToByte(System.IFormatProvider provider)
ToChar        Method       char IConvertible.ToChar(System.IFormatProvider provider)
ToDateTime    Method       datetime IConvertible.ToDateTime(System.IFormatProvider provider)
ToDecimal     Method       decimal IConvertible.ToDecimal(System.IFormatProvider provider)
ToDouble      Method       double IConvertible.ToDouble(System.IFormatProvider provider)
ToInt16       Method       short IConvertible.ToInt16(System.IFormatProvider provider)
ToInt32       Method       int IConvertible.ToInt32(System.IFormatProvider provider)
ToInt64       Method       long IConvertible.ToInt64(System.IFormatProvider provider)
ToSByte       Method       sbyte IConvertible.ToSByte(System.IFormatProvider provider)
ToSingle      Method       float IConvertible.ToSingle(System.IFormatProvider provider)
ToString      Method       string ToString(), string ToString(System.IFormatProvider provider), string IConvertible.To
ToType        Method       System.Object IConvertible.ToType(type conversionType, System.IFormatProvider provider)
ToUInt16      Method       ushort IConvertible.ToUInt16(System.IFormatProvider provider)
ToUInt32      Method       uint IConvertible.ToUInt32(System.IFormatProvider provider)
ToUInt64      Method       ulong IConvertible.ToUInt64(System.IFormatProvider provider)
TryFormat     Method       bool TryFormat(System.Span[char] destination, [ref] int charsWritten)
SideIndicator NoteProperty string SideIndicator===
```

When using **PassThru**, the original object type (**System.Boolean**) is returned. Note how the
output displayed by the default format for **System.Boolean** objects didn't display the
**SideIndicator** property. However, the returned **System.Boolean** object has the added
**NoteProperty**.

### Example 4 - Compare two simple objects using properties

In this example, we compare two different string that have the same length.

```powershell
Compare-Object -ReferenceObject 'abc' -DifferenceObject 'xyz' -Property Length -IncludeEqual
```

```Output
Length SideIndicator
------ -------------
     3 ==
```

### Example 5 - Comparing complex objects using properties

This example shows the behavior when comparing complex objects. In this example we store two
different process objects for different instances of PowerShell. Both variables contain process
objects with the same name. When the objects are compared without specifying the **Property**
parameter, the cmdlet considers the objects to be equal. Notice that the value of the
**InputObject** is the same as the result of the **ToString()** method. Since the
**System.Diagnostics.Process** class does not have the **IComparable** interface, the cmdlet
converts the objects to strings then compares the results.

```powershell
PS> Get-Process pwsh

 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
    101   123.32     139.10      35.81   11168   1 pwsh
     89   107.55      66.97      11.44   17600   1 pwsh

PS> $a = Get-Process -Id 11168
PS> $b = Get-Process -Id 17600
PS> $a.ToString()
System.Diagnostics.Process (pwsh)
PS> $b.ToString()
System.Diagnostics.Process (pwsh)
PS> Compare-Object $a $b -IncludeEqual

InputObject                       SideIndicator
-----------                       -------------
System.Diagnostics.Process (pwsh) ==

PS> Compare-Object $a $b -Property ProcessName, Id, CPU

ProcessName    Id       CPU SideIndicator
-----------    --       --- -------------
pwsh        17600   11.4375 =>
pwsh        11168 36.203125 <=
```

When you specify properties to be compared, the cmdlet shows the differences.

### Example 6 - Comparing complex objects that implement IComparable

If the object implements **IComparable**, the cmdlet searches for ways to compare the objects.If the
objects are different types, the **Difference** object is converted to the type of the
**ReferenceObject** then compared.

In this example, we are comparing a string to a **TimeSpan** object. In the first case, the string
is converted to a **TimeSpan** so the objects are equal.

```powershell
Compare-Object ([TimeSpan]"0:0:1") "0:0:1" -IncludeEqual
```

```Output
InputObject SideIndicator
----------- -------------
00:00:01    ==
```

```powershell
Compare-Object "0:0:1" ([TimeSpan]"0:0:1")
```

```Output
InputObject SideIndicator
----------- -------------
00:00:01    =>
0:0:1       <=
```

In the second case, the **TimeSpan** is converted to a string so the object are different.

## Parameters

### -CaseSensitive

Indicates that comparisons should be case-sensitive.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Culture

Specifies the culture to use for comparisons.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DifferenceObject

Specifies the objects that are compared to the **reference** objects.

```yaml
Type: System.Management.Automation.PSObject[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ExcludeDifferent

Indicates that this cmdlet displays only the characteristics of compared objects that are equal. The
differences between the objects are discarded.

Use **ExcludeDifferent** with **IncludeEqual** to display only the lines that match between the
**reference** and **difference** objects.

If **ExcludeDifferent** is specified without **IncludeEqual**, there's no output.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeEqual

**IncludeEqual** displays the matches between the **reference** and **difference** objects.

By default, the output also includes the differences between the **reference** and **difference**
objects.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru

When you use the **PassThru** parameter, `Compare-Object` omits the **PSCustomObject** wrapper
around the compared objects and returns the differing objects, unchanged.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Property

Specifies an array of properties of the **reference** and **difference** objects to compare.

The value of the **Property** parameter can be a new calculated property. The calculated property
can be a script block or a hash table. Valid key-value pairs are:

- Expression - `<string>` or `<script block>`

For more information, see
[about_Calculated_Properties](../Microsoft.PowerShell.Core/About/about_Calculated_Properties.md).

```yaml
Type: System.Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReferenceObject

Specifies an array of objects used as a reference for comparison.

```yaml
Type: System.Management.Automation.PSObject[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SyncWindow

Specifies the number of adjacent objects that `Compare-Object` inspects while looking for a match in
a collection of objects. `Compare-Object` examines adjacent objects when it doesn't find the object
in the same position in a collection. The default value is `[Int32]::MaxValue`, which means that
`Compare-Object` examines the entire object collection.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: [Int32]::MaxValue
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.Management.Automation.PSObject

You can send an object down the pipeline to the **DifferenceObject** parameter.

## Outputs

### None

If the **reference** object and the **difference** object are the same, there's no output, unless
you use the **IncludeEqual** parameter.

### System.Management.Automation.PSCustomObject

If the objects are different, `Compare-Object` wraps the differing objects in a `PSCustomObject`
wrapper with a **SideIndicator** property to reference the differences.

When you use the **PassThru** parameter, the **Type** of the object is not changed but the instance
of the object returned has an added **NoteProperty** named **SideIndicator**. **SideIndicator**
shows which input object the output belongs to.

## Notes

When using the **PassThru** parameter, the output displayed in the console may not include the
**SideIndicator** property. The default format view of the for the object type output by
`Compare-Object` does not include the **SideIndicator** property. For more information see
[Example 3](#ex3) in this article.

## Related links

[about_Calculated_Properties](../Microsoft.PowerShell.Core/About/about_Calculated_Properties.md)

[ForEach-Object](../Microsoft.PowerShell.Core/ForEach-Object.md)

[Group-Object](Group-Object.md)

[Measure-Object](Measure-Object.md)

[New-Object](New-Object.md)

[Select-Object](Select-Object.md)

[Sort-Object](Sort-Object.md)

[Tee-Object](Tee-Object.md)

[Where-Object](../Microsoft.PowerShell.Core/Where-Object.md)

[Get-Process](../Microsoft.PowerShell.Management/Get-Process.md)
