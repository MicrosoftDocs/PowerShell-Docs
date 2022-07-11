function Get-StaleDocument {
    <#
        .SYNOPSIS

        Retrieve documents from a folder that are stale

        .DESCRIPTION

        This cmdlet searches recursively through one or more folders to find documents with the
        `ms.date` key in their frontmatter where the value of that key is older than a specified
        date, indicating that the document is stale.

        .PARAMETER RelativeFolderPath

        Specify the path to one or more folders to search for stale documents relative to the
        current working directory. Do not use any wildcard characters. The value for this parameter
        is interpreted literally. Additionally, this value is used to determine the root path of any
        stale documents.

        If you specify any values including a wildcard character, this cmdlet warns you about the
        consequences. You can suppress this warning by specifying `SilentlyContinue` for the
        **WarningAction** parameter.

        .PARAMETER DaysUntilStale

        Specify an integer representing how many days can pass before a document is considered
        stale. If any document's `ms.date` key is older than this value, it is returned as a stale
        document.

        .PARAMETER StaleSinceDate

        Specify a datetime object representing the point at which any older documents are considered
        stale. If any document's `ms.date` key is older than this value, it is returned as a stale
        document. This value defaults to `330` days before this cmdlet is called.

        .EXAMPLE

        ```powershell
        Get-StaleDocument -RelativeFolderPath ./reference/
        ```

        The cmdlet searches the `reference` folder in the current working directory and returns
        every document whose `ms.date` key has a value older than 330 days from the time the command
        is called. For every document returned, the **RootPath** property is `reference`, the
        **RelativePath** property is the remaining path to the file, and the **MSDate** property is
        the datetime value from the document's frontmatter.

        .EXAMPLE

        ```powershell
        $Folders = @(
            'reference/5.1'
            'reference/7.0'
            'reference/7.2'
            'reference/docs-conceptual'
        )
        Get-StaleDocument -RelativeFolderPath $Folders -DaysUntilStale 1000
        ```

        The first command enumerates the list of folders to recursively search for stale documents.
        The second command searches those folders and returns every document whose `ms.date` key has
        a value older than 1000 days from the time the command is called.

        .EXAMPLE

        ```powershell
        Get-StaleDocument -RelativeFolderPath reference -StaleSinceDate '2022-06-15'
    #>
    [CmdletBinding(DefaultParameterSetName='ByDate')]
    [OutputType('PSDocs.DocumentInfo[]')]
    param(
        [Parameter(Mandatory)]
        [string[]]$RelativeFolderPath,

        [string[]]$ExcludeFolderSegment,

        [Parameter(ParameterSetName='ByDays')]
        [int]$DaysTilStale,
        
        [Parameter(ParameterSetName='ByDate')]
        [datetime]$StaleSinceDate = (Get-Date).AddDays(-330).Date
    )

    begin {
        $MSDatePattern = '^ms\.date: (?<date>\d+\/\d+\/\d+).*$'
        $HasWildcard
        $GetRelativePathRegex = {
            $WorkingPath = $_ -replace '\\', '/'         # Normalize paths to forward slashes
            $WorkingPath = $WorkingPath.TrimStart('.')      # Remove leading relative path dots
            $WorkingPath = $WorkingPath.Trim('/')           # Remove wrapping path segments
            [regex]::Escape($WorkingPath)
        }
        $ProcessProperties = {
            $MSDate = $_.Matches.Groups
            | Where-Object -FilterScript { $_.Name -eq 'Date' }
            | Select-Object -ExpandProperty Value
            | ForEach-Object { ([datetime]$_).Date }

            $FilePath = $_.Path -replace '\\', '/' # Normalize paths to forward slashes
            $RegexRootPaths = $RelativeFolderPath | ForEach-Object -Process {
                $RootPath = $_ -replace '\\', '/'         # Normalize paths to forward slashes
                $RootPath = $RootPath.TrimStart('.')      # Remove leading relative path dots
                $RootPath = $RootPath.Trim('/')           # Remove wrapping path segments
                [regex]::Escape($RootPath)
            } | Join-String -Separator '|'                # Join as options in a regex-or match
            $RelativePathPattern = "(?<RootPath>($RegexRootPaths))\/(?<RelativePath>.+$)"
            if ($ExcludeFolderSegment.Count -gt 0) {
                $RegexExcludeSegments = $ExcludeFolderSegment
                | ForEach-Object -Process $GetRelativePathRegex
                | Join-String -Separator '|'
                $ExcludePattern = "\/($RegexExcludeSegments)\/"
                if ($FilePath -match $ExcludePattern) {
                    # Skip!
                    Write-Debug "EXCLUDING: $FilePath"
                    return
                }
            }
            if ($FilePath -match $RelativePathPattern) {
                [PSCustomObject]@{
                    PSTypeName   = 'PSDocs.DocumentInfo'
                    RootPath     = $Matches.RootPath
                    RelativePath = $Matches.RelativePath
                    MSDate       = $MSDate
                }
            }
        }
    }

    process {
        if ($DaysUntilStale -gt 0) {
            $StaleSinceDate = (Get-Date).AddDays((0 - $DaysUntilStale)).Date
        }
        $FoldersWithWildCards = $RelativeFolderPath -match '(\*|\?|\[|\])'
        if ($FoldersWithWildCards.Count -gt 0) {
            $Message = @(
                "RelativeFolderPath included at least one path with wildcard character(s)."
                "Wildcard characters are interpreted literally. Make sure this was intentional."
                "If you do not want to see this message, specify 'SilentlyContinue for the"
                "WarningAction parameter."
                "`n`tPaths:`n`t`t$($FoldersWithWildCards -join "`n`t`t")"
            ) -join ' '
            Write-Warning -Message $Message
        }

        Get-ChildItem -LiteralPath $RelativeFolderPath -Recurse
        | Select-String -Pattern $MSDatePattern
        | ForEach-Object -Process $ProcessProperties
        | Where-Object -Property MSDate -lt $StaleSinceDate
        | Sort-Object -Property RootPath, RelativePath, MSDate
    }
}