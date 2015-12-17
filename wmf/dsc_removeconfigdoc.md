### Remove DSC Documents

When a configuration document is delivered to DSC, the document goes through various stages (pending, current, previous). We added a new cmdlet to DSC in Windows PowerShell 4.0, Remove-DscConfigurationDocument, as part of KB3000850. This cmdlet was also available in WMF 5.0 Preview February 2015. Remove-DscConfigurationDocument doesn’t have a **Partial** state in WMF 5.0 Preview April 2015.

![](media/image9.png)
