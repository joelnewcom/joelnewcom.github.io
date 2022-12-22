---
layout: single
categories:
  - craftsmanship
---

### Offline GeoCoder
Lets you geoCode a bulk of addresses to coordinates with the help of openStreetMap, docker and C#.

At work, we needed to geocode a lot of addresses. None of the online geocode services like Apple maps, Google maps, Bing maps etc. support a bulk address-to-coordinate transformation.
Either it takes for ever due to throttling, or it will cost a lot of money.

That is why I run [nominatim in a docker container](https://github.com/mediagis/nominatim-docker) locally and made geocode calls against it. 
I wrote a small C# console app to iterate over a file of addresses, make call to nominatim and inteprete the response and store the coordinates.
[See on GitHub](https://github.com/joelnewcom/geocodeLocal)