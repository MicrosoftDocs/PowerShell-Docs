param(
    [switch]$SkipCabs,
    [switch]$ShowProgress
)

# Turning off the progress display, by default
$global:ProgressPreference = 'SilentlyContinue'
if($ShowProgress){$ProgressPreference = 'Continue'}   

$ReferenceDocset = Join-Path $PSScriptRoot 'reference'
$allErrors = @()

Get-ChildItem $ReferenceDocset -Directory | ForEach-Object -Process {
    $Version = $_
    $VersionFolder = $_.FullName
    Get-ChildItem $VersionFolder -Directory | ForEach-Object -Process {
        $ModuleName = $_        
        $ModulePath = Join-Path $VersionFolder $_
      
        $LandingPage = Join-Path $ModulePath "$ModuleName.md"
        $MamlOutputFolder = Join-Path "$PSScriptRoot\out_maml" "$Version\$ModuleName"
        $CabOutputFolder = Join-Path "$PSScriptRoot\out_cab" "$Version\$ModuleName"

        try {
            New-ExternalHelp -Path $ModulePath -OutputPath $MamlOutputFolder -Force
            if (-not $SkipCabs) {
                $cabInfo = New-ExternalHelpCab -CabFilesFolder $MamlOutputFolder -LandingPagePath $LandingPage -OutputFolder $CabOutputFolder

                # Only output the cab fileinfo object
                if($cabInfo.Count -eq 8){$cabInfo[-1]}  
            }
        } catch {
            $allErrors += $_
        }
    }
}

if ($allErrors) {
    $allErrors
    throw "There are errors during platyPS run!`nPlease fix your markdown to comply with the schema: https://github.com/PowerShell/platyPS/blob/master/platyPS.schema.md"
}
