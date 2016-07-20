# Logic for preparing the module dependencies during Publish operation
1.	Modules listed as part of RequiredModules are considered as dependencies.
2.	Modules listed as part of NestedModules, whose module base is not under the specified module base, are considered as dependencies.

3.	Above dependencies should be available on the same target repository, otherwise publish operation will result in an error.
    For example: If 'SnippetPx' is not available on the repository, below error will be thrown.
    ```powershell
    Publish-PSArtifactUtility : PowerShellGet cannot resolve the module dependency 'SnippetPx' of the module 'TypePx' on the repository 'LocalRepo'. Verify that the dependent module 'SnippetPx' is available in the repository 'LocalRepo'. If this dependent
    'SnippetPx' is managed externally, add it to the ExternalModuleDependencies entry in the PSData section of the module manifest.
    ```
4.	Some module dependencies can be managed externally, in that case they should be added to the ExternalModuleDependencies entry in the PSData section of the module manifest.
    Below part in the above error message
    ```powershell
    If this dependent 'SnippetPx' is managed externally, add it to the ExternalModuleDependencies entry in the PSData section of the module manifest.
    ```

*During the module installation, above prepared dependencies list is used for installing the dependencies.*

*Please ensure that your module’s dependencies are available under $env:PSModulePath on your system during publish operation.*
