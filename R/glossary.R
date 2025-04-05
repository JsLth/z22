#' Definitions and explanations for common Census terms
#'
#' @description First off, this package uses a couple of semi-official terms to
#' make it easier to unequivocally identidy certain parts of an aspect. When we
#' are talking about a
#'
#' \itemize{
#'  \item{\strong{feature}, we talk about an indicator aggregated to grid cells,
#'  e.g., age or the number of dwellings.}
#'  \item{\strong{category}, we talk about the discrete classifications of
#'  features, e.g., ages 10 to 19, 20 to 20, 30 to 39, etc.}
#'  \item{Both feature and category have to be provided to uniquely identify
#'  a \strong{dataset}.}
#' }
#'
#' This documentation is a collection of definitions as they are provided
#' by the Federal Statistical Office of Germany.
#'
#' @section Residents:
#'
#' Each \strong{resident} is assigned to an \strong{address} and thus to a
#' grid cell with a side length of 100 m, 1 km or 10 km. Members of the German
#' Armed Forces, police authorities and the Foreign Service working abroad and
#' their families living there are not included in this analysis, as they cannot
#' be assigned regionally at grid cell level in Germany.
#'
#' @section Foreigners:
#'
#' Persons with a non-German nationality are counted as \strong{foreigners}.
#' When assigning nationality, a distinction is made between persons with German
#' and non-German nationality. Persons with German citizenship are considered
#' German, regardless of the existence of other citizenships.
#'
#' @section Nationals:
#'
#' Persons with German citizenship are counted as German \strong{nationals}.
#' When assigning nationality, a distinction is made between persons with German
#' and non-German nationality. Persons with a German nationality are considered
#' to be German, regardless of the existence of other nationalities.
#'
#' Members of the German Armed Forces, police authorities and the Foreign
#' Service working abroad and their families residing there are not included in
#' this analysis, as they cannot be assigned regionally at grid cell level in
#' Germany.
#'
#' @section Place of birth:
#'
#' Persons born up to August 2, 1945 in former German eastern territories
#' within the borders of Germany in 1937 are not counted as born abroad, but
#' are assigned the German state code. If the \strong{place of birth} is not
#' within these borders, the current state code is assigned. Places of birth in
#' countries that have merged into other countries, such as the Soviet Union
#' or Yugoslavia, are assigned to the countries that exist today wherever
#' possible.
#'
#' @section EU27:
#'
#' Comprises the member states of the European Union as of 15 May 2022,
#' previously last amended by the UK's withdrawal in 2020. Persons born in
#' Czechoslovakia are also included in "EU27 country (as of 2020)" with the
#' current country codes. Croatia is also included here following its accession
#' to the EU on July 1, 2013.
#'
#' @section Other Europe:
#'
#' Includes the Russian Federation and Turkey as well as other current country
#' codes of the former Soviet Union and the former Yugoslavia. Great Britain
#' will be assigned here following its withdrawal from the EU.
#'
#' @section Marital status:
#'
#' The \strong{marital status} indicates a person's marital status under
#' personal law. The marital status under personal law is determined in
#' accordance with the Civil Status Act (Personenstandsgesetz) and the
#' Registered Civil Partnership Act (Gesetz über die eingetragene
#' Lebenspartnerschaft).
#' The Act on the Introduction of the Right to Marriage for Persons of the Same
#' Sex (Eheöffnungsgesetz) has allowed same-sex couples to marry since October
#' 1, 2017. The establishment of new registered civil partnerships under the
#' Civil Partnership Act (Lebenspartnerschaftsgesetz, LPartG) has no longer
#' been possible since October 1, 2017. Unless existing civil partnerships are
#' converted into a marriage, registered civil partnerships remain in place.
#'
#' @section Core family:
#'
#' This characteristic indicates the type of \strong{core family} according to
#' national typification, i.e. according to the reference person principle,
#' taking into account secondary residents. A core family consists of two or
#' more persons belonging to the same private household and is made up of the
#' reference person of the private household - a central person of the private
#' household defined by age, marital status and gender - and at least one other
#' person, e.g. the partner or a child of the reference person. This family
#' concept restricts relationships between ancestors and descendants to direct
#' relationships (first degree), i.e. relationships between parents and
#' children. Only one nuclear family can exist in a household. Other persons
#' living in the household are not assigned to a core family. A household
#' without a core family is possible.
#'
#' The type of nuclear family depends on the type of couple relationship or
#' the gender of the single parent, and on the presence and age (under or over
#' 18) of children. The term marriage is not differentiated according to the
#' gender of the married persons. Persons in shared accommodation are not
#' included here, only persons who have their own household.
#'
#' @section Household:
#'
#' A private \strong{household} consists of at least one person. This isa based
#' on the "concept of communal living": all persons who live together in
#' dwelling, regardless of their residential status (sole residence, main or
#' secondary residence), are considered members of the same private household,
#' meaning that there is one private household per occupied dwelling. There
#' is a maximum of one core family in a household. Other persons living in the
#' household are not assigned to a core family.
#'
#' @section Dwelling:
#'
#' A \strong{dwelling} is defined as rooms that are closed off from the outside,
#' intended for residential purposes, usually located together, which enable
#' the management of a separate household and are not used entirely for
#' commercial purposes.
#'
#' An apartment does not necessarily have to contain a kitchen or kitchenette.
#' Apartments have their own entrance directly from the outside, from a
#' stairwell or a vestibule. However, a dwelling may also include basement or
#' floor rooms (e.g. attics) that are developed for residential purposes
#' outside the actual end of the dwelling.
#'
#' @section Net rent:
#'
#' The average \strong{net rent} per square meter is the ratio between the total rent
#' per square meter of the apartments and the total number of apartments. The
#' calculation is made for rented apartments in residential buildings
#' (excluding halls of residence). Apartments not rented out are excluded from
#' the calculation.
#'
#' @section Ownership:
#'
#' The \strong{ownership rate} represents the share of owner-occupied apartments in
#' all occupied apartments. Not taken into account: Vacant apartments,
#' vacation and leisure apartments and commercially used apartments. The
#' calculation is made for dwellings in residential buildings (excluding
#' halls of residence).
#'
#' @section Vacancy:
#'
#' The \strong{vacancy rate} (apartments) represents the ratio of vacant apartments to
#' all occupied and vacant apartments. The market-active vacancy rate
#' represents the proportion of vacant apartments that are available again
#' within three months as a percentage of all apartments in residential
#' buildings Not taken into account: Vacation and leisure apartments as well as
#' commercially used apartments. The calculation is made for dwellings in
#' residential buildings (excluding halls of residence).
#'
#' @section Building year:
#'
#' This characteristic indicates the \strong{year of construction} of a building with
#' living space in microcensus classes on the respective census reference date.
#' The year of construction refers to the year in which the building was
#' completed. In the case of conversions, extensions and additions to the house,
#' the original year of construction of the building applies. In the case of
#' completely destroyed and rebuilt buildings, the year of reconstruction is
#' taken as the year of construction.
#'
#' @section Heating type:
#'
#' The characteristic reflects the \strong{type of heating} in the building. This
#' evaluation is carried out for apartments. The predominant type of heating
#' in the building is broken down according to which spatial unit (district,
#' building block, building, apartment, room) is heated by the heating system.
#' In passive houses, systems for heat recovery/controlled ventilation systems
#' are considered "heating" and are assigned accordingly (usually: central
#' heating).
#'
#' \describe{
#'  \item{\strong{District heating}}{Here, entire residential districts are supplied
#'  with heat from a central district heating plant (so-called district
#'  heating).}
#'
#'  \item{\strong{Floor heating}}{Floor heating refers to a central heating system for
#'  all rooms in a self-contained apartment, whereby the heating source (for
#'  example, gas boiler) is usually located within this apartment.}
#'
#'  \item{\strong{Block heating}}{Block heating is when a block of entire houses is
#'  heated by a central heating system and the heating source is located in
#'  or on one of the buildings or in its immediate vicinity (so-called local
#'  heating).}
#'
#'  \item{\strong{Central heating}}{With central heating, all the residential units in
#'  a building are heated from a central heating point located within the
#'  building (usually in the basement). This also includes heat pumps.}
#'
#'  \item{\strong{Single or multi-room stoves}}{Individual stoves (such as coal or
#'  night storage stoves) only heat the room in which they are located at any
#'  one time. They are usually permanently installed. A multi-room stove (e.g.
#'  tiled stove) heats several rooms at the same time (also through air ducts).
#'  No heating in the building or in the apartments}
#' }
#'
#' @section Source of heating:
#'
#' The characteristic shows the energy \strong{source of the heating} in the building.
#' This evaluation is carried out for apartments. Energy source used to heat
#' the building. If there are several energy sources in the building, it is the
#' one that heats the largest part of the living space. In passive houses, the
#' residual heat requirement is covered by an additional source, which is
#' specified here.
#'
#' \itemize{
#'  \item{\strong{Gas}}
#'  \item{\strong{Heating oil}}
#'  \item{\strong{Wood, wood pellets}}
#'  \item{\strong{Biomass (excluding wood), biogas}: All organic substances produced by
#'  plants or animals from which energy can be obtained by burning. Energy can
#'  be obtained through combustion. This includes straw, organic waste or
#'  liquid manure (excluding wood). Biogas is produced during the fermentation
#'  of biomass and is also classified here.}
#'  \item{\strong{Solar/geothermal energy, environmental heat, exhaust air heat}:
#'  Solar energy as well as energy from water, air and earth is obtained here
#'  with the help of collectors, heat pumps and heat exchangers. This also
#'  includes heat obtained from the exhaust air of buildings (so-called exhaust
#'  air heat).}
#'  \item{\strong{Electricity (without heat pumpts)}}
#'  \item{\strong{Coal}}
#'  \item{\strong{District heating (various heating sources)}}
#'  \item{\strong{No energy source (no heating)}}
#' }
#'
#' @source Translated and slightly edited version of the dataset descriptions
#' of the Zensus 2022 gridded datasets by the Federal Statistical Office of
#' Germany
#'
#' @name glossary
NULL
