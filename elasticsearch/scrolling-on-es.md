## Option - Scroll Search
		a. Takes a snapshot of results
		b. statefull
		c. use scroll-ID & TTL of scroll.
		d. Best practice is to delete the scroll and not wait for TTL expire (Holding a snapshot is resource costly)
		
## Option - Search After (I decided to start with this option)
		a. https://www.elastic.co/guide/en/elasticsearch/reference/6.1/search-request-search-after.html
		b. Make a normal Search request
		c. Search needs to be sorted
		d. Needs a tiebraker (Best would be an uniqueID) ** the used field needs to have a doc value **
		e. Search_after (last score, and _id (tiebraker)), is used to get the next "page
		f. stateless
