<#
.SYNOPSIS
    Retrieves and validates parameters for GHA
.DESCRIPTION
    This cmdlet uses parameter handlers to retrieve and validate the inputs from a GitHub Action,
    returning a hashtable of parameters to splat on an action script.
.PARAMETER ParameterHandler
    Specify one or more parameter handlers, such as those as kept in an action's `Parameters.psd1`
    file. Make sure the hashtable in those data files is converted to a **PSCustomObject**.

    Parameter handlers have the following properties:

    - **Name:** The name of the _input_ parameter to the action. This is
      used to retrieve the value from the environment variable (`INPUT_*`)
      and is distinct from the parameters that need to be passed to the
      script.
    - **Type:** The dotnet type of the input. Currently unused, but may be
      useful for casting later.
    - **IfNullOrEmpty:** A scriptblock that will be invoked if the value
      retrieval for that parameter returns `$null` or an empty string or
      array. It takes one input (`$ErrorTarget`) and should either throw
      an exception (if the parameter is mandatory and may not be null) or
      do nothing. It should not return any objects to the output stream.
    - **Process:** A scriptblock that will be invoked if prior steps for
      the parameter do not throw any exceptions. It takes three arguments
      (`$Parameters`, `$Value`, and `$ErrorTarget`). `$Parameters` is the
      current hashtable with any already-validated parameters defined. It
      is what will eventually be splatted to the action script. This
      scriptblock should validate the script parameter(s) it gets from the
      action's inputs, add them to the hash, and return the hash. If the
      parameters fail validation, it should throw an exception to avoid
      calling the script in a broken state.
.EXAMPLE
    ```powershell
    $ParameterHandlers = Join-Path -Path $ActionPath -ChildPath Parameters.psd1 |
        ForEach-Object -Process { Import-PowerShellDataFile -Path $_ } |
        Select -ExpandProperty Parameters |
        ForEach-Object -Process { [pscustomobject]$_ }
    $Parameters = Get-ActionScriptParameter -ParameterHandler $ParameterHandlers
    ```

    This example reads in the data file containing the parameter handlers and converts them to
    **PSCustomObjects** before passing them to the cmdlet. The cmdlet retrieves the inputs from
    environment variables and uses the handlers to process them, eventually returning a hashtable
    containing the parameters for that action. If any parameter fails validation, the cmdlet throws
    an exception and the run ends.
#>
function Get-ActionScriptParameter {
    [CmdletBinding()]
    param(
        [pscustomobject[]]$ParameterHandler
    )

    begin {
        $ActionParameters = @{}
        $ErrorTarget = if ($env:GITHUB_ACTIONS) {
            $env:GITHUB_ACTION
        } else {
            $PSCmdlet.MyInvocation.InvocationName
        }

        function Update-ScriptBlockFromDataFile {
            [CmdletBinding()]
            param(
                [scriptblock]$ScriptBlock
            )

            begin {
                $Predicate = {
                    param([System.Management.Automation.Language.Ast]$AstObject)
                    return ($AstObject -is [System.Management.Automation.Language.ScriptBlockAst])
                }
            }

            process {
                $Stringified = $ScriptBlock.Ast.EndBlock.Extent.Text?.Trim()
                # Scriptblocks from data files get wrapped in extra curly braces, preventing them
                # from being invocable. Normally just the contents shows up when calling ToString()
                # on a scriptblock, so this is one way to tell.
                if ($Stringified -match '^\{') {
                    $NestedBlock = $ScriptBlock.Ast.FindAll($Predicate, $true)
                    | Where-Object -FilterScript { $_.EndBlock.Extent.Text.Trim() -notmatch '^\{' }
                    | Select-Object -First 1
                }

                if ($NestedBlock -is [System.Management.Automation.Language.ScriptBlockAst]) {
                    return $NestedBlock.GetScriptBlock()
                }

                return $ScriptBlock
            }

            end {}
        }
    }

    process {
        foreach ($Handler in $ParameterHandler) {
            $Value = Get-Item "Env:\INPUT_$($Handler.Name)" | Select-Object -ExpandProperty Value
            if ($Handler.Type -match 'String') {
                $NullHandler = Update-ScriptBlockFromDataFile -ScriptBlock $Handler.IfNullOrEmpty
                if ([string]::IsNullOrEmpty($Value) -and ($null -ne $NullHandler)) {
                    Set-Variable -Name InvocationParameters -Value @{
                        ScriptBlock  = $NullHandler
                        NoNewScope   = $true
                        ArgumentList = @(
                            $ErrorTarget
                        )
                    }
                    Invoke-Command @InvocationParameters
                }
            } else {
                $NullHandler = Update-ScriptBlockFromDataFile -ScriptBlock $Handler.IfNull
                if ($null -eq $Value -and ($null -ne $NullHandler)) {
                    Set-Variable -Name InvocationParameters -Value @{
                        ScriptBlock  = $NullHandler
                        NoNewScope   = $true
                        ArgumentList = @(
                            $ErrorTarget
                        )
                    }
                    Invoke-Command @InvocationParameters
                }
            }

            $ProcessScriptBlock = Update-ScriptBlockFromDataFile -ScriptBlock $Handler.Process
            if ($null -eq $ProcessScriptBlock) {
                throw 'no go bud, need a process script block'
            }

            Set-Variable -Name InvocationParameters -Value @{
                ScriptBlock  = $ProcessScriptBlock
                NoNewScope   = $true
                ArgumentList = @(
                    $ActionParameters
                    $Value
                    $ErrorTarget
                )
            }
            $ActionParameters = Invoke-Command @InvocationParameters
        }
    }

    end {
        $ActionParameters
    }
}
