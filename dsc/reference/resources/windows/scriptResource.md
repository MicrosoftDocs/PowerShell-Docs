---
ms.date:  08/24/2018
keywords:  dsc,powershell,configuration,setup
title:  DSC Script Resource
---
# DSC Script Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.x

The **Script** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to run Windows PowerShell script blocks on target nodes. The **Script** resource uses `GetScript`, `SetScript`, and `TestScript` properties that contain script blocks you define to perform the corresponding DSC state operations.

## Syntax

```
Script [string] #ResourceName
{
    GetScript = [string]
    SetScript = [string]
    TestScript = [string]
    [ Credential = [PSCredential] ]
    [ DependsOn = [string[]] ]
}
```

> [!NOTE]
> The `GetScript`, `TestScript`, and `SetScript` blocks are stored as strings.

## Properties

|Property|Description|
|--------|-----------|
|GetScript|A script block that returns the current state of the Node.|
|SetScript|A script block that DSC uses to enforce compliance when the Node is not in the desired state.|
|TestScript|A script block that determines if the Node is in the desired state.|
|Credential| Indicates the credentials to use for running this script, if credentials are required.|
|DependsOn| Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is **ResourceName** and its type is **ResourceType**, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.

### GetScript

DSC does not use the output from `GetScript`. The [Get-DscConfiguration](/powershell/module/PSDesiredStateConfiguration/Get-DscConfiguration) cmdlet executes the `GetScript` to retrieve a node's current state. A return value is not required from `GetScript`. If you specify a return value, it must be a `hashtable` containing a **Result** key whose value is a `String`.

### TestScript

The `TestScript` is executed by DSC to determine if the `SetScript` should be run. If the `TestScript` returns `$false`, DSC executes the `SetScript` to bring the node back to the desired state. It must return a `boolean` value. A result of `$true` indicates that the node is compliant and `SetScript` should not executed.

The [Test-DscConfiguration](/powershell/module/PSDesiredStateConfiguration/Test-DscConfiguration) cmdlet, executes the `TestScript` to retrieve the nodes compliance with the  **Script** resources. However, in this case, the `SetScript` does not run, no matter what the `TestScript` block returns.

> [!NOTE]
> All output from your `TestScript` is part of its return value. PowerShell interprets unsuppressed output as non-zero, which means that your `TestScript` will return `$true` regardless of your node's state.
> This results in unpredictable results, false positives, and causes difficulty during troubleshooting.

### SetScript

The `SetScript` modifies the node to enforce the desired state. It is called by DSC if the `TestScript` script block returns `$false`. The `SetScript` should have no return value.

## Examples

### Example 1: Write sample text using a Script resource

This example tests for the existence of `C:\TempFolder\TestFile.txt` on each node. If it does not exist, it creates it using the `SetScript`. The `GetScript` returns the contents of the file, and its return value is not used.

```powershell
Configuration ScriptTest
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    Node localhost
    {
        Script ScriptExample
        {
            SetScript = {
                $sw = New-Object System.IO.StreamWriter("C:\TempFolder\TestFile.txt")
                $sw.WriteLine("Some sample string")
                $sw.Close()
            }
            TestScript = { Test-Path "C:\TempFolder\TestFile.txt" }
            GetScript = { @{ Result = (Get-Content C:\TempFolder\TestFile.txt) } }
        }
    }
}
```

### Example 2: Compare version information using a Script resource

This example retrieves the *compliant* version information from a text file on the authoring computer and stores it in the `$version` variable. When generating the node's MOF file, DSC replaces the `$using:version` variables in each script block with the value of the `$version` variable. During execution, the *compliant* version is stored in a text file on each Node and compared and updated on subsequent executions.

```powershell
$version = Get-Content 'version.txt'

Configuration ScriptTest
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    Node localhost
    {
        Script UpdateConfigurationVersion
        {
            GetScript = {
                $currentVersion = Get-Content (Join-Path -Path $env:SYSTEMDRIVE -ChildPath 'version.txt')
                return @{ 'Result' = "$currentVersion" }
            }
            TestScript = {
                # Create and invoke a scriptblock using the $GetScript automatic variable, which contains a string representation of the GetScript.
                $state = [scriptblock]::Create($GetScript).Invoke()

                if( $state['Result'] -eq $using:version )
                {
                    Write-Verbose -Message ('{0} -eq {1}' -f $state['Result'],$using:version)
                    return $true
                }
                Write-Verbose -Message ('Version up-to-date: {0}' -f $using:version)
                return $false
            }
            SetScript = {
                $using:version | Set-Content -Path (Join-Path -Path $env:SYSTEMDRIVE -ChildPath 'version.txt')
            }
        }
    }
}
```
