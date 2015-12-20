## Help support for DSC Configuration
Support for -? during DSC configuration compilation
---------------------------------------------------

WMF 5.0 Preview April 2015 includes help support for DSC configurations.

**Examples**

Two configuration scripts: HelpSample1 and HelpSample2
```PowerShell
<#
.SYNOPSIS
The synopsis for the configuration goes here. This can be one line, or many.

.DESCRIPTION
The description for the configuration is usually a longer, more detailed explanation of what the script or function does. Use as many lines as you need.

.PARAMETER computername
Here, the dotted keyword is followed by a single parameter name. Don't precede that with a hyphen. The following lines describe the purpose of the parameter:

.PARAMETER filePath
Provide a PARAMETER section for each parameter that your script or function accepts.

.EXAMPLE
There's no need to number your examples.

.EXAMPLE
Windows PowerShell will number them for you when it displays your help text to a user.
#>

configuration HelpSample1
{
    param([string]$computername,[string]$filePath)
    File f
    {
		Contents="Hello World"
        DestinationPath = "c:\Destination.txt"
    }
}

<#
.SYNOPSIS
The synopsis for the configuration HelpSample2 goes here. This can be one line, or many.

.DESCRIPTION
The description for the configuration bar is usually a longer, more detailed explanation of what the script or function does. Take as many lines as you need.

.PARAMETER computername
Here, the dotted keyword is followed by a single parameter name. Don't precede that with a hyphen. The following lines describe the purpose of the parameter:

.PARAMETER filePath
Provide a PARAMETER section for each parameter that your script or function accepts.

.EXAMPLE
There's no need to number your examples.

.EXAMPLE
Windows PowerShell will number them for you when it displays your help text to a user.

#>

configuration HelpSample2
{
    param([string]$computername,[string]$filePath)

    File f
    {
		Contents="Hello World"
        DestinationPath = "c:\Destination.txt"
    }
}
```

Get help for first configuration named HelpSample1

```PowerShell
PS C:\Windows\system32> HelpSample1 -?

NAME
HelpSample1

SYNOPSIS
The synopsis for the configuration goes here. This can be one line, or many.

SYNTAX
HelpSample1 [[-InstanceName] <String>] [[-DependsOn] <String[]>] [[-OutputPath] <String>] [[-ConfigurationData] <Hashtable>] [[-computername] <String>] [[-filePath] <String>] [<CommonParameters>]

DESCRIPTION
The description for the configuration is usually a longer, more detailed explanation of what the script or function does. Take as many lines as you need.

RELATED LINKS

REMARKS

To see the examples, type: "get-help HelpSample1 -examples".
For more information, type: "get-help HelpSample1 -detailed".
For technical information, type: "get-help HelpSample1 -full".
```

Get detailed help for second configuration named HelpSample2

```PowerShell
PS C:\Windows\system32> get-help HelpSample2 -detailed

NAME

HelpSample2

SYNOPSIS

The synopsis for the configuration HelpSample2 goes here. This can be one line, or many.

SYNTAX

HelpSample2 [[-InstanceName] <String>] [[-DependsOn] <String[]>] [[-OutputPath] <String>] [[-ConfigurationData] <Hashtable>] [[-computername] <String>] [[-filePath] <String>] [<CommonParameters>]

DESCRIPTION

The description for the configuration bar is usually a longer, more detailed explanation of what the script or function does. Take as many lines as you need.

PARAMETERS

-InstanceName <String>
-DependsOn <String[]>
-OutputPath <String>
-ConfigurationData <Hashtable>
-computername <String>

Here, the dotted keyword is followed by a single parameter name. Don't precede that with a hyphen. The following lines describe the purpose of the parameter:

-filePath <String>

Provide a PARAMETER section for each parameter that your script or function accepts.

<CommonParameters>

This cmdlet supports the common parameters: Verbose, Debug,
ErrorAction, ErrorVariable, WarningAction, WarningVariable,
OutBuffer, PipelineVariable, and OutVariable. For more information, see
about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

-------------------------- EXAMPLE 1 --------------------------

PS C:\>There's no need to number your examples.

-------------------------- EXAMPLE 2 --------------------------

PS C:\>Windows PowerShell will number them for you when it displays your help text to a user.

REMARKS

To see the examples, type: "get-help HelpSample2 -examples".
For more information, type: "get-help HelpSample2 -detailed".
For technical information, type: "get-help HelpSample2 -full".
```

