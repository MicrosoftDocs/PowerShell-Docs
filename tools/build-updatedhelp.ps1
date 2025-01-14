<#
    Usage:

    1. Clone the docs repository
       cd C:\temp
       git clone https://github.com/MicrosoftDocs/PowerShell-Docs.git

    2. Run build-updatedhelp.ps1 for the version folder you want to build

      .\build-updatedhelp.ps1 -sourceFolder C:\temp\PowerShell-Docs\reference\5.1 -Verbose

    3. Run Update-Help  to install the newly built help

       Update-Help -SourcePath c:\temp\updatablehelp\5.1 -Recurse -Force
#>


param(
    [Parameter(Mandatory=$true)]
    [ValidateScript({ Test-Path $_ })]
    [string]$sourceFolder
)

# Turning off the progress display, by default
$savedProgressPreference = $global:ProgressPreference
$global:ProgressPreference = 'SilentlyContinue'

$tempDir = [System.IO.Path]::GetTempPath()

$needPandoc = $needPlatyps = $true

# Pandoc source URL
$panDocVersion = "2.7.3"
$pandocSourceURL = "https://github.com/jgm/pandoc/releases/download/$panDocVersion/pandoc-$panDocVersion-windows-x86_64.zip"

$docToolsPath = New-Item (Join-Path $tempDir "doctools") -ItemType Directory -Force

$pandoc = Get-Command pandoc.exe -ErrorAction SilentlyContinue
if ($pandoc) {
    $version = (& $pandoc.Source --version | Select-String -Pattern 'pandoc\.exe').Line.Split(' ')[-1]
    if ($version -ge $panDocVersion) {
        Write-Host "Found Pandoc version $version."
        $pandocExePath = $pandoc.Source
        $needPandoc = $false
    }
}

if ($needPandoc) {
    $pandocZipPath = Join-Path $docToolsPath "pandoc-$panDocVersion-windows-x86_64.zip"
    Write-Verbose "Downloading Pandoc..."
    Invoke-WebRequest -Uri $pandocSourceURL -OutFile $pandocZipPath
    Expand-Archive -Path $pandocZipPath -DestinationPath $docToolsPath -Force
    $pandocExePath = Join-Path $docToolsPath "pandoc-$panDocVersion-windows-x86_64\pandoc.exe"
}


$platyPSversion = "0.14.0"
$platyps = Get-Module -List platyps

if ($platyps) {
    if ($platyps.Version.ToString() -ge $platyPSversion) {
        Write-Host "Found PlatyPS version $($platyps.Version.ToString())"
        Import-Module platyps
        $needPlatyps = $false
    }
} else {
    Write-Verbose "Downloading platyPS..."
    Save-Module -Name platyPS -Repository PSGallery -Force -Path $docToolsPath -RequiredVersion $platyPSversion
    Import-Module -FullyQualifiedName $docToolsPath\platyPS\$platyPSversion\platyPS.psd1
}

$DocSet = Get-Item $sourceFolder
$WorkingDirectory = $PWD

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
            }
            else {
                if ($end -eq -1) {
                    $end = $x + 1
                    break
                }
            }
        }
    }
    if ($end -gt $start) {
        Write-Output ($doc[$end..$($doc.count)] -join ([Environment]::Newline))
    }
    else {
        Write-Output ($doc -join "`r`n")
    }
}

$Version = $DocSet.Name
Write-Verbose "Version = $Version"

$VersionFolder = $DocSet.FullName
Write-Verbose "VersionFolder = $VersionFolder"

# For each of the directories, go through each module folder
Get-ChildItem $VersionFolder -Directory | ForEach-Object -Process {
    $ModuleName = $_.Name
    Write-Verbose "ModuleName = $ModuleName"

    $ModulePath = Join-Path $VersionFolder $ModuleName
    Write-Verbose "ModulePath = $ModulePath"

    $LandingPage = Join-Path $ModulePath "$ModuleName.md"
    Write-Verbose "LandingPage = $LandingPage"

    $MamlOutputFolder = Join-Path "$WorkingDirectory\maml" "$Version\$ModuleName"
    Write-Verbose "MamlOutputFolder = $MamlOutputFolder"

    $CabOutputFolder = Join-Path "$WorkingDirectory\updatablehelp" "$Version\$ModuleName"
    Write-Verbose "CabOutputFolder = $CabOutputFolder"

    if (-not (Test-Path $MamlOutputFolder)) {
        New-Item $MamlOutputFolder -ItemType Directory -Force > $null
    }

    # Process the about topics if any
    $AboutFolder = Join-Path $ModulePath "About"

    if (Test-Path $AboutFolder) {
        Write-Verbose "AboutFolder = $AboutFolder"
        Get-ChildItem "$AboutFolder/about_*.md" | ForEach-Object {
            $aboutFileFullName = $_.FullName
            $aboutFileOutputName = "$($_.BaseName).help.txt"
            $aboutFileOutputFullName = Join-Path $MamlOutputFolder $aboutFileOutputName

            $pandocArgs = @(
                "--from=gfm",
                "--to=plain+multiline_tables",
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
        $cabInfo = New-ExternalHelpCab -CabFilesFolder $MamlOutputFolder -LandingPagePath $LandingPage -OutputFolder $CabOutputFolder

        # Only output the cab fileinfo object
        if ($cabInfo.Count -eq 8) { $cabInfo[-1].FullName }
    }
    catch {
        Write-Error -Message "PlatyPS failure: $ModuleName -- $Version" -Exception $_
    }
}

$global:ProgressPreference = $savedProgressPreference
