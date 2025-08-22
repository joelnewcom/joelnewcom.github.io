---
layout: single
title: "Data analysis with python"
date:   2025-08-22 00:00:00 +0200
categories: python
---

I got a table with hierarchical data and I want to have a tree structure out of it.
Each row represented a business unit and its parent and the parent of the parent and so on.

| Business Unit | Parent1 | Parent2 | Parent3 |
|---------------|---------|---------|---------|
| BU1           | P1      | GP1     | GGP1    |
| BU2           | P1      | GP1     | GGP1    |
| GP1           | GGP1    | GGP11   | GGGP11  |
| BU4           | P2      | GP1     | GGP1    |


First was to simplify the data with sql, as the data repeated itself a bit. 
The parent2 of parent1, was also a business unit with its own parents and so on.

```sql
SELECT DISTINCT
    a.business_unit_name AS child_business_unit,
    a.parent_business_unit_name_1 AS parent_business_unit
FROM hirachy AS a
WHERE a.parent_business_unit_name_1 IS NOT NULL

```
Now  have this:

| Business Unit | Parent  |
|---------------|---------|
| BU1           | P1      |
| BU2           | P1      |
| GP1           | GGP1    |
| BU4           | P2      |

Now I can use python to create a tree structure out of it using treemap: https://plotly.com/python/treemaps/

```python
import csv
import plotly.express as px

# Read CSV and build lists for plotly
names = []
parents = []

with open('child-parents.csv', newline='', encoding='utf-8') as csvfile:
    reader = csv.reader(csvfile)
    for row in reader:
        child, parent = row[0].strip(), row[1].strip()
        names.append(child)
        parents.append(parent if child != parent else "")

# Plot as treemap (bubble-like)
fig = px.treemap(
    names=names,
    parents=parents,
    title="Business Unit Hierarchy"
)
fig.show()
```