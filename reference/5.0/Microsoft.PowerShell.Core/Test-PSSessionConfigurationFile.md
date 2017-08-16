---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821522
external help file:  System.Management.Automation.dll-Help.xml
title:  Test-PSSessionConfigurationFile
---

# Test-PSSessionConfigurationFile

## SYNOPSIS
Verifies the keys and values in a session configuration file.

## SYNTAX

```
Test-PSSessionConfigurationFile [-Path] <String> [<CommonParameters>]
```

## DESCRIPTION
The **Test-PSSessionConfigurationFile** cmdlet verifies that a session configuration file contains valid keys and the values are of the correct type.
For enumerated values, the cmdlet verifies that the specified values are valid.

By default, **Test-PSSessionConfigurationFile** returns $True if the file passes all tests and $False if it does not.
To find any errors, use the *Verbose* common parameter.

**Test-PSSessionConfigurationFile** verifies the session configuration files, such as those created by the New-PSSessionConfigurationFile cmdlet.
For information about session configurations, see about_Session_Configurations (http://go.microsoft.com/fwlink/?LinkID=145152).
For information about session configuration files, see about_Session_Configuration_Files (http://go.microsoft.com/fwlink/?LinkID=236023).

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Test a session configuration file
```
PS C:\> Test-PSSessionConfigurationFile -Path "FullLanguage.pssc"
True
```

This command uses the **Test-PSSessionConfigurationFile** cmdlet to test a new session configuration file before using it in a session configuration.

### Example 2: Test the session configuration file of a session configuration
```
PS C:\> Test-PSSessionConfigurationFile -Path (Get-PSSessionConfiguration -Name Restricted).ConfigFilePath
```

This command tests the session configuration file that is being used to in the Restricted session configuration.
The value of the *Path* parameter is a Get-PSSessionConfiguration command that gets the Restricted session configuration.
The path of the session configuration file is stored in the value of the **ConfigFilePath** property of the session configuration.

### Example 3: Test all session configuration files
```
PS C:\> function Test-AllConfigFiles
{
    Get-PSSessionConfiguration | ForEach-Object { if ($_.ConfigFilePath)
    {$_.ConfigFilePath; Test-PSSessionConfigurationFile -Verbose `
     -Path $_.ConfigFilePath }}
}
C:\WINDOWS\System32\WindowsPowerShell\v1.0\SessionConfig\Empty_6fd77bf6-e084-4372-bd8a-af3e207354d3.psscTrueC:\WINDOWS\System32\WindowsPowerShell\v1.0\SessionConfig\Full_1e9cb265-dae0-4bd3-89a9-8338a47698a1.psscVERBOSE: The member 'AliasDefinitions' must contain the required key 'Description'. Add the require key to the fileC:\WINDOWS\System32\WindowsPowerShell\v1.0\SessionConfig\Full_1e9cb265-dae0-4bd3-89a9-8338a47698a1.pssc.FalseC:\WINDOWS\System32\WindowsPowerShell\v1.0\SessionConfig\NoLanguage_0c115179-ff2a-4f66-a5eb-e56e5692ba22.psscTrueC:\WINDOWS\System32\WindowsPowerShell\v1.0\SessionConfig\RestrictedLang_b6bd9474-0a6c-4e06-8722-c2c95bb10d3e.psscTrueC:\WINDOWS\System32\WindowsPowerShell\v1.0\SessionConfig\RRS_3fb29420-2c87-46e5-a402-e21436331efc.psscTrue
```

This function tests all session configuration files that are used in all session configurations on the local computer.

The function uses the Get-PSSessionConfiguration cmdlet to get all session configurations on the local computer.
The command pipes the session configuration to the ForEach-Object cmdlet, which runs a command on each of the session configurations.

The **ConfigFilePath** property of a session configuration contains the path of the session configuration file that is used in the session configuration, if any.

If the value of the **ConfigFilePath** property is populated (is true), the command gets (prints) the **ConfigFilePath** property value.
Then it uses the **Test-PSSessionConfigurationFile** cmdlet to test the file in the **ConfigFilePath** value.
The *Verbose* parameter returns the file error when the file fails the test.

## PARAMETERS

### -Path
Specifies the path and file name of a session configuration file (.pssc).
If you omit the path, the default is the current folder.
Wildcard characters are supported, but they must resolve to a single file.
You can also pipe a session configuration file path to **Test-PSSessionConfigurationFile**.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
You can pipe a session configuration file path to **Test-PSSessionConfigurationFile**.

## OUTPUTS

### System.Boolean

## NOTES

## RELATED LINKS

[Disable-PSSessionConfiguration](Disable-PSSessionConfiguration.md)

[Enable-PSSessionConfiguration](Enable-PSSessionConfiguration.md)

[Get-PSSessionConfiguration](Get-PSSessionConfiguration.md)

[New-PSSessionConfigurationFile](New-PSSessionConfigurationFile.md)

[Register-PSSessionConfiguration](Register-PSSessionConfiguration.md)

[Set-PSSessionConfiguration](Set-PSSessionConfiguration.md)

[Unregister-PSSessionConfiguration](Unregister-PSSessionConfiguration.md)

[WSMan Provider](../Microsoft.WsMan.Management/Providers/WSMan-Provider.md)

[about_Session_Configurations](About/about_Session_Configurations.md)

[about_Session_Configuration_Files](About/about_Session_Configuration_Files.md)

