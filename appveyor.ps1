param(
    [switch]$SkipCabs,
    [switch]$ShowProgress
)

# Turning off the progress display, by default
$global:ProgressPreference = 'SilentlyContinue'
if($ShowProgress){$ProgressPreference = 'Continue'}   

# Find the reference folder path w.r.t the script
$ReferenceDocset = Join-Path $PSScriptRoot 'reference'

# Variable to collect any errors in during processing
$allErrors = @()

# Go through all the directories in the reference folder
Get-ChildItem $ReferenceDocset -Directory | ForEach-Object -Process {
    $Version = $_.Name
    $VersionFolder = $_.FullName
    # For each of the directories, go through each module folder
    Get-ChildItem $VersionFolder -Directory | ForEach-Object -Process {
        $ModuleName = $_        
        $ModulePath = Join-Path $VersionFolder $_
      
        $LandingPage = Join-Path $ModulePath "$ModuleName.md"
        $MamlOutputFolder = Join-Path "$PSScriptRoot\out_maml" "$Version\$ModuleName"
        $CabOutputFolder = Join-Path "$PSScriptRoot\out_cab" "$Version\$ModuleName"

        try {
            # For each module, create a single maml help file
            # Adding warningaction=stop to throw errors for all warnings, erroraction=stop to make them terminating errors
            New-ExternalHelp -Path $ModulePath -OutputPath $MamlOutputFolder -Force -WarningAction Stop -ErrorAction Stop
            
            # For each module, create update-help help files (cab and helpinfo.xml files)
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

# If the above block, produced any errors, throw and fail the job
if ($allErrors) {
    $allErrors
    throw "There are errors during platyPS run!`nPlease fix your markdown to comply with the schema: https://github.com/PowerShell/platyPS/blob/master/platyPS.schema.md"
}
