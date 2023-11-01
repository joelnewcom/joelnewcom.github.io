---
layout: single
---

## Count elements with certain criteria

```
.result 
| map({customerTypeID: .customerTypeID})  
| group_by(.customerTypeID)  
| map({customerTypeID: .[0].customerTypeID, Count: length}) 
| .[]
 
```

## Group by

```
group_by(.customerId) | length
```

## Filter on array

```
.results | map(select(.status != "MagicLinkExported"))
```
works on this json: 

```json
{
  "exportStatus": "Success",
  "results": [
    {
      "status": "PreOnboardFailed",
      "statusMessage": "Profile with is not valid for onboarding. Validation errors: No preferred PhoneNumber is set",
      "engagementUserId": "defanged-0000-0000-0000-000000000000",
      "onboardingId": "defang-0000-0000-0000-000000000000",
    },
    {
      "status": "MagicLinkExported",
      "statusMessage": "exported",
      "engagementUserId": "defanged-9563-1234-1111-63644acbe121",
      "onboardingId": "defanged-f34f-3432-bf70-608debf06817"
    },
    {
      "status": "MagicLinkExported",
      "statusMessage": "exported",
      "engagementUserId": "defanged-b44a-4f5e-8159-1fb5a5bef1da",
      "onboardingId": "defanged-397a-4f63-a59e-5ad2b044f810"
    }
  ]
}
```