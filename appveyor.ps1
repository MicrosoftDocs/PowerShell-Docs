param(
    [switch]$SkipCabs,
    [switch]$ShowProgress
)

# Turning off the progress display, by default
$global:ProgressPreference = 'SilentlyContinue'
if($ShowProgress){$ProgressPreference = 'Continue'}

function Get-ContentWithoutHeader {
    param(
      $path
    )

    $doc = Get-Content $path -Encoding UTF8
    $start = $end = -1

   # search the first 30 lines for the Yaml header
   # no yaml header in our docset will ever be that long

    for ($x = 0; $x -lt 30; $x++) {
      if ($doc[$x] -eq '---') {
        if ($start -eq -1) {
          $start = $x
        } else {
          if ($end -eq -1) {
            $end = $x+1
            break
          }
        }
      }
    }
    if ($end -gt $start) {
      Write-Output ($doc[$end..$($doc.count)] -join "`r`n")
    } else {
      Write-Output ($doc -join "`r`n")
    }
  }

# Pandoc source URL
$panDocVersion = "2.0.6"
$pandocSourceURL = "https://github.com/jgm/pandoc/releases/download/$panDocVersion/pandoc-$panDocVersion-windows.zip"

$pandocDestinationPath = New-Item (Join-Path ([System.IO.Path]::GetTempPath()) "PanDoc") -ItemType Directory -Force
$pandocZipPath = Join-Path $pandocDestinationPath "pandoc-$panDocVersion-windows.zip"
Invoke-WebRequest -Uri $pandocSourceURL -OutFile $pandocZipPath

Expand-Archive -Path (Join-Path $pandocDestinationPath "pandoc-$panDocVersion-windows.zip") -DestinationPath $pandocDestinationPath -Force
$pandocExePath = Join-Path (Join-Path $pandocDestinationPath "pandoc-$panDocVersion") "pandoc.exe"

# Find the reference folder path w.r.t the script
$ReferenceDocset = Join-Path $PSScriptRoot 'reference'

# Variable to collect any errors in during processing
$allErrors = @()

# Go through all the directories in the reference folder
Get-ChildItem $ReferenceDocset -Directory -Exclude 'docs-conceptual','mapping', 'bread-pscore' | ForEach-Object -Process {
    $Version = $_.Name
    $VersionFolder = $_.FullName
    # For each of the directories, go through each module folder
    Get-ChildItem $VersionFolder -Directory | ForEach-Object -Process {
        $ModuleName = $_
        $ModulePath = Join-Path $VersionFolder $_

        $LandingPage = Join-Path $ModulePath "$ModuleName.md"
        $MamlOutputFolder = Join-Path "$PSScriptRoot\maml" "$Version\$ModuleName"
        $CabOutputFolder = Join-Path "$PSScriptRoot\updatablehelp" "$Version\$ModuleName"

        if(-not (Test-Path $MamlOutputFolder))
        {
            New-Item $MamlOutputFolder -ItemType Directory -Force > $null
        }

        # Process the about topics if any
        $AboutFolder = Join-Path $ModulePath "About"

        if(Test-Path $AboutFolder)
        {
            Get-ChildItem "$aboutfolder/about_*.md" | ForEach-Object {
                $aboutFileFullName = $_.FullName
                $aboutFileOutputName = "$($_.BaseName).help.txt"
                $aboutFileOutputFullName = Join-Path $MamlOutputFolder $aboutFileOutputName

                $pandocArgs = @(
                    "--from=gfm",
                    "--to=plain+multiline_tables+inline_code_attributes",
                    "--columns=75",
                    "--output=$aboutFileOutputFullName",
                    "--quiet"
                )

                Get-ContentWithoutHeader $aboutFileFullName | & $pandocExePath $pandocArgs
            }
        }

        try {
            # For each module, create a single maml help file
            # Adding warningaction=stop to throw errors for all warnings, erroraction=stop to make them terminating errors
            New-ExternalHelp -Path $ModulePath -OutputPath $MamlOutputFolder -Force -WarningAction Stop -ErrorAction Stop

            # For each module, create update-help help files (cab and helpinfo.xml files)
            if (-not $SkipCabs) {
                $cabInfo = New-ExternalHelpCab -CabFilesFolder $MamlOutputFolder -LandingPagePath $LandingPage -OutputFolder $CabOutputFolder

                # Only output the cab fileinfo object
                if($cabInfo.Count -eq 8){$cabInfo[-1].FullName}
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
