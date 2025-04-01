
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

|Theme     |Name                |Zensus11 (100m)            |Zensus11 (1km)   |Description                                                 |
|----------|--------------------|---------------------------|-----------------|------------------------------------------------------------|
|Population|`population`        |`INSGESAMT_Demographie`    |`Einwohner`      |Population                                                  |
|Population|`foreigners`        |                           |`Auslaender_A`   |Share of foreigners                                         |
|Population|`citizens`          |                           |                 |Number of german citizens, 18 or older                      |
|Population|`foreigners_from_18`|                           |                 |Share of foreigners, 18 or older                            |
|Population|`birth_country`     |`GEBURTLAND_GRP`           |                 |Country of birth (groups)                                   |
|Population|                    |`GESCHLECHT`               |                 |Sex                                                         |
|Population|                    |                           |`Frauen_A`       |Share of women                                              |
|Population|                    |`RELIGION_KURZ`            |                 |Religion                                                    |
|Population|`nationality`       |`STAATSANGE_KURZ`          |                 |Citizenship                                                 |
|Population|`nationality_group` |`STAATSANGE_GRP`           |                 |Citizenship (groups)                                        |
|Population|                    |`STAATSANGE_HLND`          |                 |Citizenship by selected countries                           |
|Population|                    |`STAATZHL`                 |                 |Number of citizenships                                      |
|Population|`avg_age`           |                           |`Alter_D`        |Average age                                                 |
|Population|`age_short`         |`ALTER_KURZ`               |                 |Age (five classes of years)                                 |
|Population|`age_long`          |`ALTER_10JG`               |                 |Age (ten years age groups)                                  |
|Population|`under_18`          |                           |`unter18_A`      |Share of people under 18                                    |
|Population|`from_65`           |                           |`ab65_A`         |Share of people 65 or older                                 |
|Population|`marital_status`    |`FAMSTND_AUSF`             |                 |Marital status                                              |
|Families  |                    |`INSGESAMT_Familien`       |                 |Total number of families                                    |
|Families  |`family_type`       |`FAMTYP_KIND`              |                 |Type of core family (by children)                           |
|Families  |                    |`FAMGROESS_KLASS`          |                 |Size of core family                                         |
|Families  |                    |`HHTYP_SENIOR_HH`          |                 |Senior status of a private household                        |
|Households|                    |`INSGESAMT_Haushalte`      |                 |Total number of households                                  |
|Households|                    |`HHTYP_FAM`                |                 |Private households by family types                          |
|Households|                    |`HHTYP_LEB`                |                 |Private households by lifestyle                             |
|Households|`avg_hh_size`       |                           |`HHGroesse_D`    |Average household size                                      |
|Households|`hh_size`           |`HHGROESS_KLASS`           |                 |Household size (groups)                                     |
|Dwellings |                    |`INSGESAMT_Wohnungen`      |                 |Total number of dwellings                                   |
|Dwellings |`net_rent`          |                           |                 |Average net cold rent                                       |
|Dwellings |`total_dwell`       |`INSGESAMT_Wohnungen`      |                 |Anzahl der Wohnungen                                        |
|Dwellings |                    |`NUTZUNG _DETAIL_HHGEN`    |                 |Use by household occupancy                                  |
|Dwellings |                    |`WOHNEIGENTUM`             |                 |Ownership of the dwelling                                   |
|Dwellings |`owner_occupier`    |                           |                 |Eigentümerquote                                             |
|Dwellings |`vacancies`         |                           |`Leerstandsquote`|Leerstandsquote                                             |
|Dwellings |`market_vacancies`  |                           |                 |Marktaktive Leerstandsquote                                 |
|Dwellings |`space_inhab`       |                           |`Wohnfl_Bew_D`   |Average living space per inhabitant                         |
|Dwellings |`space_dwell`       |                           |`Wohnfl_Whg_D`   |Average living space per dwelling                           |
|Dwellings |`space_dwell_group` |`WOHNFLAECHE_10S`          |                 |Floor space of the dwelling (10m² intervals)                |
|Dwellings |`dwell_type`        |`GEBTYPGROESSE_Wohnungen`  |                 |Dwellings by building type                                  |
|Dwellings |`dwell_rooms`       |`RAUMANZAHL`               |                 |Dwellings by number of rooms                                |
|Dwellings |                    |`BAUJAHR_MZ_Wohnungen`     |                 |Dwellings by construction year (microcensus classes)        |
|Dwellings |                    |`GEBAEUDEART_SYS_Wohnungen`|                 |Dwellings by building classification                        |
|Dwellings |                    |`EIGENTUM_Wohnungen`       |                 |Dwellings by form of ownership                              |
|Dwellings |                    |`GEBTYPBAUWEISE_Wohnungen` |                 |Dwelling by building design                                 |
|Dwellings |                    |`ZAHLWOHNGN_HHG_Wohnungen` |                 |Dwellings by number of dwellings in the building            |
|Buildings |                    |`INSGESAMT_Gebaeude`       |                 |Total number of buildings                                   |
|Buildings |`constr_year`       |`BAUJAHR_MZ_Gebaeude`      |                 |Buildings by construction year (microcensus classes)        |
|Buildings |`building_dwell`    |`ZAHLWOHNGN_HHG_Gebaeude`  |                 |Residential buildings by number of dwellings in the building|
|Buildings |`building_type`     |`GEBTYPGROESSE_Gebaeude`   |                 |Residential buildings by building type                      |
|Buildings |                    |`GEBAEUDEART_SYS_Gebaeude` |                 |Buildings by building classification                        |
|Buildings |                    |`EIGENTUM_Gebaeude`        |                 |Buildings by form of ownership                              |
|Buildings |                    |`GEBTYPBAUWEISE_Gebaeude`  |                 |Buildings by building design                                |
|Heating   |`heat_type_dwelling`|`HEIZTYP_Wohnungen`        |                 |Dwellings by predominant heating type                       |
|Heating   |`heat_type_building`|`HEIZTYP_Gebaeude`         |                 |Buildings by predominant heating type                       |
|Heating   |`heat_src_dwelling` |                           |                 |Dwellings by energy source of heating                       |
|Heating   |`heat_src_building` |                           |                 |Buildings by energy source of heating                       |

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(z22)
## basic example code
```

