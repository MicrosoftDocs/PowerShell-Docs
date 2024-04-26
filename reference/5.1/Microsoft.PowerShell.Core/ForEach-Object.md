---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 04/26/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/foreach-object?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: ForEach-Object
---
# ForEach-Object

## SYNOPSIS
Performs an operation against each item in a collection of input objects.

## SYNTAX

### ScriptBlockSet (Default)

```
ForEach-Object [-InputObject <PSObject>] [-Begin <ScriptBlock>] [-Process] <ScriptBlock[]>
 [-End <ScriptBlock>] [-RemainingScripts <ScriptBlock[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### PropertyAndMethodSet

```
ForEach-Object [-InputObject <PSObject>] [-MemberName] <String> [-ArgumentList <Object[]>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `ForEach-Object` cmdlet performs an operation on each item in a collection of input objects. The
input objects can be piped to the cmdlet or specified using the **InputObject** parameter.

Starting in Windows PowerShell 3.0, there are two different ways to construct a `ForEach-Object`
command.

- **Script block**. You can use a script block to specify the operation. Within the script block,
  use the `$_` variable to represent the current object. The script block is the value of the
  **Process** parameter. The script block can contain any PowerShell script.

  For example, the following command gets the value of the **ProcessName** property of each process
  on the computer.

  `Get-Process | ForEach-Object {$_.ProcessName}`

  `ForEach-Object` supports the `begin`, `process`, and `end` blocks as described in
  [about_functions](about/about_functions.md#piping-objects-to-functions).

  > [!NOTE]
  > The script blocks run in the caller's scope. Therefore, the blocks have access to variables in
  > that scope and can create new variables that persist in that scope after the cmdlet completes.

- **Operation statement**. You can also write an operation statement, which is much more like
  natural language. You can use the operation statement to specify a property value or call a
  method. Operation statements were introduced in Windows PowerShell 3.0.

  For example, the following command also gets the value of the **ProcessName** property of each
  process on the computer.

  `Get-Process | ForEach-Object ProcessName`

## EXAMPLES

### Example 1: Divide integers in an array

This example takes an array of three integers and divides each one of them by 1024.

```powershell
30000, 56798, 12432 | ForEach-Object -Process {$_/1024}
```

```Output
29.296875
55.466796875
12.140625
```

### Example 2: Get the length of all the files in a directory

This example processes the files and directories in the PowerShell installation directory `$PSHOME`.

```powershell
Get-ChildItem $PSHOME |
  ForEach-Object -Process {if (!$_.PSIsContainer) {$_.Name; $_.Length / 1024; " " }}
```

If the object isn't a directory, the script block gets the name of the file, divides the value of
its **Length** property by 1024, and adds a space (" ") to separate it from the next entry. The
cmdlet uses the **PSISContainer** property to determine whether an object is a directory.

### Example 3: Operate on the most recent System events

This example writes the 1000 most recent events from the System event log to a text file. The
current time is displayed before and after processing the events.

```powershell
Get-EventLog -LogName System -Newest 1000 |
    ForEach-Object -Begin {Get-Date} -Process {
        Out-File -FilePath Events.txt -Append -InputObject $_.Message
    } -End {Get-Date}
```

`Get-EventLog` gets the 1000 most recent events from the System event log and pipes them to the
`ForEach-Object` cmdlet. The **Begin** parameter displays the current date and time. Next, the
**Process** parameter uses the `Out-File` cmdlet to create a text file that's named events.txt and
stores the message property of each of the events in that file. Last, the **End** parameter is used
to display the date and time after all the processing has completed.

### Example 4: Change the value of a Registry key

This example changes the value of the **RemotePath** registry entry in all the subkeys under the
`HKCU:\Network` key to uppercase text.

```powershell
Get-ItemProperty -Path HKCU:\Network\* |
  ForEach-Object {
    Set-ItemProperty -Path $_.PSPath -Name RemotePath -Value $_.RemotePath.ToUpper()
  }
```

You can use this format to change the form or content of a registry entry value.

Each subkey in the **Network** key represents a mapped network drive that reconnects at sign on. The
**RemotePath** entry contains the UNC path of the connected drive. For example, if you map the `E:`
drive to `\\Server\Share`, an **E** subkey is created in `HKCU:\Network` with the **RemotePath**
registry value set to `\\Server\Share`.

The command uses the `Get-ItemProperty` cmdlet to get all the subkeys of the **Network** key and the
`Set-ItemProperty` cmdlet to change the value of the **RemotePath** registry entry in each key. In
the `Set-ItemProperty` command, the path is the value of the **PSPath** property of the registry
key. This is a property of the Microsoft .NET Framework object that represents the registry key, not
a registry entry. The command uses the **ToUpper()** method of the **RemotePath** value, which is a
string **REG_SZ**.

Because `Set-ItemProperty` is changing the property of each key, the `ForEach-Object` cmdlet is
required to access the property.

### Example 5: Use the $null automatic variable

This example shows the effect of piping the `$null` automatic variable to the `ForEach-Object`
cmdlet.

```powershell
1, 2, $null, 4 | ForEach-Object {"Hello"}
```

```Output
Hello
Hello
Hello
Hello
```

Because PowerShell treats `$null` as an explicit placeholder, the `ForEach-Object` cmdlet generates
a value for `$null` as it does for other objects piped to it.

### Example 6: Get property values

This example gets the value of the **Path** property of all installed PowerShell modules using
the **MemberName** parameter of the `ForEach-Object` cmdlet.

```powershell
Get-Module -ListAvailable | ForEach-Object -MemberName Path
Get-Module -ListAvailable | Foreach Path
```

The second command is equivalent to the first. It uses the `Foreach` alias of the `ForEach-Object`
cmdlet and omits the name of the **MemberName** parameter, which is optional.

The `ForEach-Object` cmdlet is useful for getting property values, because it gets the value without
changing the type, unlike the **Format** cmdlets or the `Select-Object` cmdlet, which change the
property value type.

### Example 7: Split module names into component names

This example shows three ways to split two dot-separated module names into their component names.
The commands call the **Split** method of strings. The three commands use different syntax, but they
are equivalent and interchangeable. The output is the same for all three cases.

```powershell
"Microsoft.PowerShell.Core", "Microsoft.PowerShell.Host" |
    ForEach-Object {$_.Split(".")}
"Microsoft.PowerShell.Core", "Microsoft.PowerShell.Host" |
    ForEach-Object -MemberName Split -ArgumentList "."
"Microsoft.PowerShell.Core", "Microsoft.PowerShell.Host" |
    Foreach Split "."
```

```Output
Microsoft
PowerShell
Core
Microsoft
PowerShell
Host
```

The first command uses the traditional syntax, which includes a script block and the current object
operator `$_`. It uses the dot syntax to specify the method and parentheses to enclose the delimiter
argument.

The second command uses the **MemberName** parameter to specify the **Split** method and the
**ArgumentList** parameter to identify the dot (`.`) as the split delimiter.

The third command uses the **Foreach** alias of the `ForEach-Object` cmdlet and omits the names of
the **MemberName** and **ArgumentList** parameters, which are optional.

### Example 8: Using ForEach-Object with two script blocks

In this example, we pass two script blocks positionally. All the script blocks bind to the
**Process** parameter. However, they're treated as if they had been passed to the **Begin** and
**Process** parameters.

```powershell
1..2 | ForEach-Object { 'begin' } { 'process' }
```

```Output
begin
process
process
```

### Example 9: Using ForEach-Object with more than two script blocks

In this example, we pass four script blocks positionally. All the script blocks bind to the
**Process** parameter. However, they're treated as if they had been passed to the **Begin**,
**Process**, and **End** parameters.

```powershell
1..2 | ForEach-Object { 'begin' } { 'process A' }  { 'process B' }  { 'end' }
```

```Output
begin
process A
process B
process A
process B
end
```

> [!NOTE]
> The first script block is always mapped to the `begin` block, the last block is mapped to the
> `end` block, and the two middle blocks are mapped to the `process` block.

### Example 10: Run multiple script blocks for each pipeline item

As shown in the previous example, multiple script blocks passed using the **Process** parameter get
mapped to the **Begin** and **End** parameters. To avoid this mapping, you must provide explicit
values for the **Begin** and **End** parameters.

```powershell
1..2 | ForEach-Object -Begin $null -Process { 'one' }, { 'two' }, { 'three' } -End $null
```

```Output
one
two
three
one
two
three
```

## PARAMETERS

### -ArgumentList

Specifies an array of arguments to a method call. For more information about the behavior of
**ArgumentList**, see [about_Splatting](about/about_Splatting.md#splatting-with-arrays).

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Object[]
Parameter Sets: PropertyAndMethodSet
Aliases: Args

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Begin

Specifies a script block that runs before this cmdlet processes any input objects. This script block
is only run once for the entire pipeline. For more information about the `begin` block, see
[about_Functions](about/about_functions.md#piping-objects-to-functions).

```yaml
Type: System.Management.Automation.ScriptBlock
Parameter Sets: ScriptBlockSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -End

Specifies a script block that runs after this cmdlet processes all input objects. This script block
is only run once for the entire pipeline. For more information about the `end` block, see
[about_Functions](about/about_functions.md#piping-objects-to-functions).

```yaml
Type: System.Management.Automation.ScriptBlock
Parameter Sets: ScriptBlockSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the input objects. `ForEach-Object` runs the script block or operation statement on each
input object. Enter a variable that contains the objects, or type a command or expression that gets
the objects.

When you use the **InputObject** parameter with `ForEach-Object`, instead of piping command results
to `ForEach-Object`, the **InputObject** value is treated as a single object. This is true even if
the value is a collection that's the result of a command, such as `-InputObject (Get-Process)`.
Because **InputObject** can't return individual properties from an array or collection of objects,
we recommend that if you use `ForEach-Object` to perform operations on a collection of objects for
those objects that have specific values in defined properties, you use `ForEach-Object` in the
pipeline, as shown in the examples in this topic.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -MemberName

Specifies the name of the member property to get or the member method to call. The members must be
instance members, not static members.

Wildcard characters are permitted, but work only if the resulting string resolves to a unique value.
For example, if you run `Get-Process | ForEach -MemberName *Name`, the wildcard pattern matches more
than one member causing the command to fail.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.String
Parameter Sets: PropertyAndMethodSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Process

Specifies the operation that's performed on each input object. This script block is run for every
object in the pipeline. For more information about the `process` block, see
[about_Functions](about/about_functions.md#piping-objects-to-functions).

When you provide multiple script blocks to the **Process** parameter, the first script block is
always mapped to the `begin` block. If there are only two script blocks, the second block is mapped
to the `process` block. If there are three or more script blocks, first script block is always
mapped to the `begin` block, the last block is mapped to the `end` block, and the middle blocks are
mapped to the `process` block.

```yaml
Type: System.Management.Automation.ScriptBlock[]
Parameter Sets: ScriptBlockSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemainingScripts

Specifies all script blocks that aren't taken by the **Process** parameter.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.ScriptBlock[]
Parameter Sets: ScriptBlockSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet isn't run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object to this cmdlet.

## OUTPUTS

### System.Management.Automation.PSObject

This cmdlet returns objects that are determined by the input.

## NOTES

Windows PowerShell includes the following aliases for `ForEach-Object`:

  - `%`
  - `foreach`

The `ForEach-Object` cmdlet works much like the **Foreach** statement, except that you cannot pipe
input to a **Foreach** statement. For more information about the **Foreach** statement, see
[about_Foreach](./About/about_Foreach.md).

Starting in PowerShell 4.0, `Where` and `ForEach` methods were added for use with collections. You
can read more about these new methods here [about_arrays](./About/about_Arrays.md)

## RELATED LINKS

[Compare-Object](../Microsoft.PowerShell.Utility/Compare-Object.md)

[Where-Object](Where-Object.md)

[Group-Object](../Microsoft.PowerShell.Utility/Group-Object.md)

[Measure-Object](../Microsoft.PowerShell.Utility/Measure-Object.md)

[New-Object](../Microsoft.PowerShell.Utility/New-Object.md)

[Select-Object](../Microsoft.PowerShell.Utility/Select-Object.md)

[Sort-Object](../Microsoft.PowerShell.Utility/Sort-Object.md)

[Tee-Object](../Microsoft.PowerShell.Utility/Tee-Object.md)
