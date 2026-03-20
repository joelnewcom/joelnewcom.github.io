---
layout: single
---

# Get first match
````
List<int> numbers = new List<int> { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
int result = numbers.FirstOrDefault(n => n > 5);
````

# Filter on list
````
List<int> numbers = new List<int> { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
List<int> result = numbers.Where(n => n > 5);
````

# 