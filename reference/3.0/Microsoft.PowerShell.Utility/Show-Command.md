---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=217448
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Show-Command
---

# Show-Command
## SYNOPSIS
Creates Windows PowerShell commands in a graphical command window.
## SYNTAX

```
Show-Command [[-Name] <String>] [-Height <Double>] [-Width <Double>] [-NoCommonParameter] [-ErrorPopup]
 [-PassThru] [<CommonParameters>]
```

## DESCRIPTION
The **Show-Command** cmdlet lets you create a Windows PowerShell command in a command window.
You can use the features of the command window to run the command or have it return the command to you.

**Show-Command** is a very useful teaching and learning tool.
**Show-Command** works on all command types, including cmdlets, functions, workflows and CIM commands.

Without parameters, **Show-Command** displays a command window that lists all available commands in all installed modules.
To find the commands in a module, select the module from the Modules drop-down list.
To select a command, click the command name.

To use the command window, select a command, either by using the **Name** parameter or by clicking the command name in the **Commands** list.
Each parameter set is displayed on a separate tab.
Asterisks indicate the mandatory parameters.
To enter values for a parameter, type the value in the text box or select the value from the drop-down box.
To add a switch parameter, click to select the parameter check box.

When you're ready, you can click **Copy** to copy the command that you've created to the clipboard or click **Run** to run the command.
You can also use the **Passthru** parameter to return the command to the host program, such as the Windows PowerShell console.
To cancel the command selection and return to the view that displays all commands, press Ctrl and click the selected command.

In the Windows PowerShell Integrated Scripting Environment (ISE), a variation of the **Show-Command** window is displayed by default.
For information about using this command window, see the Windows PowerShell ISE help topics.

This cmdlet is introduced in Windows PowerShell 3.0.
## EXAMPLES

### Example 1
```
PS C:\> Show-Command
```

This command displays the default view of the **Show-Command** window.
The command window displays a list of all commands in all modules that are installed on the computer.
### Example 2
```
PS C:\> Show-Command -Name Invoke-Command
```

This command opens the Invoke-Command cmdlet display in the **Show-Command** window.
You can use the Invoke-Command display to run **Invoke-Command** commands.
### Example 3
```
PS C:\> Show-Command -Name Connect-PSSession -Height 700 -Width 1000 -ErrorPopup
```

This command opens a **Show-Command** window for the Connect-PSSession cmdlet.
It uses the **Height** and **Width** parameters to specify the dimension of the command window and the **ErrorPopup** parameter to display the error command window.

When you click **Run**, the **Connect-PSSession** command runs, just as would if you typed the **Connect-PSSession** command at the command line.
### Example 4
```
PS C:\> $PSDefaultParameterValues = @{"Show-Command:Height" = 700; "Show-Command:Width" = 1000; "Show-Command:ErrorPopup" = $True}
```

This command uses the **$PSDefaultParameterValues** automatic variable to set new default values for the **Height**, **Width**, and **ErrorPopup** parameters of the **Show-Command** cmdlet.
Now when you run a **Show-Command** command, the new defaults are applied automatically.

