---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC Script Resource
---
# DSC Script Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

The **Script** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to run Windows PowerShell script blocks on target nodes. The `Script` resource uses `GetScript`, `SetScript`, and `TestScript` properties that contain script blocks you define to perform the corresponding DSC state operations.

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

You should define the `GetScript` to return a `hashtable` representing the state of the current node. The `hashtable` must only contain a **Result** key, and the value must be of type `String`. The `GetScript` is not *required* to return anything because DSC doesn't do anything with the output.

When using the [Get-DscConfiguration](https://technet.microsoft.com/library/dn407379.aspx) cmdlet, the Script resource's `GetScript` executes to return the Node's current state.

### TestScript

You should define the `TestScript` to determine if the current node needs to be modified. You can design your `TestScript` to use your `GetScript` to determine the current state of the node.

The `TestScript` must return a `boolean` value. You should return `$true` if the node is in the desired state, and `$false` if it is not. If the `TestScript` returns `$false`, DSC executes the `SetScript` to bring the node back to the desired state.

When using the [Test-DscConfiguration](https://technet.microsoft.com/en-us/library/dn407382.aspx) cmdlet, the Script resource's `TestScript` executes to return the nodes compliance. However, in this case, the `SetScript` will not run, no matter what the `TestScript` block returns.

> [!NOTE]
> You should ensure that all other output from your `TestScript` is suppressed so it does not become part of its return value. Unsuppressed output from your `TestScript` can yield
> unpredictable results, false positives, and cause difficulty during troubleshooting.

### SetScript

You should define the `SetScript` script block to modify the node. It is called by DSC if the `TestScript` script block returns `$false`. The `SetScript` should have no return value.

## Examples

### Example 1: Write sample text using a Script resource

This example tests for the existence of `C:\TempFolder\TestFile.txt` on each node. If it does not exist, it creates it using the `SetScript`. The `GetScript` returns the contents of the file, and its return value is not used.

```powershell
Configuration ScriptTest
{
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'

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
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'

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