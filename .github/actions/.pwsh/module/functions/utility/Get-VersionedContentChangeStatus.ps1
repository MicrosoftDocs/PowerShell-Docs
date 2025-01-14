<#
.SYNOPSIS
    Returns the change status of versioned content for a pull request.
.DESCRIPTION
    This cmdlet returns the change status of versioned content for a pull request. This information
    can be used to analyze whether a pull request has modified every file it should.

    Pull requests for versioned content can be tricky, requiring an author to modify the same file
    in multiple folders. This cmdlet helps clarify if changes have been made across all the versions
    a file exists in, but does not process the information itself.

    The output of this cmdlet is an array of objects with the following properties:

    - **VersionRelativePath**: The path to the changed file from the version folder
    - **BaseFolder**: The path to the parent folder of multiple versions; the grandparent of the
      **VersionRelativePath**.
    - **Versions**: An array of objects representing every version of the content the file exists
      in. Each entry has a **Version** (like `5.1` or `7.2`) and **ChangeType** (whether the file
      was `added`, `removed`, `modified`, `renamed`, `copied`, `changed`, or `unchanged`).
.PARAMETER ChangedContent
    The list of changed files from a pull request and their change type. This should usually be
    retrieved by running `Get-PullRequestChangedFile`.
.EXAMPLE
    ```powershell
    $Changes = @(
        @{
            ChangeType = 'modified'
            Path = '.openpublishing.redirection.json'
        }
        @{
            ChangeType = 'modified'
            Path = 'README.md'
        }
        @{
            ChangeType = 'modified'
            Path = 'reference/7.0/Microsoft.PowerShell.Core/About/about_Pwsh.md'
        }
        @{
            ChangeType = 'removed'
            Path = 'reference/7.1/CimCmdlets/CimCmdlets.md'
        }
        @{
            ChangeType = 'removed'
            Path = 'reference/7.2/CimCmdlets/CimCmdlets.md'
        }
    )
    Get-VersionedContentChangeStatus -ChangedContent $Changes | ConvertTo-Json -Depth 3
    ```

    ```Output
    [
        {
            "VersionRelativePath": "Microsoft.PowerShell.Core/About/about_Pwsh.md",
            "BaseFolder": "reference",
            "Versions": [
                { "Version": "7.0", "ChangeType": "modified"  },
                { "Version": "7.0", "ChangeType": "unchanged" },
                { "Version": "7.2", "ChangeType": "unchanged" },
                { "Version": "7.3", "ChangeType": "unchanged" }
            ]
        },
        {
            "VersionRelativePath": "CimCmdlets/CimCmdlets.md",
            "BaseFolder": "reference",
            "Versions": [
                { "Version": "7.1", "ChangeType": "removed"   },
                { "Version": "5.1", "ChangeType": "unchanged" },
                { "Version": "7.0", "ChangeType": "unchanged" },
                { "Version": "7.2", "ChangeType": "removed"   },
                { "Version": "7.3", "ChangeType": "unchanged" }
            ]
        }
    ]
    ```

    The cmdlet inspects each of the changed files to see if the file is versioned content or not;
    that is, if it exists in a folder with a version number in its ancestor path. If the file is not
    version content, it is skipped. If the file is versioned content, the cmdlet creates a result
    object for that file which includes its version-relative path (the path to the file from the
    version folder it live in), base folder (the path to the folder above the version folders),
    and an array of version changes, which enumerates all the versions that file exists in and
    its change status. Any versioned content not modified in the PR is listed as `unchanged`.
