$ReferenceDocset = Join-Path $PSScriptRoot 'reference'

Get-ChildItem $ReferenceDocset -Directory `
| ForEach-Object -Process {
    $Version = $_
    $VersionFolder = $_.FullName
    Get-ChildItem $VersionFolder -Directory `
    | ForEach-Object -Process {
        $ModuleName = $_        
        $ModulePath = Join-Path $VersionFolder $_
      
        $LandingPage = Join-Path $ModulePath "$ModuleName.md"
        $MamlOutputFolder = Join-Path "$PSScriptRoot\out_maml" "$Version\$ModuleName"
        $CabOutputFolder = Join-Path "$PSScriptRoot\out_cab" "$Version\$ModuleName"
        

        New-ExternalHelp -Path $ModulePath -OutputPath $MamlOutputFolder
        New-ExternalHelpCab -CabFilesFolder $MamlOutputFolder -LandingPagePath $LandingPage -OutputFolder $CabOutputFolder 
    }
}