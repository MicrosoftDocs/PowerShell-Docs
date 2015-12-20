# New-Guid
Often script (or perhaps writing a DSC resource), you have the need for a unique identifier. GUIDs work well, and it is easy to call the .NET Framework Guid class to generate one, but having a cmdlet makes this more discoverable for end users who are not already familiar with the .NET Framework class:

PS C:\\&gt; New-Guid

Guid

----

e19d6ea5-3cc2-4db9-8095-0cdaed5a703d
