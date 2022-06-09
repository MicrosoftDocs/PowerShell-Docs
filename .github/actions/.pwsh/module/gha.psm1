$FunctionFinderParams = @{
    Path    = "$PSScriptRoot/functions"
    Include = '*-*.ps1'
    Exclude = '*.Tests.ps1'
    Recurse = $true
}

Get-ChildItem @FunctionFinderParams
| ForEach-Object -Process {
    . $_.FullName
}

Export-ModuleMember -Function *