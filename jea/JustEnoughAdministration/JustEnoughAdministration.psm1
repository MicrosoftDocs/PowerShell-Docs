[DscResource()]
class JeaEndpoint
{
    ## The mandatory endpoint name. Use 'Microsoft.PowerShell' by default.
    [DscProperty(Key)]
    [string] $EndpointName = 'Microsoft.PowerShell'

    ## The mandatory role definition map to be used for the endpoint. This
    ## should be a string that represents the Hashtable used for the RoleDefinitions
    ## property in New-PSSessionConfigurationFile, such as:
    ## RoleDefinitions = '@{ Everyone = @{ RoleCapabilities = "BaseJeaCapabilities" } }'
    [Dscproperty(Mandatory)]
    [string] $RoleDefinitions
    
    ## The optional groups to be used when the endpoint is configured to
    ## run as a Virtual Account
    [DscProperty()]
    [string[]] $RunAsVirtualAccountGroups
    
    ## The optional Group Managed Service Account (GMSA) to use for this
    ## endpoint. If configured, will disable the default behaviour of
    ## running as a Virtual Account
    [DscProperty()]
    [string] $GroupManagedServiceAccount

    ## The optional directory for transcripts to be saved to
    [DscProperty()]
    [string] $TranscriptDirectory

    ## The optional startup script for the endpoint
    [DscProperty()]
    [string[]] $ScriptsToProcess

    ## The optional switch to enable mounting of a restricted user drive
    [Dscproperty()]
    [bool] $MountUserDrive

    ## The optional size of the user drive. The default is 50MB.
    [Dscproperty()]
    [long] $UserDriveMaximumSize

    ## The optional expression declaring which domain groups (for example,
    ## two-factor authenticated users) connected users must be members of. This
    ## should be a string that represents the Hashtable used for the RequiredGroups
    ## property in New-PSSessionConfigurationFile, such as:
    ## RequiredGroups = '@{ And = "RequiredGroup1", @{ Or = "OptionalGroup1", "OptionalGroup2" } }'
    [Dscproperty()]
    [string] $RequiredGroups
    
    ## Applies the JEA configuration
    [void] Set()
    {
        $psscPath = Join-Path ([IO.Path]::GetTempPath()) ([IO.Path]::GetRandomFileName() + ".pssc")

        ## Convert the RoleDefinitions string to the actual Hashtable
        $roleDefinitionsHash = $this.ConvertStringToHashtable($this.RoleDefinitions)

        $configurationFileArguments = @{
            Path = $psscPath
            RoleDefinitions = $roleDefinitionsHash
        }

        if($this.RunAsVirtualAccountGroups -and $this.GroupManagedServiceAccount)
        {
            throw "The RunAsVirtualAccountGroups setting can not be used when a configuration is set to run as a Group Managed Service Account"
        }
        
        ## Set up the JEA identity
        if($this.RunAsVirtualAccountGroups)
        {
            $configurationFileArguments["RunAsVirtualAccount"] = $true
            $configurationFileArguments["RunAsVirtualAccountGroups"] = $this.RunAsVirtualAccountGroups
        }
        elseif($this.GroupManagedServiceAccount)
        {
            $configurationFileArguments["GroupManagedServiceAccount"] = $this.GroupManagedServiceAccount
        }       
        else
        {
            $configurationFileArguments["RunAsVirtualAccount"] = $true
        }
        
        ## Transcripts
        if($this.TranscriptDirectory)
        {
            $configurationFileArguments["TranscriptDirectory"] = $this.TranscriptDirectory
        }

        ## Startup scripts
        if($this.ScriptsToProcess)
        {
            $configurationFileArguments["ScriptsToProcess"] = $this.ScriptsToProcess
        }

        ## Mount user drive
        if($this.MountUserDrive)
        {
            $configurationFileArguments["MountUserDrive"] = $this.MountUserDrive
        }

        ## User drive maximum size
        if($this.UserDriveMaximumSize)
        {
            $configurationFileArguments["UserDriveMaximumSize"] = $this.UserDriveMaximumSize
            $configurationFileArguments["MountUserDrive"] = $true
        }
        
        ## Required groups
        if($this.RequiredGroups)
        {
            ## Convert the RequiredGroups string to the actual Hashtable
            $requiredGroupsHash = $this.ConvertStringToHashtable($this.RequiredGroups)
            $configurationFileArguments["RequiredGroups"] = $requiredGroupsHash
        }

        ## Register the endpoint
        try
        {
            ## If we are replacing Microsoft.PowerShell, create a 'break the glass' endpoint
            if($this.EndpointName -eq "Microsoft.PowerShell")
            {
                $breakTheGlassName = "Microsoft.PowerShell.Restricted"
                if(-not (Get-PSSessionConfiguration -Name ($breakTheGlassName + "*") |
                    Where-Object Name -eq $breakTheGlassName))
                {
                    Register-PSSessionConfiguration -Name $breakTheGlassName
                }
            }

            ## Remove the previous one, if any.
            $existingConfiguration = Get-PSSessionConfiguration -Name ($this.EndpointName + "*") |
                Where-Object Name -eq $this.EndpointName

            if($existingConfiguration)
            {
                Unregister-PSSessionConfiguration -Name $this.EndpointName
            }

            ## Create the configuration file
            New-PSSessionConfigurationFile @configurationFileArguments
            Register-PSSessionConfiguration -Name $this.EndpointName -Path $psscPath

            ## Enable PowerShell logging on the system
            $basePath = "HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"

            if(-not (Test-Path $basePath))
            {
                $null = New-Item $basePath -Force
            }
    
            Set-ItemProperty $basePath -Name EnableScriptBlockLogging -Value "1"
        }
        finally
        {
            Remove-Item $psscPath
        }
    }
    
