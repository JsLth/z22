# z22 1.0.3

* change: `z22_data()` and `z22_grid()` now return a SpatRaster instead of a SpatRasterDataset
* fix: a bug where `z22_grid()` could not rasterize grids
* fix: shift grids produced by `z22_grid()` by half a cell to keep grid alignments consistent
* fix: allow cache updates for auxiliary population counts when normalize = TRUE

# z22 1.0.0

* Initial CRAN submission.
