---
ms.date: 07/17/2020
ms.topic: reference
title: GetConfigurationResultOutput method
description: GetConfigurationResultOutput method
---
# GetConfigurationResultOutput method

Gets the Configuration Agent output associated with a specific job.

## Syntax

```mof
uint32 GetConfigurationResultOutput(
  [in]  string                      jobId,
  [in]  uint8                       resumeOutputBookmark[],
  [out] MSFT_DSCConfigurationOutput output[]
);
```

## Parameters

**jobId** \[in\]
The ID of the job for which to get output data.

**resumeOutputBookmark** \[in\]
Specifies that the output should be a continuation from a previous bookmark.

**output** \[out\]
The output for the specified job.

## Return value

Returns zero on success; otherwise returns an error code.

## Remarks

This is a static method.

## Requirements

**MOF:** DscCore.mof

**Namespace**: Root\Microsoft\Windows\DesiredStateConfiguration

## See also

[**MSFT_DSCLocalConfigurationManager**](msft-dsclocalconfigurationmanager.md)
