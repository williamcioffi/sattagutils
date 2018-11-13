# sattagutils
a collection of utils to help with manupulating wildlife computers sat tags (primarily mk10s)

[tutorial](https://williamcioffi.github.io/sattagutils) on some basic features.

## notes
### need to bring over
- plot\_dives2
- censor\_tag2
- find\_gaps2
- plot\_status
- plot\_corrupt
### other to dos?

- should load\_tag be able to read the wch and figure out the settings? and then write the relevant metadata to appropraite slots in those matching sattagstreams? if there is no wch file would it alternatively be able to parse an htm file? if there aren't either then those slots would just be NA? NULL? empty? I am thinking about things like:
	- sampling period for series
	- min depth and duration for behavior dive qual
 
