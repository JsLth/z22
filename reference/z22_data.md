# Get Census 2022 grid dataset

Retrieve the values and coordinates of gridded features from the
censuses 2011 and 2022.

When we are talking about a

- **feature**, we talk about an indicator aggregated to grid cells,
  e.g., age or the number of dwellings.

- **category**, we talk about the discrete classifications of features,
  e.g., ages 10 to 19, 20 to 20, 30 to 39, etc.

- Both feature and category have to be provided to uniquely identify a
  **dataset**.

## Usage

``` r
z22_data(
  feature,
  categories = NULL,
  year = 2022,
  res = "1km",
  all_cells = FALSE,
  normalize = FALSE,
  as = c("df", "sf", "raster"),
  update_cache = FALSE
)
```

## Arguments

- feature:

  A grid feature. See
  [`z22_features`](https://jslth.github.io/z22/reference/z22_features.md)
  for a list of available features. You can pass both English names and
  legacy names (i.e., variable names from the 2011 census).

- categories:

  One or multiple feature categories. See
  [`z22_categories`](https://jslth.github.io/z22/reference/categories.md)
  for a list of available categories. If `NULL`, retrieves all
  categories for a given feature. Generally, the more categories are
  selected, the longer the download.

- year:

  Census year. Currently, only 2011 and 2022 are available. Defaults to
  2022.

- res:

  Resolution of the grid dataset. Can be `"100m"`, `"1km"`, or `"10km"`.
  If `year` is 2011, `"10km"` is not available and some features are
  only available at certain resolutions.

- all_cells:

  If `TRUE`, joins the retrieved attribute with the complete grid from
  [`z22_grid`](https://jslth.github.io/z22/reference/z22_grid.md).
  Otherwise, the attribute grid will contain only those grid cells with
  one or more recorded units. Defaults to `FALSE`, because loading the
  grid and joining with it is computationally expensive.

- normalize:

  If `TRUE` and `feature` is a counted feature, computes shares by
  dividing the counts by the total number of units in the grid cell. The
  type of unit depends on the theme of the feature, e.g., if the feature
  is in theme "Buildings", the feature counts are divided by the total
  number of buildings. Note that this operation requires an additional
  download (the total number of units). Also note that sometimes
  (possibly due to the key-cell method), shares of over 1 are computed.
  Defaults to `FALSE`.

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

If a tibble is returned each category in `categories` is stored in a
column. If a `SpatRaster` is returned, each category is a named layer.

## Details

Half of the grids cell width is added to each coordinate in the dataset
internally. According to the INSPIRE guidelines, coordinates always
represent the South-west of the grid cells. Centroids represent the
geographic location of grid cells better which is why they are used.

By default, data are downloaded from the
[z22data](https://github.com/jslth/z22data) data repository which stores
all pre-processed data. You can download this repository and use it
offline or use an entirely different repository by setting
`options(z22.data_repo = "path/to/z22data")`.

## Examples

``` r
# Get gridded population
pop <- z22_data("population", res = "10km", as = "raster")
terra::plot(pop$cat_0)


# Get data about the number of people born in a EU27 country
z22_data("birth_country", categories = 21, res = "1km")
#> # A tibble: 210,556 × 3
#>    cat_21       x       y
#>     <int>   <dbl>   <dbl>
#>  1      3 4338000 2690000
#>  2     NA 4342000 2690000
#>  3     NA 4342000 2691000
#>  4     NA 4341000 2692000
#>  5      3 4342000 2692000
#>  6     NA 4342000 2693000
#>  7      3 4345000 2693000
#>  8      3 4341000 2694000
#>  9     NA 4342000 2694000
#> 10     NA 4344000 2694000
#> # ℹ 210,546 more rows
```
