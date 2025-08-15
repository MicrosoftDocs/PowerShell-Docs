<#
.SYNOPSIS
    Stylize text for console viewing.
.DESCRIPTION
    This cmdlet stylizes input text for viewing in the console.
.PARAMETER Text
    The text to stylize. The styles are applied to the entire string.
.PARAMETER StyleComponent
    Specifies one or more PSStyle components to apply to the text.
.PARAMETER DefinedStyle
    Specifies a pre-defined style to apply to the text. Select one of:

    - `Success`: Bold and bright blue
    - `UserName`: Bright yellow
    - `Target`: Bold and bright magenta
.EXAMPLE
    ```powershell
    Format-ConsoleStyle -Text 'foo bar' -StyleComponent @(
        $PSStyle.Underline
        $PSStyle.Foreground.BrightGreen
    )
    ```

    The cmdlet returns the string `foo bar` in bright green and underlined.
.EXAMPLE
    ```powershell
    Format-ConsoleStyle -Text 'hooray!' -DefinedStyle Success
    ```

    The cmdlet returns the string `hooray!` in bright blue and bolded.
#>
function Format-ConsoleStyle {
    [CmdletBinding(DefaultParameterSetName='Components')]
    [OutputType([string])]
    param (
        [Parameter(Mandatory)]
        [string]$Text,
        [Parameter(Mandatory, ParameterSetName='Components')]
        [string[]]$StyleComponent,
        [Parameter(Mandatory, ParameterSetName='DefinedStyle')]
        [ValidateSet('Success', 'Target', 'UserName')]
        [string]$DefinedStyle
    )

    begin {
        $Styles = @{
            Success = @(
                $PSStyle.Bold
                $PSStyle.Foreground.BrightBlue
            )
            UserName = @(
                $PSStyle.Foreground.BrightYellow
            )
            Target = @(
                $PSStyle.Bold
                $PSStyle.Foreground.BrightMagenta
            )
        }
    }

    process {
        if ($StyleComponent.Count -eq 0) {
            $StyleComponent = $Styles.$DefinedStyle
        }

        @(($StyleComponent -join ''), $Text, $PSStyle.Reset) -join ''
    }

    end {}
}
