function Invoke-Test
{
    [CmdletBinding()]
    param()

    $path = Join-Path $PSScriptRoot 'Pester'
    $logFilePath = Join-Path $PSScriptRoot 'TestResults.xml'

    Invoke-Pester $path -OutputFile $logFilePath -OutputFormat NUnitXml
    Test-PSPesterResults -TestResultsFile $logFilePath
}

function Test-PSPesterResults
{
    param(
        [string]$TestResultsFile = "pester-tests.xml"
    )

    if(!(Test-Path $TestResultsFile))
    {
        throw "Test result file '$testResultsFile' not found."
    }

    $x = [xml](Get-Content -Raw $testResultsFile)
    if ([int]$x.'test-results'.failures -gt 0)
    {
        logerror "TEST FAILURES"
        # switch between methods, SelectNode is not available on dotnet core
        if ( "System.Xml.XmlDocumentXPathExtensions" -as [Type] ) {
            $failures = [System.Xml.XmlDocumentXPathExtensions]::SelectNodes($x."test-results",'.//test-case[@result = "Failure"]')
        }
        else {
            $failures = $x.SelectNodes('.//test-case[@result = "Failure"]')
        }
        foreach ( $testfail in $failures )
        {
            Show-PSPesterError $testfail
        }
        throw "$($x.'test-results'.failures)"
    }
}

function Show-PSPesterError
{
    param ( [Xml.XmlElement]$testFailure )
    logerror ("Description: " + $testFailure.description)
    logerror ("Name:        " + $testFailure.name)
    logerror "message:"
    logerror $testFailure.failure.message
    logerror "stack-trace:"
    logerror $testFailure.failure."stack-trace"
}

function script:logerror([string]$message) {
    Write-Host -Foreground Red $message
    #reset colors for older package to at return to default after error message on a compilation error
    [console]::ResetColor()
}
