$ReferenceDocset = Join-Path $PSScriptRoot 'reference'

Get-ChildItem $ReferenceDocset -Directory `
| ForEach-Object -Process {
    $VersionFolder = $_.FullName
    Get-ChildItem $VersionFolder -Directory `
    | ForEach-Object -Process {
        $ModuleName = $_        
        $ModulePath = Join-Path $VersionFolder $_
      
        $LandingPage = Join-Path $ModulePath "$ModuleName.md"
        $MamlOutputFolder = Join-Path "$PSScriptRoot\out_maml" $ModuleName
        $CabOutputFolder = Join-Path "$PSScriptRoot\out_cab" $ModuleName
        

        New-ExternalHelp -Path $ModulePath -OutputPath $MamlOutputFolder
        New-ExternalHelpCab -CabFilesFolder $MamlOutputFolder -LandingPagePath $LandingPage -OutputFolder $CabOutputFolder 
    }
}