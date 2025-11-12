# Features

Get a list of available features. To get a list of all categories, see
[`z22_categories`](https://jslth.github.io/z22/reference/categories.md).

For further clarification of terms used in the feature labels, see the
[glossary](https://jslth.github.io/z22/reference/glossary.md).

## Usage

``` r
z22_features(theme = NULL, year = NULL, res = NULL, legacy_names = FALSE)
```

## Arguments

- theme:

  Theme of the feature. Available themes are `"population"`,
  `"families"`, `"households"`, `"dwellings"`, and `"buildings"`. If
  `NULL`, returns features for all themes.

- year:

  Census year. Can be 2011 or 2022. If `NULL`, returns features for both
  years.

- res:

  Resolution of the feature grid. Can be `"100m"`, `"1km"`, or `"10km"`.
  For Census 2011, only 100m and 1km are available and not all features
  are available for both resolutions. For Census 2022, all features are
  available at all resolutions. If `NULL`, returns features for all
  resolutions.

- legacy_names:

  If `TRUE`, uses legacy (german) feature names from the Census 2011
  where possible. Defaults to `FALSE`.

## Value

A tibble containing the following columns:

- `theme`: Theme of the feature

- `feature`: Feature name

- `desc`: Human-readable english description

- `z22`: Whether the feature is available in the Census 2022

- `z11_100m`: Whether the feature is available in the Census 2011 at a
  100m resolution

- `z11_1km`: Whether the feature is available in the Census 2011 at a
  1km resolution

- `has_cat`: Whether the feature is is further divided into categories.

## Examples

``` r
# return all features related to dwellings
z22_features("dwellings")
#> # A tibble: 19 × 8
#>    theme     feature               english german z22   z11_100m z11_1km has_cat
#>    <chr>     <chr>                 <chr>   <chr>  <lgl> <lgl>    <lgl>   <lgl>  
#>  1 Dwellings dwellings             Total … Gesam… TRUE  TRUE     FALSE   FALSE  
#>  2 Dwellings rent_avg              Averag… Durch… TRUE  FALSE    FALSE   FALSE  
#>  3 Dwellings dwelling_occupancy    Use by… Nutzu… FALSE TRUE     FALSE   TRUE   
#>  4 Dwellings dwelling_ownership_h… Owners… Eigen… FALSE TRUE     FALSE   TRUE   
#>  5 Dwellings dwelling_ownership_p… Dwelli… Wohnu… FALSE TRUE     FALSE   TRUE   
#>  6 Dwellings owner_occupier        Share … Eigen… TRUE  FALSE    FALSE   FALSE  
#>  7 Dwellings vacancies             Share … Leers… TRUE  FALSE    TRUE    FALSE  
#>  8 Dwellings market_vacancies      Share … Markt… TRUE  FALSE    FALSE   FALSE  
#>  9 Dwellings inhabitant_space      Averag… Durch… TRUE  FALSE    TRUE    FALSE  
#> 10 Dwellings dwelling_space        Averag… Durch… TRUE  FALSE    TRUE    FALSE  
#> 11 Dwellings floor_space           Floor … Fläch… TRUE  TRUE     FALSE   TRUE   
#> 12 Dwellings dwelling_rooms        Dwelli… Wohnu… TRUE  TRUE     FALSE   TRUE   
#> 13 Dwellings dwelling_constr_year  Dwelli… Wohnu… FALSE TRUE     FALSE   TRUE   
#> 14 Dwellings dwelling_building_dw… Dwelli… Wohnu… FALSE TRUE     FALSE   FALSE  
#> 15 Dwellings dwelling_building_si… Dwelli… Wohnu… TRUE  TRUE     FALSE   TRUE   
#> 16 Dwellings dwelling_building_ty… Dwelli… Wohnu… FALSE TRUE     FALSE   TRUE   
#> 17 Dwellings dwelling_building_de… Dwelli… Wohnu… FALSE TRUE     FALSE   TRUE   
#> 18 Dwellings dwelling_heat_type    Dwelli… Wohnu… TRUE  TRUE     FALSE   TRUE   
#> 19 Dwellings dwelling_heat_src     Dwelli… Wohnu… TRUE  FALSE    FALSE   TRUE   

# return all features available in the Census 2011
z22_features(year = 2011)
#> # A tibble: 48 × 8
#>    theme      feature            english   german z22   z11_100m z11_1km has_cat
#>    <chr>      <chr>              <chr>     <chr>  <lgl> <lgl>    <lgl>   <lgl>  
#>  1 Population population         Populati… Bevöl… TRUE  TRUE     TRUE    FALSE  
#>  2 Population foreigners         Share of… Auslä… TRUE  FALSE    TRUE    FALSE  
#>  3 Population birth_country      Country … Gebur… TRUE  TRUE     FALSE   TRUE   
#>  4 Population sex                Sex       Gesch… FALSE TRUE     FALSE   TRUE   
#>  5 Population women              Share of… Fraue… FALSE FALSE    TRUE    FALSE  
#>  6 Population religion           Religion  Relig… FALSE TRUE     FALSE   TRUE   
#>  7 Population citizenship        Citizens… Staat… TRUE  TRUE     FALSE   TRUE   
#>  8 Population citizenship_group  Citizens… Staat… TRUE  TRUE     FALSE   TRUE   
#>  9 Population citizenship_origin Citizens… Staat… FALSE TRUE     FALSE   TRUE   
#> 10 Population citizenship_total  Number o… Anzah… FALSE TRUE     FALSE   TRUE   
#> # ℹ 38 more rows

# return all features available in 2011 at a 1km resolution
z22_features(year = 2011, res = "1km")
#> # A tibble: 10 × 8
#>    theme      feature            english   german z22   z11_100m z11_1km has_cat
#>    <chr>      <chr>              <chr>     <chr>  <lgl> <lgl>    <lgl>   <lgl>  
#>  1 Population population         Populati… Bevöl… TRUE  TRUE     TRUE    FALSE  
#>  2 Population foreigners         Share of… Auslä… TRUE  FALSE    TRUE    FALSE  
#>  3 Population women              Share of… Fraue… FALSE FALSE    TRUE    FALSE  
#>  4 Population age_avg            Average … Durch… TRUE  FALSE    TRUE    FALSE  
#>  5 Population age_under_18       Share of… Antei… TRUE  FALSE    TRUE    FALSE  
#>  6 Population age_from_65        Share of… Antei… TRUE  FALSE    TRUE    FALSE  
#>  7 Households household_size_avg Average … Durch… TRUE  FALSE    TRUE    FALSE  
#>  8 Dwellings  vacancies          Share of… Leers… TRUE  FALSE    TRUE    FALSE  
#>  9 Dwellings  inhabitant_space   Average … Durch… TRUE  FALSE    TRUE    FALSE  
#> 10 Dwellings  dwelling_space     Average … Durch… TRUE  FALSE    TRUE    FALSE  
```
