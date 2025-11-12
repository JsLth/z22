# Changelog

## z22 1.1.0

CRAN release: 2025-10-29

- Replace `rasterize` and `as_sf` arguments with a single `as` argument
  that takes `"df"`, `"sf"`, or `"raster"`
- Fix z22_inspire_generate() for the long format by not truncating
  trailing zeroes
- Rename `legacy` to `short` for INSPIRE identifiers. Short and long are
  more descriptive than the previous naming scheme
- Add an argument `llc` to
  [`z22_inspire_generate()`](https://jslth.github.io/z22/reference/inspire.md)
  that specifies whether the coordinate pairs are already lower-left
  corners or must be adjusted accordingly
- Add an argument `meta` to
  [`z22_inspire_extract()`](https://jslth.github.io/z22/reference/inspire.md)
  that controls whether to return metadata like CRS and resolution.
- Add additional checks to
  [`z22_inspire_generate()`](https://jslth.github.io/z22/reference/inspire.md)

## z22 1.0.3

- change:
  [`z22_data()`](https://jslth.github.io/z22/reference/z22_data.md) and
  [`z22_grid()`](https://jslth.github.io/z22/reference/z22_grid.md) now
  return a SpatRaster instead of a SpatRasterDataset
- fix: a bug where
  [`z22_grid()`](https://jslth.github.io/z22/reference/z22_grid.md)
  could not rasterize grids
- fix: shift grids produced by
  [`z22_grid()`](https://jslth.github.io/z22/reference/z22_grid.md) by
  half a cell to keep grid alignments consistent
- fix: allow cache updates for auxiliary population counts when
  normalize = TRUE

## z22 1.0.0

CRAN release: 2025-05-19

- Initial CRAN submission.
