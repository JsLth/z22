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

# pivot to a long table
z22_pivot_longer(age, feature = "age_short")
#> # A tibble: 19,110 × 4
#>    category value       x       y
#>    <fct>    <int>   <dbl>   <dbl>
#>  1 Under 18    NA 4340000 2690000
#>  2 Under 18    NA 4350000 2690000
#>  3 Under 18    53 4340000 2700000
#>  4 Under 18   810 4350000 2700000
#>  5 Under 18     3 4420000 2700000
#>  6 Under 18     5 4330000 2710000
#>  7 Under 18   486 4340000 2710000
#>  8 Under 18  1431 4350000 2710000
#>  9 Under 18   133 4360000 2710000
#> 10 Under 18   431 4400000 2710000
#> # ℹ 19,100 more rows
```
