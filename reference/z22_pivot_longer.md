# Cast feature grid to a long table

Helper function to convert the output of
[`z22_data`](https://jslth.github.io/z22/reference/z22_data.md) to a
long table. This can be useful for plotting or other data wrangling
tasks.

Note that pivoting can quickly become expensive for larger 100m grids.

## Usage

``` r
z22_pivot_longer(.data, feature, lang = c("english", "german"))
```

## Arguments

- .data:

  Output of
  [`z22_data`](https://jslth.github.io/z22/reference/z22_data.md).

- feature:

  A grid feature that is represented by `.data`.

- lang:

  Specifies the language of the output description. Can be either
  `"english"` (default) or `"german"`. Note that the English
  descriptions are only ad-hoc translations based off the German
  originals.

## Value

A dataframe containing the columns `category`, `value`, `x` and `y`. All
non-category columns are preserved.

## Details

Note that all columns starting with `"cat_*"` are automatically used for
pivoting.

## Examples

``` r
# get feature grid
age <- z22_data("age_short", res = "10km")
#> Error in httr2::req_perform(req, path = path): HTTP 504 Gateway Timeout.

# pivot to a long table
z22_pivot_longer(age, feature = "age_short")
#> Error: object 'age' not found
```
