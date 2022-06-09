<#
.SYNOPSIS
    Writes a console log message displaying the parameter value, colorized.
.DESCRIPTION
    This cmdlet writes a console log message declaring that a parameter value has been determined,
    including the name and colorized value. It uses `Write-Host` to avoid polluting the output
    stream, allowing it to be log this information in parameter handler scriptblocks invoked by the
    `Get-ActionScriptParameter` cmdlet.
.PARAMETER Name
    Specify the name of the parameter to display.
.PARAMETER Value
    Specify the value of the parameter. This value will be colorized.
.PARAMETER MultiLine
    Specify whether the value should be displayed as a multi-line string. Specifying this switch
    causes the indentation and wrapping to handle differently than for single-lines.
.PARAMETER Color
    Specify the color to apply to the value. By default, it is bright magenta.
.EXAMPLE
    ```powershell
    Write-HostParameter -Name Foo -Value 'Apple'
    ```

    This example will write the message `Foo: Apple` with `Apple` bolded and colored bright magenta.
#>
function Write-HostParameter {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,
        [Parameter(Mandatory)]
        [string[]]$Value,
        [switch]$MultiLine,
        [string]$Color = $PSStyle.Foreground.BrightMagenta
        
    )

    begin {}

    process {
        $Prefix = "${Name}: ".PadLeft(20)
        if ($MultiLine) {
            $MultilineValue = $Value -split "`n"
            | ForEach-Object -Process { "$(' ' * 20)$_" }
            | Join-String -Separator "`n"
            Write-Verbose "Body:`n$MultiLineValue"
            $MultilineValue = $PSStyle.Bold + $Color + $MultilineValue + $PSStyle.Reset
            Write-Verbose "After formatting:`n$MultilineValue"
            $Message = "$Prefix`n$MultilineValue"
        } else {
            $Values = $Value
            | ForEach-Object -Process { $PSStyle.Bold + $Color + $_ + $PSStyle.Reset }
            | Join-String -Separator ', '
            $Message = $Prefix + $Values
        }

        Write-Host $Message
    }

    end {}
}