    # Tests if the resource is in the desired state.
    [bool] Test()
    {
        $currentInstance = $this.Get()

        ## If this was configured with our mandatory property (RoleDefinitions), dig deeper
        if($currentInstance.RoleDefinitions)
        {
            if($currentInstance.EndpointName -ne $this.EndpointName)
            {
                Write-Verbose "EndpointName not equal: $($currentInstance.EndpointName)"
                return $false
            }

            ## Convert the RoleDefinitions string to the actual Hashtable
            $roleDefinitionsHash = $this.ConvertStringToHashtable($this.RoleDefinitions)
            Write-Verbose ($currentInstance.RoleDefinitions.GetType())

            if(-not $this.ComplexObjectsEqual($this.ConvertStringToHashtable($currentInstance.RoleDefinitions), $roleDefinitionsHash))
            {
                Write-Verbose "RoleDfinitions not equal: $($currentInstance.RoleDefinitions)"
                return $false
            }

            if(-not $this.ComplexObjectsEqual($currentInstance.RunAsVirtualAccountGroups, $this.RunAsVirtualAccountGroups))
            {
                Write-Verbose "RunAsVirtualAccountGroups not equal: $(ConvertTo-Json $currentInstance.RunAsVirtualAccountGroups -Depth 100)"
                return $false
            }

            if($currentInstance.GroupManagedServiceAccount -ne $this.GroupManagedServiceAccount)
            {
                Write-Verbose "GroupManagedServiceAccount not equal: $($currentInstance.GroupManagedServiceAccount)"
                return $false
            }

            if($currentInstance.TranscriptDirectory -ne $this.TranscriptDirectory)
            {
                Write-Verbose "TranscriptDirectory not equal: $($currentInstance.TranscriptDirectory)"
                return $false
            }

            if(-not $this.ComplexObjectsEqual($currentInstance.ScriptsToProcess, $this.ScriptsToProcess))
            {
                Write-Verbose "ScriptsToProcess not equal: $(ConvertTo-Json $currentInstance.ScriptsToProcess -Depth 100)"
                return $false
            }

            if($currentInstance.MountUserDrive -ne $this.MountUserDrive)
            {
                Write-Verbose "MountUserDrive not equal: $($currentInstance.MountUserDrive)"
                return $false
            }

            if($currentInstance.UserDriveMaximumSize -ne $this.UserDriveMaximumSize)
            {
                Write-Verbose "UserDriveMaximumSize not equal: $($currentInstance.UserDriveMaximumSize)"
                return $false
            }

            $requiredGroupsHash = $this.ConvertStringToHashtable($this.RequiredGroups)
            if(-not $this.ComplexObjectsEqual($this.ConvertStringToHashtable($currentInstance.RequiredGroups), $requiredGroupsHash))
            {
                Write-Verbose "RequiredGroups not equal: $(ConvertTo-Json $currentInstance.RequiredGroups -Depth 100)"
                return $false
            }

            return $true
        }
        else
        {
            return $false
        }
    }

