# Feature categories

While some features contain total counts or averages, others contain
figures classified by certain categories. You can access these tables
programmatically using `z22_categories`.

For further clarification of terms used in the category labels, see the
[glossary](https://jslth.github.io/z22/reference/glossary.md).

## Usage

``` r
z22_categories(feature, year = NULL)
```

## Arguments

- feature:

  A grid feature. See
  [`z22_features`](https://jslth.github.io/z22/reference/z22_features.md)
  for a list of available features. If a feature is provided that does
  not have categories, generates a table based on the feature
  description.

- year:

  Census year. This is needed only for two features,
  `dwelling_constr_year` and `building_constr_year`. These features rely
  on microcensus classes that change between census years. For other
  features, this argument is ignored.

## Value

A tibble containing the category code (`code`) as well as German and
English labels (`german` and `english`). Each row relates to a category
of a feature.

## Categories

- `birth_country` (2011):

  |          |                  |              |
  |----------|------------------|--------------|
  | **code** | **german**       | **english**  |
  | 1        | Deutschland      | Germany      |
  | 21       | EU27-Land        | EU27 Country |
  | 22       | Sonstiges Europa | Other Europe |
  | 23       | Sonstige Welt    | Other World  |
  | 24       | Sonstige         | Other        |

- `birth_country` (2022):

  |          |                  |              |
  |----------|------------------|--------------|
  | **code** | **german**       | **english**  |
  | 1        | Deutschland      | Germany      |
  | 20       | Ausland          | Foreign      |
  | 21       | EU27-Land        | EU27 Country |
  | 22       | Sonstiges Europa | Other Europe |
  | 23       | Sonstige Welt    | Other World  |
  | 24       | Sonstige         | Other        |

- `sex`:

  |          |                   |             |
  |----------|-------------------|-------------|
  | **code** | **german**        | **english** |
  | 1        | M\<U+00E4\>nnlich | Male        |
  | 2        | Weiblich          | Female      |

- `religion`:

  |          |                                     |                             |
  |----------|-------------------------------------|-----------------------------|
  | **code** | **german**                          | **english**                 |
  | 1        | R\<U+00F6\>misch-katholische Kirche | Roman Catholic Church       |
  | 2        | Evangelische Kirche                 | Evangelical Church          |
  | 3        | Sonstige, keine, ohne Angabe        | Other, none, no information |

- `citizenship`:

  |          |             |             |
  |----------|-------------|-------------|
  | **code** | **german**  | **english** |
  | 1        | Deutschland | Germany     |
  | 2        | Ausland     | Foreign     |

- `citizenship_group` (2011):

  |          |                  |              |
  |----------|------------------|--------------|
  | **code** | **german**       | **english**  |
  | 1        | Deutschland      | Germany      |
  | 21       | EU27-Land        | EU27 Country |
  | 22       | Sonstiges Europa | Other Europe |
  | 23       | Sonstige Welt    | Other World  |
  | 24       | Sonstige         | Other        |

- `citizenship_group` (2022):

  |          |                  |              |
  |----------|------------------|--------------|
  | **code** | **german**       | **english**  |
  | 1        | Deutschland      | Germany      |
  | 20       | Ausland          | Foreign      |
  | 21       | EU27-Land        | EU27 Country |
  | 22       | Sonstiges Europa | Other Europe |
  | 23       | Sonstige Welt    | Other World  |
  | 24       | Sonstige         | Other        |

- `citizenship_origin`:

  |          |                               |                        |
  |----------|-------------------------------|------------------------|
  | **code** | **german**                    | **english**            |
  | 1        | Deutschland                   | Germany                |
  | 2        | Bosnien und Herzegowina       | Bosnia and Herzegovina |
  | 3        | Griechenland                  | Greece                 |
  | 4        | Italien                       | Italy                  |
  | 5        | Kasachstan                    | Kazakhstan             |
  | 6        | Kroatien                      | Croatia                |
  | 7        | Niederlande                   | Netherlands            |
  | 8        | \<U+00D6\>sterreich           | Austria                |
  | 9        | Polen                         | Poland                 |
  | 10       | Rum\<U+00E4\>nien             | Romania                |
  | 11       | Russische F\<U+00F6\>deration | Russian Federation     |
  | 12       | T\<U+00FC\>rkei               | Turkey                 |
  | 13       | Ukraine                       | Ukraine                |
  | 14       | Sonstige                      | Other                  |

- `citizenship_total`:

  |          |                                    |                         |
  |----------|------------------------------------|-------------------------|
  | **code** | **german**                         | **english**             |
  | 1        | Eine Staatsangeh\<U+00F6\>rigkeit  | One citizenship         |
  | 2        | Mehrere, deutsch und ...           | Several, German and ... |
  | 3        | Mehrere, nur ausl\<U+00E4\>ndische | Several, only foreign   |
  | 4        | Nicht bekannt                      | Unknown                 |

- `age_short`:

  |          |                       |              |
  |----------|-----------------------|--------------|
  | **code** | **german**            | **english**  |
  | 1        | Unter 18              | Under 18     |
  | 2        | 18 - 29               | 18 to 29     |
  | 3        | 30 - 49               | 30 to 49     |
  | 4        | 50 - 64               | 50 to 64     |
  | 5        | 65 und \<U+00E4\>lter | 65 and older |

- `age_long`:

  |          |                       |              |
  |----------|-----------------------|--------------|
  | **code** | **german**            | **english**  |
  | 1        | Unter 10              | Under 10     |
  | 2        | 10 - 19               | 10 to 19     |
  | 3        | 20 - 29               | 20 to 29     |
  | 4        | 30 - 39               | 30 to 39     |
  | 5        | 40 - 49               | 40 to 49     |
  | 6        | 50 - 59               | 50 to 59     |
  | 7        | 60 - 69               | 60 to 69     |
  | 8        | 70 - 79               | 70 to 79     |
  | 9        | 80 und \<U+00E4\>lter | 80 and older |

- `marital_status`:

  |          |                                         |                                 |
  |----------|-----------------------------------------|---------------------------------|
  | **code** | **german**                              | **english**                     |
  | 1        | Ledig                                   | Single                          |
  | 2        | Verheiratet                             | Married                         |
  | 3        | Verwitwet                               | Widowed                         |
  | 4        | Geschieden                              | Divorced                        |
  | 5        | Eingetr. Lebenspartnerschaft            | Registered partnership          |
  | 6        | Eingetr. Lebenspartner/-in verstorben   | Registered partner deceased     |
  | 7        | Eingetr. Lebenspartnerschaft aufgehoben | Registered partnership annulled |
  | 8        | Ohne Angabe                             | No information                  |

- `family_type`:

  |          |                                                            |                                                          |
  |----------|------------------------------------------------------------|----------------------------------------------------------|
  | **code** | **german**                                                 | **english**                                              |
  | 1        | Ehepaare ohne Kind                                         | Couples without child                                    |
  | 2        | Ehepaare, mind. 1 Kind \< 18                               | Couples, at least 1 child \< 18                          |
  | 3        | Ehepaare alle Kinder \<U+2265\> 18                         | Couples all children \<U+2265\> 18                       |
  | 4        | Eingetr. Lebenspartnerschaften ohne Kind                   | Registered civil partnerships without child              |
  | 5        | Eingetr. Lebenspartnerschaften mind. 1 Kind \< 18          | Registered civil partnerships, at least 1 child \< 18    |
  | 6        | Eingetr. Lebenspartnerschaften alle Kinder \<U+2265\> 18   | Registered civil partnerships all children \<U+2265\> 18 |
  | 7        | Nichteheliche Lebensgem. ohne Kind                         | Non-marital partnerships without child                   |
  | 8        | Nichteheliche Lebensgem. mind. 1 Kind \< 18                | Non-marital partnerships, at least 1 child \< 18         |
  | 9        | Nichteheliche Lebensgem. alle Kinder \<U+2265\> 18         | Non-marital partnerships all children \<U+2265\> 18      |
  | 10       | Alleinerziehende V\<U+00E4\>ter mind. 1 Kind \< 18         | Single fathers, at least 1 child \< 18                   |
  | 11       | Alleinerziehende V\<U+00E4\>ter alle Kinder \<U+2265\> 18  | Single fathers all children \<U+2265\> 18                |
  | 12       | Alleinerziehende M\<U+00FC\>tter mind. 1 Kind \< 18        | Single mothers, at least 1 child \< 18                   |
  | 13       | Alleinerziehende M\<U+00FC\>tter alle Kinder \<U+2265\> 18 | Single mothers all children \<U+2265\> 18                |

- `family_size`:

  |          |                     |                    |
  |----------|---------------------|--------------------|
  | **code** | **german**          | **english**        |
  | 1        | 2 Personen          | 2 Persons          |
  | 2        | 3 Personen          | 3 Persons          |
  | 3        | 4 Personen          | 4 Persons          |
  | 4        | 5 Personen          | 5 Persons          |
  | 5        | 6 und mehr Personen | 6 and more Persons |

- `household_family`:

  |          |                                        |                                             |
  |----------|----------------------------------------|---------------------------------------------|
  | **code** | **german**                             | **english**                                 |
  | 1        | Einpersonenhaushalte (Singlehaushalte) | One-person households (Single households)   |
  | 2        | Paare ohne Kind(er)                    | Couples without child(ren)                  |
  | 3        | Paare mit Kind(ern)                    | Couples with child(ren)                     |
  | 4        | Alleinerziehende Elternteile           | Single parents                              |
  | 5        | Mehrpersonenhaushalte ohne Kernfamilie | Multi-person households without core family |

- `household_lifestyle`:

  |          |                                        |                                             |
  |----------|----------------------------------------|---------------------------------------------|
  | **code** | **german**                             | **english**                                 |
  | 1        | Einpersonenhaushalte (Singlehaushalte) | One-person households (Single households)   |
  | 2        | Ehepaare                               | Married couples                             |
  | 3        | Eingetr. Lebenspartnerschaften         | Registered civil partnerships               |
  | 4        | Nichteheliche Lebensgemeinschaften     | Non-marital partnerships                    |
  | 5        | Alleinerziehende M\<U+00FC\>tter       | Single mothers                              |
  | 6        | Alleinerziehende V\<U+00E4\>ter        | Single fathers                              |
  | 7        | Mehrpersonenhaushalte ohne Kernfamilie | Multi-person households without core family |

- `household_senior`:

  |          |                                                       |                                            |
  |----------|-------------------------------------------------------|--------------------------------------------|
  | **code** | **german**                                            | **english**                                |
  | 1        | Haushalte mit ausschlie\<U+00DF\>lich Senioren/-innen | Households with only seniors               |
  | 2        | Haushalte mit Senioren/-innen und J\<U+00FC\>ngeren   | Households with seniors and younger people |
  | 3        | Haushalte ohne Senioren/-innen                        | Households without seniors                 |

- `household_size_group`:

  |          |                     |                    |
  |----------|---------------------|--------------------|
  | **code** | **german**          | **english**        |
  | 1        | 1 Person            | 1 Person           |
  | 2        | 2 Personen          | 2 Persons          |
  | 3        | 3 Personen          | 3 Persons          |
  | 4        | 4 Personen          | 4 Persons          |
  | 5        | 5 Personen          | 5 Persons          |
  | 6        | 6 und mehr Personen | 6 and more Persons |

- `dwelling_occupancy`:

  |          |                                                     |                                                |
  |----------|-----------------------------------------------------|------------------------------------------------|
  | **code** | **german**                                          | **english**                                    |
  | 1        | Von Eigent\<U+00FC\>mer/-in bewohnt                 | Occupied by owner                              |
  | 11       | Eigentum: mit aktuell gef\<U+00FC\>hrtem Haushalt   | Ownership: with currently managed household    |
  | 12       | Eigentum: ohne aktuell gef\<U+00FC\>hrtem Haushalt  | Ownership: without currently managed household |
  | 2        | Zu Wohnzwecken vermietet                            | Rented for residential purposes                |
  | 21       | Vermietet: mit aktuell gef\<U+00FC\>hrtem Haushalt  | Rented: with currently managed household       |
  | 22       | Vermietet: ohne aktuell gef\<U+00FC\>hrtem Haushalt | Rented: without currently managed household    |
  | 3        | Ferien- und Freizeitwohnung                         | Holiday and leisure home                       |
  | 4        | Leer stehend                                        | Vacant                                         |
  | 5        | Diplomaten-/Streitkr\<U+00E4\>ftewohnung            | Diplomatic/Military housing                    |
  | 99       | Gewerbl. Nutzung                                    | Commercial use                                 |

- `dwelling_ownership_home`:

  |          |                                                         |                                          |
  |----------|---------------------------------------------------------|------------------------------------------|
  | **code** | **german**                                              | **english**                              |
  | 1        | Privatperson/-en                                        | Private person(s)                        |
  | 2        | Privatwirtschaftliche Unternehmen (jur. Personen)       | Private sector companies (legal persons) |
  | 3        | \<U+00D6\>ffentliche Unternehmen, Kirchen o.\<U+00E4\>. | Public companies, churches or similar    |
  | 4        | Wohnungsgenossenschaft                                  | Housing cooperative                      |
  | 99       | Trifft nicht zu (da keine Eigentumswohnung)             | Does not apply (no condominium)          |

- `dwelling_ownership_property`:

  |          |                                                      |                                           |
  |----------|------------------------------------------------------|-------------------------------------------|
  | **code** | **german**                                           | **english**                               |
  | 1        | Gemeinschaft von Wohnungseigent\<U+00FC\>mern/-innen | Homeowner association                     |
  | 2        | Privatperson/-en                                     | Private person(s)                         |
  | 3        | Wohnungsgenossenschaft                               | Housing cooperative                       |
  | 4        | Kommune oder Kommunales Wohnungsunternehmen          | Municipality or municipal housing company |
  | 5        | Privatwirtschaftliches Wohnungsunternehmen           | Private sector housing company            |
  | 6        | Anderes privatwirtschaftliches Unternehmen           | Other private sector company              |
  | 7        | Bund oder Land                                       | Federal or state government               |
  | 8        | Organisation ohne Erwerbszweck (z.B. Kirche)         | Non-profit organization (e.g. church)     |

- `floor_space`:

  |          |                    |                  |
  |----------|--------------------|------------------|
  | **code** | **german**         | **english**      |
  | 1        | Unter 30           | Under 30         |
  | 2        | 30 - 39            | 30 - 39          |
  | 3        | 40 - 49            | 40 - 49          |
  | 4        | 50 - 59            | 50 - 59          |
  | 5        | 60 - 69            | 60 - 69          |
  | 6        | 70 - 79            | 70 - 79          |
  | 7        | 80 - 89            | 80 - 89          |
  | 8        | 90 - 99            | 90 - 99          |
  | 9        | 100 - 109          | 100 - 109        |
  | 10       | 110 - 119          | 110 - 119        |
  | 11       | 120 - 129          | 120 - 129        |
  | 12       | 130 - 139          | 130 - 139        |
  | 13       | 140 - 149          | 140 - 149        |
  | 14       | 150 - 159          | 150 - 159        |
  | 15       | 160 - 169          | 160 - 169        |
  | 16       | 170 - 179          | 170 - 179        |
  | 17       | 180 und mehr       | 180 and more     |
  | 99       | t.n.z., gewerblich | n.a., commercial |

- `dwelling_rooms`:

  |          |                           |                  |
  |----------|---------------------------|------------------|
  | **code** | **german**                | **english**      |
  | 1        | 1 Raum                    | 1 Room           |
  | 2        | 2 R\<U+00E4\>ume          | 2 Rooms          |
  | 3        | 3 R\<U+00E4\>ume          | 3 Rooms          |
  | 4        | 4 R\<U+00E4\>ume          | 4 Rooms          |
  | 5        | 5 R\<U+00E4\>ume          | 5 Rooms          |
  | 6        | 6 R\<U+00E4\>ume          | 6 Rooms          |
  | 7        | 7 und mehr R\<U+00E4\>ume | 7 and more Rooms |
  | 99       | t.n.z., gewerblich        | n.a., commercial |

- `dwelling_constr_year` (2011):

  |          |                          |                |
  |----------|--------------------------|----------------|
  | **code** | **german**               | **english**    |
  | 1        | Vor 1919                 | Before 1919    |
  | 2        | 1919 - 1948              | 1919 - 1948    |
  | 3        | 1949 - 1978              | 1949 - 1978    |
  | 4        | 1979 - 1986              | 1979 - 1986    |
  | 5        | 1987 - 1990              | 1987 - 1990    |
  | 6        | 1991 - 1995              | 1991 - 1995    |
  | 7        | 1996 - 2000              | 1996 - 2000    |
  | 8        | 2001 - 2004              | 2001 - 2004    |
  | 9        | 2005 - 2008              | 2005 - 2008    |
  | 10       | 2009 und sp\<U+00E4\>ter | 2009 and later |

- `dwelling_constr_year` (2022):

  |          |                          |                |
  |----------|--------------------------|----------------|
  | **code** | **german**               | **english**    |
  | 1        | Vor 1919                 | Before 1919    |
  | 2        | 1919 - 1948              | 1919 - 1948    |
  | 3        | 1949 - 1978              | 1949 - 1978    |
  | 4        | 1979 - 1990              | 1979 - 1990    |
  | 5        | 1991 - 2000              | 1991 - 2000    |
  | 6        | 2001 - 2010              | 2001 - 2010    |
  | 7        | 2011 - 2019              | 2011 - 2019    |
  | 8        | 2020 und sp\<U+00E4\>ter | 2020 and later |

- `dwelling_building_type`:

  |          |                                         |                                              |
  |----------|-----------------------------------------|----------------------------------------------|
  | **code** | **german**                              | **english**                                  |
  | 1        | Geb\<U+00E4\>ude mit Wohnraum           | Building with living space                   |
  | 11       | Wohngeb\<U+00E4\>ude                    | Residential building                         |
  | 111      | Wohngeb\<U+00E4\>ude (ohne Wohnheime)   | Residential building (excluding dormitories) |
  | 112      | Wohnheim                                | Dormitory                                    |
  | 12       | Sonstiges Geb\<U+00E4\>ude mit Wohnraum | Other building with living space             |

- `dwelling_building_design`:

  |          |                             |                     |
  |----------|-----------------------------|---------------------|
  | **code** | **german**                  | **english**         |
  | 1        | Freistehendes Haus          | Detached house      |
  | 2        | Doppelhaus H\<U+00E4\>lfte  | Semi-detached house |
  | 3        | Gereihtes Haus              | Terraced house      |
  | 4        | Anderer Geb\<U+00E4\>udetyp | Other building type |

- `dwelling_building_size`:

  |          |                                             |                                            |
  |----------|---------------------------------------------|--------------------------------------------|
  | **code** | **german**                                  | **english**                                |
  | 1        | Freistehendes Einfamilienhaus               | Detached single-family house               |
  | 2        | Einfamilienhaus: Doppelhaush\<U+00E4\>lfte  | Single-family house: semi-detached         |
  | 3        | Einfamilienhaus: Reihenhaus                 | Single-family house: terraced              |
  | 4        | Freistehendes Zweifamilienhaus              | Detached two-family house                  |
  | 5        | Zweifamilienhaus: Doppelhaush\<U+00E4\>lfte | Two-family house: semi-detached            |
  | 6        | Zweifamilienhaus: Reihenhaus                | Two-family house: terraced                 |
  | 7        | Mehrfamilienhaus: 3-6 Wohnungen             | Multi-family house: 3-6 apartments         |
  | 8        | Mehrfamilienhaus: 7-12 Wohnungen            | Multi-family house: 7-12 apartments        |
  | 9        | Mehrfamilienhaus: 13 und mehr Wohnungen     | Multi-family house: 13 and more apartments |
  | 10       | Anderer Geb\<U+00E4\>udetyp                 | Other building type                        |

- `dwelling_heat_type`:

  |          |                                                           |                                                                |
  |----------|-----------------------------------------------------------|----------------------------------------------------------------|
  | **code** | **german**                                                | **english**                                                    |
  | 1        | Fernheizung (Fernw\<U+00E4\>rme)                          | District heating (long-distance heating)                       |
  | 2        | Etagenheizung                                             | Self-contained central heating                                 |
  | 3        | Blockheizung                                              | Block heating                                                  |
  | 4        | Zentralheizung                                            | Central heating                                                |
  | 5        | Einzel-/Mehrraum\<U+00F6\>fen (auch Nachtspeicherheizung) | Individual/multi-room stoves (including night storage heating) |
  | 6        | Keine Heizung im Geb\<U+00E4\>ude oder in den Wohnungen   | No heating in the building or in the apartments                |

- `dwelling_heat_src`:

  |          |                                         |                                  |
  |----------|-----------------------------------------|----------------------------------|
  | **code** | **german**                              | **english**                      |
  | 1        | Gas                                     | Gas                              |
  | 2        | Heiz\<U+00F6\>l                         | Heating oil                      |
  | 3        | Holz(pellets)                           | Wood (pellets)                   |
  | 4        | Biomasse (ohne Holz), Biogas            | Biomass (no wood), biogas        |
  | 5        | Solar-/Geothermie, W\<U+00E4\>rmepumpen | Solar, geothermal, heat pumps    |
  | 6        | Strom (ohne W\<U+00E4\>rmepumpen)       | Electric heating (no heat pumps) |
  | 7        | Kohle                                   | Coal                             |
  | 8        | Fernw\<U+00E4\>rme                      | District heating                 |
  | 9        | Kein Energietr\<U+00E4\>ger             | No heating                       |

- `building_ownership_property`:

  |          |                                                      |                                           |
  |----------|------------------------------------------------------|-------------------------------------------|
  | **code** | **german**                                           | **english**                               |
  | 1        | Gemeinschaft von Wohnungseigent\<U+00FC\>mern/-innen | Homeowner association                     |
  | 2        | Privatperson/-en                                     | Private person(s)                         |
  | 3        | Wohnungsgenossenschaft                               | Housing cooperative                       |
  | 4        | Kommune oder Kommunales Wohnungsunternehmen          | Municipality or municipal housing company |
  | 5        | Privatwirtschaftliches Wohnungsunternehmen           | Private sector housing company            |
  | 6        | Anderes privatwirtschaftliches Unternehmen           | Other private sector company              |
  | 7        | Bund oder Land                                       | Federal or state government               |
  | 8        | Organisation ohne Erwerbszweck (z.B. Kirche)         | Non-profit organization (e.g. church)     |

- `building_constr_year` (2011):

  |          |                          |                |
  |----------|--------------------------|----------------|
  | **code** | **german**               | **english**    |
  | 1        | Vor 1919                 | Before 1919    |
  | 2        | 1919 - 1948              | 1919 - 1948    |
  | 3        | 1949 - 1978              | 1949 - 1978    |
  | 4        | 1979 - 1986              | 1979 - 1986    |
  | 5        | 1987 - 1990              | 1987 - 1990    |
  | 6        | 1991 - 1995              | 1991 - 1995    |
  | 7        | 1996 - 2000              | 1996 - 2000    |
  | 8        | 2001 - 2004              | 2001 - 2004    |
  | 9        | 2005 - 2008              | 2005 - 2008    |
  | 10       | 2009 und sp\<U+00E4\>ter | 2009 and later |

- `building_constr_year` (2022):

  |          |                          |                |
  |----------|--------------------------|----------------|
  | **code** | **german**               | **english**    |
  | 1        | Vor 1919                 | Before 1919    |
  | 2        | 1919 - 1948              | 1919 - 1948    |
  | 3        | 1949 - 1978              | 1949 - 1978    |
  | 4        | 1979 - 1990              | 1979 - 1990    |
  | 5        | 1991 - 2000              | 1991 - 2000    |
  | 6        | 2001 - 2010              | 2001 - 2010    |
  | 7        | 2011 - 2019              | 2011 - 2019    |
  | 8        | 2020 und sp\<U+00E4\>ter | 2020 and later |

- `building_dwellings`:

  |          |                       |                        |
  |----------|-----------------------|------------------------|
  | **code** | **german**            | **english**            |
  | 1        | 1 Wohnung             | 1 Apartment            |
  | 2        | 2 Wohnungen           | 2 Apartments           |
  | 3        | 3 - 6 Wohnungen       | 3 - 6 Apartments       |
  | 4        | 7 - 12 Wohnungen      | 7 - 12 Apartments      |
  | 5        | 13 und mehr Wohnungen | 13 and more Apartments |

- `building_size`:

  |          |                                             |                                            |
  |----------|---------------------------------------------|--------------------------------------------|
  | **code** | **german**                                  | **english**                                |
  | 1        | Freistehendes Einfamilienhaus               | Detached single-family house               |
  | 2        | Einfamilienhaus: Doppelhaush\<U+00E4\>lfte  | Single-family house: semi-detached         |
  | 3        | Einfamilienhaus: Reihenhaus                 | Single-family house: terraced              |
  | 4        | Freistehendes Zweifamilienhaus              | Detached two-family house                  |
  | 5        | Zweifamilienhaus: Doppelhaush\<U+00E4\>lfte | Two-family house: semi-detached            |
  | 6        | Zweifamilienhaus: Reihenhaus                | Two-family house: terraced                 |
  | 7        | Mehrfamilienhaus: 3-6 Wohnungen             | Multi-family house: 3-6 apartments         |
  | 8        | Mehrfamilienhaus: 7-12 Wohnungen            | Multi-family house: 7-12 apartments        |
  | 9        | Mehrfamilienhaus: 13 und mehr Wohnungen     | Multi-family house: 13 and more apartments |
  | 10       | Anderer Geb\<U+00E4\>udetyp                 | Other building type                        |

- `building_type`:

  |          |                                         |                                              |
  |----------|-----------------------------------------|----------------------------------------------|
  | **code** | **german**                              | **english**                                  |
  | 1        | Geb\<U+00E4\>ude mit Wohnraum           | Building with living space                   |
  | 11       | Wohngeb\<U+00E4\>ude                    | Residential building                         |
  | 111      | Wohngeb\<U+00E4\>ude (ohne Wohnheime)   | Residential building (excluding dormitories) |
  | 112      | Wohnheim                                | Dormitory                                    |
  | 12       | Sonstiges Geb\<U+00E4\>ude mit Wohnraum | Other building with living space             |

- `building_design`:

  |          |                             |                     |
  |----------|-----------------------------|---------------------|
  | **code** | **german**                  | **english**         |
  | 1        | Freistehendes Haus          | Detached house      |
  | 2        | Doppelhaus H\<U+00E4\>lfte  | Semi-detached house |
  | 3        | Gereihtes Haus              | Terraced house      |
  | 4        | Anderer Geb\<U+00E4\>udetyp | Other building type |

- `building_heat_type`:

  |          |                                                           |                                                                |
  |----------|-----------------------------------------------------------|----------------------------------------------------------------|
  | **code** | **german**                                                | **english**                                                    |
  | 1        | Fernheizung (Fernw\<U+00E4\>rme)                          | District heating (long-distance heating)                       |
  | 2        | Etagenheizung                                             | Self-contained central heating                                 |
  | 3        | Blockheizung                                              | Block heating                                                  |
  | 4        | Zentralheizung                                            | Central heating                                                |
  | 5        | Einzel-/Mehrraum\<U+00F6\>fen (auch Nachtspeicherheizung) | Individual/multi-room stoves (including night storage heating) |
  | 6        | Keine Heizung im Geb\<U+00E4\>ude oder in den Wohnungen   | No heating in the building or in the apartments                |

- `building_heat_src`:

  |          |                                         |                                  |
  |----------|-----------------------------------------|----------------------------------|
  | **code** | **german**                              | **english**                      |
  | 1        | Gas                                     | Gas                              |
  | 2        | Heiz\<U+00F6\>l                         | Heating oil                      |
  | 3        | Holz(pellets)                           | Wood (pellets)                   |
  | 4        | Biomasse (ohne Holz), Biogas            | Biomass (no wood), biogas        |
  | 5        | Solar-/Geothermie, W\<U+00E4\>rmepumpen | Solar, geothermal, heat pumps    |
  | 6        | Strom (ohne W\<U+00E4\>rmepumpen)       | Electric heating (no heat pumps) |
  | 7        | Kohle                                   | Coal                             |
  | 8        | Fernw\<U+00E4\>rme                      | District heating                 |
  | 9        | Kein Energietr\<U+00E4\>ger             | No heating                       |

## Examples

``` r
z22_categories("sex")
#> # A tibble: 2 × 3
#>    code german   english
#>   <int> <chr>    <chr>  
#> 1     1 Männlich Male   
#> 2     2 Weiblich Female 

# Features without categories are given code 0
z22_categories("families")
#> # A tibble: 1 × 3
#>    code german                  english                 
#>   <dbl> <chr>                   <chr>                   
#> 1     0 Gesamtzahl der Familien Total number of families
```
