# z22 1.1.0

* Replace `rasterize` and `as_sf` arguments with a single `as` argument that takes `"df"`, `"sf"`, or `"raster"`
* Fix z22_inspire_generate() for the long format by not truncating trailing zeroes
* Rename `legacy` to `short` for INSPIRE identifiers. Short and long are more descriptive than the previous naming scheme
* Add an argument `llc` to `z22_inspire_generate()` that specifies whether the coordinate pairs are already lower-left corners or must be adjusted accordingly
* Add an argument `meta` to `z22_inspire_extract()` that controls whether to return metadata like CRS and resolution.
* Add additional checks to `z22_inspire_generate()`


# z22 1.0.3

* change: `z22_data()` and `z22_grid()` now return a SpatRaster instead of a SpatRasterDataset
* fix: a bug where `z22_grid()` could not rasterize grids
* fix: shift grids produced by `z22_grid()` by half a cell to keep grid alignments consistent
* fix: allow cache updates for auxiliary population counts when normalize = TRUE

# z22 1.0.0

* Initial CRAN submission.
