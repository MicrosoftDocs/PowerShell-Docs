@{
    # Script module or binary module file associated with this manifest.
    RootModule           = 'gha.psm1'

    # Version number of this module.
    ModuleVersion        = '0.0.1'

    # ID used to uniquely identify this module
    GUID                 = '8e4299da-59ae-4b46-ab06-dc8da81d1c3c'

    # Author of this module
    Author               = 'PowerShell Docs Team'

    # Copyright statement for this module
    Copyright            = '(c) Microsoft. All rights reserved.'

    # Description of the functionality provided by this module
    Description          = 'Helper module for GitHub Actions'

    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion    = '7.2'

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules      = @()

    # Assemblies that must be loaded prior to importing this module
    RequiredAssemblies   = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    ScriptsToProcess     = @()

    # Type files (.ps1xml) to be loaded when importing this module
    TypesToProcess       = @()

    # Format files (.ps1xml) to be loaded when importing this module
    FormatsToProcess     = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    NestedModules        = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport    = @(
        # API Functions
        'Add-PullRequestComment'
        'Get-AuthorPermission'
        'Get-OpenPRWithoutExpectation'
        'Get-PullRequestChangedFile'
        # Utility Functions
        'Add-VersionedContentTable'
        'Format-ConsoleBoolean'
        'Format-ConsoleStyle'
        'Format-GHAConsoleText'
        'Get-ActionScriptParameter'
        'Get-GHAConsoleError'
        'Get-StaleDocument'
        'Get-VersionedContentChangeStatus'
        'Get-VersionedContentTableColumnWidth'
        'New-CliErrorRecord'
        'New-InvalidParameterError'
        'Write-ActionFailureSummary'
        'Write-HostParameter'
    )

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport      = @()

    # Variables to export from this module
    VariablesToExport    = '*'

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport      = @()

    # List of all modules packaged with this module
    ModuleList           = @()

    # HelpInfo URI of this module
    # HelpInfoURI          = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData          = @{

      PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags       = @()

        # A URL to the license for this module.
        LicenseUri = ''

        # A URL to the main website for this project.
        ProjectUri = ''

        # A URL to an icon representing this module.
        IconUri    = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''
      } # End of PSData hashtable

    } # End of PrivateData hashtable
}
