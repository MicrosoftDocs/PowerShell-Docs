---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=113279
external help file:  System.Management.Automation.dll-Help.xml
title:  Add-History
---
# Add-History

## SYNOPSIS

Appends entries to the session history.

## SYNTAX

```
Add-History [[-InputObject] <PSObject[]>] [-Passthru] [<CommonParameters>]
```

## DESCRIPTION

The **Add-History** cmdlet adds entries to the end of the session history, that is, the list of commands entered during the current session.

You can use the Get-History cmdlet to get the commands and pass them to **Add-History**, or you can export the commands to a CSV or XML file, then import the commands, and pass the imported file to **Add-History**.
You can use this cmdlet to add specific commands to the history or to create a single history file that includes commands from more than one session.

## EXAMPLES

### Example 1

```
PS> get-history | export-csv c:\testing\history.csv
PS> import-csv history.csv | add-history
```

These commands add the commands typed in one Windows PowerShell session to the history of a different Windows PowerShell session.
The first command gets objects representing the commands in the history and exports them to the History.csv file.
The second command is typed at the command line of a different session.
It uses the Import-Csv cmdlet to import the objects in the History.csv file.
The pipeline operator passes the objects to the **Add-History** cmdlet, which adds the objects representing the commands in the History.csv file to the current session history.

### Example 2

```
PS> import-clixml c:\temp\history.xml | add-history -passthru | foreach-object -process {invoke-history}
```

This command imports commands from the History.xml file, adds them to the current session history, and then executes the commands in the combined history.

The first command uses the Import-Clixml cmdlet to import a command history that was exported to the History.xml file.
The pipeline operator (|) passes the commands to the **Add-History** parameter, which adds the commands to the current session history.
The PassThru parameter passes the objects representing the added commands down the pipeline.

The command then uses the ForEach-Object cmdlet to apply the Invoke-History command to each of the commands in the combined history.
The **Invoke-History** command is formatted as a script block (enclosed in braces) as required by the **Process** parameter of the **ForEach-Object** cmdlet.

### Example 3

```
PS> get-history -id 5 -count 5 | add-history
```

This command adds the first five commands in the history to the end of the history list.
It uses the Get-History cmdlet to get the five commands ending in command 5.
The pipeline operator (|) passes them to the **Add-History** cmdlet, which appends them to the current history.
The **Add-History** command does not include any parameters, but Windows PowerShell associates the objects passed through the pipeline with the **InputObject** parameter of **Add-History**.

### Example 4

```
PS> $a = import-csv c:\testing\history.csv
PS> add-history -inputobject $a -passthru
```

These commands add the commands in the History.csv file to the current session history.
The first command uses the Import-Csv cmdlet to import the commands in the History.csv file and store its contents in the variable $a.
The second command uses the **Add-History** cmdlet to add the commands from History.csv to the current session history.
It uses the **InputObject** parameter to specify the $a variable and the **PassThru** parameter to generate an object to display at the command line.
Without the **PassThru** parameter, the **Add-History** cmdlet does not generate any output.

### Example 5

```
PS> add-history -inputobject (import-clixml c:\temp\history01.xml)
```

This command adds the commands in the History01.xml file to the current session history.
It uses the **InputObject** parameter to pass the results of the command in parentheses to the **Add-History** cmdlet.
The command in parentheses, which is executed first, imports the History01.xml file into Windows PowerShell.
The **Add-History** cmdlet then adds the commands in the file to the session history.

## PARAMETERS

### -InputObject

Adds the specified HistoryInfo object to the session history.
You can use this parameter to submit a HistoryInfo object, such as the ones that are returned by the Get-History, Import-Clixml, or Import-Csv cmdlets, to **Add-History**.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Passthru

Returns a history object for each history entry.
By default, this cmdlet does not generate any output.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](./About/about_CommonParameters.md).

## INPUTS

### Microsoft.PowerShell.Commands.HistoryInfo

You can pipe a HistoryInfo object to **Add-History**.

## OUTPUTS

### None or Microsoft.PowerShell.Commands.HistoryInfo

When you use the **PassThru** parameter, **Add-History** returns a HistoryInfo object.
Otherwise, this cmdlet does not generate any output.

## NOTES

- The session history is a list of the commands entered during the session along with the ID. The session history represents the order of execution, the status, and the start and end times of the command. As you enter each command, Windows PowerShell adds it to the history so that you can reuse it.  For more information about the session history, see [about_History](./About/about_History.md).

  To specify the commands to add to the history, use the **InputObject** parameter.
The **Add-History** command accepts only **HistoryInfo** objects, such as those returned for each command by the Get-History cmdlet.
You cannot pass it a path and file name or a list of commands.

  You can use the **InputObject** parameter to pass a file of HistoryInfo objects to **Add-History**.
To do so, export the results of a Get-History command to a file by using the Export-Csv or Export-Clixml cmdlet and then import the file by using the Import-Csv or Import-Clixml cmdlets.
You can then pass the file of imported HistoryInfo objects to **Add-History** through a pipeline or in a variable.
For more information, see the examples.

  The file of HistoryInfo objects that you pass to the **Add-History** cmdlet must include the type information, column headings, and all of the properties of the HistoryInfo objects.
If you intend to pass the objects back to **Add-History**, do not use the **NoTypeInformation** parameter of the Export-Csv cmdlet and do not delete the type information, column headings, or any fields in the file.

  To edit the session history, export the session to a CSV or XML file, edit the file, import the file, and use **Add-History** to append it to the current session history.

## RELATED LINKS

[Clear-History](Clear-History.md)

[Get-History](Get-History.md)

[Invoke-History](Invoke-History.md)

[about_History](About/about_History.md)