    ## A simple comparison for complex objects used in JEA configurations.
    ## We don't need anything extensive, as we should be the only ones changing
    ## them.
    hidden [bool] ComplexObjectsEqual($object1, $object2)
    {
        $json1 = ConvertTo-Json -InputObject $object1 -Depth 100
        Write-Verbose "Argument1: $json1"

        $json2 = ConvertTo-Json -InputObject $object2 -Depth 100
        Write-Verbose "Argument2: $json2"

        return ($json1 -eq $json2)
    }

    ## Convert a string representing a Hashtable into a Hashtable
    hidden [Hashtable] ConvertStringToHashtable($hashtableAsString)
    {
        $ast = [System.Management.Automation.Language.Parser]::ParseInput($hashtableAsString, [ref] $null, [ref] $null)
        $data = $ast.Find( { $args[0] -is [System.Management.Automation.Language.HashtableAst] }, $false )

        return [Hashtable] $data.SafeGetValue()
    }

    # Gets the resource's current state.
    [JeaEndpoint] Get()
    {
        $returnObject = New-Object JeaEndpoint
        
        $sessionConfiguration = Get-PSSessionConfiguration -Name ($this.EndpointName + "*") |
            Where-Object Name -eq $this.EndpointName

        if((-not $sessionConfiguration) -or (-not $sessionConfiguration.ConfigFilePath))
        {
            return $returnObject
        }
        else
        {
            $configFileArguments = Import-PowerShellDataFile $sessionConfiguration.ConfigFilePath
            $rawConfigFileAst = [System.Management.Automation.Language.Parser]::ParseFile($sessionConfiguration.ConfigFilePath, [ref] $null, [ref] $null)
            $rawConfigFileArguments = $rawConfigFileAst.Find( { $args[0] -is [System.Management.Automation.Language.HashtableAst] }, $false )

            $returnObject.EndpointName = $sessionConfiguration.Name

            ## Convert the hashtable to a string, as that is the input format required by DSC
            $returnObject.RoleDefinitions = $rawConfigFileArguments.KeyValuePairs | ? { $_.Item1.Extent.Text -eq 'RoleDefinitions' } | % { $_.Item2.Extent.Text }

            if($sessionConfiguration.RunAsVirtualAccountGroups)
            {
                $returnObject.RunAsVirtualAccountGroups = $sessionConfiguration.RunAsVirtualAccountGroups -split ';'
            }

            if($sessionConfiguration.RunAsUser)
            {
                $returnObject.GroupManagedServiceAccount = $sessionConfiguration.RunAsUser
            }

            if($configFileArguments.TranscriptDirectory)
            {
                $returnObject.TranscriptDirectory = $configFileArguments.TranscriptDirectory
            }

            if($configFileArguments.ScriptsToProcess)
            {
                $returnObject.ScriptsToProcess = $configFileArguments.ScriptsToProcess
            }

            if($configFileArguments.MountUserDrive)
            {
                $returnObject.MountUserDrive = $configFileArguments.MountUserDrive
            }

            if($configFileArguments.UserDriveMaximumSize)
            {
                $returnObject.UserDriveMaximumSize = $configFileArguments.UserDriveMaximumSize
            }

            if($configFileArguments.RequiredGroups)
            {
                $returnObject.RequiredGroups = $rawConfigFileArguments.KeyValuePairs | ? { $_.Item1.Extent.Text -eq 'RequiredGroups' } | % { $_.Item2.Extent.Text }
            }

            return $returnObject
        }
    }
}