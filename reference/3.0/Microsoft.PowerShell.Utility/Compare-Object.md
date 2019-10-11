---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
ms.date: 09/17/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/compare-object?view=powershell-3.0&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Compare-Object
---

# Compare-Object

## SYNOPSIS
Compares two sets of objects.

## SYNTAX

### All

```
Compare-Object [-ReferenceObject] <PSObject[]> [-DifferenceObject] <PSObject[]>
 [-SyncWindow <Int32>] [-Property <Object[]>] [-ExcludeDifferent] [-IncludeEqual] [-PassThru]
 [-Culture <String>] [-CaseSensitive] [<CommonParameters>]
```

## DESCRIPTION

The `Compare-Object` cmdlet compares two sets of objects. One set of objects is the **reference**,
and the other set of objects is the **difference**.

The result of the comparison indicates whether a property value appeared only in the **reference**
object (`<=`) or only in the **difference** object (`=>`). If the **IncludeEqual** parameter is
used, (`==`) indicates the value is in both objects.

If the **reference** or the **difference** objects are null (`$null`), `Compare-Object` generates a
terminating error.

Some examples use splatting to reduce the line length of the code samples. For more information, see
[about_Splatting](../Microsoft.PowerShell.Core/About/about_Splatting.md). And, the examples use two
text files, with each value on a separate line. `Testfile1.txt` contains the values: dog, squirrel,
and bird. `Testfile2.txt` contains the values: cat, bird, and racoon.

## EXAMPLES

### Example 1: Compare the content of two text files

This example compares the contents of two text files. The output displays only the lines that are
different between the files. `Testfile1.txt` is the **reference** object (`<=`) and
`Testfile2.txt`is the **difference** object (`=>`).

Lines with content that appear in both files aren't displayed.

```powershell
Compare-Object -ReferenceObject $(Get-Content -Path C:\Test\Testfile1.txt) -DifferenceObject $(Get-Content -Path C:\Test\Testfile2.txt)
```

```Output
InputObject SideIndicator
----------- -------------
cat         =>
racoon      =>
dog         <=
squirrel    <=
```

### Example 2: Compare each line of content in two text files

This example uses the **IncludeEqual** to compare each line of content in two text files. All the
lines of content from both files are displayed.

The **SideIndicator** specifies if the line appears in the `Testfile1.txt` **reference** object
(`<=`), `Testfile2.txt` **difference** object (`=>`), or both files (`==`).

```powershell
$objects = @{
ReferenceObject = $(Get-Content -Path C:\Test\Testfile1.txt)
DifferenceObject = $(Get-Content -Path C:\Test\Testfile2.txt)
}
Compare-Object @objects -IncludeEqual
```

```Output
InputObject SideIndicator
----------- -------------
bird        ==
cat         =>
racoon      =>
dog         <=
squirrel    <=
```

### Example 3: Compare each line of content and exclude the differences

This example uses the **IncludeEqual** and **ExcludeDifferent** parameters to compare each line of
content in two text files.

Because the command uses the **ExcludeDifferent** parameter, the output only contains lines
contained in both files, as shown by the **SideIndicator** (`==`).

```powershell
$objects = @{
ReferenceObject = $(Get-Content -Path C:\Test\Testfile1.txt)
DifferenceObject = $(Get-Content -Path C:\Test\Testfile2.txt)
}
Compare-Object @objects -IncludeEqual -ExcludeDifferent
```

```Output
InputObject SideIndicator
----------- -------------
bird        ==
```

### Example 4: Compare two sets of process objects

This example compares two sets of objects that contain the computer's running processes.

```powershell
$Processes_Before = Get-Process
notepad.exe
$Processes_After = Get-Process
Compare-Object -ReferenceObject $Processes_Before -DifferenceObject $Processes_After
```

```Output
InputObject                            SideIndicator
-----------                            -------------
System.Diagnostics.Process (notepad)   =>
```

The `Get-Process` cmdlet gets the computer's running processes and stores them in the
`$Processes_Before` variable.

The **notepad.exe** application is started.

`Get-Process` gets the computer's updated list of running processes and stores them in the
`$Processes_After` variable.

The `Compare-Object` compare the two sets of process objects stored in the `$Processes_Before` and
`$Processes_After` variables. The output displays the difference, **notepad.exe**, from the
`$Processes_After` object.

## PARAMETERS

### -CaseSensitive

Indicates that comparisons should be case-sensitive.

```yaml
Type: SwitchParameter
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
Type: String
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
Type: PSObject[]
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
Type: SwitchParameter
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
Type: SwitchParameter
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
Type: SwitchParameter
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

```yaml
Type: Object[]
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
Type: PSObject[]
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
Type: Int32
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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can send an object down the pipeline to the **DifferenceObject** parameter.

## OUTPUTS

### None

If the **reference** object and the **difference** object are the same, there's no output.

### System.Management.Automation.PSCustomObject

If the objects are different, `Compare-Object` wraps the differing objects in a `PSCustomObject`
wrapper with a **SideIndicator** property to reference the differences. When you use the
**PassThru** parameter, `Compare-Object` omits the `PSCustomObject` wrapper around the compared
objects and returns the differing objects, unchanged.

## NOTES

## RELATED LINKS

[ForEach-Object](../Microsoft.PowerShell.Core/ForEach-Object.md)

[Group-Object](Group-Object.md)

[Measure-Object](Measure-Object.md)

[New-Object](New-Object.md)

[Select-Object](Select-Object.md)

[Sort-Object](Sort-Object.md)

[Tee-Object](Tee-Object.md)

[Where-Object](../Microsoft.PowerShell.Core/Where-Object.md)

[Get-Process](../Microsoft.PowerShell.Management/Get-Process.md)
