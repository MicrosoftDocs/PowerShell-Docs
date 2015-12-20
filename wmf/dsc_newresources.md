### New in-box Resources

WMF 5.0 RTM has three new DSC resources name WindowsFeatureSet, WindowsOptionalFeatureSet and ServiceSet.

#### Windowsfeatureset

PS C:\\&gt; Get-DscResource -Module psdesiredstateconfiguration -Name WindowsFeatureSet -Syntax

WindowsFeatureSet \[String\] \#ResourceName

{

\[DependsOn = \[String\[\]\]\]

Name = \[String\[\]\]

\[Ensure = \[String\]\]

\[Source = \[String\]\]

\[IncludeAllSubFeature = \[Boolean\]\]

\[Credential = \[PSCredential\]\]

\[LogPath = \[String\]\]

}

#### WindowsOptionalFeatureSet 

WindowsOptionalFeatureSet \[String\] \#ResourceName

{

\[DependsOn = \[String\[\]\]\]

Name = \[String\[\]\]

Ensure = \[String\]

\[Source = \[String\[\]\]\]

\[RemoveFilesOnDisable = \[Boolean\]\]

\[LogPath = \[String\]\]

\[NoWindowsUpdateCheck = \[Boolean\]\]

\[LogLevel = \[String\]\]

}

#### ServiceSet 

PS C:\\&gt; Get-DscResource -Module psdesiredstateconfiguration -Name ServiceSet -Syntax

ServiceSet \[String\] \#ResourceName

{

\[DependsOn = \[String\[\]\]\]

Name = \[String\[\]\]

\[StartupType = \[String\]\]

\[BuiltInAccount = \[String\]\]

\[State = \[String\]\]

\[Ensure = \[String\]\]

\[Credential = \[PSCredential\]\]

}