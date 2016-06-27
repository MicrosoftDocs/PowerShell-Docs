---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/?LinkID=525909
schema: 2.0.0
---

# Write-Information
## SYNOPSIS
Specifies how Windows PowerShell handles information stream data for a command.

## SYNTAX

```
Write-Information [-MessageData] <Object> [[-Tags] <String[]>]
```

## DESCRIPTION
Windows PowerShell 5.0 introduces a new, structured information stream (number 6 in Windows PowerShell streams) that you can use to transmit structured data between a script and its callers (or hosting environment).
Write-Information lets you add an informational message to the stream, and specify how Windows PowerShell handles information stream data for a command.

The $InformationPreference preference variable value determines whether the message you provide to Write-Information is displayed at the expected point in a script's operation.
Because the default value of this variable is SilentlyContinue, by default, informational messages are not shown.
If you don't want to change the value of $InformationPreference, you can override its value by adding the InformationAction common parameter to your command.
For more information, see about_Preference_Variables and about_CommonParameters.

Starting in Windows PowerShell 5.0, Write-Host is a wrapper for Write-Information.
You can now use Write-Host to emit output to the information stream, but the $InformationPreference preference variable and InformationAction common parameter do not affect Write-Host messages.
Information streams also work for PowerShell.Streams, jobs, scheduled jobs, and workflows.

Write-Information is also a supported workflow activity.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Get-WindowsFeature -Name p*; Write-Information -MessageData "Got your features!" -InformationAction Continue
Display Name                                            Name                       Install State
------------                                            ----                       -------------
[ ] Print and Document Services                         Print-Services                 Available
    [ ] Print Server                                    Print-Server                   Available
    [ ] Distributed Scan Server                         Print-Scan-Server              Available
    [ ] Internet Printing                               Print-Internet                 Available
    [ ] LPD Service                                     Print-LPD-Service              Available
[ ] Peer Name Resolution Protocol                       PNRP                           Available
[X] Windows PowerShell                                  PowerShellRoot                 Installed
    [X] Windows PowerShell 5.0                          PowerShell                     Installed
    [ ] Windows PowerShell 2.0 Engine                   PowerShell-V2                    Removed
    [X] Windows PowerShell ISE                          PowerShell-ISE                 Installed
Got your features!
```

In this example, you show an informational message, "Got your features!", after running the Get-WindowsFeature command to find all features that have a Name value that starts with "p".
Because the $InformationPreference variable is still set to its default, SilentlyContinue, you add the InformationAction parameter to override the $InformationPreference value, and show the message.
The InformationAction value is Continue, which means that your message is shown, but the script or command continues, if it is not yet finished.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>Get-WindowsFeature -Name p*; Write-Information -MessageData "To filter your results for PowerShell, pipe your results to the Where-Object cmdlet." -Tags "Instructions" -InformationAction Continue
Display Name                                            Name                       Install State
------------                                            ----                       -------------
[ ] Print and Document Services                         Print-Services                 Available
    [ ] Print Server                                    Print-Server                   Available
    [ ] Distributed Scan Server                         Print-Scan-Server              Available
    [ ] Internet Printing                               Print-Internet                 Available
    [ ] LPD Service                                     Print-LPD-Service              Available
[ ] Peer Name Resolution Protocol                       PNRP                           Available
[X] Windows PowerShell                                  PowerShellRoot                 Installed
    [X] Windows PowerShell 5.0                          PowerShell                     Installed
    [ ] Windows PowerShell 2.0 Engine                   PowerShell-V2                    Removed
    [X] Windows PowerShell ISE                          PowerShell-ISE                 Installed
To filter your results for PowerShell, pipe your results to the Where-Object cmdlet.
```

In this example, you use Write-Information to let users know they'll need to run another command after they're done running the current command.
The example adds the tag Instructions to the informational message.
After running this command, if you search the information stream for messages tagged Instructions, the message specified here would be among the results.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>function Test-Info
       { 
         Get-Process P*
         Write-Information "Here you go"
       }
Test-Info 6> Info.txt
```

In this example, you redirect the information stream in the function to a file, Info.txt, by using the code 6\>.
When you open the Info.txt file, you see the text, "Here you go."

## PARAMETERS

### -MessageData
Specifies an informational message that you want to display to users as they run a script or command.
For best results, enclose the informational message in quotation marks.
An example is "Test complete."

```yaml
Type: Object
Parameter Sets: (All)
Aliases: Msg

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tags
Specifies a simple string that you can use to sort and filter messages that you have added to the information stream with Write-Information.
This parameter works similarly to the Tags parameter in New-ModuleManifest.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### 
Write-Information does not accept piped input.

## OUTPUTS

### System.Management.Automation.InformationRecord

## NOTES

## RELATED LINKS

[about_CommonParameters]()

[about_Redirection]()

[about_Preference_Variables]()

