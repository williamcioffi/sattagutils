# CHANGES IN sattagutils VERSION 0.1.0-beta.2

## NEW FEATURES
- `load\_dap\_output` function for loading a directory with DAP / Argos Message Decoder output and returning a tagstack
- `merge_stacks` function for merging two tagstacks together and combining matching sattagstreams where possible.
- `duplicated_sattagstream` used by `merge_stacks` to look for duplicates in different streamtypes

## MAJOR CHANGES

## MINOR CHANGES

## BUG FIXES
- getstream no longer throws an error when run on a tagstack if some of the tags are missing the stream entirely. (issue #23)
- getstream no longer throws an error when `squash == TRUE` for streams with multiple filenames (possibly merged with `merge_stacks`. (issue #34)

# INITIAL RELEASE sattagutils VERSION 0.1.0-beta

## Details
- inital beta release
- not on CRAN
- still has bugs (see issues #12 , #16 , #18)
