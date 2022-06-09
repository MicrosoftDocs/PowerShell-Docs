<#
.SYNOPSIS
    Returns a decorated string for writing a boolean in the console.
.DESCRIPTION
    The cmdlet decorates a boolean value for console viewing and returns it. If the **Value** is
    `$true`, it is returned bright blue. If the **Value** is `$false`, it is returned bright
    magenta.
.PARAMETER Value
    The boolean value to format as a decorated string for console viewing.
.EXAMPLE
    Format-ConsoleBoolean -Value $true
    Format-ConsoleBoolean -Value $false

    The cmdlet shows the styling for console viewing; the first statement shows "True" in bright
    blue, the second shows "False" in bright magenta.
#>
function Format-ConsoleBoolean {
    [CmdletBinding(DefaultParameterSetName='Components')]
    [OutputType([String])]
    param (
        [Parameter(Mandatory)]
        [bool]$Value
    )

    begin {
        $Styles = @{
            True  = $PSStyle.Foreground.BrightBlue
            False = $PSStyle.Foreground.BrightMagenta
        }
    }

    process {
        "$($Styles."$Value")$Value$($PSStyle.Reset)"
    }

    end {}
}