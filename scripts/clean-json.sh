#! /bin/bash


$(cat alerts.json |  jq 'del(.[].targetEndpoints, .[].updated, .[].includeObsoleteMetrics, .[].modifyAclAccess, .[].hidden, .[].lastNotificationMillis, .[].evaluateRealtimeData, .[].secureMetricDetails, .[].updatedEpochMillis, .[].lastEventTime, .[].event, .[].event.annotations, .[].isEphemeral, .[].runningState, .[].status, .[].id, .[].created, .[].hostsUsed, .[].orphan, .[].lastQueryTime, .[].systemAlertVersion, .[].inTrash, .[].acl, .[].systemOwned, .[].snoozed, .[].failingHostLabelPairs, .[].inMaintenanceHostLabelPairs, .[].activeMaintenanceWindows, .[].updateUserId, .[].prefiringHostLabelPairs, .[].notificants, .[].createUserId, .[].lastProcessedMillis, .[].processRateMinutes, .[].pointsScannedAtLastQuery, .[].alertsLastDay, .[].alertsLastWeek, .[].alertsLastMonth, .[].isEphemeral, .[].creatorId, .[].updaterId, .[].runningState, .[].canDelete, .[].canClose, .[].creatorType, .[].numPointsInFailureFrame, .[].creatorId, .[].updaterId, .[].createdEpochMillis, .[].deleted, .[].failingHostLabelPairLinks, .[].sortAttr, .[].severityList, .[].event.hosts)' > ./clean.json)
