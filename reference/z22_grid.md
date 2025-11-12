# Get INSPIRE grid

Retrieve the entire INSPIRE grid.

Unlike the feature grids retrieved from
[`z22_data`](https://jslth.github.io/z22/reference/z22_data.md), the
INSPIRE grid encompasses the entire area of Germany. You can thus use it
to join with the incomplete feature grids from `z22_data` to create a
complete dataset.

## Usage

``` r
z22_grid(res, year = 2019, as = c("df", "sf", "raster"), update_cache = FALSE)
```

## Arguments

- res:

  Resolution of the grid. Can be `"100m"`, `"250m"`, `"1km"`, `"5km"`,
  `"10km"`, or `"100km"`.

- year:

  Version of the grid. Can be 2015, 2017, 2018 and 2019. Defaults to the
  latest version.

- as:

  Specifies the output class. Must be one of `"df"`, `"sf"`, or
  `"raster"`. If `"df"` (default), returns flat coordinates in a
  dataframe. If `"sf"` (and the `sf` package is installed), converts the
  coordinates to an `sf` tibble. If `"raster"` (and the `terra` package
  is installed), converts the coordinates to a
  [`SpatRaster`](https://rspatial.github.io/terra/reference/rast.html).

- update_cache:

  By default, both functions cache attribute files for the remainder of
  the R session. They are downloaded to a temporary directory and - if
  the file to download already exists - are recovered from the cache. In
  other words, when rerunning the same request multiple times, the
  subsequent calls should be much faster. If `TRUE`, disables caching
  for this call and overwrites the currently cached attribute file (if
  any) with a fresh one. Defaults to `FALSE`, i.e. always cache.

## Value

A tibble,
[`SpatRaster`](https://rspatial.github.io/terra/reference/rast.html) or
[`sf`](https://r-spatial.github.io/sf/reference/st_as_sf.html) tibble
depending on the `as` argument.

## Details

Note the uncompressed object sizes of the output (2019 version):

- 100 m: 38 million cells, 291 MB

- 250 m: 6 million cells, 47 MB

- 1 km: 384 thousand cells, 3 MB

- 5 km: 16 thousand cells, 0.12 MB

- 10 km: 4 thousand cells, 0.03 MB

## Examples

``` r
# Get high-res grid as tibble
z22_grid("100m")
#> # A tibble: 38,171,748 × 2
#>          x       y
#>      <dbl>   <dbl>
#>  1 4334200 2684100
#>  2 4334300 2684100
#>  3 4334400 2684100
#>  4 4334500 2684100
#>  5 4334600 2684100
#>  6 4334200 2684200
#>  7 4334300 2684200
#>  8 4334400 2684200
#>  9 4334500 2684200
#> 10 4334600 2684200
#> # ℹ 38,171,738 more rows

# Get low-res grid as raster
z22_grid("1km", as = "raster")
#> class       : SpatRaster 
#> size        : 873, 642, 1  (nrow, ncol, nlyr)
#> resolution  : 1000, 1000  (x, y)
#> extent      : 4031500, 4673500, 2684500, 3557500  (xmin, xmax, ymin, ymax)
#> coord. ref. : ETRS89-extended / LAEA Europe (EPSG:3035) 
```
