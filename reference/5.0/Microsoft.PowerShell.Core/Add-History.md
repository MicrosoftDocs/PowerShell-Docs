---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821468
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

### Example 1: Add commands to the history of a different session
```
PS C:\> Get-History | Export-Csv c:\testing\history.csv
PS C:\> Import-Csv history.csv | Add-History
```

These commands add the commands typed in one Windows PowerShell session to the history of a different Windows PowerShell session.

The first command gets objects representing the commands in the history and exports them to the History.csv file.

The second command is typed at the command line of a different session.
It uses the **Import-Csv** cmdlet to import the objects in the History.csv file.
The pipeline operator (|) passes the objects to the **Add-History** cmdlet, which adds the objects representing the commands in the History.csv file to the current session history.

### Example 2: Import and run commands
```
PS C:\> Import-Clixml c:\temp\history.xml | Add-History -PassThru | ForEach-Object -Process {Invoke-History}
```

This command imports commands from the History.xml file, adds them to the current session history, and then runs the commands in the combined history.

The first command uses the **Import-Clixml** cmdlet to import a command history that was exported to the History.xml file.
The pipeline operator passes the commands to the **Add-History** cmdlet, which adds the commands to the current session history.
The *PassThru* parameter passes the objects representing the added commands down the pipeline.

The command then uses the ForEach-Object cmdlet to apply the Invoke-History command to each of the commands in the combined history.
The **Invoke-History** command is formatted as a script block, enclosed in braces, as required by the *Process* parameter of the **ForEach-Object** cmdlet.

### Example 3: Add commands in the history to the end of the history
```
PS C:\> Get-History -Id 5 -Count 5 | Add-History
```

This command adds the first five commands in the history to the end of the history list.
It uses the Get-History cmdlet to get the five commands ending in command 5.
The pipeline operator passes them to the **Add-History** cmdlet, which appends them to the current history.
The **Add-History** command does not include any parameters, but Windows PowerShell associates the objects passed through the pipeline with the *InputObject* parameter of **Add-History**.

### Example 4: Add commands in a .csv file to the current history
```
PS C:\> $a = Import-Csv c:\testing\history.csv
PS C:\> Add-History -InputObject $a -PassThru
```

These commands add the commands in the History.csv file to the current session history.

The first command uses the **Import-Csv** cmdlet to import the commands in the History.csv file and store its contents in the variable $a.

The second command uses the **Add-History** cmdlet to add the commands from History.csv to the current session history.
It uses the *InputObject* parameter to specify the $a variable and the *PassThru* parameter to generate an object to display at the command line.
Without the *PassThru* parameter, the **Add-History** cmdlet does not generate any output.

### Example 5: Add commands in an .xml file to the current history
```
PS C:\> Add-History -InputObject (Import-Clixml c:\temp\history01.xml)
```

This command adds the commands in the History01.xml file to the current session history.
It uses the *InputObject* parameter to pass the results of the command in parentheses to the **Add-History** cmdlet.
The command in parentheses, which is executed first, imports the History01.xml file into Windows PowerShell.
The **Add-History** cmdlet then adds the commands in the file to the session history.

## PARAMETERS

### -InputObject
Specifies an array of entries to add to the history as HistoryInfo object to the session history.
You can use this parameter to submit a **HistoryInfo** object, such as the ones that are returned by the **Get-History**, Import-Clixml, or Import-Csv cmdlets, to **Add-History**.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Passthru
Indicates that this cmdlet returns a history object for each history entry.
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Microsoft.PowerShell.Commands.HistoryInfo
You can pipe a **HistoryInfo** object to this cmdlet.

## OUTPUTS

### None or Microsoft.PowerShell.Commands.HistoryInfo
This cmdlet returns a **HistoryInfo** object if you specify the *PassThru* parameter.
Otherwise, this cmdlet does not generate any output.

## NOTES
* The session history is a list of the commands entered during the session together with the ID. The session history represents the order of execution, the status, and the start and end times of the command. As you enter each command, Windows PowerShell adds it to the history so that you can reuse it. For more information about the session history, see about_History.

  To specify the commands to add to the history, use the *InputObject* parameter.
The **Add-History** command accepts only **HistoryInfo** objects, such as those returned for each command by the **Get-History** cmdlet.
You cannot pass it a path and file name or a list of commands.

  You can use the *InputObject* parameter to pass a file of **HistoryInfo** objects to **Add-History**.
To do so, export the results of a **Get-History** command to a file by using the Export-Csv or Export-Clixml cmdlet and then import the file by using the **Import-Csv** or **Import-Clixml** cmdlets.
You can then pass the file of imported **HistoryInfo** objects to **Add-History** through a pipeline or in a variable.
For more information, see the examples.

  The file of **HistoryInfo** objects that you pass to the **Add-History** cmdlet must include the type information, column headings, and all of the properties of the **HistoryInfo** objects.
If you intend to pass the objects back to **Add-History**, do not use the *NoTypeInformation* parameter of the **Export-Csv** cmdlet and do not delete the type information, column headings, or any fields in the file.

  To modify the session history, export the session to a CSV or XML file, modify the file, import the file, and use **Add-History** to append it to the current session history.

*

## RELATED LINKS

[Clear-History](Clear-History.md)

[Get-History](Get-History.md)

[Invoke-History](Invoke-History.md)

[about_History](About/about_History.md)

