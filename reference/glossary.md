# Definitions and explanations for common Census terms

First off, this package uses a couple of semi-official terms to make it
easier to unequivocally identify certain parts of an aspect. When we are
talking about a

- **feature**, we talk about an indicator aggregated to grid cells,
  e.g., age or the number of dwellings.

- **category**, we talk about the discrete classifications of features,
  e.g., ages 10 to 19, 20 to 29, 30 to 39, etc.

- Both feature and category have to be provided to uniquely identify a
  **dataset**.

This documentation is a collection of definitions as they are provided
by the Federal Statistical Office of Germany.

## Source

Translated and slightly edited version of the dataset descriptions of
the Zensus 2022 and Zensus 2011 gridded datasets by the Federal
Statistical Office of Germany.

© Statistische Ämter des Bundes und der Länder, 2024

## Building year

This characteristic indicates the **year of construction** of a building
with living space in microcensus classes on the respective census
reference date. The year of construction refers to the year in which the
building was completed. In the case of conversions, extensions and
additions to the house, the original year of construction of the
building applies. In the case of completely destroyed and rebuilt
buildings, the year of reconstruction is taken as the year of
construction.

## Building classifications

The census distinguishes three types of building classifications.
Because they are very close terminologically, they need clarification:

- **Building size**:

  Originally called "building type size" (Gebäudetyp-Größe), this
  classification provides information on the building type in relation
  to its size. Categories range from detached single-family buildings to
  multi-story multi-unit buildings.

- **Building type**:

  Originally called "building type" (Gebäudeart), this classification
  provides information about the residential use of residential
  buildings. It distinguishes buildings based on how much space is used
  for residential purposes. Categories include:

  - **Buildings with living space**: Permanent buildings which are
    either fully or partially reserved for residential use by
    households. This also includes buildings used for administrative or
    commercial purposes if they contain at least one dwelling used for
    residential purposes. Buildings with living space are divided into
    residential buildings and other buildings with living space.

  - **Residential buildings**: Buildings in which at least half of the
    total usable floor space is used for residential purposes.
    Residential buildings also include dormitories (where residents run
    their own household).

  - **Dormitories**: Dormitories are residential buildings that
    primarily serve the housing needs of certain groups of the
    population (e.g. student residences, retirement homes). Dormitories
    have common rooms. Residents of dormitories run their own
    households.

  - **Other buildings with living space**: Buildings in which less than
    half of the total floor space is used for residential purposes, e.g.
    because the building is predominantly occupied by stores or offices.

- **Building design**:

  Originally called "building type construction design"
  (Gebäudetyp-Bauweise), this classification specifies the morphological
  design of a building, i.e. whether it is detached, semi-detached,
  terraced or something else.

## Citizens / Citizenship

Persons with German citizenship are counted as German **citizens**. When
assigning citizenship, a distinction is made between persons with German
and non-German citizenship. Persons with a German citizenship are
considered to be German, regardless of the existence of other
citizenships.

Members of the German Armed Forces, police authorities and the Foreign
Service working abroad and their families residing there are not
included in this analysis, as they cannot be assigned regionally at grid
cell level in Germany.

## Core family

This characteristic indicates the type of **core family** according to
national typification, i.e. according to the reference person principle,
taking into account secondary residents. A core family consists of two
or more persons belonging to the same private household and is made up
of the reference person of the private household - a central person of
the private household defined by age, marital status and gender - and at
least one other person, e.g. the partner or a child of the reference
person. This family concept restricts relationships between ancestors
and descendants to direct relationships (first degree), i.e.
relationships between parents and children. Only one core family can
exist in a household. Other persons living in the household are not
assigned to a core family. A household without a core family is
possible.

The type of core family depends on the type of couple relationship or
the gender of the single parent, and on the presence and age (under or
over 18) of children. The term marriage is not differentiated according
to the gender of the married persons. Persons in shared accommodation
are not included here, only persons who have their own household.

A range of terms relate to core families:

- A **couple** comprises of married couples, couples in a registered
  civil partnership and couples in a non-marital partnership who live
  together in a private household.

