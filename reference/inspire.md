# Generate INSPIRE IDs

Given pairs of coordinates, generates their INSPIRE grid representation.
Given INSPIRE identifiers, can also extract the X and Y coordinates.

An INSPIRE ID contains information about the CRS, cell size and the
ETRS89-LAEA coordinates of the south-west corner of the grid cell in its
format.

    CRS3035RES{cellsize}mN{y}E{x} # long format
    {cellsize}N{y}E{x}         # short format

The short format always uses meters while the short formats aggregates
cell sizes greater or equal to 1000m to km.

## Usage

``` r
z22_inspire_generate(coords, res = NULL, short = FALSE, llc = FALSE)

z22_inspire_extract(inspire, as = c("df", "sf"), meta = FALSE)
```

## Arguments

- coords:

  A list, matrix, or dataframe where the X and Y coordinates are either
  in the columns `"x"` and `"y"` or in the first and second column
  position, respectively. Column names are converted to lowercase.

  Can also be a `sf`/`sfc` object in which case the coordinates are
  extracted using
  [`st_coordinates`](https://r-spatial.github.io/sf/reference/st_coordinates.html).

- res:

  Resolution of the grid. Can be `"100m"`, `"250m"`, `"1km"`, `"5km"`,
  `"10km"`, or `"100km"`. If `NULL`, tries to guess the resolution from
  the provided coordinates.

- short:

  If `TRUE`, generates short INSPIRE IDs. Defaults to `FALSE`.

- llc:

  Do the coordinates in `coords` represent the lower-left corners of
  their cells? If `FALSE`, subtracts each coordinate by half of `res`.
  If `TRUE`, leaves them as-is. Defaults to `FALSE`, i.e., treat
  coordinates as cell centroids.

- inspire:

  A vector of INSPIRE IDs. Can be either short or long format.

- as:

  Specifies the output class. Must be one of `"df"` or `"sf"`. If `"df"`
  (default), returns flat coordinates in a dataframe. If `"sf"` (and the
  `sf` package is installed), converts the coordinates to an `sf`
  tibble.

- meta:

  Whether to include parsed CRS and resolution in the output. If
  `FALSE`, output contains only coordinates. If `TRUE`, also contains
  columns `"crs"` and `"res"`.

## Value

`z22_inspire_generate` returns a character vector containing the INSPIRE
identifiers. `z22_inspire_extract` returns a dataframe or
[`sfc`](https://r-spatial.github.io/sf/reference/sfc.html) object
containing the points extracted from the INSPIRE identifiers. Note that
the returned coordinates are always the centers of the grid cells as
opposed to the south-west corners.

## Details

To remain fast even for huge grid datasets, the function is just a very
simple [`sprintf`](https://rdrr.io/r/base/sprintf.html) wrapper that
performs no input checks. To produce valid INSPIRE identifiers, make
sure to transform your data to ETRS89-LAEA (e.g. using
[`st_transform`](https://r-spatial.github.io/sf/reference/st_transform.html)`(..., 3035)`).
You should also make sure that the coordinates are the south-west corner
of existing INSPIRE grid cells.

## Examples

``` r
library(dplyr, warn.conflicts = FALSE)

# Generate IDs from a dataframe
coords <- tibble(x = c(4334150, 4334250), y = c(2684050, 2684050))
identical(z22_inspire_extract(z22_inspire_generate(coords))[c("x", "y")], coords)
#> [1] TRUE

# Extract coordinates from short ID strings
z22_inspire_extract("100mN34000E44000")
#> # A tibble: 1 × 2
#>         x       y
#>     <dbl>   <dbl>
#> 1 4400050 3400050

# Generate IDs from an sf dataframe
if (requireNamespace("sf", quietly = TRUE)) {
  coords <- sf::st_as_sf(coords, coords = c("x", "y"), crs = 3035)
  z22_inspire_generate(coords)
}
#> [1] "CRS3035RES100mN2684000E4334100" "CRS3035RES100mN2684000E4334200"
```
