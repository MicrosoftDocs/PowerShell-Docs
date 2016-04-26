function greet-everything {
    [CmdletBinding()]
    Param(
        [parameter (ValueFromPipeline=$true)] [int]$number
    )

    begin { }
    process { Write-Output "Hello $number" }
    end { }
}
