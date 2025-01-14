<#
.SYNOPSIS

    Adds a table summarizing a changeset's impact on versioned content.

.DESCRIPTION

    This cmdlet adds a table summarizing a changeset's impact on versioned content to a
    **StringBuilder** object. It records the path to the file relative to its version folder and
    the type of change to each version of that file.

.PARAMETER ChangeSet

    Specify one or more changesets to build a versioned content table for. Each item in this array
    gets an entry in the table.

.PARAMETER Summary

    Specify a **System.Text.StringBuilder** object to write the table to. Because **StringBuilder**
    objects are updated when text is appended to them, this object is not returned but is instead
    updated-in-place.

.PARAMETER RelativePathWidth

    Specify a minimum width for the table column containing the **RelativePath** to a changed file.
    If this value is not passed, it is calculated based on the input **ChangeSet**.

.PARAMETER VersionWidth

    Specify a minimum width for the table columns for each **Version** of a changed file. If this
    value is not passed, it is calculated based on the input **ChangeSet**.

.EXAMPLE

    ```powershell
    $ChangeSet = @(
        [PSCustomObject]@{
            VersionRelativePath = 'foo.md'
            Versions = @(
                @{ Version = '1.1'; ChangeType = 'N/A' }
                @{ Version = '1.2'; ChangeType = 'unchanged' }
                @{ Version = '1.3'; ChangeType = 'modified' }
            )
        }
        [PSCustomObject]@{
            VersionRelativePath = 'bar/baz.md'
            Versions = @(
                @{ Version = '1.1' ; ChangeType = 'added' }
                @{ Version = '1.2' ; ChangeType = 'added' }
                @{ Version = '1.3' ; ChangeType = 'added' }
            )
        }
    )
    $Summary = New-Object -TypeName System.Text.StringBuilder
    Add-VersionedContentTable -ChangeSet $ChangeSet -Summary $Summary
    $Summary.ToString()
    ```

    ```Output
    | Version-Relative Path        | 1.1        | 1.2        | 1.3        |
    |:-----------------------------|:----------:|:----------:|:----------:|
    | `foo.md`                     | N/A        | Unchanged  | Modified   |
    | `bar/baz.md`                 | Added      | Added      | Added      |
    ```

    The first command constructs an arbitrary changeset where:

    - The file `foo.md` does not exist in version `1.1`, was not changed in version `1.2`, and was
      modified in version `1.3`.
    - The file `bar/baz.md` was added in all three versions.

    The second command creates a new **StringBuilder** object to write the table to.

    The third command uses this cmdlet to write a versioned content summary table to `$Summary`.
    Because neither **RelativePathWidth** nor **VersionWidth** were passed to the cmdlet, it
    calculates the required column widths dynamically.

    The final command displays the string the third command has built.
#>
function Add-VersionedContentTable {
    [CmdletBinding()]
    [OutputType([Void])]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        $ChangeSet,

        [Parameter(Mandatory)]
        [System.Text.StringBuilder]$Summary,

        [int]$RelativePathWidth,

        [int]$VersionWidth
    )

    begin {
        $WidthParams = @{
            ChangeSet = $ChangeSet
        }
    }
    process {
        #region Column Widths
        if (($RelativePathWidth -eq 0) -and ($VersionWidth -eq 0)) {
            $RelativePathWidth, $VersionWidth = Get-VersionedContentTableColumnWidth @WidthParams
        } elseif ($RelativePathWidth -eq 0) {
            $WidthParams.Add('RelativePath', $true)
            $RelativePathWidth = Get-VersionedContentTableColumnWidth @WidthParams
        } elseif ($VersionWidth -eq 0) {
            $WidthParams.Add('Version', $true)
            $VersionWidth = Get-VersionedContentTableColumnWidth @WidthParams
        }
        #endregion Column Widths
        #region Setup the table header
        $null = $Summary.Append("|$(' Version-Relative Path'.PadRight($RelativePathWidth))")
        # Retrieve the list of unique versions
        $VersionList = $ChangeSet.Versions.Version | Select-Object -Unique
        foreach ($Version in $VersionList) {
            $null = $Summary.Append("|$(" $Version".PadRight($VersionWidth))")
        }
        $null = $Summary.AppendLine('|')
        $null = $Summary.Append("|:$('-' * ($RelativePathWidth - 1))")
        foreach ($Version in $VersionList) {
            $null = $Summary.Append("|:$('-' * ($VersionWidth - 2)):")
        }
        $null = $Summary.AppendLine('|')
        #endregion Setup the table header
        # loop over change sets; version status or `N/A` if it doesn't exist.
        foreach ($Set in $ChangeSet) {
            $RelativePath = Split-Path -Path $Set.VersionRelativePath -Leaf
            $null = $Summary.Append("|$(" ``$RelativePath`` ".PadRight($RelativePathWidth))")
            foreach ($Version in $VersionList) {
                $ChangeType = $Set.Versions.Where({ $_.Version -eq $Version }).ChangeType
                if ([string]::IsNullOrEmpty($ChangeType)) {
                    $ChangeType = 'n/a'
                }
                # Title case the change type
                $ChangeType = (Get-Culture).TextInfo.ToTitleCase($ChangeType)
                $null = $Summary.Append("|$(" $ChangeType ".PadRight($VersionWidth))")
            }
            $null = $summary.AppendLine('|')
        }
        $null = $Summary.AppendLine()
    }
}