#>
function Get-VersionedContentChangeStatus {
    [CmdletBinding()]
    param(
        $ChangedContent
    )

    begin {
        $VersionedContent = @()
        $VersionPattern = '(?<version>(v(\d+\.){0,}\d+(-[^\/]+)*)|(\d+\.){1,}\d+(-[^\/]+)*)'
        $Pattern = "^(?<BaseFolder>.+)\/$VersionPattern\/(?<VersionRelativePath>.+)`$"
    }

    process {
        # Associates the changed files together as an array of entries, like:
        # [pscustomobject]@{
        #     VersionRelativePath = 'Microsoft.PowerShell.Core/Enter-PSHostProcess.md'
        #     BaseFolder          = 'reference'
        #     Versions            = @(
        #         [pscustomobject]@{ Version = '5.1' ; ChangeType = 'modified' }
        #         [pscustomobject]@{ Version = '7.1' ; ChangeType = 'removed'  }
        #     )
        # }
        foreach ($Item in $ChangedContent) {
            if ($Item.Path -match $Pattern) {
                $BaseFolder = $Matches.BaseFolder
                $Version = $Matches.Version
                $VersionRelativePath = $Matches.VersionRelativePath

                $AddEntry = $true
                for ($i = 0 ; $i -lt $VersionedContent.Count ; $i++){
                    $Entry = $VersionedContent[$i]
                    $MatchingVersionRelativePath = $Entry.VersionRelativePath -eq $VersionRelativePath
                    $MatchingBaseFolder = $Entry.BaseFolder -eq $BaseFolder
                    if ($MatchingVersionRelativePath -and $MatchingBaseFolder) {
                        $AddEntry = $false
                        $VersionedContent[$i].Versions += [PSCustomObject]@{
                            Version    = $Version
                            ChangeType = $Item.ChangeType
                        }
                        break
                    }
                }

                if ($AddEntry) {
                    $VersionedContent += [pscustomobject]@{
                        VersionRelativePath = $VersionRelativePath
                        BaseFolder          = $BaseFolder
                        Versions            = @(
                            [pscustomobject]@{
                                Version    = $Version
                                ChangeType = $Item.ChangeType
                            }
                        )
                    }
                }
            }
        }
        # Find all the version folders immediately beneath the base folders.
        $BaseFolders = @{}
        $VersionedContent.BaseFolder | Select-Object -Unique | ForEach-Object -Process {
            $FolderName = $_
            $Versions = Get-ChildItem -Path $_ -Directory | Where-Object -FilterScript {
                $_.BaseName -match $VersionPattern
            } | Select-Object -ExpandProperty BaseName
            $BaseFolders.Add($FolderName, $Versions)
        }
        # Loops over the items after initial processing to find unchanged files in other versions.
        foreach ($Item in $VersionedContent) {
            $VersionRelativePath = $Item.VersionRelativePath
            $BaseFolder = $Item.BaseFolder
            Get-Item -Path "$BaseFolder/*.*/$VersionRelativePath" | ForEach-Object {
                $FilePath = $_.FullName -replace '\\', '/'
                if ($FilePath -match $Pattern) {
                    $Version = $Matches.Version
                    if ($Item.Versions.Version -notcontains $Version) {
                        $Item.Versions += [PSCustomObject]@{
                            Version = $Version
                            ChangeType = 'unchanged'
                        }
                    }
                }
            }
            # Handle versions where the file does not exist:
            $BaseFolders.$BaseFolder
            | Where-Object -FilterScript {
                $_ -notin $Item.Versions.Version
            } | ForEach-Object -Process {
                $Item.Versions += [PSCustomObject]@{
                    Version = $_
                    ChangeType = 'n/a'
                }
            }
            # Make sure to sort versions not by discovery order but by version number
            $Item.Versions = $Item.Versions | Sort-Object -Property {
                $Version = $_.Version
                if ($Version -match '^v(?<Major>\d+)(?<RemainingSegments>(\.\d+)*((-|\+)\w+)*)') {
                    if ([string]::IsNullOrEmpty($Matches.RemainingSegments)) {
                        $Version = "$($Matches.Major).0"
                    } else {
                        $Version = "$($Matches.Major)$($Matches.RemainingSegments)"
                    }
                }
                [System.Management.Automation.SemanticVersion]$Version
            }
            # Send the result to the pipeline
            $Item
        }
    }

    end {}
}
