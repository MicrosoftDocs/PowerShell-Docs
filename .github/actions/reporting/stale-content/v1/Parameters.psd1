@{
  Parameters = @(
    @{
      Name = 'Relative_Folder_Path'
      Type = 'String[]'
      IfNullOrEmpty = {
        param($ErrorTarget)
        # It's okay if this parameter is not specified, but warn that it will
        # inspect the entire repository:
        $Message = @(
          'No relative folder path specified;'
          'defaulting to search the entire working directory for stale content.'
        ) -join ' '

        Write-Warning -Message $Message
      }
      Process = {
        param($Parameters, $Value, $ErrorTarget)

        $RelativeFolderPath = $Value -split "`n"
        | ForEach-Object -Process { $_.Trim().Trim('"').Trim("'") }
        | Where-Object -FilterScript { -not [string]::IsNullOrEmpty($_) }

        if ([string]::IsNullOrEmpty($RelativeFolderPath)) {
          $Parameters.RelativeFolderPath = '.'
        } else {
          $Parameters.RelativeFolderPath = $RelativeFolderPath
        }
        Write-HostParameter -Name RelativeFolderPath -Value $Parameters.RelativeFolderPath

        return $Parameters
      }
    }

    @{
      Name = 'Exclude_Folder_Segment'
      Type = 'String[]'
      IfNullOrEmpty = {
        param($ErrorTarget)
        # It's okay if this parameter is not specified.
      }
      Process = {
        param($Parameters, $Value, $ErrorTarget)

        $ExcludeFolderSegment = $Value -split "`n"
        | ForEach-Object -Process { $_.Trim().Trim('"').Trim("'") }
        | Where-Object -FilterScript { -not [string]::IsNullOrEmpty($_) }

        if (![string]::IsNullOrEmpty($ExcludeFolderSegment)) {
          $Parameters.ExcludeFolderSegment = $ExcludeFolderSegment
          Write-HostParameter -Name ExcludeFolderSegment -Value $Parameters.ExcludeFolderSegment
        }

        return $Parameters
      }
    }

    @{
      Name = 'Days_Until_Stale'
      Type = 'Int'
      IfNullOrEmpty = {
        param($ErrorTarget)
        # It's okay if this parameter is not specified.
      }
      Process = {
        param($Parameters, $Value, $ErrorTarget)

        if ([string]::IsNullOrEmpty($Value)) {
          return $Parameters
        }

        # Because DaysUntilStale and StaleSinceDate belong to different
        # parameter sets, do not add DaysUntilStale if StaleSinceDate is already
        # defined.
        if ($Parameters.ContainsKey('StaleSinceDate')) {
          $Message = @(
            'Specified both days_until_stale and stale_since_date parameters;'
            'they cannot be used together. Using the stale_since_date value of'
            "'$($Parameters.StaleSinceDate)' for the action. To use the"
            'days_until_stale value, remove the stale_since_date input from'
            'your workflow definition.'
          ) -join ' '
          Write-Warning $Message
        }

        $Parameters.DaysUntilStale = [int]$Value
        Write-HostParameter -Name DaysUntilStale -Value $Parameters.DaysUntilStale

        return $Parameters
      }
    }

    @{
      Name = 'Stale_Since_Date'
      Type = 'DateTime'
      IfNullOrEmpty = {
        param($ErrorTarget)
        # It's okay if this parameter is not specified.
      }
      Process = {
        param($Parameters, $Value, $ErrorTarget)

        if ([string]::IsNullOrEmpty($Value)) {
          return $Parameters
        }

        # Because DaysUntilStale and StaleSinceDate belong to different
        # parameter sets, remove DaysUntilStale before adding StaleSinceDate.
        if ($Parameters.ContainsKey('DaysUntilStale')) {
          $Message = @(
            'Specified both days_until_stale and stale_since_date parameters;'
            'they cannot be used together. Using the stale_since_date value of'
            "'$($Value)' for the action. To use the days_until_stale value,"
            'remove the stale_since_date input from your workflow definition.'
          ) -join ' '
          Write-Warning $Message
          $Parameters.Remove('DaysUntilStale')
        }

        $Parameters.StaleSinceDate = [datetime]$Value
        Write-HostParameter -Name StaleSinceDate -Value $Parameters.StaleSinceDate

        return $Parameters
      }
    }

    @{
      Name = 'Upload_Artifact'
      Type = 'Bool'
      IfNullOrEmpty = {
        param($ErrorTarget)
        # It's okay if this parameter is not specified.
      }
      Process = {
        param($Parameters, $Value, $ErrorTarget)

        if ([string]::IsNullOrEmpty($Value)) {
          return $Parameters
        }

        if ($Parameters.ContainsKey('ExportAsCsv')) {
          $Message = @(
            'Specified both export_as_csv and upload_artifact parameters;'
            'upload_artifact implies export_as_csv, so you do not need to'
            'specify both. The stale content report will be exported as a'
            'CSV and uploaded as an artifact in this action.'
          ) -join ' '
          Write-Warning $Message
        }

        if ($Value -eq 'True') {
          $Parameters.UploadArtifact = $true
          Write-HostParameter -Name UploadArtifact -Value $Parameters.UploadArtifact
        } else {
          $Message = @(
            "Specified upload_artifact as '$Value';"
            'unless specified as "true" (case-insensitive), it is ignored and'
            'the stale content report is not automatically uploaded as an'
            'action artifact.'
          ) -join ' '
          Write-Warning $Message
        }

        return $Parameters
      }
    }

    @{
      Name = 'Export_As_Csv'
      Type = 'Bool'
      IfNullOrEmpty = {
        param($ErrorTarget)
        # It's okay if this parameter is not specified.
      }
      Process = {
        param($Parameters, $Value, $ErrorTarget)

        if ([string]::IsNullOrEmpty($Value)) {
          return $Parameters
        }

        if ($Parameters.ContainsKey('UploadArtifact')) {
          $Message = @(
            'Specified both export_as_csv and upload_artifact parameters;'
            'upload_artifact implies export_as_csv, so you do not need to'
            'specify both. The stale content report will be exported as a'
            'CSV and uploaded as an artifact in this action.'
          ) -join ' '
          Write-Warning $Message
        }

        if ($Value -eq 'True') {
          $Parameters.ExportAsCsv = $true
          Write-HostParameter -Name ExportAsCsv -Value $Parameters.ExportAsCsv
        } else {
          $Message = @(
            "Specified export_as_csv as '$Value';"
            'unless specified as "true" (case-insensitive), it is ignored and'
            'the stale content report is exported as a CSV file.'
          ) -join ' '
          Write-Warning $Message
        }

        return $Parameters
      }
    }

    @{
      Name = 'Export_Path'
      Type = 'string'
      IfNullOrEmpty = {
        param($ErrorTarget)
        # It's okay if this parameter is not specified.
      }
      Process = {
        param($Parameters, $Value, $ErrorTarget)

        if ([string]::IsNullOrEmpty($Value)) {
          return $Parameters
        } elseif ($Value -match '\$\(.+\)') {
          # It seems like they're trying to get a dynamic value for the name,
          # which we can't support for security reasons. Instead, they should
          # dynamically generate the name in a prior step.
          $Message = @(
            "Specified export_path as '$Value', which looks like a dynamically"
            'defined value; this input is passed literally. For this run,'
            'the default file name will be used instead.To dynamically generate'
            'a value for the CSV file name, use another step in your workflow'
            'to define the output and reference for this input instead. For an'
            'example on how to do this, see our documentation.'
            'Note that any value matching the following regex will trigger this'
            "warning: '\$\(.+\)'"
          ) -join ' '
          Write-Warning -Message $Message
        } else {
          $Parameters.ExportPath = $Value.Trim()
          Write-HostParameter -Name ExportPath -Value $Parameters.ExportPath
        }

        return $Parameters
      }
    }
  )
}