- A **married couple** is a couple married according to the legal
  marital status on the reference date and living in a private
  household.

- A **registered civil partnership** (ELP) is a legally recognized
  same-sex couple in a private household according to the legal marital
  status on the reference date.

- A **non-marital partnership** (NELG) is a mixed-sex couple in a
  private household who were not married to each other according to
  their legal marital status on the reference date.

- A **single mother** or a **single father** is a parent without a
  partner with at least one child within a private household.

- A **child** is a biological son, stepson or adopted son or a
  biological daughter, stepdaughter or adopted daughter (regardless of
  age) whose usual place of residence is in the private household of at
  least one parent and one parent is the caregiver and/or partner of the
  caregiver.

- A **senior** is defined as a person who has reached the age of 65 on
  the census date.

## Dwelling

A **dwelling** is defined as rooms that are closed off from the outside,
intended for residential purposes, usually located together, which
enable the management of a separate household and are not used entirely
for commercial purposes.

A dwelling does not necessarily have to contain a kitchen or
kitchenette. Apartments have their own entrance directly from the
outside, from a stairwell or a vestibule. However, a dwelling may also
include basement or floor rooms (e.g. attics) that are developed for
residential purposes outside the actual end of the dwelling.

## Floor space

To determine the **floor space**, the following areas are taken into
account:

- **full**: floor areas of rooms or parts of rooms with a clear height
  of at least 2 meters.

- **half**: floor areas of rooms or parts of rooms with a clear height
  of at least 1 meter but less than 2 meters; unheatable observatories,
  swimming pools, and similar rooms closed on all sides.

- **generally a quarter, but no more than half**: areas of balconies,
  loggias, roof gardens, terraces.

## Foreigners

Persons with a non-German nationality are counted as **foreigners**.
When assigning nationality, a distinction is made between persons with
German and non-German nationality. Persons with German citizenship are
considered German, regardless of the existence of other citizenships.

## Household

A private **household** consists of at least one person. This is based
on the "concept of communal living": all persons who live together in
dwelling, regardless of their residential status (sole residence, main
or secondary residence), are considered members of the same private
household, meaning that there is one private household per occupied
dwelling. There is a maximum of one core family in a household. Other
persons living in the household are not assigned to a core family.

## Heating type

The characteristic reflects the **type of heating** in the building.
This evaluation is carried out for dwellings. The predominant type of
heating in the building is broken down according to which spatial unit
(district, building block, building, dwelling, room) is heated by the
heating system. In passive houses, systems for heat recovery/controlled
ventilation systems are considered "heating" and are assigned
accordingly (usually: central heating).

- **District heating**:

  Here, entire residential districts are supplied with heat from a
  central district heating plant (so-called district heating).

- **Self-contained central heating**:

  Self-contained central heating refers to a central heating system for
  all rooms in a self-contained dwelling, whereby the heating source
  (for example, gas boiler) is usually located within this dwelling.

- **Block heating**:

  Block heating is when a block of entire houses is heated by a central
  heating system and the heating source is located in or on one of the
  buildings or in its immediate vicinity (so-called local heating).

- **Central heating**:

  With central heating, all the residential units in a building are
  heated from a central heating point located within the building
  (usually in the basement). This also includes heat pumps.

- **Single or multi-room stoves**:

  Individual stoves (such as coal or night storage stoves) only heat the
  room in which they are located at any one time. They are usually
  permanently installed. A multi-room stove (e.g. tiled stove) heats
  several rooms at the same time (also through air ducts). No heating in
  the building or in the dwellings

## Marital status

The **marital status** indicates a person's marital status under
personal law. The marital status under personal law is determined in
accordance with the Personenstandsgesetz (PStG) and the
Lebenspartnerschaftsgesetz (LPartG).

The introduction of the right to marriage for persons of the same sex
(Eheöffnungsgesetz) has allowed same-sex couples to marry since October
1, 2017. The establishment of new registered civil partnerships under
the Lebenspartnerschaftsgesetz (LPartG) has no longer been possible
since October 1, 2017. Unless existing civil partnerships are converted
into a marriage, registered civil partnerships remain in place.

## Net rent

