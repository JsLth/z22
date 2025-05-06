#' Features
#' @description
#' Get a list of available features. To get a list of all categories, see
#' \code{\link{z22_categories}}.
#'
#' For further clarification of terms used in the feature labels, see the
#' \link{glossary}.
#'
#' @param theme Theme of the feature. Available themes are \code{"population"},
#' \code{"families"}, \code{"households"}, \code{"dwellings"}, and
#' \code{"buildings"}. If \code{NULL}, returns features for all themes.
#' @param year Census year. Can be 2011 or 2022. If \code{NULL}, returns
#' features for both years.
#' @param res Resolution of the feature grid. Can be \code{"100m"},
#' \code{"1km"}, or \code{"10km"}. For Census 2011, only 100m and 1km are
#' available and not all features are available for both resolutions. For
#' Census 2022, all features are available at all resolutions. If
#' \code{NULL}, returns features for all resolutions.
#' @param legacy_names If \code{TRUE}, uses legacy (german) feature names from
#' the Census 2011 where possible. Defaults to \code{FALSE}.
#'
#' @returns A tibble containing the following columns:
#'
#' \itemize{
#'  \item{\code{theme}: Theme of the feature}
#'  \item{\code{feature}: Feature name}
#'  \item{\code{desc}: Human-readable english description}
#'  \item{\code{z22}: Whether the feature is available in the Census 2022}
#'  \item{\code{z11_100m}: Whether the feature is available in the Census 2011
#'  at a 100m resolution}
#'  \item{\code{z11_1km}: Whether the feature is available in the Census 2011
#'  at a 1km resolution}
#'  \item{\code{has_cat}: Whether the feature is is further divided into
#'  categories.}
#' }
#'
#' @export
#'
#' @examples
#' # return all features related to dwellings
#' z22_features("dwellings")
#'
#' # return all features available in the Census 2011
#' z22_features(year = 2011)
#'
#' # return all features available in 2011 at a 1km resolution
#' z22_features(year = 2011, res = "1km")
z22_features <- function(theme = NULL, year = NULL, res = NULL, legacy_names = FALSE) {
  check_theme(theme, null = TRUE)
  check_year(year, null = TRUE)
  check_resolution(res, year, null = TRUE)

  if (!is.null(theme)) {
    features <- features[tolower(features$theme) %in% tolower(theme), ]
  }

  col <- "name"
  if (!is.null(year)) {
    col <- switch(as.character(year), "2022" = "z22", "2011" = "z11")

    if (year == 2011) {
      col <- sprintf("z11_%s", res %||% c("100m", "1km"))
    }
  }

  if (length(col) > 1) {
    feats <- features[apply(!is.na(features[col]), 1, any), ]
  } else {
    feats <- features[!is.na(features[[col]]), ]
  }

  if (legacy_names) {
    feats <- dplyr::mutate(
      feats,
      name = dplyr::coalesce(z11_100m, z11_1km, name)
    )
  }

  dplyr::transmute(
    feats,
    theme = theme,
    feature = name,
    english = english,
    german = german,
    z22 = !is.na(z22),
    z11_100m = !is.na(z11_100m),
    z11_1km = !is.na(z11_1km),
    has_cat = feature %in% names(categories)
  )
}


get_feature_any <- function(feature) {
  check_string(feature)

  is_feat <- features$name %in% feature |
    features$z11_100m %in% feature |
    features$z11_1km %in% feature

  if (!sum(is_feat)) {
    cli::cli_abort(c(
      "No feature {.val {feature}} available.",
      "i" = "See `z22_features()` for a list of available features."
    ))
  }

  features[is_feat, ]$name
}


