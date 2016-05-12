---
title:  Object Pipeline
ms.date:  2016-05-11
keywords:  powershell,cmdlet
description:  
ms.topic:  article
author:  jpjofre
manager:  dongill
ms.prod:  powershell
ms.assetid:  523d8ae4-d743-47a4-b79a-806130ca688a
---

# Object Pipeline
Pipelines act like a series of connected segments of pipe. Items moving along the pipeline pass through each segment. To create a pipeline in Windows PowerShell, you connect commands together with the pipe operator "|". The output of each command is used as input to the next command.

Pipelines are arguably the most valuable concept used in command\-line interfaces. Properly used, pipelines not only reduce the effort involved in entering complex commands, but also make it easier to see the flow of work in the commands. A related useful characteristic of pipelines is that because they operate on each item separately, you do not have to modify them based on whether you will have zero, one, or many items in the pipeline. Furthermore, each command in a pipeline (called a pipeline element) usually passes its output to the next command in the pipeline item\-by\-item. This usually reduces the resource demand of complex commands and allows you to begin getting the output immediately.

In this chapter, we will describe how the Windows PowerShell pipeline differs from the pipelines of most popular shells, and then demonstrate some basic tools that you can use to help control pipeline output and also to see how the pipeline operates.

