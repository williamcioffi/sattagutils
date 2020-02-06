# CHANGES IN sattagutils VERSION 0.2.0

## NEW FEATURES
- `load\_dap_output` load a directory of output csv created by DAP
- `merge\_stacks` merge two tagstacks together with overlapping sets of tags and streams
- `paginate\_series` menu based navigation through a series datastream for inspection
- `sort\_by\_messsage` sort behavior streams by start time keeping messages together
- `has_stream` check to see if a tagstack of sattag has a stream
- `duplicated\_sattagstream` find duplicates aware that some columns might be different

## MAJOR CHANGES
- see above added functions

## MINOR CHANGES
- updated description
- custom citation

## BUG FIXES
- changed `file.exists()` which works on \*nix for dirs `dir.exists()` for windows compatability (issue #40)


# CHANGES IN sattagutils VERSION 0.1.0-beta.2

## NEW FEATURES
- `load\_dap\_output` function for loading a directory with DAP / Argos Message Decoder output and returning a tagstack
- `merge_stacks` function for merging two tagstacks together and combining matching sattagstreams where possible.
- `duplicated_sattagstream` used by `merge_stacks` to look for duplicates in different streamtypes
- `sort_by_message` a function for sorting behavior sattagstreams while respecting messages.

## MAJOR CHANGES

## MINOR CHANGES
- `plot_series` `show_gaps = TRUE` looks more like `plot_dives2` now.

## BUG FIXES
- getstream no longer throws an error when run on a tagstack if some of the tags are missing the stream entirely. (issue #23)
- getstream no longer throws an error when `squash == TRUE` for streams with multiple filenames (possibly merged with `merge_stacks`. (issue #34)

# INITIAL RELEASE sattagutils VERSION 0.1.0-beta

## Details
- inital beta release
- not on CRAN
- still has bugs (see issues #12 , #16 , #18)
