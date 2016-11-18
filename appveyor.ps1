param(
    [switch]$SkipCabs
)

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

        New-ExternalHelp -Path $ModulePath -OutputPath $MamlOutputFolder -Force -ErrorVariable ev
        $allErrors += $ev

        if (-not $SkipCabs) {
            New-ExternalHelpCab -CabFilesFolder $MamlOutputFolder -LandingPagePath $LandingPage -OutputFolder $CabOutputFolder -ErrorVariable ev
            $allErrors += $ev
        }
    }
}

if ($allErrors) {
    $allErrors
    throw "There are errors during platyPS run!`nPlease fix your markdown to comply with the schema: https://github.com/PowerShell/platyPS/blob/master/platyPS.schema.md"
}
