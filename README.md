
# z22

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

Quickly and efficiently retrieve official socio-demographic microdata as 100m
or 1km INSPIRE grids from the German Census 2022. Powered by the
[z22data](https://github.com/jslth/z22data) data repository which hosts the
Census grid data in small and digestible chunks. Based on the predecessor
package [z11](https://github.com/stefanjuenger/z11/) which allows easy access
to the gridded data from the Census 2011.

## Installation

You can install the development version of z22 like so:

``` r
remotes::install_github("jslth/z22")
```

## Available data

|Theme     |Name                         |Description                                                 |Zensus22|Zensus11 (100m)|Zensus11 (1km)|
|----------|-----------------------------|------------------------------------------------------------|--------|---------------|--------------|
|Population|`population`                 |Population                                                  |✅      |✅             |✅            |
|Population|`foreigners`                 |Share of foreigners                                         |✅      |❌             |✅            |
|Population|`citizens`                   |Number of german citizens, 18 or older                      |✅      |❌             |❌            |
|Population|`foreigners_from_18`         |Share of foreigners, 18 or older                            |✅      |❌             |❌            |
|Population|`birth_country`              |Country of birth (groups)                                   |✅      |✅             |❌            |
|Population|`sex`                        |Sex                                                         |❌      |✅             |❌            |
|Population|`women`                      |Share of women                                              |❌      |❌             |✅            |
|Population|`religion`                   |Religion                                                    |❌      |✅             |❌            |
|Population|`citizenship`                |Citizenship                                                 |✅      |✅             |❌            |
|Population|`citizenship_group`          |Citizenship (groups)                                        |✅      |✅             |❌            |
|Population|`citizenship_origin`         |Citizenship by selected countries                           |❌      |✅             |❌            |
|Population|`citizenship_total`          |Number of citizenships                                      |❌      |✅             |❌            |
|Population|`age_avg`                    |Average age                                                 |✅      |❌             |✅            |
|Population|`age_short`                  |Age (five classes of years)                                 |✅      |✅             |❌            |
|Population|`age_long`                   |Age (ten years age groups)                                  |✅      |✅             |❌            |
|Population|`age_under_18`               |Share of people under 18                                    |✅      |❌             |✅            |
|Population|`age_from_65`                |Share of people 65 or older                                 |✅      |❌             |✅            |
|Population|`marital_status`             |Marital status                                              |✅      |✅             |❌            |
|Families  |`families`                   |Total number of families                                    |❌      |✅             |❌            |
|Families  |`family_type`                |Type of core family (by children)                           |✅      |✅             |❌            |
|Families  |`family_size`                |Size of core family                                         |❌      |✅             |❌            |
|Households|`households`                 |Total number of private households                          |❌      |✅             |❌            |
|Households|`household_family`           |Private households by family types                          |❌      |✅             |❌            |
|Households|`household_lifestyle`        |Private households by lifestyle                             |❌      |✅             |❌            |
|Households|`household_senior`           |Private households by senior status                         |❌      |✅             |❌            |
|Households|`household_size_avg`         |Average household size                                      |✅      |❌             |✅            |
|Households|`household_size_group`       |Household size (groups)                                     |✅      |✅             |❌            |
|Dwellings |`dwellings`                  |Total number of dwellings                                   |✅      |✅             |❌            |
|Dwellings |`rent_avg`                   |Average net cold rent                                       |✅      |❌             |❌            |
|Dwellings |`dwelling_occupancy`         |Use by household occupancy                                  |❌      |✅             |❌            |
|Dwellings |`dwelling_ownership_home`    |Ownership of the dwelling                                   |❌      |✅             |❌            |
|Dwellings |`dwelling_ownership_property`|Dwellings by form of ownership                              |❌      |✅             |❌            |
|Dwellings |`owner_occupier`             |Share of owner occupiers                                    |✅      |❌             |❌            |
|Dwellings |`vacancies`                  |Share of vacancies                                          |✅      |❌             |✅            |
|Dwellings |`market_vacancies`           |Share of market active vacancies                            |✅      |❌             |❌            |
|Dwellings |`inhabitant_space`           |Average living space per inhabitant                         |✅      |❌             |✅            |
|Dwellings |`dwelling_space`             |Average living space per dwelling                           |✅      |❌             |✅            |
|Dwellings |`floor_space`                |Floor space of the dwelling (10m² intervals)                |✅      |✅             |❌            |
|Dwellings |`dwelling_type`              |Dwellings by building type                                  |✅      |✅             |❌            |
|Dwellings |`dwelling_rooms`             |Dwellings by number of rooms                                |✅      |✅             |❌            |
|Dwellings |`dwelling_constr_year`       |Dwellings by construction year (microcensus classes)        |❌      |✅             |❌            |
|Dwellings |`dwelling_building_type`     |Dwellings by building classification                        |❌      |✅             |❌            |
|Dwellings |`dwelling_building_design`   |Dwelling by building design                                 |❌      |✅             |❌            |
|Dwellings |`dwelling_building_size`     |Dwellings by number of dwellings in the building            |❌      |✅             |❌            |
|Dwellings |`dwelling_heat_type`         |Dwellings by predominant heating type                       |✅      |✅             |❌            |
|Dwellings |`dwelling_heat_src`          |Dwellings by energy source of heating                       |✅      |❌             |❌            |
|Buildings |`buildings`                  |Total number of buildings                                   |❌      |✅             |❌            |
|Buildings |`building_ownership_property`|Buildings by form of ownership                              |❌      |✅             |❌            |
|Buildings |`building_constr_year`       |Buildings by construction year (microcensus classes)        |✅      |✅             |❌            |
|Buildings |`building_dwellings`         |Residential buildings by number of dwellings in the building|✅      |✅             |❌            |
|Buildings |`building_size`              |Residential buildings by building type                      |✅      |✅             |❌            |
|Buildings |`building_type`              |Buildings by building design                                |❌      |✅             |❌            |
|Buildings |`building_design`            |Buildings by building design                                |❌      |✅             |❌            |
|Buildings |`building_heat_type`         |Buildings by predominant heating type                       |✅      |✅             |❌            |
|Buildings |`building_heat_src`          |Buildings by energy source of heating                       |✅      |❌             |❌            |

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(z22)
## basic example code
```

