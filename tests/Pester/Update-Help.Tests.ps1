# Test Settings:
# This is the list of PowerShell Core modules for which we test update-help
$powershellCoreModules = @(
    "Microsoft.PowerShell.Host"
    "Microsoft.PowerShell.Core"
    "Microsoft.PowerShell.Diagnostics"
    "Microsoft.PowerShell.Management"
    "Microsoft.PowerShell.Security"
    "Microsoft.PowerShell.Utility"
    "Microsoft.WsMan.Management"
)

# The file extension for the help content on the Download Center.
# For Linux we use zip, and on Windows we use $extension.
$extension = ".cab"

# This is the list of test cases -- each test case represents a PowerShell Core module.
$testCases = @{

    "Microsoft.PowerShell.Core" = @{
        HelpFiles            = "System.Management.Automation.dll-help.xml"
        HelpInfoFiles        = "Microsoft.PowerShell.Core_00000000-0000-0000-0000-000000000000_HelpInfo.xml"
        CompressedFiles      = "Microsoft.PowerShell.Core_00000000-0000-0000-0000-000000000000_en-US_HelpContent$extension"
        HelpInstallationPath = "$pshome\en-US"
    }

    "Microsoft.PowerShell.Diagnostics" = @{
        HelpFiles            = "Microsoft.PowerShell.Commands.Diagnostics.dll-help.xml"
        HelpInfoFiles        = "Microsoft.PowerShell.Diagnostics_ca046f10-ca64-4740-8ff9-2565dba61a4f_HelpInfo.xml"
        CompressedFiles      = "Microsoft.PowerShell.Diagnostics_ca046f10-ca64-4740-8ff9-2565dba61a4f_en-US_helpcontent$extension"
        HelpInstallationPath = "$pshome\en-US"
    }

    "Microsoft.PowerShell.Host" = @{
        HelpFiles            = "Microsoft.PowerShell.ConsoleHost.dll-help.xml"
        HelpInfoFiles        = "Microsoft.PowerShell.Host_56d66100-99a0-4ffc-a12d-eee9a6718aef_HelpInfo.xml"
        CompressedFiles      = "Microsoft.PowerShell.Host_56d66100-99a0-4ffc-a12d-eee9a6718aef_en-US_helpcontent$extension"
        HelpInstallationPath = "$pshome\en-US"
    }

    "Microsoft.PowerShell.Management" = @{
        HelpFiles            = "Microsoft.PowerShell.Commands.Management.dll-help.xml"
        HelpInfoFiles        = "Microsoft.PowerShell.Management_eefcb906-b326-4e99-9f54-8b4bb6ef3c6d_HelpInfo.xml"
        CompressedFiles      = "Microsoft.PowerShell.Management_eefcb906-b326-4e99-9f54-8b4bb6ef3c6d_en-US_helpcontent$extension"
        HelpInstallationPath = "$pshome\en-US"
    }

    "Microsoft.PowerShell.Security" = @{
        HelpFiles            = "Microsoft.PowerShell.Security.dll-help.xml"
        HelpInfoFiles        = "Microsoft.PowerShell.Security_a94c8c7e-9810-47c0-b8af-65089c13a35a_HelpInfo.xml"
        CompressedFiles      = "Microsoft.PowerShell.Security_a94c8c7e-9810-47c0-b8af-65089c13a35a_en-US_helpcontent$extension"
        HelpInstallationPath = "$pshome\en-US"
    }

    "Microsoft.PowerShell.Utility" = @{
        HelpFiles            = "Microsoft.PowerShell.Commands.Utility.dll-Help.xml", "Microsoft.PowerShell.Utility-help.xml"
        HelpInfoFiles        = "Microsoft.PowerShell.Utility_1da87e53-152b-403e-98dc-74d7b4d63d59_HelpInfo.xml"
        CompressedFiles      = "Microsoft.PowerShell.Utility_1da87e53-152b-403e-98dc-74d7b4d63d59_en-US_helpcontent$extension"
        HelpInstallationPath = "$pshome\en-US"
    }

    "Microsoft.WSMan.Management" = @{
        HelpFiles            = "Microsoft.WSMan.Management.dll-help.xml"
        HelpInfoFiles        = "Microsoft.WsMan.Management_766204A6-330E-4263-A7AB-46C87AFC366C_HelpInfo.xml"
        CompressedFiles      = "Microsoft.WsMan.Management_766204A6-330E-4263-A7AB-46C87AFC366C_en-US_helpcontent$extension"
        HelpInstallationPath = "$pshome\en-US"
    }
}

if(($PSVersionTable.PSVersion.Major -ge 5) -and ($PSVersionTable.PSVersion.Minor -ge 1))
{
    $testCases += @{
        "Microsoft.PowerShell.LocalAccounts" = @{
            HelpFiles            = "Microsoft.Powershell.LocalAccounts.dll-help.xml"
            HelpInfoFiles        = "Microsoft.PowerShell.LocalAccounts_8e362604-2c0b-448f-a414-a6a690a644e2_HelpInfo.xml"
            CompressedFiles      = "Microsoft.PowerShell.LocalAccounts_8e362604-2c0b-448f-a414-a6a690a644e2_en-US_HelpContent$extension"
            HelpInstallationPath = "$pshome\Modules\Microsoft.PowerShell.LocalAccounts\*\en-US"
        }
    }

    $powershellCoreModules += "Microsoft.PowerShell.LocalAccounts"

}

# These are the inbox modules.
#$modulesInBox = @("Microsoft.PowerShell.Core"
#    Get-Module -ListAvailable | ForEach-Object{$_.Name}
$modulesInBox = $powershellCoreModules

function GetFiles
{
    param (
        [string]$fileType = "*help.xml",
        [ValidateNotNullOrEmpty()]
        [string]$path
    )

    Get-ChildItem $path -Include $fileType -Recurse -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName
}

function ValidateInstalledHelpContent
{
    param (
        [ValidateNotNullOrEmpty()]
        [string]$moduleName
    )

    $helpFilesInstalled = @(GetFiles -Path $testCases[$moduleName].HelpInstallationPath | ForEach-Object {Split-Path $_ -Leaf})
    $expectedHelpFiles = @($testCases[$moduleName].HelpFiles)
    $helpFilesInstalled.Count | Should Be $expectedHelpFiles.Count

    foreach ($fileName in $expectedHelpFiles)
    {
        $helpFilesInstalled -contains $fileName | Should Be $true
    }
}

function RunUpdateHelpTests
{
    param (
        [switch]$useSourcePath
    )

    foreach ($moduleName in $modulesInBox)
    {
        It "Validate Update-Help for module '$moduleName'" {

            # If the help file is already installed, delete it.
            Get-ChildItem $testCases[$moduleName].HelpInstallationPath -Include @("about_*.txt","*help.xml") -Recurse -ErrorAction SilentlyContinue |
            Remove-Item -Force -ErrorAction SilentlyContinue

            if ($useSourcePath)
            {
                Update-Help -Module $moduleName -Force -SourcePath "$PSScriptRoot\..\..\updatablehelp\5.1\$moduleName"
            }
            else
            {
                Update-Help -Module $moduleName -Force
            }

            ValidateInstalledHelpContent -moduleName $moduleName
        }
    }
}

Describe "Validate Update-Help -SourcePath for all PowerShell Core modules." {
    BeforeAll {
        $SavedProgressPreference = $ProgressPreference
        $ProgressPreference = "SilentlyContinue"
    }
    AfterAll {
        $ProgressPreference = $SavedProgressPreference
    }

    RunUpdateHelpTests -useSourcePath
}
