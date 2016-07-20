---
title: Improved Pull Server Registrations
author:  jaimeo
contributor: Indhu Sivaramakrishnan
---

## Improved Pull Server Registration ##

In the earlier versions of WMF, simulataneous registrations/reporting requests to DSC Pull Server while using the ESENT database would lead to LCM failing to register and/or report as the case may be. In such cases, the event logs on the Pull Server will have the error "Instance Name already in use."
This was due to an incorrect pattern being used to access the ESENT database in a multi threaded scenario. In WMF 5.1, this issue has been fixed. Concurrent registrations or reporting (involving ESENT database) will work fine in WMF 5.1. This issue is applicable only to the ESENT database and does not apply to the OLEDB database. 