features <- dplyr::tribble(
  ~theme, ~name, ~z22, ~z11_100m, ~z11_1km, ~english, ~german, ~type,
  "Population", "population", "population", "INSGESAMT_population", "Einwohner", "Population", "Bev\u00f6lkerung", "count",
  "Population", "citizens", "citizens", NA, NA, "Number of german citizens, 18 or older", "Deutsche Staatsangeh\u00f6rige ab 18 Jahren", "count",
  "Population", "foreigners", "foreigners", NA, "Auslaender_A", "Share of foreigners", "Ausl\u00e4nderanteil", "share",
  "Population", "foreigners_from_18", "foreigners_from_18", NA, NA, "Share of foreigners, 18 or older", "Ausl\u00e4nderanteil ab 18 Jahren", "share",
  "Population", "birth_country", "birth_country", "GEBURTLAND_GRP", NA, "Country of birth (groups)", "Geburtsland (Gruppen)", "count",
  "Population", "sex", NA, "GESCHLECHT", NA, "Sex", "Geschlecht", "count",
  "Population", "women", NA, NA, "Frauen_A", "Share of women", "Frauenanteil", "share",
  "Population", "religion", NA, "RELIGION_KURZ", NA, "Religion", "Religion", "count",
  "Population", "citizenship", "citizenship", "STAATSANGE_KURZ", NA, "Citizenship", "Staatsangeh\u00f6rigkeit", "count",
  "Population", "citizenship_group", "citizenship_group", "STAATSANGE_GRP", NA, "Citizenship (groups)", "Staatsangeh\u00f6rigkeit (Gruppen)", "count",
  "Population", "citizenship_origin", NA, "STAATSANGE_HLND", NA, "Citizenship by selected countries", "Staatsangeh\u00f6rigkeit nach ausgew\u00e4hlten L\u00e4ndern", "count",
  "Population", "citizenship_total", NA, "STAATZHL", NA, "Number of citizenships", "Anzahl Staatsangeh\u00f6rigkeiten", "count",
  "Population", "age_avg", "age_avg", NA, "Alter_D", "Average age", "Durchschnittsalter", "average",
  "Population", "age_short", "age_short", "ALTER_KURZ", NA, "Age (five classes of years)", "Alter in 5 Altersklassen", "count",
  "Population", "age_long", "age_long", "ALTER_10JG", NA, "Age (ten years age groups)", "Alter in 10er-Jahresgruppen", "count",
  "Population", "age_under_18", "age_under_18", NA, "unter18_A", "Share of people under 18", "Anteil er unter 18-J\u00e4hrigen", "share",
  "Population", "age_from_65", "age_from_65", NA, "ab65_A", "Share of people 65 or older", "Anteil der ab 65-J\u00e4hrigen", "share,",
  "Population", "marital_status", "marital_status", "FAMSTND_AUSF", NA, "Marital status", "Familienstand", "count",
  "Families", "families", "families", "INSGESAMT_families", NA, "Total number of families", "Gesamtzahl der Familien", "count",
  "Families", "family_type", "family_type", "FAMTYP_KIND", NA, "Type of core family (by children)", "Typ der Kernfamilie (nach Kindern)", "count",
  "Families", "family_size", NA, "FAMGROESS_KLASS", NA, "Size of core family", "Gr\u00f6\u00dfe der Kernfamilie", "count",
  "Households", "households", "households", "INSGESAMT_households", NA, "Total number of private households", "Gesamtzahl der Privathaushalte", "count",
  "Households", "household_family", NA, "HHTYP_FAM", NA, "Private households by family types", "Typ des privaten Haushalts (nach Familien)", "count",
  "Households", "household_lifestyle", NA, "HHTYP_LEB", NA, "Private households by lifestyle", "Typ des privaten Haushalts (nach Lebensform)", "count",
  "Households", "household_senior", NA, "HHTYP_SENIOR_HH", NA, "Private households by senior status", "Seniorenstatus eines privaten Haushalts", "count",
  "Households", "household_size_avg", "household_size_avg", NA, "HHGroesse_D", "Average household size", "Durchschnittliche Haushaltsgr\u00f6\u00dfe", "average",
  "Households", "household_size_group", "household_size_group", "HHGROESS_KLASS", NA, "Household size (groups)", "Gr\u00f6\u00dfe des privaten Haushalts", "count",
  "Dwellings", "dwellings", "dwellings", "INSGESAMT_dwellings", NA, "Total number of dwellings", "Gesamtzahl der Wohnungen", "count",
  "Dwellings", "rent_avg", "rent_avg", NA, NA, "Average net cold rent", "Durchschnittliche Nettokaltmiete", "average",
  "Dwellings", "dwelling_occupancy", NA, "NUTZUNG_DETAIL_HHGEN", NA, "Use by household occupancy", "Nutzung nach Belegung durch Haushalte", "count",
  "Dwellings", "dwelling_ownership_home", NA, "WOHNEIGENTUM", NA, "Ownership of the dwelling", "Eigentumsverh\u00e4ltnisse der Wohnung", "count",
  "Dwellings", "dwelling_ownership_property", NA, "EIGENTUM_dwellings", NA, "Dwellings by form of ownership", "Wohnungen nach Eigentumsform des Geb\u00e4udes", "count",
  "Dwellings", "owner_occupier", "owner_occupier", NA, NA, "Share of owner occupiers", "Eigent\u00fcmerquote", "share",
  "Dwellings", "vacancies", "vacancies", NA, "Leerstandsquote", "Share of vacancies", "Leerstandsquote", "share",
  "Dwellings", "market_vacancies", "market_vacancies", NA, NA, "Share of market active vacancies", "Marktaktive Leerstandsquote", "share",
  "Dwellings", "inhabitant_space", "inhabitant_space", NA, "Wohnfl_Bew_D", "Average living space per inhabitant", "Durchschnittliche Wohnfl\u00e4che je Bewohner", "average",
  "Dwellings", "dwelling_space", "dwelling_space", NA, "Wohnfl_Whg_D", "Average living space per dwelling", "Durchschnittliche Wohnfl\u00e4che je Wohnung", "average",
  "Dwellings", "floor_space", "floor_space", "WOHNFLAECHE_10S", NA, "Floor space of the dwelling (10m\u00b2 intervals)", "Fl\u00e4che der Wohnung (10m\u00b2-Intervalle)",  "count",
  "Dwellings", "dwelling_rooms", "dwelling_rooms", "RAUMANZAHL", NA, "Dwellings by number of rooms", "Wohnungen nach Zahl der R\u00e4ume", "count",
  "Dwellings", "dwelling_constr_year", NA, "BAUJAHR_MZ_dwellings", NA, "Dwellings by construction year (microcensus classes)", "Wohnungen nach Baujahr (in Mikrozensus-Klassen)", "count",
  "Dwellings", "dwelling_building_dwellings", NA, "ZAHLWOHNGN_HHG_dwellings", NA, "Dwellings by number of dwellings in the building", "Wohnungen nach Anzahl der Wohnungen im Geb\u00e4ude", "count",
  "Dwellings", "dwelling_building_size", "dwelling_building_size", "GEBTYPGROESSE_dwellings", NA, "Dwellings by building type and size", "Wohnungen nach Geb\u00e4udetyp (Gr\u00f6\u00dfe)", "count",
  "Dwellings", "dwelling_building_type", NA, "GEBAEUDEART_SYS_dwellings", NA, "Dwellings by residential usage type", "Wohnungen nach Art des Geb\u00e4udes", "count",
  "Dwellings", "dwelling_building_design", NA, "GEBTYPBAUWEISE_dwellings", NA, "Dwelling by building design", "Wohnungen nach Geb\u00e4udetyp (Bauweise)", "count",
  "Dwellings", "dwelling_heat_type", "dwelling_heat_type", "HEIZTYP_dwellings", NA, "Dwellings by predominant heating type", "Wohnungen nach \u00fcberwiegender Heizungsart", "count",
  "Dwellings", "dwelling_heat_src", "dwelling_heat_src", NA, NA, "Dwellings by energy source of heating", "Wohnungen nach Energietr\u00e4ger der Heizung", "count",
  "Buildings", "buildings", "buildings", "INSGESAMT_buildings", NA, "Total number of buildings", "Gesamtzahl der Geb\u00e4ude", "count",
  "Buildings", "building_ownership_property", NA, "EIGENTUM_buildings", NA, "Buildings by form of ownership", "Geb\u00e4ude nach Eigentumsform des Geb\u00e4udes", "count",
  "Buildings", "building_constr_year", "building_constr_year", "BAUJAHR_MZ_buildings", NA, "Buildings by construction year (microcensus classes)", "Geb\u00e4ude nach Baujahr (in Mikrozensus-Klassen)", "count",
  "Buildings", "building_dwellings", "building_dwellings", "ZAHLWOHNGN_HHG_buildings", NA, "Residential buildings by number of dwellings in the building", "Geb\u00e4ude mit Wohnraum nach Anzahl der Wohnungen im Geb\u00e4ude", "count",
  "Buildings", "building_size", "building_size", "GEBTYPGROESSE_buildings", NA, "Residential buildings by building type and size", "Geb\u00e4ude mit Wohnraum nach Geb\u00e4udetyp (Gr\u00f6\u00dfe)", "count",
  "Buildings", "building_type", NA, "GEBAEUDEART_SYS_buildings", NA, "Buildings by residential usage type", "Geb\u00e4ude nach Art des Geb\u00e4udes", "count",
  "Buildings", "building_design", NA, "GEBTYPBAUWEISE_buildings", NA, "Buildings by building design", "Geb\u00e4ude nach Geb\u00e4udetyp (Bauweise)", "count",
  "Buildings", "building_heat_type", "building_heat_type", "HEIZTYP_buildings", NA, "Buildings by predominant heating type", "Geb\u00e4ude nach \u00fcberwiegender Heizungsart", "count",
  "Buildings", "building_heat_src", "building_heat_src", NA, NA, "Buildings by energy source of heating", "Geb\u00e4ude nach Energietr\u00e4ger der Heizung", "count",
)


make_feature_table <- function() {
  features |>
   dplyr::transmute(
     Theme = theme,
     Name = paste0("`", name, "`"),
     Description = english,
     Zensus22 = dplyr::if_else(!is.na(z22), "\u2705", "\u274c"),
     `Zensus11 (100m)` = dplyr::if_else(!is.na(z11_100m), "\u2705", "\u274c"),
     `Zensus11 (1km)` = dplyr::if_else(!is.na(z11_1km), "\u2705", "\u274c")
   )
}