Run HelpSample1 in debug mode

```PowerShell
PS C:\Windows\system32> HelpSample1 -debug

DEBUG: MSFT_FileDirectoryConfiguration: RESOURCE PROCESSING STARTED [KeywordName='File'] Function='PSDesiredStateConfiguration\File']
DEBUG: MSFT_FileDirectoryConfiguration: ResourceID = [File]f
DEBUG: MSFT_FileDirectoryConfiguration: Processing property 'DependsOn' [
DEBUG: MSFT_FileDirectoryConfiguration: Processing completed 'DependsOn' ]
DEBUG: MSFT_FileDirectoryConfiguration: Processing property 'PsDscRunAsCredential' [
DEBUG: MSFT_FileDirectoryConfiguration: Processing completed 'PsDscRunAsCredential' ]
DEBUG: MSFT_FileDirectoryConfiguration: Processing property 'DestinationPath' [
DEBUG: MSFT_FileDirectoryConfiguration: Canonicalized property 'DestinationPath' = 'c:\Destination.txt'
DEBUG: MSFT_FileDirectoryConfiguration: Processing completed 'DestinationPath' ]
DEBUG: MSFT_FileDirectoryConfiguration: Processing property 'Ensure' [
DEBUG: MSFT_FileDirectoryConfiguration: Processing completed 'Ensure' ]
DEBUG: MSFT_FileDirectoryConfiguration: Processing property 'Type' [
DEBUG: MSFT_FileDirectoryConfiguration: Processing completed 'Type' ]
DEBUG: MSFT_FileDirectoryConfiguration: Processing property 'SourcePath' [
DEBUG: MSFT_FileDirectoryConfiguration: Processing completed 'SourcePath' ]
DEBUG: MSFT_FileDirectoryConfiguration: Processing property 'Contents' [
DEBUG: MSFT_FileDirectoryConfiguration: Canonicalized property 'Contents' = 'Hello World'
DEBUG: MSFT_FileDirectoryConfiguration: Processing completed 'Contents' ]
DEBUG: MSFT_FileDirectoryConfiguration: Processing property 'Checksum' [
DEBUG: MSFT_FileDirectoryConfiguration: Processing completed 'Checksum' ]
DEBUG: MSFT_FileDirectoryConfiguration: Processing property 'Recurse' [
DEBUG: MSFT_FileDirectoryConfiguration: Processing completed 'Recurse' ]
DEBUG: MSFT_FileDirectoryConfiguration: Processing property 'Force' [
DEBUG: MSFT_FileDirectoryConfiguration: Processing completed 'Force' ]
DEBUG: MSFT_FileDirectoryConfiguration: Processing property 'Credential' [
DEBUG: MSFT_FileDirectoryConfiguration: Processing completed 'Credential' ]
DEBUG: MSFT_FileDirectoryConfiguration: Processing property 'Attributes' [
DEBUG: MSFT_FileDirectoryConfiguration: Processing completed 'Attributes' ]
DEBUG: MSFT_FileDirectoryConfiguration: Processing property 'MatchSource' [
DEBUG: MSFT_FileDirectoryConfiguration: Processing completed 'MatchSource' ]
DEBUG: MSFT_FileDirectoryConfiguration: MOF alias for this resource is '$MSFT_FileDirectoryConfiguration1ref'
DEBUG: MSFT_FileDirectoryConfiguration: RESOURCE PROCESSING COMPLETED. TOTAL ERROR COUNT: 0

Directory: C:\temp\HelpSample1

Mode LastWriteTime Length Name
---- ------------- ------ ----
-a---- 4/16/2015 3:30 PM 1940 localhost.mof

WARNING: The configuration 'HelpSample1' is loading one or more built-in resources without explicitly importing associated modules. Add Import-DscResource –ModuleName ’PSDesiredStateConfiguration’ to your configuration to avoid this
message.
```