To use these default values in every Windows PowerShell session, add the **$PSDefaultParameterValues** variable to your Windows PowerShell profile.
For more information, see about_Profiles (http://go.microsoft.com/fwlink/?LinkID=113729) and [about_Parameters_Default_Values](../Microsoft.PowerShell.Core/About/about_Parameters_Default_Values.md).

### Example 5
```
PS C:\> Show-Command Get-ChildItem | Out-GridView
```

This command shows how to use the **Show-Command** and Out-GridView cmdlets together.

The command uses the **Show-Command** cmdlet to open a command window for the Get-ChildItem cmdlet.
When you click the **Run** button, the **Get-ChildItem** command runs and generates output.
The pipeline operator ( | ) sends the output of the **Get-ChildItem** command to the **Out-GridView** cmdlet, which displays the **Get-ChildItem** output in an interactive window.
### Example 6
```
PS C:\> Show-Command -Passthru
Get-EventLog -LogName "Windows PowerShell" -Newest 5
```

This command shows the command that you created in the **Show-Command** window.
The command uses the **Passthru** parameter, which returns the **Show-Command** results in a string.

For example, if you use the **Show-Command** window to create a Get-EventLog command that gets the five newest events in the Windows PowerShell event log, and then click **OK**, the command returns the following output.

Viewing the command string helps you to learn Windows PowerShell.
### Example 7
```
The first command uses the **PassThru** parameter of the **Show-Command** cmdlet. It saves the results of the command in the $c variable.The command opens a Show-Command window. In this case, we use the **Show-Command** window to create a Get-EventLog command that gets the five newest events in the Windows PowerShell event log. When you click **OK**, **Show-Command** returns the command string, which is saved in the $c variable.
PS C:\> $c = Show-Command -Passthru

This command displays the command string in the $c variable.
PS C:\> $c
Get-EventLog -LogName "Windows PowerShell" -Newest 5

These commands use the Invoke-Expression cmdlet to run the string in the $c variable. The first command uses the full cmdlet name. The second command uses the "iex" alias for the Invoke-Expression cmdlet. These commands are equivalent and you can use them interchangeably.The output shows the five newest events in the Windows PowerShell event log.
PS C:\> Invoke-Expression $c
                         
PS C:\> iex $c
   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
   11520 Dec 16 16:37  Information PowerShell                    400 Engine state is changed from None to Available....
   11519 Dec 16 16:37  Information PowerShell                    600 Provider "Variable" is Started. ...
   11518 Dec 16 16:37  Information PowerShell                    600 Provider "Registry" is Started. ...
   11517 Dec 16 16:37  Information PowerShell                    600 Provider "Function" is Started. ...
   11516 Dec 16 16:37  Information PowerShell                    600 Provider "FileSystem" is Started. ...
```

This command shows how to run the command string that you get when you use the **PassThru** parameter of the **Show-Command** cmdlet.
This strategy lets you see the command and use it.
### Example 8
```
The first command runs the **Show-Command** cmdlet with the **ErrorPopup** parameter. In addition to displaying errors in a window, **ErrorPopup** returns command output to the current command, instead of creating a new command.When you run this command, the **Show-Command** window opens. You can use the window features to set parameter values. To run the command, click the **Run** button in the **Show-Command** window. 
PS C:\> $p = Show-Command Get-Process -ErrorPopup

The second command displays the value in the $p variable.
PS C:\> $p
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName

-------  ------    -----      ----- -----   ------     -- -----------

    473      33    94096     112532   709     2.06   4492 powershell
```

These commands use the **ErrorPopup** parameter of the **Show-Command** cmdlet to save the output of a command in a variable.
## PARAMETERS

### -Height
Specifies the height of the **Show-Command** window in pixels.
Enter a value between 300 and the number of pixels in the screen resolution.
If the value is too large to display the command window on the screen, **Show-Command** generates an error.
The default height is 600 pixels.
For a **Show-Command** command that includes the **Name** parameter, the default height is 300 pixels.

```yaml
Type: Double
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 600 or 300
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Displays a command window for the specified command.
Enter the name of one command, such as the name of a cmdlet, function, workflow, or CIM command.
If you omit this parameter, **Show-Command** displays a command window that lists all of the Windows PowerShell commands in all modules installed on the computer.

```yaml
Type: String
Parameter Sets: (All)
Aliases: CommandName

Required: False
Position: 1
Default value: All commands
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoCommonParameter
Omits the Common Parameters section of the command display.
By default, the Common Parameters appear in an expandable section at the bottom of the command window.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: Show common parameters
Accept pipeline input: False
Accept wildcard characters: False
```

### -Width
Specifies the width of the **Show-Command** window in pixels.
Enter a value between 300 and the number of pixels in the screen resolution.
If the value is too large to display the command window on the screen, Show-Command generates an error.
The default width is 300 pixels.

```yaml
Type: Double
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: Variable
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Displays the command string in the console, instead of running it.

To run the command string, copy and paste it at the command prompt or save it in a variable and use the Invoke-Expression cmdlet to run the string in the variable.

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

### -ErrorPopup
Displays errors in a pop-up window, in addition to displaying them at the command line.
By  default, when a command that is run in a **Show-Command** window generates an error, the error is displayed only at the command line.

Also, when you run the command (by using the **Run** button in the **Show-Command** window), the **ErrorPopup** parameter returns the command results to the current command, instead of running the command and returning its output to a new command.
You can use this feature to save the command results in a variable.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: No error popup
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### None
You cannot pipe input to **Show-Command**.
## OUTPUTS

### System.String, System.Object
When you use the **PassThru** parameter, **Show-Command** returns a command string.
When you use the **ErrorPopup** parameter, **Show-Command** returns the command output (any object).Otherwise, **Show-Command** does not generate any output.
## NOTES
* **Show-Command** does not work in remote sessions.
## RELATED LINKS