The average **net rent** per square meter is the ratio between the total
rent per square meter of the dwellings and the total number of
dwellings. The calculation is made for rented dwellings in residential
buildings (excluding dormitories). Dwellings not rented out are excluded
from the calculation.

## Ownership

Ownership is divided into **home ownership** and **property ownership**.
Home ownership determines who is entitled to ownership of a dwelling in
a building divided according to the Wohneigentumsgesetz (WEG) while
property ownership determines who is entitled to ownership in a
building. Owners can be private individuals or legal entities.

The **ownership rate** represents the share of owner-occupied dwellings
in all occupied dwellings. Not taken into account: Vacant dwellings,
vacation and leisure dwellings and commercially used dwellings. The
calculation is made for dwellings in residential buildings (excluding
halls of residence).

## Place of birth

Persons born up to August 2, 1945 in former German eastern territories
within the borders of Germany in 1937 are not counted as born abroad,
but are assigned the German state code. If the **place of birth** is not
within these borders, the current state code is assigned. Places of
birth in countries that have merged into other countries, such as the
Soviet Union or Yugoslavia, are assigned to the countries that exist
today wherever possible.

- **EU27**:

  Comprises the member states of the European Union as of 15 May 2022,
  previously last amended by the UK's withdrawal in 2020. Persons born
  in Czechoslovakia are also included in "EU27 country (as of 2020)"
  with the current country codes. Croatia is also included here
  following its accession to the EU on July 1, 2013.

- **Other Europe**:

  Includes the Russian Federation and Turkey as well as other current
  country codes of the former Soviet Union and the former Yugoslavia.
  Great Britain is assigned here following its withdrawal from the EU.

- **Other World**:

  Includes all other countries. This category includes other current
  country codes of the former Soviet Union that were not assigned to
  "Other Europe".

- **Other**:

  Includes "Not specified".

## Residents

Each **resident** is assigned to an **address** and thus to a grid cell
with a side length of 100 m, 1 km or 10 km. Members of the German Armed
Forces, police authorities and the Foreign Service working abroad and
their families living there are not included in this analysis, as they
cannot be assigned regionally at grid cell level in Germany.

## Room

A **room** is either a living room, dining room, bedroom or other
separate room (e.g. habitable cellar or floor rooms) of at least 6
square meters in size as well as self-contained kitchens, regardless of
their size. Bathrooms, toilets, hallways and utility rooms are generally
not counted. A living room with a dining area, sleeping alcove or
kitchenette is to be counted as one room. Accordingly, dwellings in
which there is no structural separation of the individual living areas
(e.g. so-called "loft dwellings") consist of only one room.

## Source of heating

The characteristic shows the energy **source of the heating** in the
building. This evaluation is carried out for dwellings. Energy source
used to heat the building. If there are several energy sources in the
building, it is the one that heats the largest part of the living space.
In passive houses, the residual heat requirement is covered by an
additional source, which is specified here.

- **Gas**

- **Heating oil**

- **Wood, wood pellets**

- **Biomass (excluding wood), biogas**: All organic substances produced
  by plants or animals from which energy can be obtained by burning.
  Energy can be obtained through combustion. This includes straw,
  organic waste or liquid manure (excluding wood). Biogas is produced
  during the fermentation of biomass and is also classified here.

- **Solar/geothermal energy, environmental heat, exhaust air heat**:
  Solar energy as well as energy from water, air and earth is obtained
  here with the help of collectors, heat pumps and heat exchangers. This
  also includes heat obtained from the exhaust air of buildings
  (so-called exhaust air heat).

- **Electricity (without heat pumps)**

- **Coal**

- **District heating (various heating sources)**

- **No energy source (no heating)**

## Vacancy

The **vacancy rate** (dwellings) represents the ratio of vacant
dwellings to all occupied and vacant dwellings. The market-active
vacancy rate represents the proportion of vacant dwellings that are
available again within three months as a percentage of all dwellings in
residential buildings. Not taken into account: Vacation and leisure
dwellings as well as commercially used dwellings. The calculation is
made for dwellings in residential buildings (excluding halls of
residence).
