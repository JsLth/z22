z22_features <- function(theme = NULL, year = NULL, res = NULL) {
  check_theme(theme, null = TRUE)
  check_year(year, null = TRUE)
  check_resolution(res, year, null = TRUE)

  if (!is.null(theme)) {
    overview <- overview[tolower(overview$theme) %in% tolower(theme), ]
  }

  col <- "name"
  if (!is.null(year)) {
    col <- switch(as.character(year), "2022" = "z22", "2011" = "z11")
    col <- sprintf("z11_%s", res %||% c("100m", "1km"))
  }

  if (length(col) > 1) {
    feats <- overview[apply(!is.na(overview[col]), 1, any), ]
  } else {
    feats <- overview[!is.na(overview[[col]]), ]
  }

  dplyr::transmute(
    feats,
    theme = theme,
    feature = name,
    desc = desc,
    z22 = !is.na(z22),
    z11_100m = !is.na(z11_100m),
    z11_1km = !is.na(z11_1km)
  )
}

overview <- dplyr::tribble(
  ~theme, ~name, ~z22, ~z11_100m, ~z11_1km, ~desc,
  "Population", "population", "population", "INSGESAMT_population", "Einwohner", "Population",
  "Population", "citizens", "citizens", NA, NA, "Number of german citizens, 18 or older",
  "Population", "foreigners", "foreigners", NA, "Auslaender_A", "Share of foreigners",
  "Population", "foreigners_from_18", "foreigners_from_18", NA, NA, "Share of foreigners, 18 or older",
  "Population", "birth_country", "birth_country", "GEBURTLAND_GRP", NA, "Country of birth (groups)",
  "Population", "sex", NA, "GESCHLECHT", NA, "Sex",
  "Population", "women", NA, NA, "Frauen_A", "Share of women",
  "Population", "religion", NA, "RELIGION_KURZ", NA, "Religion",
  "Population", "citizenship", "citizenship", "STAATSANGE_KURZ", NA, "Citizenship",
  "Population", "citizenship_group", "citizenship_group", "STAATSANGE_GRP", NA, "Citizenship (groups)",
  "Population", "citizenship_origin", NA, "STAATSANGE_HLND", NA, "Citizenship by selected countries",
  "Population", "citizenship_total", NA, "STAATZHL", NA, "Number of citizenships",
  "Population", "age_avg", "age_avg", NA, "Alter_D", "Average age",
  "Population", "age_short", "age_short", "ALTER_KURZ", NA, "Age (five classes of years)",
  "Population", "age_long", "age_long", "ALTER_10JG", NA, "Age (ten years age groups)",
  "Population", "age_under_18", "age_under_18", NA, "unter18_A", "Share of people under 18",
  "Population", "age_from_65", "age_from_65", NA, "ab65_A", "Share of people 65 or older",
  "Population", "marital_status", "marital_status", "FAMSTND_AUSF", NA, "Marital status",
  "Families", "families", "families", "INSGESAMT_families", NA, "Total number of families",
  "Families", "family_type", "family_type", "FAMTYP_KIND", NA, "Type of core family (by children)",
  "Families", "family_size", NA, "FAMGROESS_KLASS", NA, "Size of core family",
  "Households", "households", "households", "INSGESAMT_households", NA, "Total number of private households",
  "Households", "household_family", NA, "HHTYP_FAM", NA, "Private households by family types",
  "Households", "household_lifestyle", NA, "HHTYP_LEB", NA, "Private households by lifestyle",
  "Households", "household_senior", NA, "HHTYP_SENIOR_HH", NA, "Private households by senior status",
  "Households", "household_size_avg", "household_size_avg", NA, "HHGroesse_D", "Average household size",
  "Households", "household_size_group", "household_size_group", "HHGROESS_KLASS", NA, "Household size (groups)",
  "Dwellings", "dwellings", "dwellings", "INSGESAMT_dwellings", NA, "Total number of dwellings",
  "Dwellings", "rent_avg", "rent_avg", NA, NA, "Average net cold rent",
  "Dwellings", "dwelling_occupancy", NA, "NUTZUNG_DETAIL_HHGEN", NA, "Use by household occupancy",
  "Dwellings", "dwelling_ownership_home", NA, "WOHNEIGENTUM", NA, "Ownership of the dwelling",
  "Dwellings", "dwelling_ownership_property", NA, "EIGENTUM_dwellings", NA, "Dwellings by form of ownership",
  "Dwellings", "owner_occupier", "owner_occupier", NA, NA, "Share of owner occupiers",
  "Dwellings", "vacancies", "vacancies", NA, "Leerstandsquote", "Share of vacancies",
  "Dwellings", "market_vacancies", "market_vacancies", NA, NA, "Share of market active vacancies",
  "Dwellings", "inhabitant_space", "inhabitant_space", NA, "Wohnfl_Bew_D", "Average living space per inhabitant",
  "Dwellings", "dwelling_space", "dwelling_space", NA, "Wohnfl_Whg_D", "Average living space per dwelling",
  "Dwellings", "floor_space", "floor_space", "WOHNFLAECHE_10S", NA, "Floor space of the dwelling (10m\u00b2 intervals)",
  "Dwellings", "dwelling_rooms", "dwelling_rooms", "RAUMANZAHL", NA, "Dwellings by number of rooms",
  "Dwellings", "dwelling_constr_year", NA, "BAUJAHR_MZ_dwellings", NA, "Dwellings by construction year (microcensus classes)",
  "Dwellings", "dwelling_building_dwellings", NA, "ZAHLWOHNGN_HHG_dwellings", NA, "Dwellings by number of dwellings in the building",
  "Dwellings", "dwelling_building_size", "dwelling_building_size", "GEBTYPGROESSE_dwellings", NA, "Dwellings by building type",
  "Dwellings", "dwelling_building_type", NA, "GEBAEUDEART_SYS_dwellings", NA, "Dwellings by building classification",
  "Dwellings", "dwelling_building_design", NA, "GEBTYPBAUWEISE_dwellings", NA, "Dwelling by building design",
  "Dwellings", "dwelling_heat_type", "dwelling_heat_type", "HEIZTYP_dwellings", NA, "Dwellings by predominant heating type",
  "Dwellings", "dwelling_heat_src", "dwelling_heat_src", NA, NA, "Dwellings by energy source of heating",
  "Buildings", "buildings", "buildings", "INSGESAMT_buildings", NA, "Total number of buildings",
  "Buildings", "building_ownership_property", NA, "EIGENTUM_buildings", NA, "Buildings by form of ownership",
  "Buildings", "building_constr_year", "building_constr_year", "BAUJAHR_MZ_buildings", NA, "Buildings by construction year (microcensus classes)",
  "Buildings", "building_dwellings", "building_dwellings", "ZAHLWOHNGN_HHG_buildings", NA, "Residential buildings by number of dwellings in the building",
  "Buildings", "building_size", "building_size", "GEBTYPGROESSE_buildings", NA, "Residential buildings by building type",
  "Buildings", "building_type", NA, "GEBAEUDEART_SYS_buildings", NA, "Buildings by building design",
  "Buildings", "building_design", NA, "GEBTYPBAUWEISE_buildings", NA, "Buildings by building design",
  "Buildings", "building_heat_type", "building_heat_type", "HEIZTYP_buildings", NA, "Buildings by predominant heating type",
  "Buildings", "building_heat_src", "building_heat_src", NA, NA, "Buildings by energy source of heating"
)
