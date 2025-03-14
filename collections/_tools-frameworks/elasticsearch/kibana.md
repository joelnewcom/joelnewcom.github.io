---
layout: single
---

# Search in Kibana
You can type into the search bar something like: ````log.level: "ERROR" and not message: "Self registration failed"````

## Advanced search

In discover, switch from a existing data-view to ES|QL and write something like: 
````
from "applog-*,logs-*.applog-*" | where service.name == "my-application" AND log.level == "WARNING" | WHERE STARTS_WITH(message,"Failed to get document from Archive. Response status: ’Internal Server Error’") == true | DISSECT message "%{action} to get document from %{source}. Response status: ’%{response_status}’, error message: ’%{error_message}’, content: ’{“type“:“about:blank“,“title“:“Internal Server Error“,“status“:500,“instance“:“%{document}“,“timestamp“:“%{date}’"
| KEEP document
| STATS count() BY document
````

With this query you can work with the dissected fields in the next steps.

# Ignored fields
You cannot search for fields that are ignored in the index pattern.
If a field is ignored, you can see this yellowish warning sign in the field list.
![ignored field](/assets/images/tools/kibana/not-searchable-field.png)