---
layout: single
---

# Backward compatibility
Allows the consumer code to use a new version of a schema and process messages with an old version of the schema. 
Allows the following changes to be made on a schema:

* Delete fields
* Add optional fields

# Forward compatibility
Allows the consumer code to use an old schema version and read messages with the new schema. 
Forward compatibility mode allows the following changes to be made on a schema:

* Add fields
* Delete optional fields