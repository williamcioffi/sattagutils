# sattagutils -- **sattagutils is under major overhaul** 
you might be better off with using the dev branch right now. that is, `remotes::install_github("williamcioffi/sattagutils", ref = "dev")`. there is some functionality missing there, specifically plotting behavior data streams. you should be able to get it back by sourcing these two files:

- [findgaps2](https://github.com/williamcioffi/zc_sync/blob/main/01_helper_functions/findgaps.r)
- [plot_dives2](https://github.com/williamcioffi/zc_sync/blob/main/01_helper_functions/plot_dives.r)

more updates pending. please file an [issue](github.com/williamcioffi/sattagutils/issues) if you have any problems.

## ok back to regularly scheduled programming:

[![DOI](https://zenodo.org/badge/153984008.svg)](https://zenodo.org/badge/latestdoi/153984008)

* A collection of utils to help with manupulating Wildlife Computers sat tags (primarily SPLASH10).

* see also: [sattagutils_extras](https://github.com/williamcioffi/sattagutils_extras) which is a set of dependency heavy add-ons for sattagutils. It is pretty bare at the moment though. [monitorgonio](https://github.com/williamcioffi/monitorgonio) displays Argos Goniometer output in real time in a shiny app. [parsegonio](https://github.com/williamcioffi/parsegonio) converts Argos Goniometer saved logs into prv like files for decoding.

* For now, please cite as:

Cioffi WR (2020). sattagutils: a collection of utils to help with manupulating sat tag output. R package version 0.2.0. https://github.com/williamcioffi/sattagutils. (doi:10.5281/zenodo.3647714).

## Obligatory warning
This package is under active dev... things will change.

## Contributing

Start here if you'd like to [contribute](CONTRIBUTING.md). If you have questions feel free to drop me a line at wrc14 [at] duke.edu

## Quick Guide
_There is no tutorial right now but comming soon._ Some background chitchat is posted at https://williamcioffi.github.io/sattagutils.

For now you can install:
```r
remotes::install_github("williamcioffi/sattagutils")
```

And you probably want to start with:
```r
?sattagutils
?load_tag
?batch_load_tags
```
