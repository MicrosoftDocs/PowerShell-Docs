<#
.SYNOPSIS
    Returns an error record about an invalid action parameter.
.DESCRIPTION
    This cmdlet composes and returns an error record for when a parameter handler determines that
    the input for a GitHub Action cannot be validly converted to a parameter for an action script.

    It returns the error record but does not throw it or write it to the error stream.
.PARAMETER Name
    Specify the name of the parameter that failed validation.
.PARAMETER Message
    Specify the string to write as the message for how/why the parameter failed validation.
.PARAMETER Target
    Specify the name of the action or step the validation failed during.
.PARAMETER Type
    Specify how the parameter failed validation. Currently supported values are `Missing` and
    `Invalid`. By default, the **Type** is `Missing`.

    Specify `Missing` when the value could not be discovered at all. Specify `Invalid` when the
    value was discovered but did not meet the requirements.
.EXAMPLE
    ```powershell
    $Details = @{
        Name = 'Foo'
        Message = 'Foo must be bigger than 10 but was: 5'
        Target  = 'Test-BigNumber.ps1'
        Type    = 'Invalid'
    }
    New-InvalidParameterError @Details
    ```

    This example creates a new error record indicating that while the value found for **Foo** was
    the correct type, it was not large enough to pass validation.
#>
function New-InvalidParameterError {
    [CmdletBinding()]
    param(
        [parameter(Mandatory)]
        [string]$Name,
        [parameter(Mandatory)]
        [string]$Message,
        [parameter(Mandatory)]
        [string]$Target,
        [ValidateSet('Missing', 'Invalid')]
        [string]$Type = 'Missing'
    )

    begin {}

    process {
        $Message   = Format-GHAConsoleText -Text $Message
        switch ($Type) {
            'Missing' {
                $Exception = [System.Management.Automation.PSArgumentNullException]::new(
                    $Name,
                    $Message
                )
                $ErrorID =  'GHA.MissingParameter'
            }
            default { # Includes 'Invalid'
                $Exception = [System.Management.Automation.PSArgumentException]::new(
                    $Message,
                    $Name
                )
                $ErrorID =  'GHA.InvalidParameter'
            }
        }
        $Target    = Format-GHAConsoleText -Text $Target
        [System.Management.Automation.ErrorRecord]::new(
            $Exception,
            $ErrorID,
            [System.Management.Automation.ErrorCategory]::InvalidArgument,
            $Target
        )
    }

    end {}
}