<#
.SYNOPSIS

    Calculates the maximum width of columns for a versioned content table.

.DESCRIPTION

    This cmdlet calculates the maximum width of columns for a versioned content table for a given
    changeset, returning the minimum widths for these columns:

    - **RelativePath:** Used for the **VersionRelativePath** value for each changeset item.
    - **Version:** Used for the **ChangeType** value for every version of each changeset item.

    By default, it returns the widths for each defined column in the order listed above.

.PARAMETER ChangeSet

    Specify one or more changesets to calculate the column widths for a versioned content table
    enumerating these changes.

.PARAMETER DefaultWidth

    Specify an integer as the default width for all calculated column widths. If this value is not
    specified, each column has its own default width:

    - **RelativePath:** `30` characters wide.
    - **Version:** `12` characters wide.

.PARAMETER RelativePath

    Specify this switch to return only the calculated width for the **RelativePath** column.

.PARAMETER Version

    Specify this switch to return only the calculated width for the **Version** columns.

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
    $RelativePathWidth, $VersionWidth = Get-VersionedContentTableColumnWidth -ChangeSet $ChangeSet
    "Relative Path Column Width: $RelativePathWidth"
    "Version Column Width:       $VersionWidth"
    ```

    ```Output
    Relative Path Column Width: 30
    Version Column Width:       12
    ```

    The first command constructs an arbitrary changeset.

    The second command uses this cmdlet to determine the column widths for a table describing that
    changeset, assigning the output to the `$RelativePathWidth` and `$VersionWidth` variables. Because
    the **DefaultWidth** parameter was not specified, the cmdlet uses default values for each column
    (`30` for **RelativePath** and `12` for **Version**).

    The last two commands display the results. Because none of the data in the changeset has a
    longer path or version than the defaults for the columns, the output values are the same as the
    default values for each column.

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
    Get-VersionedContentTableColumnWidth -ChangeSet $ChangeSet -RelativePath -DefaultWidth 5
    ```

    ```Output
    14
    ```

    The first command constructs an arbitrary changeset.

    The second command uses this cmdlet to determine the width of the **RelativePath** column for a
    table describing that changeset. It limits the calculations to only the **RelativePath** column
    by using the switch parameter of the same name. It specifies the minimum width of the column to
    `5`.

    The widest **VersionRelativePath** property in the changeset is `bar/baz.md`, which is `10`
    characters wide. The calculation adds an additional four characters to this width to account for
    the wrapping backticks and spaces in the table entry. The result value is therefore `14`.

#>

function Get-VersionedContentTableColumnWidth {
    [CmdletBinding(DefaultParameterSetName='AllColumns')]
    [OutputType([Int[]])]
    [OutputType([int], ParameterSetName=('RelativePathOnly','VersionOnly'))]
    param(
        [Parameter(Mandatory, ParameterSetName='RelativePathOnly')]
        [Parameter(Mandatory, ParameterSetName='VersionOnly')]
        [Parameter(Mandatory, ParameterSetName='AllColumns')]
        [ValidateNotNullOrEmpty()]
        $ChangeSet,

        [Parameter(ParameterSetName='RelativePathOnly')]
        [Parameter(ParameterSetName='VersionOnly')]
        [Parameter(ParameterSetName='AllColumns')]
        [int]$DefaultWidth,

        [Parameter(ParameterSetName='RelativePathOnly')]
        [switch]$RelativePath,

        [Parameter(ParameterSetName='VersionOnly')]
        [switch]$Version
    )

    process {
        #region RelativePath
        if ($RelativePath -or !$Version) {
            # Set the default width for RelativePath unless specified by user
            $RelativePathWidth = ($DefaultWidth -lt 1) ? 30 : $DefaultWidth
            # Loop over changesets to find longest path & set as width
            $ChangeSet.VersionRelativePath | ForEach-Object -Process {
                $PathEntryLength = Split-Path -Path $_ -Leaf | Select-Object -ExpandProperty Length
                $PathEntryLength += 4
                if ($PathEntryLength -gt $RelativePathWidth) {
                    $RelativePathWidth = $PathEntryLength
                }
            }
            # Write the calculated RelativePath column width to output
            $RelativePathWidth
        }
        #endregion RelativePath
        if ($Version -or !$RelativePath) {
            # Set the default width for Version unless specified by user
            $VersionWidth = ($DefaultWidth -lt 1) ? 12 : $DefaultWidth
            # Find unique versions and loop over them to find longest version & set as width
            $VersionList = $ChangeSet.Versions.Version | Select-Object -Unique
            $VersionList | ForEach-Object -Process {
                $VersionLength = $_.Length + 2
                if ($VersionLength -gt $VersionWidth) {
                    $VersionWidth = $VersionLength
                }
            }
            # Write the calculated Version column width to output
            $VersionWidth
        }
    }
}
