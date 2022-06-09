@{
  Parameters = @(
    @{
      Name = 'Repository'
      Type = 'string'
      IfNullOrEmpty = {
        param($ErrorTarget)

        $ErrorDetails = @{
          Name    = 'Repository'
          Type    = 'Missing'
          Message = @(
            'Could not determine repository;'
            'was it passed as an input to the action?'
          ) -join ' '
          Target  = $ErrorTarget
        }
        $Record = New-InvalidParameterError @ErrorDetails

        throw $Record
      }
      Process = {
        param($Parameters, $Value, $ErrorTarget)

        $Parameters.Owner, $Parameters.Repo = $Value -split '/'
        Write-HostParameter -Name Owner -Value $Parameters.Owner
        Write-HostParameter -Name Repo -Value $Parameters.Repo

        return $Parameters
      }
    }

    @{
      Name = 'Permissions'
      Type = 'String[]'
      IfNullOrEmpty = {
          param($ErrorTarget)

          $ErrorDetails = @{
              Name    = 'Permissions'
              Type    = 'Missing'
              Message = @(
                  'Could not determine valid permission list;'
                  'was it passed as an input to the action?'
              ) -join ' '
              Target  = $ErrorTarget
          }
          $Record = New-InvalidParameterError @ErrorDetails

          throw $Record
      }
      Process = {
        param($Parameters, $Value, $ErrorTarget)

        $SpecifiedPermissions = $Value -split ','

        $InvalidPermissions = @()
        $ValidPermissions = @(
          'Admin'
          'Maintain'
          'Pull'
          'Push'
          'Triage'
        )
        $Parameters.ValidPermissions = $SpecifiedPermissions | ForEach-Object {
          if ($_ -notin $ValidPermissions) {
            $InvalidPermissions += $_
          } else {
            $_
          }
        }
        if ($InvalidPermissions.Count -gt 0) {
          $Message = New-Object -TypeName System.Text.StringBuilder
          $null = $Message.Append('Specified invalid permissions;')
          $null = $Message.AppendLine('Permissions must be any of:')
          foreach ($Permission in $ValidPermissions) {
            $null = $Message.AppendLine("`t$Permission")
          }
          $null = $Message.AppendLine(
            'But the following invalid permissions were specified:'
          )
          foreach ($Permission in $InvalidPermissions) {
            $null = $Message.AppendLine("`t$Permission")
          }
          $ErrorDetails = @{
            Name    = 'Permissions'
            Type    = 'Invalid'
            Message = $Message.ToString()
            Target  = $ErrorTarget
          }
          $Record = New-InvalidParameterError @ErrorDetails
          throw $Record
        } else {
          Write-HostParameter -Name Permissions -Value $Parameters.ValidPermissions

          return $Parameters
        }
      }
    }

    @{
      Name = 'Target'
      Type = 'String[]'
      IfNullOrEmpty = {
        param($ErrorTarget)

        $ErrorDetails = @{
          Name    = 'Target'
          Type    = 'Missing'
          Message = @(
            'Could not determine target to check for authorization;'
            'was it passed as an input to the action?'
          ) -join ' '
          Target  = $ErrorTarget
        }
        $Record = New-InvalidParameterError @ErrorDetails

        throw $Record
      }
      Process = {
        param($Parameters, $Value, $ErrorTarget)

        $Type, $Targets = $Value -split ':' | ForEach-Object -Process { $_.Trim() }
        # Munge all invalid specifications here to Branch, since we can't apply validation on the
        # action input directly at this time.
        if ($Type -ne 'Path') {
          $Type = 'Branch'
        }

        if ([string]::IsNullOrEmpty($Targets)) {
          if ($Type -eq 'Branch') {
            # Even though this is the default, we need to handle if someone manages to get a null
            # value here in a way we didn't predict.
            $Targets = 'live'
          } else {
            # In this case, the user passed `path:` without specifying any paths.
            $ErrorDetails = @{
              Name    = 'Target'
              Type    = 'Missing'
              Message = @(
                'Determined that the target to check for authorization is a path,'
                'but no paths were specified after the colon.'
                'You must specify one or more paths, separated by a comma or a newline.'
              ) -join ' '
              Target  = $ErrorTarget
            }
            $Record = New-InvalidParameterError @ErrorDetails

            throw $Record
          }
        } else {
          # Split on commas and newlines, trim whitespace and wrapping quotes from all outputs, then
          # discard any empty strings to make sure that only valid targets get passed.
          $Targets = $Targets -split "[,`n]"
          | ForEach-Object -Process { $_.Trim().Trim('"').Trim("'") }
          | Where-Object -FilterScript { -not [string]::IsNullOrEmpty($_) }
        }

        switch ($Type) {
          'Path' {
            $Parameters.TargetPath = $Targets
            Write-HostParameter -Name TargetPath -Value $Parameters.TargetPath
          }
          default {
            $Parameters.TargetBranch = $Targets
            Write-HostParameter -Name TargetBranch -Value $Parameters.TargetBranch
          }
        }

        return $Parameters
      }
    }

    @{
      Name = 'User'
      Type = 'String'
      IfNullOrEmpty = {
        param($ErrorTarget)

        $ErrorDetails = @{
          Name    = 'User'
          Type    = 'Missing'
          Message = @(
            'Could not determine user to check for authorization;'
            'was it passed as an input to the action?'
            'If the action was not triggered on pull request,'
            'it needs to pass the user explicitly.'
          ) -join ' '
          Target  = $ErrorTarget
        }
        $Record = New-InvalidParameterError @ErrorDetails

        throw $Record
      }
      Process = {
        param($Parameters, $Value, $ErrorTarget)

        $Parameters.User = $Value

        Write-HostParameter -Name User -Value $Parameters.User

        return $Parameters
      }
    }
  )
}