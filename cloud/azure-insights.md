## Azure data logs Kusto syntax
I once had the problem that the request logs couldn't be retrieved because the url value contained characters which lead to malformed json (request where from vulnerability scan).
So I created a query which displays all columns expect the url one. Fortunately the url also appears in the name and operation_name column anyway.
```
let start=datetime("2021-09-09T05:11:00.000Z");
let end=datetime("2021-09-09T06:37:00.000Z");
requests
    | where timestamp > start and timestamp < end
    | where client_Type != "Browser"
    | project timestamp, id, source, name, success, resultCode, duration, performanceBucket, itemType, customDimensions, customMeasurements, operation_Name, operation_Id, operation_ParentId, operation_SyntheticSource, session_Id, user_Id,user_AuthenticatedId, user_AccountId, application_Version, client_Type, client_Model, client_OS, client_IP, client_City, client_StateOrProvince, client_CountryOrRegion, client_Browser, cloud_RoleName, cloud_RoleInstance, appId, appName, iKey,sdkVersion, itemId, itemCount
```

### Get all available logs for a specific string

```
union isfuzzy=true
availabilityResults,
requests,
exceptions,
pageViews,
traces,
customEvents,
dependencies
| where timestamp > datetime("2022-04-13T12:35:47.836Z") and timestamp < datetime("2022-04-15T12:35:47.836Z")
| where * has "AF9FC008-CAD5-E911-80CE-0050569BE8EF"
| order by timestamp desc
| take 1000
```

## Giving access Dashboards
Providing access to a specific dashboard is not enough. People also need to have reader access on the underlying data of the dashboard.
This can be achieved by providing the default role "Reader" for Azure Insights. 

