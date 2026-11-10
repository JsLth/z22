# z22 1.2.0

**Major changes**:

* Perform full joins rather than left joins when multiple categories are provided.
    * Earlier versions can severely underreport cell occurrences when downloading multiple categories so it is recommended to depend on version 1.2.0.
* `normalize = TRUE` now computes shares based on the sum of subtotals instead of population totals as suggested by the census methods paper.
* Several corrupt category codes that were not used by the census data were removed. This includes:
    * `floor_space`: code 99
    * `dwelling_rooms`: code 99
    * `dwelling_occupancy`: codes 99, 1, 2, and 5
* Added a category specification for `dwelling_building_dwellings`.

**Minor changes**:

* Cache files are cleaned up when a download fails.
* `z22_decode()` now supports a `year` argument to account for category changes between censuses.
* NAs are replaced with zeroes for shares when `all_cells = TRUE`.

# z22 1.1.4

- Add support for changes between census years (#3)
- Remove shift-by-half coordinate transformation (#4)
- Fix vignette image links


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
